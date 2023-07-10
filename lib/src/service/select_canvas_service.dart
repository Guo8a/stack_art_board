import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/canvas_config.dart';

part 'select_canvas_service.g.dart';

@riverpod
class SelectCanvasService extends _$SelectCanvasService {
  @override
  SelectCanvas? build() {
    return null;
  }

  void update(SelectCanvas selectCanvas) {
    state = selectCanvas;
  }

  void reset() {
    state = null;
  }
}

@immutable
class SelectCanvas {
  final Key canvasKey;
  final CanvasConfig canvasConfig;

  const SelectCanvas({
    required this.canvasKey,
    required this.canvasConfig,
  });
}
