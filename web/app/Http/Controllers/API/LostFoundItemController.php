<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\LostFoundItem;
use Illuminate\Http\Request;

class LostFoundItemController extends Controller
{
    public function index() {
        return LostFoundItem::all();
    }
    public function lostItemCreate(Request $request) {
        $lostFoundItem = LostFoundItem::create([
            'u_id'=>$request->u_id,
            'type'=>$request->type,
            'item_name'=>$request->item_name,
            'description'=>$request->description,
            'img1'=>$request->img1 ?? null,
            'img2'=>$request->img2 ?? null,
            'img3'=>$request->img3 ?? null,
            'img4'=>$request->img4 ?? null,
        ]);
        if (!is_null($request->img1)) {
            $image = time() . '-lostFoundItem' . '.' . $request->img1->extension();
            $request->file('img1',)->storeAs('lost-found-item/', $image);

            $lostFoundItem->img1 = $image;
            $lostFoundItem->save();
        }
        if (!is_null($request->img2)) {
            $image = time() . '-lostFoundItem' . '.' . $request->img2->extension();
            $request->file('img2',)->storeAs('lost-found-item/', $image);

            $lostFoundItem->img2 = $image;
            $lostFoundItem->save();
        }
        if (!is_null($request->img3)) {
            $image = time() . '-lostFoundItem' . '.' . $request->img3->extension();
            $request->file('img1',)->storeAs('lost-found-item/', $image);

            $lostFoundItem->img3 = $image;
            $lostFoundItem->save();
        }
        if (!is_null($request->img4)) {
            $image = time() . '-lostFoundItem' . '.' . $request->img4->extension();
            $request->file('img4',)->storeAs('lost-found-item/', $image);

            $lostFoundItem->img4 = $image;
            $lostFoundItem->save();
        }
    }
    public function updateStation(Request $request,LostFoundItem $item) {
        return $item->update([
            'station_id'=>$request->station_id,
            'officer_id'=>$request->officer_id
        ]);
    }
    public function updateRelease(Request $request,LostFoundItem $item) {
        return $item->update([
            'release_info'=>$request->release_info,
            'release_tp'=>$request->release_tp
        ]);
    }



}
