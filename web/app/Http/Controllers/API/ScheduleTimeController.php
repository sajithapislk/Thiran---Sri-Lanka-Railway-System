<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\ScheduleTime;
use App\Models\Station;
use App\Models\TicketPrice;
use Illuminate\Http\Request;

class ScheduleTimeController extends Controller
{
    public function filter(Request $request)
    {
        // return $request;
        // if ($request->from == $request->to) {
        //     return ['error' => 'same station'];
        // }
        $scheduleTimes = ScheduleTime::with('route','train')
            ->whereDate('start_at', $request->date)
            ->get();
        // return($scheduleTimes);
        $_scheduleTimes = array();
        $_return = array();
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

                            $ticket = TicketPrice::where('beyond','<=',$_distance)->where('above','>=',$_distance)->first();

                            array_push($_return, [
                                'distance' => $_distance,
                                'price' => $ticket,
                                'schedules' => $_scheduleTimes
                            ]);
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
        return $_return;
    }
}
