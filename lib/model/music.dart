class Music {
  final String title;
  final String artist;
  //final String albumImage; // 이미지를 어떻게 주고 받을지 고민해봐야함

  Music({
    required this.title,
    required this.artist,
    // required this.albumImage,
  });

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
      title: json['title'] ?? '', // title이 없으면 공백으로 저장
      artist: json['artist'] ?? '',
      // albumImage: json['albumImage'] ?? '', // 이건 논의를 해봐야함
    );
  }
}
