<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\ScheduleTime;
use App\Models\Station;
use App\Models\TicketPrice;
use Carbon\Carbon;
use Illuminate\Http\Request;

class ScheduleTimeController extends Controller
{
    public function filter(Request $request)
    {
        // return $request;
        // if ($request->from == $request->to) {
        //     return ['error' => 'same station'];
        // }
        // return $request->date;
        $scheduleTimes = ScheduleTime::with('route','train')
            ->whereDate('start_at',Carbon::parse($request->date))
            ->get();
        $_scheduleTimes = array();
        $_distance = 0.0;
        foreach ($scheduleTimes as $row) {
            $isInserted = false;
            $_time = 0;
            $stationList = $row->route->station_list;
            if (in_array($request->from, $stationList) && in_array($request->to, $stationList)) {
                $no = 0;
                foreach ($stationList as $key => $station) {
                    $stationInfo = Station::find($station);

                    if($station == $request->from ){
                        $_time += ( $row->route->direction=='LEFT' ? $stationInfo->left_time : $stationInfo->right_time );
                    }
                    if($no == 1){
                        if ($request->to == $station) {
                            $no++;
                            $isInserted=true;
                        }else{
                            $_distance += ( $row->route->direction=='LEFT' ? $stationInfo->left_distance : $stationInfo->right_distance );

                        }
                    }
                    if ($request->from == $station && $no == 0) {
                        $no++;
                        $_distance += ( $row->route->direction=='LEFT' ? $stationInfo->left_distance : $stationInfo->right_distance );
                    }
                }
            }
            if($isInserted)
                array_push($_scheduleTimes, [
                    'data' => $row,
                    'datetime' => Carbon::parse($row->start_at)->addMinutes($_time)
                ]);
        }
        $ticket = TicketPrice::where('beyond','<=',$_distance)->where('above','>=',$_distance)->first();
        return [
            'distance' => $_distance,
            'price' => $ticket,
            'schedules' => $_scheduleTimes
        ];
    }
}
