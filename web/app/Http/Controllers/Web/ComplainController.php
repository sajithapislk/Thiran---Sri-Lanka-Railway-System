<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Complain;
use Illuminate\Http\Request;
use Inertia\Inertia;

class ComplainController extends Controller
{
    public function index()
    {
        $list = Complain::all();
        return Inertia::render('Admin/Complain',compact('list'));
    }
}
