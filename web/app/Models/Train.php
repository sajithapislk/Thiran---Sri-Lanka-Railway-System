<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Train extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'no',
        'acs_max_seats',
        'os_max_seats',
        'scrs_max_seats',
        'tcrs_max_seats'
    ];

    public function train()
    {
        return $this->hasOne(Train::class,'id','train_id');
    }
}
