import 'dart:developer';

import 'package:app/Provider/ComplainProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplainController extends GetxController{
  Future<void> create({required String text}) async {
    var res = await ComplainProvider.create({"note":text});
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