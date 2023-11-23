import 'dart:ffi';
import 'dart:math';

import 'package:app/Models/TrainLocationModel.dart';
import 'package:location/location.dart';

import '../Services/my_api.dart';

class MapProvider {
  static Future<TrainLocationModel?> getCurrentLocation(stId) async {
    var response = await CallApi().getData('train_locations/${stId}');
    if (response.statusCode == 200) {
      return trainLocationModelFromJson(response.body);
    } else {
      return null;
    }
  }
}
