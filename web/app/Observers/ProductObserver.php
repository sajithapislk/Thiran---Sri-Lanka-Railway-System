<?php

namespace App\Observers;

use App\Http\Controllers\DistanceController;
use App\Models\ScheduleTime;
use App\Models\Station;
use App\Models\StationUpdate;
use App\Models\TrainLocation;

class ProductObserver
{
    /**
     * Handle the TrainLocation "created" event.
     */
    public function created(TrainLocation $trainLocation): void
    {
        $st_id = $trainLocation->st_id;
        $stationUpdates = StationUpdate::where('st_id',$st_id)->orderBy('id', 'DESC')->get();
        $length = $stationUpdates->count();

        $scheduleTimes = ScheduleTime::with('route')->find($st_id);

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
