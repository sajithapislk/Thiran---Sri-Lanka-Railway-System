<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DateTimeInterface;

class StationUpdate extends Model
{
    use HasFactory;

    protected $fillable = [
        "st_id",
        "station_id",
        "status"
    ];

    public function schedule_time()
    {
        return $this->hasOne(ScheduleTime::class,'id','st_id');
    }
    protected function serializeDate(DateTimeInterface $date)
    {
        return $date->format('Y-m-d H:i:s');
    }

}


