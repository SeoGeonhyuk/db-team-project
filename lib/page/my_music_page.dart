import 'package:flutter/material.dart';
import 'package:mugorithm/model/User.dart';

class MyMusicPage extends StatefulWidget {
  const MyMusicPage({Key? key}) : super(key: key);

  @override
  State<MyMusicPage> createState() => _MyMusicPageState();
}

class _MyMusicPageState extends State<MyMusicPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("my music init\n");
  }

  @override
  Widget build(BuildContext context) {
    print('my music\n');
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: Center(
        child: Text(
          'my music',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
