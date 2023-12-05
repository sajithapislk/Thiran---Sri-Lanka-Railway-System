<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DateTimeInterface;

class ScheduleTime extends Model
{
    use HasFactory;

    protected $fillable = [
        "train_id",
        "route_id",
        "start_at",
        "end_at",
        "status",
        "acs_p_seats",
        "os_p_seats",
        "scrs_p_seats",
        "tcrs_p_seats"
    ];

    public function route()
    {
        return $this->hasOne(Route::class,'id','route_id');
    }
    public function train()
    {
        return $this->hasOne(Train::class,'id','train_id');
    }
    public function users()
    {
        return $this->hasMany(Book::class,'st_id','id');
    }
    protected function serializeDate(DateTimeInterface $date)
    {
        return $date->format('Y-m-d H:i:s');
    }

}
