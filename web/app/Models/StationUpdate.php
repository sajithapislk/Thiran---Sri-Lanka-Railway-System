<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StationUpdate extends Model
{
    use HasFactory;

    protected $fillable = [
        "id",
        "status"
    ];

    public function schedule_time()
    {
        return $this->hasOne(ScheduleTime::class,'id','st_id');
    }
}


