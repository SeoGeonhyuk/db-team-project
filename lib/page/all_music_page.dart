import 'package:flutter/material.dart';
import 'package:mugorithm/model/User.dart';
import 'package:mugorithm/page/my_music_page.dart';
import 'package:mugorithm/providers/music_provider.dart';
import 'package:mugorithm/providers/user_provider.dart';
import 'package:mugorithm/widgets/music_list_view.dart';
import 'package:provider/provider.dart';

class AllMusicPage extends StatelessWidget {
  const AllMusicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*User? user = context.watch<UserProvider>().user; //userProvider에서 data 가져오기
    print(user?.email); // login정보가 넘어오는지 테스트*/
    print('all music\n');
    final musicProvider = Provider.of<MusicProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    musicProvider.fetchAllMusicList(userProvider.user!);

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // all music list view
        Consumer<MusicProvider>(
          builder: (context, musciProvider, child) {
            if (musicProvider.allMusicList.isEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      '뮤직 리스트',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  MusicListView(musicList: musicProvider.allMusicList),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      '추천 뮤직 리스트',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  MusicListView(musicList: musicProvider.allMusicList),
                ],
              );
            }
          },
        ),
      ],
    ));
  }
}
