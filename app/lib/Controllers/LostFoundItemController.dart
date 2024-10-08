import 'dart:developer';

import 'package:app/Models/LostFoundItemModel.dart';
import 'package:app/Provider/LostFoundItemProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LostFoundItemController extends GetxController {
  var list = <LostFoundItemModel>[].obs;
  final is_loaded = true.obs;

  @override
  void onInit() {
    super.onInit();
    getList();
  }
  Future<void> getList() async {
    var res = await LostFoundItemProvider.list();
    list.assignAll(res);
    is_loaded(false);
  }
  Future<void> create({required dynamic data}) async {
    var res = await LostFoundItemProvider.create(data);
    if(res) {
      Get.defaultDialog(
        title: "Sucess",
        middleText: "Sucess",
        backgroundColor: Colors.green,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),

      );
    }
  }
}