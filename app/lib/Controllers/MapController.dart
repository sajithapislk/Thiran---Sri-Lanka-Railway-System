import 'dart:developer';

import 'package:app/Controllers/StationController.dart';
import 'package:app/Models/BookModel.dart';
import 'package:app/provider/MapProvider.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapController extends GetxController {
  List<int>? stationIdList;
  MapController(this.stationIdList);
  final _stationController = Get.put(StationController());
  final is_loaded = true.obs;

  // List<int>? stationIdList = [1,2,3,4,5,6,7,8,9];

  String googleMapAPI = 'AIzaSyBFDrC2GwE-H1BnJpVhGgW_EUoZLdXt_Us';

  final pGooglePlex = LatLng(7.3505661,80.6800127).obs;
  final pApplePark = LatLng(7.4203979,80.6315839).obs;

  RxList<LatLng> stationList = <LatLng>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _polylines();
  }
  Future<void> _waitForLoaded() async {
    while (_stationController.is_loaded.value) {
      await Future.delayed(Duration(milliseconds: 100)); // Add a small delay to avoid busy-waiting
    }
  }
  Future<void> _polylines() async {
    await _waitForLoaded();
    stationIdList?.forEach((int element) {
      final station = _stationController.findById(element);
      if (station != null) {
        if (station.latitude == "" || station.longitude == "") {
          log('#empty');
          return;
        }

        LatLng newLatLng = LatLng(
            double.parse(station.latitude), double.parse(station.longitude));

        stationList.add(newLatLng);
      }
    });
    log(stationList.length.toString());
    is_loaded(false);
  }

  Future<void> schedule_times({required stId }) async {
    var res = await MapProvider.getCurrentLocation(stId);

  }
}
