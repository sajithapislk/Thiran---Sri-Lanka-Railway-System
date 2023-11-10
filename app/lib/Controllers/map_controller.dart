import 'dart:developer' as dev;

import 'package:app/provider/map_provider.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapController extends GetxController {
  String googleMapAPI = 'AIzaSyBe3BIrxawrbRurIlbus2HuAta9caIuD3g';
  final pGooglePlex = LatLng(7.3505661,80.6800127).obs;
  final pApplePark = LatLng(7.4203979,80.6315839).obs;

  // Future<void> schedule_times({required String }) async {
  //   var data = {"st_id": 'email', "password": 'password'};
  //   var res = await MapProvider.login(data);
  //   if (res.token == null) {
  //     print("empty");
  //     return;
  //   }
  // }
}
