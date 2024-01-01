import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad/home/HomePage.dart';

class HttpService {
  static final _client = http.Client();

  static final _loginUrl = Uri.parse('http://192.168.63.33:8080/api/login');

  static List(email, password, context) async {
    EasyLoading.show(status: 'loading...');
    // print('1asdsdasd');
    http.Response response = await _client
        .post(_loginUrl, body: {"email": email, "password": password});

    // print(response.statusCode);
    if (response.statusCode == 200) {
      // ignore: non_constant_identifier_names
// test@example.com
      EasyLoading.dismiss();
      var Users = jsonDecode(response.body);
      print(Users);
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("email", email);
      await pref.setString("id_user", Users['user']['id_user'].toString());
      await pref.setString("full_name", Users['user']['name'].toString());
      await pref.setString("role_id", Users['user']['role_id'].toString());
      await pref.setString("token", Users['token']);
      await pref.setBool("is_login", true);
      // print(object)

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const Homepage(),
        ),
        (route) => false,
      );
    } else {
      EasyLoading.showError('Login Gagal');
      EasyLoading.dismiss();
    }
  }
}
