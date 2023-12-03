<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Route;
use App\Models\Station;
use Illuminate\Http\Request;
use Inertia\Inertia;

class RouteController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $list = Route::all();
        // return $list;
        return Inertia::render('Admin/Route/Index',compact('list'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $list = Station::all();
        return Inertia::render('Admin/Route/Insert', compact('list'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $_stationList = array();
        foreach ($request->stations as $row) {
            array_push($_stationList, $row["id"]);
        }
        Route::create([
            'name' => $request->name,
            'direction' => $request->direction,
            'station_list' => $_stationList
        ]);

        return redirect()->route('admin.route.index')->with('status', 'Route successful');
    }

    /**
     * Display the specified resource.
     */
    public function show(Route $route)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Route $route)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Route $route)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Route $route)
    {
        //
    }
}
