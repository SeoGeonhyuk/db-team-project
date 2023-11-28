import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mugorithm/model/User.dart';
import 'package:mugorithm/model/music.dart';
import 'package:http/http.dart' as http;
import 'package:mugorithm/providers/user_provider.dart';

class MusicProvider extends ChangeNotifier {
  List<Music> _allMusicList = [];

  List<Music> get allMusicList => _allMusicList;

  final String _allMusicApi = '전체 뮤직 api 주소';

  Future<void> fetchAllMusicList(User user) async {
    // 실제 동작 부분
    /*  try {
      final response = await http.get(Uri.parse(_allMusicApi));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _allMusicList = data.map((json) => Music.fromJson(json)).toList();
      } else {
        print('서버 응답 실패. 상태 코드: ${response.statusCode}');
      }
    } catch (e) {
      print('오류 발생: $e');
    }*/

    final List<Map<String, dynamic>> fakeMusicData = [
      {
        'title': 'Song 1',
        'artist': 'Artist 1',
      },
      {
        'title': 'Song 2',
        'artist': 'Artist 2',
      },
      {
        'title': 'Song 3',
        'artist': 'Artist 3',
      },
      {
        'title': 'Song 4',
        'artist': 'Artist 4',
      },
      {
        'title': 'Song 5',
        'artist': 'Artist 5',
      },
      {
        'title': 'Song 6',
        'artist': 'Artist 6',
      },
      {
        'title': 'Song 7',
        'artist': 'Artist 7',
      },
      {
        'title': 'Song 8',
        'artist': 'Artist 8',
      },
      {
        'title': 'Song 9',
        'artist': 'Artist 9',
      },
      {
        'title': 'Song 10',
        'artist': 'Artist 10',
      },

      // 추가적인 더미 데이터
    ];

    _allMusicList = fakeMusicData.map((json) => Music.fromJson(json)).toList();
    //테스트 부분
    await Future.delayed(Duration(seconds: 2));
    print("future\n");
    notifyListeners();
    print('Data updated: ${_allMusicList.length} items');
  }
}
