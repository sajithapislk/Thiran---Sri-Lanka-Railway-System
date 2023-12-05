import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  final String url = 'http://192.168.8.181:8000/api/';

  Future<http.Response> postData(data, apiUrl) async {
    var fullUrl = url + apiUrl;
    log(fullUrl);
    var response = await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: await _getToken(),
      },
    );
    log(response.body);
    return response;
  }

  Future<http.Response> getData(apiUrl) async {
    var fullUrl = url + apiUrl;
    log(fullUrl);

    var response = await http.get(
      Uri.parse(fullUrl),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: await _getToken(),
      },
    );
    log(response.body);
    return response;
  }

  Future<String> _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return 'Bearer $token';
  }
}
