import 'package:flutter/material.dart';

import '../model/canvas_config.dart';
import 'art_board_canvas.dart';

class CustomArtboardCanvas extends StatelessWidget {
  final Key canvasKey;
  final Key stackArtboardKey;
  final CanvasConfig canvasConfig;
  final double transformRatio;
  final Widget child;

  const CustomArtboardCanvas({
    super.key,
    required this.canvasKey,
    required this.stackArtboardKey,
    required this.canvasConfig,
    required this.transformRatio,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ArtBoardCanvas(
      canvasKey: canvasKey,
      stackArtboardKey: stackArtboardKey,
      canvasConfig: canvasConfig,
      transformRatio: transformRatio,
      childBuilder: (child) {
        return child ?? const SizedBox.shrink();
      },
      child: child,
    );
  }
}
