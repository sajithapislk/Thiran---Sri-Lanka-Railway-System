import 'dart:developer' as dev;

import 'package:app/provider/map_provider.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapController extends GetxController {
  String googleMapAPI = 'AIzaSyBe3BIrxawrbRurIlbus2HuAta9caIuD3g';
  List<LatLng> _polylineCoordinates = [];
  late LocationData currentLocation;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> _getPolyPoints(
      {required PointLatLng sourceLocation,
      required PointLatLng destination}) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapAPI, // Your Google Map Key
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => _polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
    }
  }

  Future<void> getCurrentLocation() async {
    currentLocation = await MapProvider.getCurrentLocation();
  }

  Future<String> getDistance(double lat, double lon) async {
    _polylineCoordinates.clear();

    await _getPolyPoints(
        sourceLocation:
            PointLatLng(currentLocation.latitude!, currentLocation.longitude!),
        destination: PointLatLng(lat, lon));

    double totalDistance = 0;
    for (var i = 0; i < _polylineCoordinates.length - 1; i++) {
      totalDistance += MapProvider.calculateDistance(
          _polylineCoordinates[i].latitude,
          _polylineCoordinates[i].longitude,
          _polylineCoordinates[i + 1].latitude,
          _polylineCoordinates[i + 1].longitude);
    }
    dev.log(totalDistance.toString());
    return totalDistance.toStringAsFixed(2);
  }

  Future<void> getDistance_monitorPlace(
      {required String monitorPlaceId,
      required double lat,
      required double lon,
      int isDanger = 0}) async {
    try{
      _polylineCoordinates.clear();

      await _getPolyPoints(
          sourceLocation:
          PointLatLng(currentLocation.latitude!, currentLocation.longitude!),
          destination: PointLatLng(lat, lon));

      double totalDistance = 0;
      for (var i = 0; i < _polylineCoordinates.length - 1; i++) {
        totalDistance += MapProvider.calculateDistance(
            _polylineCoordinates[i].latitude,
            _polylineCoordinates[i].longitude,
            _polylineCoordinates[i + 1].latitude,
            _polylineCoordinates[i + 1].longitude);
      }
      dev.log(totalDistance.toString());
      if (totalDistance <= 5 && totalDistance != 0 && isDanger == 1) {
        // RiskUserController().create(
        //     monitor_place_id: monitorPlaceId,
        //     distance: totalDistance.toStringAsFixed(2),
        //     lat: lat.toString(),
        //     lon: lon.toString());
      }
    }catch(e){

    }
  }
}
