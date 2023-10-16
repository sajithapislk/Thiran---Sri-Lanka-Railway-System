<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\TrainLocation;
use Illuminate\Http\Request;

class TrainLocationController extends Controller
{
    public function store(Request $request){
        return TrainLocation::create([
            'st_id' => $request->st_id,
            'latitude' => $request->latitude,
            'longitude' => $request->longitude,
            'status' => $request->status,
        ]);
    }
}
