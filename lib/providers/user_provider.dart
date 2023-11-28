import 'package:flutter/material.dart';
import 'package:mugorithm/model/User.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  User? _user;
  final String _userApi = 'user api path'; // 유저 정보 확인 api

  // user getter
  User? get user => _user;

  // 비동기로 유저 존재 유무 확인
  Future<void> fetchUserDataFromServer(String email, String password) async {
    User user = User(email: email, password: password); // 입력받은 유저 정보

    // 서버로 데이터 전송 (여기를 수정 해야함)
    /*
    try {
      final response = await http.post(Uri.parse(_userApi), body: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        // 유저 존재
        _user = user;
      } else {
        // 유전 존재 안함
        _user = null;
      }
    } catch (e) {
      print('오류 발생 : $e');
    }
    */

    // test용
    bool isUser = false;
    // 데이터를 가져오는 가정을 2초로 비동기 처리
    await Future.delayed(Duration(seconds: 2));
    isUser = true; //존재로 가정
    //유저 존재하면 저장 없으면 널 값
    if (isUser) {
      _user = user;
    } else {
      _user = null;
    }

    notifyListeners();
  }
}
