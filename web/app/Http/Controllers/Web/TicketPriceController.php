<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Station;
use App\Models\TicketPrice;
use Illuminate\Http\Request;
use Inertia\Inertia;

class TicketPriceController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $list = TicketPrice::all();
        return Inertia::render('Admin/TicketPrice',compact('list'));
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
        TicketPrice::create([
            'beyond' => $request->beyond,
            'above' => $request->above,
            'acs_price' => $request->acs_price,
            'os_price' => $request->os_price,
            'scrs_price' => $request->scrs_price,
            'tcrs_price' => $request->tcrs_price,
        ]);

        return back()->with('status', 'store successful');
    }

    /**
     * Display the specified resource.
     */
    public function show(TicketPrice $ticketPrice)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(TicketPrice $ticketPrice)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, TicketPrice $ticketPrice)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(TicketPrice $ticketPrice)
    {
        //
    }
}
