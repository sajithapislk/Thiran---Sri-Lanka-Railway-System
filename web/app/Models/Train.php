<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Train extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'acs_max_seat',
        'scrs_max_seat',
        'tcrs_max_seat',
    ];
}
