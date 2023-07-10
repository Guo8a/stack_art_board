import 'dart:typed_data';
import 'package:image/image.dart' as img_lib;

import 'package:flutter/material.dart';

import 'canvas_config.dart';
import 'canvas_type.dart';

@immutable
class CanvasItem {
  final CanvasType canvasType;
  final Key key;

  const CanvasItem({
    required this.canvasType,
    required this.key,
  });

  @override
  bool operator ==(Object other) => other is CanvasItem && key == other.key;

  @override
  int get hashCode => key.hashCode;
}

@immutable
class CustomCanvasItem extends CanvasItem {
  final Widget child;
  final CanvasConfig canvasConfig;

  CustomCanvasItem({
    required this.child,
    required this.canvasConfig,
  }) : super(
          key: UniqueKey(),
          canvasType: CanvasType.custom,
        );
}

@immutable
class BorderCanvasItem extends CanvasItem {
  BorderCanvasItem()
      : super(
          key: UniqueKey(),
          canvasType: CanvasType.border,
        );
}

@immutable
class TransparentBgImageCanvasItem extends CanvasItem {
  final img_lib.Image image;
  final Uint8List imageBytes;
  final CanvasConfig canvasConfig;

  TransparentBgImageCanvasItem({
    required this.image,
    required this.imageBytes,
    required this.canvasConfig,
  }) : super(
          key: UniqueKey(),
          canvasType: CanvasType.custom,
        );
}
