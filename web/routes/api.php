<?php

use App\Http\Controllers\API\StationController;
use App\Http\Controllers\API\TrainLocationController;
use App\Http\Controllers\API\TrainLocationSaveController;
use App\Http\Controllers\API\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('/train-location', TrainLocationSaveController::class);


Route::prefix('user')->group(function () {
    Route::post('login',[UserController::class,'check']);
    Route::post('store',[UserController::class,'store']);

    Route::group(['middleware' => ['auth:sanctum', 'ability:user:*']], function () {
        Route::get('logout',[UserController::class,'logout']);
    });

});
Route::controller(StationController::class)->group(function () {
    Route::get('station', 'index')->name('station');
});
Route::controller(TrainLocationController::class)->group(function () {
    Route::get('train-location', 'store')->name('train-location.store');
});

