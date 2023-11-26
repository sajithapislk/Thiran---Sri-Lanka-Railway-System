<?php

use App\Http\Controllers\API\BookController;
use App\Http\Controllers\API\ComplainStoreController;
use App\Http\Controllers\API\PredictionController;
use App\Http\Controllers\API\ScheduleTimeController;
use App\Http\Controllers\API\StationController;
use App\Http\Controllers\API\TrainLocationSaveController;
use App\Http\Controllers\API\UserController;
use App\Http\Controllers\API\PayPalController;
use App\Http\Controllers\API\TrainLocationController;
use App\Http\Controllers\DistanceController;
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
    Route::post('login', [UserController::class, 'check']);
    Route::post('store', [UserController::class, 'store']);

    Route::group(['middleware' => 'auth:sanctum'], function () {

        Route::controller(BookController::class)->group(function () {
            Route::get('book', 'index')->name('book.index');
        });

        Route::post('complain', ComplainStoreController::class);
        Route::get('logout', [UserController::class, 'logout']);
    });
});

Route::get('train_locations/{st_id}', TrainLocationController::class);

Route::controller(StationController::class)->group(function () {
    Route::get('station', 'index')->name('station');
});
Route::controller(ScheduleTimeController::class)->group(function () {
    Route::post('time-table', 'filter')->name('schedule-time.filter');
});
Route::post('prediction', [PredictionController::class, 'Arrival_Time']);


Route::controller(PayPalController::class)->group(function () {
    Route::get('process-transaction', 'processTransaction')->name('processTransaction');
    Route::get('success-transaction', 'successTransaction')->name('successTransaction');
    Route::get('cancel-transaction', 'cancelTransaction')->name('cancelTransaction');
});
