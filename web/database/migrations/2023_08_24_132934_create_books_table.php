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
        Schema::create('books', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('st_id');
            $table->unsignedBigInteger('seat_id');
            $table->unsignedBigInteger('payment_id');
            $table->datetime('entered_at')->nullable();
            $table->datetime('is_canceled')->nullable();
            $table->timestamps();
            $table->foreign('st_id')->references('id')->on('schedule_times');
            $table->foreign('seat_id')->references('id')->on('schedule_train_seats');
            $table->foreign('payment_id')->references('id')->on('payments');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('books');
    }
};
