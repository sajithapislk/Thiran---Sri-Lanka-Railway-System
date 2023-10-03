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
        Schema::create('ticket_prices', function (Blueprint $table) {
            $table->id();
            $table->integer('beyond');
            $table->integer('above');
            $table->double('price',8,2);
            $table->integer('acs_price'); // Air Conditioned Saloon
            $table->integer('os_price'); // Observation Saloon
            $table->integer('scrs_price'); // Second Class Reserved Seats
            $table->integer('tcrs_price'); // Third Class Reserved Seats
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ticket_prices');
    }
};
