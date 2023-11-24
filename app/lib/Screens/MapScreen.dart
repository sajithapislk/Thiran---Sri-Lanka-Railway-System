import 'dart:async';
import 'dart:developer';

import 'package:app/Controllers/MapController.dart';
import 'package:app/Models/BookModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  BookModel bookModel;
  MapScreen({super.key,required this.bookModel});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = Get.put(MapController(
      stationIdList: widget.bookModel.scheduleTime.route.stationList,
      stId: widget.bookModel.stId
    ));
    setCustomIcon();
    getLocationUpdates().then(
      (_) => {
        getPolylinePoints().then((coordinates) => {
              generatePolyLineFromPoints(coordinates),
            }),
      },
    );
  }

  // Location _locationController = new Location();
  BitmapDescriptor stationLocationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor trainLocationIcon = BitmapDescriptor.defaultMarker;

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  Map<PolylineId, Polyline> polylines = {};


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => mapController.stationList.isEmpty
            ? const Center(
                child: Text("Loading..."),
              )
            : GoogleMap(
                onMapCreated: ((GoogleMapController controller) =>
                    _mapController.complete(controller)),
                initialCameraPosition: CameraPosition(
                  target: mapController.stationList[0],
                  zoom: 50,
                ),
                markers: {
                  ...mapController.stationList.asMap().entries.map((entry) {
                    return Marker(
                      markerId: MarkerId(entry.key.toString()),
                      icon: stationLocationIcon,
                      position: entry.value,
                    );
                  }),
                  Marker(
                    markerId: MarkerId("additionalMarker1"),
                    icon: trainLocationIcon,
                    position: LatLng(7.4037763,80.6436449),
                  )
                },
                polylines: Set<Polyline>.of(polylines.values),
              ),
      ),
    );
  }

  Future<void> _cameraToPosition() async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: LatLng(mapController.stationList.first.latitude,
          mapController.stationList.first.longitude),
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    while (mapController.is_loaded.value) {
      await Future.delayed(Duration(
          milliseconds: 100)); // Add a small delay to avoid busy-waiting
    }
    _cameraToPosition();

    // _locationController.onLocationChanged
    //     .listen((LocationData currentLocation) {
    //   if (currentLocation.latitude != null &&
    //       currentLocation.longitude != null) {
    //     setState(() {
    //       _currentP =
    //           LatLng(currentLocation.latitude!, currentLocation.longitude!);
    //       _currentP = LatLng(7.372055, 80.617687);
    //       // _cameraToPosition(_currentP!);
    //     });
    //   }
    // });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    if (mapController.stationList.isEmpty) {
      log("mapController.stationList.isEmpty");
      return [];
    }

    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      mapController.googleMapAPI,
      PointLatLng(mapController.stationList.first.latitude,
          mapController.stationList.first.longitude),
      PointLatLng(mapController.stationList.last.latitude,
          mapController.stationList.last.longitude),
      travelMode: TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 8);
    setState(() {
      polylines[id] = polyline;
    });
  }

  void setCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/icon/train_96px.png")
        .then(
      (icon) {
        stationLocationIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/icon/train_192px.png")
        .then(
          (icon) {
        trainLocationIcon = icon;
      },
    );
  }

  void setTrainIcon() {

  }
}
