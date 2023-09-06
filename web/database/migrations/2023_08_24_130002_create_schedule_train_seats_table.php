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
        Schema::create('schedule_train_seats', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('st_id');
            $table->integer('is_available')->default(true);
            $table->timestamps();
            $table->foreign('st_id')->references('id')->on('schedule_times');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('schedule_train_seats');
    }
};
