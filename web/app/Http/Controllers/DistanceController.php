<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use GoogleMaps\GoogleMaps;

class DistanceController extends Controller
{
    public $distance;

    public function __construct($lat1, $lon1, $lat2, $lon2) {
        $earthRadius = 6371;

        $dLat = deg2rad($lat2 - $lat1);
        $dLon = deg2rad($lon2 - $lon1);

        $a = sin($dLat / 2) * sin($dLat / 2) + cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * sin($dLon / 2) * sin($dLon / 2);
        $c = 2 * atan2(sqrt($a), sqrt(1 - $a));

        $distance = $earthRadius * $c;

        $this->distance = round($distance, 2);
    }
}
