<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('schedule_route_orders', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('st_id');
            $table->unsignedBigInteger('station_id');
            $table->string('status');
            $table->timestamps();
            $table->foreign('st_id')->references('id')->on('schedule_times');
            $table->foreign('station_id')->references('id')->on('stations');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('schedule_route_orders');
    }
};
