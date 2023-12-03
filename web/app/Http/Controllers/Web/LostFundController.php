<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\LostFoundItem;
use App\Models\Route;
use App\Models\Train;
use Illuminate\Http\Request;
use Inertia\Inertia;

class LostFundController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $list = LostFoundItem::all();
        $trainList = Train::all();
        $routeList = Route::all();
        return Inertia::render('Admin/LostFoundItem', compact('list','trainList','routeList'));
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
        LostFoundItem::create([
            'u_id'=>$request->u_id,
            'item_name'=> $request->item_name,
            'description'=> $request->description,
            'img1'=> $request->img1,
            'img2'=> $request->img2,
            'img3'=> $request->img3,
            'img4'=> $request->img4,
            'station_id'=> $request->station_id,
            'officer_id'=> $request->officer_id,
            'is_release'=> $request->is_release,
            'release_info'=> $request->release_info,
            'release_tp'=> $request->release_tp,
        ]);

        return back()->with('status', 'store successful');
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
