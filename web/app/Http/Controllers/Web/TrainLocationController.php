<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\TrainLocation;
use Illuminate\Http\Request;
use Inertia\Inertia;

class TrainLocationController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $list = TrainLocation::all();
        return Inertia::render('Admin/TrainLocation', compact('list'));
        //
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

        TrainLocation::create([
            'id' => $request->id,
            'st_id'=> $request->st_id,
            'latitude'=> $request->latitude,
            'longitude'=> $request->longitude,
            'status'=> $request->status,
        ]);

        return back()->with('status', 'store successful');
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(TrainLocation $trainLocation)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(TrainLocation $trainLocation)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, TrainLocation $trainLocation)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(TrainLocation $trainLocation)
    {
        //
    }
}
