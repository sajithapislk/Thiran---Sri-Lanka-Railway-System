<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\ScheduleTime;
use App\Models\TrainLocation;
use Illuminate\Http\Request;

class TrainLocationController extends Controller
{
    /**
     * Handle the incoming request.
     */
    public function __invoke($st_id)
    {
        $trainLocation = TrainLocation::where('st_id',$st_id);

        if ($trainLocation) {
            $latestTrainLocation = $trainLocation->latest()->first();
            return $latestTrainLocation;
        } else {
            // Handle the case where TrainLocation with $st_id is not found
            return response()->json(['error' => 'Train location not found'], 404);
        }
    }
}
