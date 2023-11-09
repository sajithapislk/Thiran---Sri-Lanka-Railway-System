<?php

namespace App\Observers;

use App\Events\TimePredictionNotification;
use App\Http\Controllers\DistanceController;
use App\Http\Services\RandomForestPrediction;
use App\Models\TrainLocation;
use App\Models\ScheduleTime;
use App\Models\Station;
use App\Models\StationUpdate;
use Carbon\Carbon;

class TrainLocationObserver
{
    /**
     * Handle the TrainLocation "created" event.
     */
    public function created(TrainLocation $trainLocation): void
    {
        $st_id = $trainLocation->st_id;
        $stationUpdates = StationUpdate::where('st_id',$st_id)->orderBy('id', 'DESC')->get();
        $length = $stationUpdates->count();

        $scheduleTimes = ScheduleTime::with('route','users')->find($st_id);

        if (isset($scheduleTimes->route->station_list[$length-1])) {
            $station = Station::find($scheduleTimes->route->station_list[$length-1]);
            if($station->latitude !== ""){
                $distanceController = new DistanceController(
                    $trainLocation->latitude,
                    $trainLocation->longitude,
                    $station->latitude,
                    $station->longitude
                );
                $distance = $distanceController->distance;

                $trainLocation = $trainLocation->with('schedule_time.train');
                // machine learning part (prediction time)
                $randomForestResult = (new RandomForestPrediction([
                    $trainLocation->train_id,
                    $trainLocation->route_id,
                    $trainLocation->route->from,
                    $trainLocation->route->to,
                    $distance,
                    null,
                    null,
                    null,
                    null,
                    null
                ]))->predictArrivalTime();
                $currentDateTime = Carbon::now();
                $newDateTime = $currentDateTime->addMinutes($randomForestResult);
                // pusher(real time update - notification)
                foreach ($scheduleTimes->users as $key => $user) {
                    TimePredictionNotification::dispatch($user->id, "TimePrediction", "Train will arrive at " + $newDateTime->format('h:i A'), Carbon::now());
                }

                if($distance<=0.1){
                    $station->update([
                        'status'=>"Station Ekata laga"
                    ]);
                    if (isset($scheduleTimes->route->station_list[$length])) {
                        $_nextStation = $scheduleTimes->route->station_list[$length];
                        // $stationUpdate_check = StationUpdate::where('st_id',$st_id)->where('station_id',$_nextStation);
                        // if (!$stationUpdate_check->exists()) {
                            StationUpdate::create([
                                'st_id' => $st_id,
                                'station_id' => $_nextStation,
                                'status' => "kalin station eke inne"
                            ]);
                    //     }
                    }
                }
            }
        }

    }

    /**
     * Handle the TrainLocation "updated" event.
     */
    public function updated(TrainLocation $trainLocation): void
    {
        //
    }

    /**
     * Handle the TrainLocation "deleted" event.
     */
    public function deleted(TrainLocation $trainLocation): void
    {
        //
    }

    /**
     * Handle the TrainLocation "restored" event.
     */
    public function restored(TrainLocation $trainLocation): void
    {
        //
    }

    /**
     * Handle the TrainLocation "force deleted" event.
     */
    public function forceDeleted(TrainLocation $trainLocation): void
    {
        //
    }
}
