<?php
namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class BlockRoutes
{
    public function handle(Request $request, Closure $next)
    {
        return redirect('/')->with('error', 'Accesso non consentito.');
    }
}