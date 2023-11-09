<?php

use App\Http\Controllers\Web\StationController;
use App\Http\Controllers\Auth\AdminAuthenticatedSessionController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\Web\ComplainController;
use App\Http\Controllers\Web\RouteController;
use App\Http\Controllers\Web\TicketPriceController;
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
    Route::resource('complain',ComplainController::class);

    Route::get('logout', [AdminAuthenticatedSessionController::class, 'destroy'])
    ->name('logout');
});

Route::middleware('guest:admin')->group(function () {
    Route::get('login', [AdminAuthenticatedSessionController::class, 'create'])
    ->name('login');

    Route::post('login', [AdminAuthenticatedSessionController::class, 'store']);
});

