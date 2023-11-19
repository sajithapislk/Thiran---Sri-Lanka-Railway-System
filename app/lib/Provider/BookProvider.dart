import 'dart:core';
import 'dart:developer';

import 'package:app/Models/BookModel.dart';
import 'package:app/Models/StationModel.dart';

import '../Services/my_api.dart';

class BookProvider {
  static Future<List<BookModel>> getBookList() async {
    var response = await CallApi().getData('user/book');
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      return bookModelFromJson(response.body);
    } else {
      return [];
    }
  }
}
