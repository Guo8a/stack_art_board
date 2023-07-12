import 'dart:typed_data';
import 'package:image/image.dart' as img_lib;

import 'package:flutter/material.dart';

import 'canvas_config.dart';
import 'canvas_type.dart';

@immutable
class CanvasItem {
  /// canvas type
  final CanvasType canvasType;

  /// canvas unique key
  final Key key;

  /// create a base canvas item
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
  /// child widget
  final Widget child;

  /// canvas config
  final CanvasConfig canvasConfig;

  /// create a custom canvas item
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
  /// create border canvas item
  ///
  /// !!! you should not use it, because the logic of adding border canvas I have implemented !!!
  ///
  BorderCanvasItem()
      : super(
          key: UniqueKey(),
          canvasType: CanvasType.border,
        );
}

@immutable
class TransparentBgImageCanvasItem extends CanvasItem {
  /// image library image
  final img_lib.Image image;

  /// image bytes
  final Uint8List imageBytes;

  /// canvas config
  final CanvasConfig canvasConfig;

  /// create the transparent bg image canvas item
  ///
  /// transparent areas in the image will not receive click events
  TransparentBgImageCanvasItem({
    required this.image,
    required this.imageBytes,
    required this.canvasConfig,
  }) : super(
          key: UniqueKey(),
          canvasType: CanvasType.custom,
        );
}
