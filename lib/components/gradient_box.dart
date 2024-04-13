import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class GradientBox extends StatelessWidget {
  final ImageProvider imageProvider;
  final Widget? child;

  const GradientBox({
    super.key,
    required this.imageProvider,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PaletteGenerator.fromImageProvider(imageProvider),
      builder: (context, snapshot) {
        Color color = Colors.transparent;
        if (snapshot.hasData) {
          final palette = snapshot.data!;
          if (palette.dominantColor != null) {
            color = palette.dominantColor!.color;
          }
        }
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, Colors.transparent],
              stops: const [0.05, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: child,
        );
      },
    );
  }
}
