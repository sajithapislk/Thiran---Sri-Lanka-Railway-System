import 'dart:developer';

import '../Models/LostFoundItemModel.dart';
import '../Services/my_api.dart';

class LostFoundItemProvider{
  static Future<bool> create(dynamic data) async {
    var response = await CallApi().postData(data, 'user/lost-found-item');
    log(response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
  static Future<List<LostFoundItemModel>> list() async {
    var response = await CallApi().getData('user/lost-found-item');
    if (response.statusCode == 200) {
      return lostFoundItemModelFromJson(response.body);
    } else {
      return [];
    }
  }
}