<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Requests\TrainLocationStorePR;
use App\Models\ScheduleTime;
use App\Models\TrainLocation;
use Carbon\Carbon;
use Illuminate\Http\Request;


use App\Events\TimePredictionNotification;
use App\Http\Controllers\DistanceController;
use App\Http\Services\RandomForestPrediction;
use App\Models\Station;
use App\Models\StationUpdate;

class TrainLocationSaveController extends Controller
{
    public function __invoke(TrainLocationStorePR $request)
    {
        $datetime = Carbon::now();
        $scheduleTimes = ScheduleTime::where('train_id', $request->train_id)
            ->where('start_at', '<=', $datetime)
            ->where('end_at', '>=', $datetime)
            ->first();
        if ($scheduleTimes) {
            TrainLocation::create([
                'st_id' => $scheduleTimes->id,
                'latitude' => $request->latitude,
                'longitude' => $request->longitude,
                'status' => $request->status
            ]);


            // $trainLocation = $trainLocation->with('schedule_time.train');
            // $randomForestResult = (new RandomForestPrediction([
            //     $trainLocation->train_id,
            //     $trainLocation->route_id,
            //     $trainLocation->route->from,
            //     $trainLocation->route->to,
            //     $distance,
            //     null,
            //     null,
            //     null,
            //     null,
            //     null
            // ]))->predictArrivalTime();
            // $currentDateTime = Carbon::now();
            // $newDateTime = $currentDateTime->addMinutes($randomForestResult);
            // foreach ($scheduleTimes->users as $key => $user) {
            //     TimePredictionNotification::dispatch($user->id, "TimePrediction", "Train will arrive at " + $newDateTime->format('h:i A'), Carbon::now());
            // }
            return "done";
        } else {
            return "no schedule";
        }
    }
}
