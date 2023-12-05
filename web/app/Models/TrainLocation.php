<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DateTimeInterface;

class TrainLocation extends Model
{
    use HasFactory;

    protected $fillable = [
        'st_id',
        'latitude',
        'longitude',
        'status'
    ];


    public function schedule_time()
    {
        return $this->hasOne(Train::class,'id','st_id');
    }
    protected function serializeDate(DateTimeInterface $date)
    {
        return $date->format('Y-m-d H:i:s');
    }

}
