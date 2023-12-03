<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Route;
use App\Models\ScheduleTime;
use App\Models\Train;
use Illuminate\Http\Request;
use Inertia\Inertia;

class ScheduleTimeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $list = ScheduleTime::all();
        $trainList = Train::all();
        $routeList = Route::all();
        return Inertia::render('Admin/ScheduleTime',compact('list','trainList','routeList'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        ScheduleTime::create([
            "train_id" => $request->train_id,
            "route_id"  => $request->route_id,
            "start_at" => $request->start_at,
            "end_at" => $request->end_at,
            "status" => $request->status,
            "acs_p_seats" => $request->acs_p_seats,
            "os_p_seats" => $request->os_p_seats,
            "scrs_p_seats" => $request->scrs_p_seats,
            "tcrs_p_seats" => $request->tcrs_p_seats,

        ]);

        return back()->with('status', 'store successful');

        //
    }

    /**
     * Display the specified resource.
     */
    public function show(ScheduleTime $scheduleTime)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(ScheduleTime $scheduleTime)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, ScheduleTime $scheduleTime)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(ScheduleTime $scheduleTime)
    {
        //
    }
}
