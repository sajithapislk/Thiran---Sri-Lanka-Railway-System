import 'dart:developer';

import 'package:get/get.dart';

import '../Models/ScheduleTimeTableModel.dart';
import '../Provider/ScheduleTimeTableProvider.dart';

class ScheduleTimeTableController extends GetxController {
  var list = <Schedule>[].obs;
  var distance = 0.00.obs;
  var acs_price =0.00.obs;
  var os_price =0.00.obs;
  var scrs_price =0.00.obs;
  var tcrs_price =0.00.obs;

  Future<void> getList({
    required String from,
    required String to,
    required String date,
  }) async {
    var data = {"from": from, "to": to, "date": date};
    log(data.toString());
    try {
      var res = await ScheduleTimeProvider.getScheduleTimeList(data);
      if (res != null) {
        distance(res.distance);
        list.assignAll(res.schedules);
        acs_price(res.price.acsPrice);
        os_price(res.price.osPrice);
        scrs_price(res.price.scrsPrice);
        tcrs_price(res.price.tcrsPrice);
      }else{
        distance(0.0);
        list.clear();
        acs_price(0.00);
        os_price(0.00);
        scrs_price(0.00);
        tcrs_price(0.00);
      }
    }on Exception catch (e) {
      distance(0.0);
      list.clear();
      acs_price(0.00);
      os_price(0.00);
      scrs_price(0.00);
      tcrs_price(0.00);
    }
  }
}
