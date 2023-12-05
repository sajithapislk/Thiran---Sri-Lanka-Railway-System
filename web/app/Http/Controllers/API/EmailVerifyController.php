<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;

class EmailVerifyController extends Controller
{
    /**
     * Handle the incoming request.
     */
    public function __invoke($user_id)
    {
        User::find($user_id)->update([
            'email_verified_at'=>Carbon::now()
        ]);
    }
}
