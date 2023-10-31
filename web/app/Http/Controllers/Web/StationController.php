<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Station;
use Illuminate\Http\Request;
use Inertia\Inertia;

class StationController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $list = Station::all();
        return Inertia::render('Admin/Station',compact('list'));
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
        Station::create([
            'name' => $request->name,
            'address' => $request->address,
            'tp' => $request->tp,
            'left_slide' => $request->left_slide,
            'right_slide' => $request->right_slide,
        ]);

        return back()->with('status', 'store successful');
    }

    /**
     * Display the specified resource.
     */
    public function show(Station $station)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Station $station)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Station $station)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Station $station)
    {
        //
    }
}
