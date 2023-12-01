<?php

use App\Http\Controllers\Web\StationController;
use App\Http\Controllers\Auth\AdminAuthenticatedSessionController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\Web\ComplainController;
use App\Http\Controllers\Web\LostFundController;
use App\Http\Controllers\Web\RouteController;
use App\Http\Controllers\Web\ScheduleTimeController;
use App\Http\Controllers\Web\TicketPriceController;
use App\Http\Controllers\Web\TrainController;
use App\Http\Controllers\Web\TrainLocationController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/


Route::middleware('auth:admin')->group(function () {

    Route::get('/dashboard', function () {
        return Inertia::render('Admin/Dashboard');
    })->name('dashboard');

    Route::resource('station',StationController::class);
    Route::resource('route',RouteController::class);
    Route::resource('ticket-price',TicketPriceController::class);
    Route::resource('train-location',TrainLocationController::class);
    Route::resource('lost-found',LostFundController::class);
    Route::resource('complain',ComplainController::class);
    Route::resource('train',TrainController::class);
    Route::resource('schedule-time',ScheduleTimeController::class);
    // train location

    Route::get('logout', [AdminAuthenticatedSessionController::class, 'destroy'])
    ->name('logout');

    Route::get('/map', function () {
        return Inertia::render('Admin/Map');
    });
});

Route::middleware('guest:admin')->group(function () {
    Route::get('login', [AdminAuthenticatedSessionController::class, 'create'])
    ->name('login');

    Route::post('login', [AdminAuthenticatedSessionController::class, 'store']);
});

