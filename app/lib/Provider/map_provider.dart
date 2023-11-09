import 'dart:math';

import 'package:location/location.dart';

class MapProvider {
  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static Future<LocationData> getCurrentLocation() async {
    LocationData location = await Location().getLocation();
    return location;
  }
}
