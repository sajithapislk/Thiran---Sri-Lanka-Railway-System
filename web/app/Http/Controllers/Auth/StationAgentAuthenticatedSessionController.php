<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\StationAgentLoginRequest;
use App\Providers\RouteServiceProvider;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Routing\Route;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
use Inertia\Response;

class StationAgentAuthenticatedSessionController extends Controller
{
    public function create(): Response
    {
        return Inertia::render('Auth/StationAgentLogin', [
            'status' => session('status'),
        ]);
    }

    /**
     * Handle an incoming authentication request.
     */
    public function store(StationAgentLoginRequest $request): RedirectResponse
    {
        $request->authenticate('station-agent');

        $request->session()->regenerate();

        return redirect()->intended(RouteServiceProvider::STATION_AGENT);
    }

    /**
     * Destroy an authenticated session.
     */
    public function destroy(Request $request): RedirectResponse
    {
        Auth::guard('station-agent')->logout();

        $request->session()->invalidate();

        $request->session()->regenerateToken();

        return redirect('/');
    }
}
