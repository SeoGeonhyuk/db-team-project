import 'package:flutter/material.dart';

class MusicItem extends StatefulWidget {
  final String title;
  final String artist;
  //final String imgUrl;

  const MusicItem({
    Key? key,
    required this.title,
    required this.artist,
  }) : super(key: key);

  @override
  State<MusicItem> createState() => _MusicItemState();
}

class _MusicItemState extends State<MusicItem> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black12,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          //이미지
          Container(
            width: 150,
            height: 170,
            child: Image.asset(
              'testImg/musicImg.jpg',
              fit: BoxFit.cover,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Column(
                children: [
                  //노래제목
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  // 아티스트
                  Text(widget.artist),
                ],
              ),
              IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  })
            ],
          ),
        ],
      ),
    );
  }
}
