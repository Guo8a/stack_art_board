import 'package:flutter/material.dart';

/// art board config
class ArtBoardConfig {
  /// the size of the container on screen
  final Size containerSize;

  /// the size of widget that scales and positions within itself according to [fit].
  final Size artBoardSize;

  /// delete widget or rotate widget width
  final double toolIconWidth;

  /// select canvas border width
  final double borderWidth;

  /// select canvas border color
  final Color borderColor;

  /// rotate widget
  final Widget rotateWidget;

  /// delete widget
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

/// canvas config
class CanvasConfig {
  /// canvas size
  Size size = Size.zero;

  /// canvas initial transform
  Matrix4 transform = Matrix4.identity();

  /// allow user interaction
  bool allowUserInteraction = true;

  CanvasConfig({
    required this.size,
    required this.transform,
    required this.allowUserInteraction,
  });
}
