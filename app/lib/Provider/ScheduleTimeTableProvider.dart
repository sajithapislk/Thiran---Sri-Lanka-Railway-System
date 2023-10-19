import 'dart:core';
import 'dart:developer';

import 'package:app/Models/StationModel.dart';

import '../Models/ScheduleTimeTableModel.dart';
import '../my_api.dart';

class ScheduleTimeProvider {
  static Future<List<ScheduleTimeTableModel>> getScheduleTimeList(dynamic data) async {
    var response = await CallApi().postData(data,'time-table');
    if (response.statusCode == 200) {
      return scheduleTimeTableModelFromJson(response.body);
    } else {
      return [];
    }
  }
}
