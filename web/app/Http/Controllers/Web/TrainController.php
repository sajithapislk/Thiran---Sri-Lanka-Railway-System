<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Train;
use Illuminate\Http\Request;
use Inertia\Inertia;

class TrainController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $list = Train::all();
        return Inertia::render('Admin/Train', compact('list'));
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
        Train::create([
            'name' => $request->name,
            'no' => $request->no,
            'acs_max_seats' => $request->acs_max_seats,
            'os_max_seats' => $request->os_max_seats,
            'scrs_max_seats' => $request->scrs_max_seats,
            'tcrs_max_seats' => $request->tcrs_max_seats,
        ]);

        return back()->with('status', 'store successful');
    }

    /**
     * Display the specified resource.
     */
    public function show(Train $train)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Train $train)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Train $train)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Train $train)
    {
        //
    }
}
