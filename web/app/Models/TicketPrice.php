<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

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
}
