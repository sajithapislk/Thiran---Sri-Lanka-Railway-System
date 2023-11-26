import 'dart:developer';

import 'package:app/Provider/ComplainProvider.dart';
import 'package:get/get.dart';

class ComplainController extends GetxController{
  Future<void> create({required String text}) async {
    var res = await ComplainProvider.create({"note":text});
    if(res) {
      log("sucess");
    }
  }
}