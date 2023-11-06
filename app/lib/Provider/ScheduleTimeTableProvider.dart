import 'dart:core';
import 'dart:developer';

import 'package:app/Models/StationModel.dart';

import '../Models/ScheduleTimeTableModel.dart';
import '../Services/my_api.dart';

class ScheduleTimeProvider {
  static Future<ScheduleTimeTableModel?> getScheduleTimeList(dynamic data) async {
    var response = await CallApi().postData(data,'time-table');
    if (response.statusCode == 200) {
      log(response.body);
      return scheduleTimeTableModelFromJson(response.body);
    } else {
      return null;
    }
  }
}
