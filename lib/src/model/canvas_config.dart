import 'package:flutter/material.dart';

class ArtBoardConfig {
  final Size containerSize;
  final Size artBoardSize;
  final double toolIconWidth;
  final double borderWidth;
  final Color borderColor;
  final Widget rotateWidget;
  final Widget deleteWidget;

  const ArtBoardConfig({
    required this.containerSize,
    required this.artBoardSize,
    required this.toolIconWidth,
    required this.borderWidth,
    required this.borderColor,
    required this.rotateWidget,
    required this.deleteWidget,
  });
}

class CanvasConfig {
  Size size = Size.zero;
  Matrix4 transform = Matrix4.identity();
  bool allowUserInteraction = true;

  CanvasConfig({
    required this.size,
    required this.transform,
    required this.allowUserInteraction,
  });
}
