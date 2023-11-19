<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Book;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class BookController extends Controller
{
    function index() {
        $user_id = Auth::user()->id;
        return Book::where('uid',$user_id)->with('payment','schedule_time.train','schedule_time.route','to_station','from_station')->get();
    }

}
