<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DateTimeInterface;

class TempReservation extends Model
{
    use HasFactory;

    protected $fillable = [
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

    protected function serializeDate(DateTimeInterface $date)
    {
        return $date->format('Y-m-d H:i:s');
    }
}
