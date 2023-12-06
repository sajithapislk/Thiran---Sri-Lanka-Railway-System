<?php

use App\Http\Controllers\Auth\StationAgentAuthenticatedSessionController;
use App\Http\Controllers\StationAgentDashboard;
use App\Http\Controllers\Web\BooksController;
use App\Http\Controllers\Web\StationUpdateController;
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


Route::middleware('auth:station-agent')->group(function () {

    Route::get('/dashboard', StationAgentDashboard::class)->name('dashboard');

    Route::get('station-update', [StationUpdateController::class, 'index'])
    ->name('station-update');

    Route::post('station-update/confirm',[StationUpdateController::class,'confirm'])
    ->name('station-update.confirm');

    Route::get('logout', [StationAgentAuthenticatedSessionController::class, 'destroy'])
    ->name('logout');





});

Route::middleware('guest:station-agent')->group(function () {
    Route::get('login', [StationAgentAuthenticatedSessionController::class, 'create'])
    ->name('login');

    Route::post('login', [StationAgentAuthenticatedSessionController::class, 'store']);
});

