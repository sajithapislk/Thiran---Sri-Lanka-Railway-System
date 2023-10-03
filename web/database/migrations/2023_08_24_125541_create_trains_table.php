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
        Schema::create('trains', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('no');
            $table->integer('acs_max_seats'); // Air Conditioned Saloon
            $table->integer('os_max_seats'); // Observation Saloon
            $table->integer('scrs_max_seats'); // Second Class Reserved Seats
            $table->integer('tcrs_max_seats'); // Third Class Reserved Seats
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('trains');
    }
};
