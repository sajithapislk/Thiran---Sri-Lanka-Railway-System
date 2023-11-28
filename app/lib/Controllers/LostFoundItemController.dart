import 'dart:developer';

import 'package:app/Provider/LostFoundItemProvider.dart';
import 'package:get/get.dart';

class LostFoundItemController extends GetxController {
  Future<void> create({required String text}) async {
    var res = await LostFoundItemProvider.create({"note":text});
    if(res) {
      log("sucess");
    }
  }
}