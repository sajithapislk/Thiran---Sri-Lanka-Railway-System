<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\StationUpdate;
use Illuminate\Http\Request;
use Inertia\Inertia;

use function Laravel\Prompts\confirm;

class StationUpdateController extends Controller
{
    public function index() {

        $list = StationUpdate::all();
        return Inertia::render('StationAgent/StationUpdate',compact('list'));
    }

    public function confirm(Request $request){
        $stationUpdate = StationUpdate::find($request->id);
        $stationUpdate->update([
            'status'=>'Station Confirmation'
        ]);
        return back()->with('status', 'Route successful');
    }


    //
}
