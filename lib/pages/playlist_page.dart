import 'package:flutter/material.dart';
import 'package:music_player/components/music_list_tile.dart';
import 'package:music_player/data/providers/music_provider.dart';
import 'package:music_player/pages/music_player_page.dart';
import 'package:music_player/pages/settings_page.dart';
import 'package:provider/provider.dart';

class PlayListPage extends StatelessWidget {
  const PlayListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('P L A Y L I S T')),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Icon(
                  Icons.music_note,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  size: 40,
                ),
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            // PlayList
            ListTile(
              title: Text('P L A Y L I S T'),
              leading: Icon(Icons.list),
              onTap: () => Navigator.pop(context),
            ),

            const SizedBox(
              height: 8,
            ),

            // Settings
            ListTile(
              title: Text('S E T T I N G S'),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SettingsPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: Provider.of<MusicProvider>(context).musicList.length,
        itemBuilder: (context, index) {
          final music = Provider.of<MusicProvider>(context).musicList[index];
          return MusicListTile(
            musicName: music.musicName,
            artistName: music.artistName,
            imagePath: music.imagePath,
            onTap: () {
              Provider.of<MusicProvider>(context, listen: false)
                  .selectMusic(index)
                  .then(
                (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MusicPlayerPage();
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
