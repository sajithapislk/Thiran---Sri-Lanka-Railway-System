<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Requests\TrainLocationStorePR;
use App\Models\TrainLocation;
use Illuminate\Http\Request;

class TrainLocationSaveController extends Controller
{
    public function __invoke(TrainLocationStorePR $request){
        return TrainLocation::create([
            'st_id'=>$request,
            'latitude'=>$request,
            'longitude'=>$request,
            'status'=>$request
        ]);
    }
}
