<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\ScheduleTime;
use App\Models\Station;
use Illuminate\Http\Request;

class ScheduleTimeController extends Controller
{
    public function filter(Request $request)
    {
        // return $request;
        if ($request->from == $request->to) {
            return ['error' => 'same station'];
        }
        $scheduleTimes = ScheduleTime::with('route')
            ->whereDate('start_at', $request->date)
            ->get();
        $_scheduleTimes = array();
        foreach ($scheduleTimes as $row) {
            $stationList = $row->route->station_list;
            if (in_array($request->from, $stationList) && in_array($request->to, $stationList)) {
                $no = 0;
                foreach ($stationList as $key => $station) {
                    if ($request->from == $station && $no == 0) {
                        $no++;
                    }
                    if ($request->from == $station && $no == 1) {
                        array_push($_scheduleTimes, $row);
                    }
                }
            }
        }
        return $_scheduleTimes;
    }
}
