<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DateTimeInterface;

class LostFoundItem extends Model
{
    use HasFactory;

    protected $fillable = [
        'u_id',
        'item_name',
        'description',
        'img1',
        'img2',
        'img3',
        'img4',
        'station_id',
        'officer_id',
        'is_release',
        'release_info',
        'release_tp'
    ];
    protected function serializeDate(DateTimeInterface $date)
    {
        return $date->format('Y-m-d H:i:s');
    }

}
