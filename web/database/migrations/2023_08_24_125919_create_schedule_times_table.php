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
        Schema::create('schedule_times', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('train_id');
            $table->unsignedBigInteger('route_id');
            $table->datetime('start_at');
            $table->datetime('end_at');
            $table->string('status');
            $table->integer('acs_p_seats');
            $table->integer('os_p_seats');
            $table->integer('scrs_p_seats');
            $table->integer('tcrs_p_seats');
            $table->timestamps();
            $table->foreign('train_id')->references('id')->on('trains');
            $table->foreign('route_id')->references('id')->on('routes');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('schedule_times');
    }
};
