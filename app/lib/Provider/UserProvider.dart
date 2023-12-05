import 'dart:convert';

import 'package:get/get.dart';

import '../Models/UserLoginModel.dart';
import '../Services/my_api.dart';

class UserProvider {
  static Future<UserLoginModel> login(dynamic data) async {
    var response = await CallApi().postData(data, 'user/login');
    if (response.statusCode == 201) {
      return userLoginModelFromJson(response.body);
    } else {
      var jsonMap = json.decode(response.body);
      var errors = jsonMap['errors'];
      String msg = "";

      errors.forEach((key, value) {
        msg = '$key errors:';
        // print('$key errors:');
        value.forEach((message) => msg += '- $message');
      });

      Get.defaultDialog(
          title: jsonDecode(response.body)["message"],
          middleText: msg,
          radius: 30);
      return UserLoginModel(token: null, user: null);
    }
  }

  static Future<void> logout() async {
    await CallApi().getData('user/logout');
  }

  static Future<dynamic> create(dynamic data) async {
    var response = await CallApi().postData(data, 'user/store');
    if (response.statusCode == 201) {
       return jsonDecode(response.body);
    } else {
      var jsonMap = json.decode(response.body);
      var errors = jsonMap['errors'];
      String msg = "";

      errors.forEach((key, value) {
        msg = '$key errors:';
        // print('$key errors:');
        value.forEach((message) => msg += '- $message');
      });

      Get.defaultDialog(
          title: jsonDecode(response.body)["message"],
          middleText: msg,
          radius: 30);
      return UserLoginModel(token: null, user: null);
    }
  }
}
