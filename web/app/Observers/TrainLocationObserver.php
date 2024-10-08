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
use Illuminate\Support\Facades\Log;

class TrainLocationObserver
{
    /**
     * Handle the TrainLocation "created" event.
     */
    public function created(TrainLocation $trainLocation): void
    {
        $stationUpdates = StationUpdate::where('st_id', $trainLocation->st_id)->orderBy('id', 'DESC')->get();
        $length = $stationUpdates->count();

        Log::info("length " . $length);

        $scheduleTimes = ScheduleTime::with('route', 'users')->find($trainLocation->st_id);

        if ($length == 0) {
            $_station = Station::find($scheduleTimes->route->station_list[$length]);
            $distanceController = new DistanceController(
                $trainLocation->latitude,
                $trainLocation->longitude,
                $_station->latitude,
                $_station->longitude
            );
            $distance = $distanceController->distance;

            $scheduleTimes->update([
                'status' => 'Started'
            ]);

            StationUpdate::create([
                'st_id' => $trainLocation->st_id,
                'station_id' => $scheduleTimes->route->station_list[$length],
                'status' => 'Started'
            ]);
            return;
        } else {
            if ($trainLocation->status == "NOT_MOVING") {
                $scheduleTimes->update([
                    'status' => 'NOT_MOVING'
                ]);
                return;
            }
            if (isset($scheduleTimes->route->station_list[$length + 1])) {
                $station = Station::find($scheduleTimes->route->station_list[$length + 1]);
                $distanceController = new DistanceController(
                    $trainLocation->latitude,
                    $trainLocation->longitude,
                    $station->latitude,
                    $station->longitude
                );
                $distance = $distanceController->distance;

                $_stationUpdate = $stationUpdates
                    ->where("station_id", $scheduleTimes->route->station_list[$length])
                    ->first();

                if ($_stationUpdate)
                    return;

                if ($distance <= 0.1) {
                    $scheduleTimes->update([
                        'status' => 'Next Station soon : ' . $scheduleTimes->route->station_list[$length]
                    ]);
                    StationUpdate::create([
                        'st_id' => $trainLocation->st_id,
                        'station_id' => $scheduleTimes->route->station_list[$length],
                        'status' => 'Next Station soon : '. $scheduleTimes->route->station_list[$length]
                    ]);
                }
                return;
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
