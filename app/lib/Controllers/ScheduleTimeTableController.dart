import 'package:get/get.dart';

import '../Models/ScheduleTimeTableModel.dart';
import '../Provider/ScheduleTimeTableProvider.dart';

class ScheduleTimeTableController extends GetxController {
  var list = <Schedule>[].obs;
  var distance = 0.obs;
  var acs_price =0.obs;
  var os_price =0.obs;
  var scrs_price =0.obs;
  var tcrs_price =0.obs;

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
      acs_price(res.price.acsPrice);
      os_price(res.price.osPrice);
      scrs_price(res.price.scrsPrice);
      tcrs_price(res.price.tcrsPrice);
    }
  }
}
