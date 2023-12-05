<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DateTimeInterface;

class TicketPrice extends Model
{
    use HasFactory;

    protected $fillable = [
        "beyond",
        "above",
        "acs_price",
        "os_price",
        "scrs_price",
        "tcrs_price"
    ];
    protected function serializeDate(DateTimeInterface $date)
    {
        return $date->format('Y-m-d H:i:s');
    }

}
