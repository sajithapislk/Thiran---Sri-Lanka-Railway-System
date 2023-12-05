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
        $trainLocation = TrainLocation::find($st_id)->latest()->first();
        return $trainLocation;
    }
}
