import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mugorithm/model/User.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  User? _user;

  final String _userApi = 'http://localhost/login'; // 유저 정보 확인 api

  // user getter
  User? get user => _user;

  // 비동기로 유저 존재 유무 확인
  Future<void> fetchUserDataFromServer(String email, String password) async {
    User user = User(email: email, password: password); // 입력받은 유저 정보

    final response = await http.post(Uri.parse(_userApi),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }));
    if (response.statusCode == 200) {
      // 유저 존재
      print("api 작동");
      _user = user;
    } else {
      // 유전 존재 안함
      print("유저 없음");
      _user = null;
    }

    // // test용
    // bool isUser = false;
    // // 데이터를 가져오는 가정을 2초로 비동기 처리
    // await Future.delayed(Duration(seconds: 2));
    // isUser = true; //존재로 가정
    // //유저 존재하면 저장 없으면 널 값
    // if (isUser) {
    //   _user = user;
    // } else {
    //   _user = null;
    // }

    notifyListeners();
  }
}
