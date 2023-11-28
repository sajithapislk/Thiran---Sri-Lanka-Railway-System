import 'dart:developer';

import '../Services/my_api.dart';

class LostFoundItemProvider{
  static Future<bool> create(dynamic data) async {
    var response = await CallApi().postData(data, 'user/complain');
    log(response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}