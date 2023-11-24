import 'package:flutter/material.dart';

import 'all_music_page.dart';
import 'my_music_page.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  int _currentIndex = 0;

  final List<Widget> _page = [
    AllMusicPage(),
    MyMusicPage(),
  ];

  @override
  Widget build(BuildContext context) {
    print('route page\n');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor:
            _currentIndex == 0 ? Colors.white : Colors.indigoAccent,
        elevation: 2,
        title: Text(
          'Mugorithm',
          style: TextStyle(
            color: _currentIndex == 0 ? Colors.indigoAccent : Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _page[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            _currentIndex == 0 ? Colors.white : Colors.indigoAccent,
        currentIndex: _currentIndex,
        selectedItemColor:
            _currentIndex == 0 ? Colors.indigoAccent : Colors.white,
        elevation: 10,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          //하단 메뉴바 아이템들
          BottomNavigationBarItem(
            icon: Icon(Icons.queue_music),
            label: 'music',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_music),
            label: 'my music',
          ),
        ],
      ),
    );
  }
}
