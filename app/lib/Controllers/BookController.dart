import 'package:app/Models/StationModel.dart';
import 'package:app/Provider/BookProvider.dart';
import 'package:app/Provider/StationProvider.dart';
import 'package:get/get.dart';

import '../Models/BookModel.dart';

class BookController extends GetxController{
  var list = <BookModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  Future<void> getList() async {
    var res = await BookProvider.getBookList();
    list.assignAll(res);
  }

  BookModel? findById(int id) {
    for (var item in list) {
      if (item.id == id) {
        return item;
      }
    }
    return null; // Return null if the item is not found
  }
}