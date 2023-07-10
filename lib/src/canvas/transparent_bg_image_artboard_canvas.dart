import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img_lib;

import '../utils/alpha_ignore_pointer.dart';
import '../model/canvas_config.dart';
import 'art_board_canvas.dart';

class TransparentBgImageArtboardCanvas extends StatelessWidget {
  final Key canvasKey;
  final Key stackArtboardKey;
  final CanvasConfig canvasConfig;
  final img_lib.Image image;
  final Uint8List imageBytes;
  final double toolIconWidth;
  final double transformRatio;

  const TransparentBgImageArtboardCanvas({
    super.key,
    required this.canvasKey,
    required this.stackArtboardKey,
    required this.canvasConfig,
    required this.image,
    required this.imageBytes,
    required this.toolIconWidth,
    required this.transformRatio,
  });

  @override
  Widget build(BuildContext context) {
    return ArtBoardCanvas(
      canvasKey: canvasKey,
      stackArtboardKey: stackArtboardKey,
      canvasConfig: canvasConfig,
      transformRatio: transformRatio,
      childBuilder: (child) {
        if (canvasConfig.allowUserInteraction) {
          return TransparentIgnorePointer(
            image: image,
            transformSize: Size(
              canvasConfig.size.width,
              canvasConfig.size.height,
            ),
            toolIconWidth: toolIconWidth,
            child: child ?? const SizedBox.shrink(),
          );
        } else {
          return IgnorePointer(
            child: child,
          );
        }
      },
      child: Image.memory(imageBytes),
    );
  }
}
