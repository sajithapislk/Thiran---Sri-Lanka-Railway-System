<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\User\StorePostRequest;
use App\Http\Requests\User\LoginPostRequest;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function store(StorePostRequest $request)
    {
        $user =  User::create($request->validated());
        $token = $user->createToken('api',['user:*'])->plainTextToken;

        $response = [
            'user' => $user,
            'token' => $token
        ];

        return response($response, 201);
    }
    public function check(LoginPostRequest $request)
    {
        $fields = $request->validated();
        $user = User::where('email', $fields['email'])->first();
        if (!$user || !Hash::check($fields['password'], $user->password)) {
            return response([
                'message' => 'Password is incorrect'
            ], 401);
        }

        $token = $user->createToken('api',['user:*'])->plainTextToken;

        $response = [
            'user' => $user,
            'token' => $token
        ];

        return response($response, 201);
    }

    public function logout(Request $request)
    {
        $user = $request->user()->tokens()->delete();
        return response([
            'message' => 'logout',
            'user' => $user
        ]);
    }
}
