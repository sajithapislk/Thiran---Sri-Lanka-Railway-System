<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Requests\TrainLocationStorePR;
use App\Models\ScheduleTime;
use App\Models\TrainLocation;
use Carbon\Carbon;
use Illuminate\Http\Request;

class TrainLocationSaveController extends Controller
{
    public function __invoke(TrainLocationStorePR $request){
        $datetime = Carbon::now();
        // return $datetime;
        $st = ScheduleTime::where('train_id', $request->train_id)
            ->where('start_at', '<=', $datetime)
            ->where('end_at', '>=', $datetime)
            ->first();
        if($st){
            return TrainLocation::create([
                'st_id' => $st->id,
                'latitude' => $request->latitude,
                'longitude' => $request->longitude,
                'status' => $request->status
            ]);
        }else{
            return "error";
        }


    }

}
