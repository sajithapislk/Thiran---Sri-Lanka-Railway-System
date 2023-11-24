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
  int stId;
  MapController({required this.stationIdList,required this.stId});
  final _stationController = Get.put(StationController());
  final is_loaded = true.obs;

  // List<int>? stationIdList = [1,2,3,4,5,6,7,8,9];

  String googleMapAPI = 'AIzaSyBFDrC2GwE-H1BnJpVhGgW_EUoZLdXt_Us';

  late Rx<LatLng> currectLocation;

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
    await _schedule_times();
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

  Future<void> _schedule_times() async {
    var res = await MapProvider.getCurrentLocation(stId);
    try {
      currectLocation.value = LatLng(double.parse(res!.latitude),double.parse(res.longitude));
    }catch(e){
      log("error");
    }
  }
}
