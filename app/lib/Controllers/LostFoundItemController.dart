import 'dart:developer';

import 'package:app/Provider/LostFoundItemProvider.dart';
import 'package:get/get.dart';

class LostFoundItemController extends GetxController {
  Future<void> create({required dynamic data}) async {
    var res = await LostFoundItemProvider.create(data);
    if(res) {
      log("sucess");
    }
  }
}