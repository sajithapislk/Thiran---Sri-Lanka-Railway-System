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
        Schema::create('temp_reservations', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('st_id');
            $table->unsignedBigInteger('payment_id');
            $table->unsignedBigInteger('from_s_id');
            $table->unsignedBigInteger('to_s_id');
            $table->double('distance');
            $table->string('seat_type');
            $table->integer('nop'); //no of passenger
            $table->datetime('entered_at')->nullable();
            $table->datetime('ended_at')->nullable();
            $table->datetime('is_canceled')->nullable();
            $table->timestamps();
            $table->foreign('st_id')->references('id')->on('schedule_times');
            $table->foreign('payment_id')->references('id')->on('payments');
            $table->foreign('from_s_id')->references('id')->on('stations');
            $table->foreign('to_s_id')->references('id')->on('stations');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('temp_reservations');
    }
};
