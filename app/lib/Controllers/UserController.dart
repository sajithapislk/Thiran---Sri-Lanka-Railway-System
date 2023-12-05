import 'package:app/Screens/HomeScreen.dart';
import 'package:app/Screens/LoginScreen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/UserLoginModel.dart';
import '../Provider/UserProvider.dart';

class UserController extends GetxController {
  final userName = "".obs;

  Future<void> login({required String email, required String password}) async {
    var data = {"email": email, "password": password};
    var res = await UserProvider.login(data);
    if (res.token == null) {
      print("empty");

      return;
    }
    sessionSave(res);
    Get.offAll(() => const HomeScreen());
  }

  Future<void> logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    await localStorage.remove('user_id');
    await localStorage.remove('user_name');
    await localStorage.remove('token');

    await UserProvider.logout();

    Get.offAll(() => const LoginScreen());
  }

  Future<void> create(
      {required String name,
      required String email,
      required String password
      }) async {
    var data = {
      "name": name,
      "email": email,
      "password": password,
    };
    var res = await UserProvider.create(data);

    if (res.token == null) {
      return;
    }
    sessionSave(res);
    Get.offAll(() => const HomeScreen());
  }

  void sessionSave(UserLoginModel res) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    localStorage.setString('user_id', res.user!.id.toString());
    localStorage.setString('user_name', res.user!.name.toString());
    localStorage.setString('token', res.token!);

    userName(localStorage.getString('user_name'));
  }
}
