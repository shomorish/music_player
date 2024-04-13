import 'package:flutter/material.dart';

class MusicListTile extends StatelessWidget {
  final String musicName;
  final String artistName;
  final String imagePath;
  final VoidCallback onTap;

  const MusicListTile({
    super.key,
    required this.musicName,
    required this.artistName,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        musicName,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(imagePath),
      ),
      subtitle: Text(
        artistName,
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.onBackground.withAlpha(255 ~/ 2),
        ),
      ),
      onTap: onTap,
    );
  }
}
