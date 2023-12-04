<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Http\Controllers\DistanceController;
use App\Models\Station;
use App\Models\StationUpdate;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Inertia\Inertia;

use function Laravel\Prompts\confirm;

class StationUpdateController extends Controller
{
    public function index() {

        $list = StationUpdate::all();
        return Inertia::render('StationAgent/StationUpdate',compact('list'));
    }

    public function confirm(Request $request){
        $stationUpdate = StationUpdate::where('id',$request->id)->with('schedule_time.route')->first();

        $station = Station::find($stationUpdate->station_id);
        $stationUpdate->update([
            'status'=>'Station Confirmation'
        ]);

        $weatherData = $this->getWeatherData($station->longitude,$station->latitude);

        $stationList = $stationUpdate->schedule_time->route->station_list;
        $firstStation = reset($stationList);
        $lastStation = end($stationList);

        $_train_id = $stationUpdate->schedule_time->train_id;

        $prevStationUpdate = StationUpdate::with('schedule_time')->whereHas('schedule_time', function ($query) use($_train_id) {
            return $query->where('train_id', $_train_id);
        })->orderBy('id','desc')->get();

        $prevStation = Station::where('id',$prevStationUpdate[1]->station_id)->first();

        $distanceController = new DistanceController(
            $prevStation->latitude,
            $prevStation->longitude,
            $station->latitude,
            $station->longitude
        );
        $distance = $distanceController->distance;

        $start  = new Carbon($prevStation->updated_at);
        $end    = Carbon::now();
        $_diffInMinutes = $start->diffInMinutes($end);

        $this->write(
            $stationUpdate->schedule_time->train_id,
            $firstStation,
            $lastStation,
            $distance,
            $weatherData,
            $_diffInMinutes
        );

        return back()->with('status', 'Route successful');
    }

    public function getWeatherData($lat, $lon,) {
        $apiKey = env('OPEN_WAETHER_MAP_API');
        $url = "https://api.openweathermap.org/data/2.5/weather?lat={$lat}&lon={$lon}&appid={$apiKey}";

        $response = Http::get($url);

        return $response['weather'][0]['main'];
    }

    public function write($train_id,$from,$to,$distance,$weather,$duration)
    {
        $filename = 'train.csv';
        $filePath = storage_path('app/' . $filename);

        $newData = [$train_id,$from,$to,$distance,$weather,$duration];

        $file = fopen($filePath, 'a');
        fputcsv($file, $newData);
        fclose($file);
    }

    //
}
