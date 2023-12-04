<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Station extends Model
{
    use HasFactory;

    protected $fillable = [
        "name",
        "address",
        "tp",
        "left_distance",
        "right_distance",
        "left_time",
        "right_time",
        "longitude",
        "latitude"
    ];
}
