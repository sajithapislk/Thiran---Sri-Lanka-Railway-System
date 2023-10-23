<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Services\RandomForestPrediction;
use Illuminate\Http\Request;

class PredictionController extends Controller
{
    public function Arrival_Time(Request $request){
        $randomForestResult = (new RandomForestPrediction([
            $request->train_id,
            $request->route_id,
            $request->from,
            $request->to,
            $request->distance,
            $request->passenger,
            $request->weather=='Sunny' ? 0 : 0,
            $request->weather=='Cloudy' ? 0 : 0,
            $request->weather=='Rainy' ? 0 : 0,
            $request->weather=='Overcast' ? 0 : 0
        ]))->predictArrivalTime();

        return $randomForestResult;
    }
}
