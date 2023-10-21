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
        // if ($request->from == $request->to) {
        //     return ['error' => 'same station'];
        // }
        $scheduleTimes = ScheduleTime::with('route')
            ->whereDate('start_at', $request->date)
            ->get();
        $_scheduleTimes = array();
        $_distance = 0.0;
        foreach ($scheduleTimes as $row) {
            $stationList = $row->route->station_list;
            if (in_array($request->from, $stationList) && in_array($request->to, $stationList)) {
                $no = 0;
                foreach ($stationList as $key => $station) {
                    if($no == 1){
                        if ($request->to == $station) {
                            $no++;
                            array_push($_scheduleTimes, $row);

                            return [
                                'distance' => $_distance,
                                'schedules' => $_scheduleTimes
                            ];
                        }else{
                            $stationInfo = Station::find($station);
                            $_distance = $_distance + ( $row->route->direction=='LEFT' ? $stationInfo->left_slide : $stationInfo->right_slide );
                        }
                    }
                    if ($request->from == $station && $no == 0) {
                        $no++;
                        $stationInfo = Station::find($station);
                        $_distance = $_distance + ( $row->route->direction=='LEFT' ? $stationInfo->left_slide : $stationInfo->right_slide );
                    }
                }
            }
        }
        return $_scheduleTimes;
    }
}
