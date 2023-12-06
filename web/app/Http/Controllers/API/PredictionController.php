<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Services\RandomForestPrediction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class PredictionController extends Controller
{
    public function Arrival_Time(Request $request){
        $apiKey = env('OPEN_WAETHER_MAP_API');
        $url = "https://api.openweathermap.org/data/2.5/weather?lat={$request->lat}&lon={$request->lon}&appid={$apiKey}";

        $response = Http::get($url);

        $weather = $response['weather'][0]['main'];
        $randomForestResult = (new RandomForestPrediction([
            $request->train_id,
            $request->from,
            $request->to,
            $request->distance,
            $weather
        ]))->predictArrivalTime();

        return $randomForestResult;
    }
}
