<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DateTimeInterface;

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
    protected function serializeDate(DateTimeInterface $date)
    {
        return $date->format('Y-m-d H:i:s');
    }

}
