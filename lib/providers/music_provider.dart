import 'package:flutter/material.dart';
import 'package:mugorithm/model/music.dart';

class MusicProvider extends ChangeNotifier {
  List<Music> _allMusicList = [];

  List<Music> get allMusicList => _allMusicList;
}
