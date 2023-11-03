<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Route extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'direction',
        'station_list'
    ];


    protected $casts = [
        'station_list' => 'array'
    ];
}
