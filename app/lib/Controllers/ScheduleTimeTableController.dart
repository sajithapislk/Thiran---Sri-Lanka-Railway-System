import 'package:get/get.dart';

import '../Models/ScheduleTimeTableModel.dart';
import '../Provider/ScheduleTimeTableProvider.dart';

class ScheduleTimeTableController extends GetxController {
  var list = <Schedule>[].obs;
  var distance = 0.obs;

  Future<void> getList({
    required String from,
    required String to,
    required String date,
  }) async {
    var data = {"from": from, "to": to, "date": date};

    var res = await ScheduleTimeProvider.getScheduleTimeList(data);
    if (res != null){
      distance(res.distance);
      list.assignAll(res.schedules);
    }
  }
}
