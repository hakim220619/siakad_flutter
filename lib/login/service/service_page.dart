import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad/home/HomePage.dart';

class HttpService {
  // static final _client = http.Client();

  // static var _loginUrl = Uri.parse('http://batu.dlhcode.com/api/login');
  static login(email, password, context) async {
    // bool isLoading = false;
    // http.Response response = await _client
    //     .post(_loginUrl, body: {"email": email, "password": password});
    // if (response.statusCode == 200) {
    //   var Users = jsonDecode(response.body);
    // print(Users);
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("email", email);
    // await pref.setString("id_user", Users['user']['id'].toString());
    // await pref.setString("role_id", Users['user']['role_id'].toString());
    // await pref.setString("token", Users['data']);
    await pref.setBool("is_login", true);
    EasyLoading.show(status: 'loading...');
    EasyLoading.removeAllCallbacks();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const Homepage(),
      ),
      (route) => false,
    );
  }
}
// }
