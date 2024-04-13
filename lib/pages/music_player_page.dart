import 'package:flutter/material.dart';
import 'package:music_player/components/gradient_box.dart';
import 'package:music_player/components/ink_button.dart';
import 'package:music_player/data/providers/music_provider.dart';
import 'package:music_player/utils/format.dart';
import 'package:music_player/utils/math.dart';
import 'package:provider/provider.dart';

class MusicPlayerPage extends StatelessWidget {
  const MusicPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<MusicProvider>(context, listen: false)
          .playMusicFromBeginning(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Navigator.pop(context);
        }
        return PopScope(
          // 前の画面に戻るときに音楽を停止する
          onPopInvoked: (didPop) =>
              Provider.of<MusicProvider>(context, listen: false).stopMusic(),
          child: Consumer<MusicProvider>(
            builder: (context, musicProvider, child) {
              final music = musicProvider.currentMusic;
              return Scaffold(
                body: GradientBox(
                  imageProvider: Image.asset(music.imagePath).image,
                  child: Column(
                    children: [
                      // 上部バー
                      AppBar(
                        backgroundColor: Colors.transparent,
                      ),

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 画像
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                music.imagePath,
                                width: 300,
                                height: 300,
                                fit: BoxFit.fill,
                              ),
                            ),

                            const SizedBox(height: 24),

                            // 曲名
                            Text(
                              music.musicName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // アーティスト名
                            Text(music.artistName),

                            // シークバー
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: Colors.green.shade300,
                                    thumbShape: SliderComponentShape.noThumb,
                                    trackHeight: 2,
                                  ),
                                  child: Slider(
                                    value: safeDivide(
                                      musicProvider.currentDuration.inSeconds,
                                      musicProvider.totalDuration.inSeconds,
                                    ),
                                    onChanged: (value) {
                                      musicProvider.seekMusic(value);
                                    },
                                    onChangeStart: (value) {
                                      musicProvider.pauseMusic();
                                    },
                                    onChangeEnd: (value) {
                                      musicProvider.resumeMusic();
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(formattedMinSec(
                                          musicProvider.currentDuration)),
                                      Text(formattedMinSec(
                                          musicProvider.totalDuration)),
                                    ],
                                  ),
                                )
                              ],
                            ),

                            const SizedBox(height: 24),

                            // 各ボタン
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  // 前の曲へ
                                  Expanded(
                                    child: InkButton(
                                      borderRadius: BorderRadius.circular(12),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      onTap: musicProvider.skipPrevious,
                                      child: const Icon(
                                        Icons.skip_previous_rounded,
                                        size: 32,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 16),

                                  // 再生 / 一時停止
                                  Expanded(
                                    flex: 2,
                                    child: InkButton(
                                      borderRadius: BorderRadius.circular(12),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      onTap: () {
                                        if (musicProvider.isPlaying) {
                                          musicProvider.pauseMusic();
                                        } else {
                                          musicProvider.resumeMusic();
                                        }
                                      },
                                      child: Icon(
                                        musicProvider.isPlaying
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded,
                                        size: 32,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 16),

                                  // 次の曲へ
                                  Expanded(
                                    child: InkButton(
                                      borderRadius: BorderRadius.circular(12),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      onTap: musicProvider.skipNext,
                                      child: const Icon(
                                        Icons.skip_next_rounded,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
