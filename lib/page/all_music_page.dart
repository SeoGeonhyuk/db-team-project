import 'package:flutter/material.dart';
import 'package:mugorithm/page/my_music_page.dart';

class AllMusicPage extends StatefulWidget {
  const AllMusicPage({Key? key}) : super(key: key);

  @override
  State<AllMusicPage> createState() => _AllMusicPageState();
}

class _AllMusicPageState extends State<AllMusicPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("all music init\n");
  }

  @override
  Widget build(BuildContext context) {
    print('all music\n');
    return Scaffold(
      body: Center(
        child: Text(
          'all music page',
        ),
      ),
    );
  }
}
