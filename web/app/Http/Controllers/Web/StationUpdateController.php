<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\StationUpdate;
use Illuminate\Http\Request;
use Inertia\Inertia;

class StationUpdateController extends Controller
{
    public function index() {

        $list = StationUpdate::all();
        return Inertia::render('StationAgent/StationAgentUpdate',compact('list'));



    }
    //
}
