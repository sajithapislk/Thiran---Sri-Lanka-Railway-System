import 'dart:developer';

import 'package:app/Models/StationModel.dart';
import 'package:app/Provider/StationProvider.dart';
import 'package:get/get.dart';

import '../Models/ScheduleTimeTableModel.dart';
import '../Provider/ScheduleTimeTableProvider.dart';

class ScheduleTimeTableController extends GetxController {
  var list = <ScheduleTimeTableModel>[].obs;

  Future<void> getList({
    required String from,
    required String to,
    required String date,
  }) async {
    var data = {"from": from, "to": to, "date": date};

    var res = await ScheduleTimeProvider.getScheduleTimeList(data);
    list.assignAll(res);
  }
}
