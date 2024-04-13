class MusicModel {
  // 曲名
  final String musicName;

  // アーティスト名
  final String artistName;

  // 曲のパス
  final String musicPath;

  // 画像のパス
  final String imagePath;

  MusicModel({
    required this.musicName,
    required this.artistName,
    required this.musicPath,
    required this.imagePath,
  });
}
