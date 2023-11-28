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
        Schema::create('lost_found_items', function (Blueprint $table) {
            $table->id();
            $table->string('u_id');
            $table->string('type');
            $table->string('item_name');
            $table->text('description');
            $table->string('img1')->nullable();
            $table->string('img2')->nullable();
            $table->string('img3')->nullable();
            $table->string('img4')->nullable();
            $table->datetime('is_submit_station')->nullable();
            $table->bigInteger('station_id')->nullable();
            $table->bigInteger('officer_id')->nullable();
            $table->datetime('is_release')->nullable();
            $table->text('release_info')->nullable();
            $table->string('release_tp')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('lost_found_items');
    }
};
