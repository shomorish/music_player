import 'dart:collection';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/data/models/music_model.dart';

class MusicProvider extends ChangeNotifier {
  // 曲一覧
  final List<MusicModel> _musicList = [
    MusicModel(
      musicName: 'ゴーストタウン',
      artistName: 'ゆうり',
      musicPath: 'assets/music/ゴーストタウン.mp3',
      imagePath: 'assets/images/ゴーストタウン.jpg',
    ),
    MusicModel(
      musicName: 'Morning',
      artistName: 'しゃろう',
      musicPath: 'assets/music/Morning.mp3',
      imagePath: 'assets/images/Morning.jpg',
    ),
    MusicModel(
      musicName: 'なんでしょう？',
      artistName: 'KK',
      musicPath: 'assets/music/なんでしょう？.mp3',
      imagePath: 'assets/images/なんでしょう？.jpg',
    ),
  ];
  UnmodifiableListView<MusicModel> get musicList =>
      UnmodifiableListView(_musicList);

  // 現在再生中の曲を示すインデックス
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  // 現在再生中の曲
  MusicModel get currentMusic => musicList[currentIndex];

  // AudioPlayer
  AudioPlayer _player = AudioPlayer();

  // 再生中フラグ
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  // 現在の再生位置
  Duration _currentDuration = const Duration();
  Duration get currentDuration => _currentDuration;

  // 現在の曲の長さ
  Duration _totalDuration = const Duration();
  Duration get totalDuration => _totalDuration;

  MusicProvider() {
    _player.audioCache.prefix = '';

    // 再生位置の更新
    _player.onPositionChanged.listen((duration) {
      _currentDuration = duration;
      notifyListeners();
    });

    // 曲の長さを更新
    _player.onDurationChanged.listen((duration) {
      _totalDuration = duration;
      notifyListeners();
    });

    // 曲の再生が完了した際の処理
    _player.onPlayerComplete.listen((event) {
      _isPlaying = false;
      notifyListeners();
    });
  }

  Future<void> selectMusic(int index) async {
    _currentIndex = index;
    await _player.setSourceAsset(musicList[index].musicPath);
    notifyListeners();
  }

  Future<void> playMusicFromBeginning() async {
    await _player.seek(const Duration(seconds: 0));
    await _player.resume();
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> pauseMusic() async {
    await _player.pause();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> resumeMusic() async {
    await _player.resume();
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> stopMusic() async {
    await _player.stop();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> disposePlayer() async {
    await _player.dispose();
  }

  Future<void> skipPrevious() async {
    if (currentDuration.inSeconds == 0) {
      if (currentIndex == 0) {
        await selectMusic(musicList.length - 1);
      } else {
        await selectMusic(currentIndex - 1);
      }
      if (isPlaying) await playMusicFromBeginning();
    } else {
      await _player.seek(const Duration());
    }
    notifyListeners();
  }

  Future<void> skipNext() async {
    await selectMusic((currentIndex + 1) % musicList.length);
    if (isPlaying) await playMusicFromBeginning();
    notifyListeners();
  }

  Future<void> seekMusic(double value) async {
    await _player
        .seek(Duration(seconds: (totalDuration.inSeconds * value).toInt()));
    notifyListeners();
  }
}
