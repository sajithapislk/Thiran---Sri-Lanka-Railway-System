import 'dart:developer';

import 'package:app/Models/StationModel.dart';
import 'package:app/Provider/StationProvider.dart';
import 'package:get/get.dart';

class StationController extends GetxController{
  var list = <StationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  Future<void> getList() async {
    var res = await StationProvider.getStationList();
    list.assignAll(res);
    log(list.length.toString());
  }
}