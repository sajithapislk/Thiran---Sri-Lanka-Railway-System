import 'dart:convert';
import 'dart:core';

import 'package:app/Models/StationModel.dart';

import '../Services/my_api.dart';

class StationProvider {
  static Future<List<StationModel>> getStationList() async {
    var response = await CallApi().getData('station');
    if (response.statusCode == 200) {
      return stationModelFromJson(response.body);
    } else {
      return [];
    }
  }
}
