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
        $list = Station::all();
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
        //
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
