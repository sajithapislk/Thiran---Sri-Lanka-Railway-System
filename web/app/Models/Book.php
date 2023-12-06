<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DateTimeInterface;

class Book extends Model
{
    use HasFactory;

    protected $fillable = [
        'id',
        'uid',
        'st_id',
        'payment_id',
        'from_s_id',
        'to_s_id',
        'distance',
        'seat_type',
        'nop',
        'entered_at',
        'ended_at',
        'is_canceled',
    ];


    public function payment()
    {
        return $this->hasOne(Payment::class,'id','payment_id');
    }
    public function schedule_time()
    {
        return $this->hasOne(ScheduleTime::class,'id','st_id');
    }
    public function from_station()
    {
        return $this->hasOne(Station::class,'id','from_s_id');
    }
    public function to_station()
    {
        return $this->hasOne(Station::class,'id','to_s_id');
    }
    protected function serializeDate(DateTimeInterface $date)
    {
        return $date->format('Y-m-d H:i:s');
    }

}
