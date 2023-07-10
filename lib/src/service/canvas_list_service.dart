import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/canvas_item.dart';
import 'select_canvas_service.dart';

part 'canvas_list_service.g.dart';

@riverpod
class CanvasListService extends _$CanvasListService {
  @override
  List<CanvasItem> build({
    required Key key,
  }) {
    return [];
  }

  void resetCanvasKey() {
    final selectCanvasService = ref.read(selectCanvasServiceProvider.notifier);
    selectCanvasService.reset();
  }

  void add(CanvasItem item) {
    List<CanvasItem> configs = List.from(state);
    configs.add(item);
    state = configs;
  }

  void insert(CanvasItem item, int index) {
    List<CanvasItem> configs = List.from(state);
    configs.insert(index, item);
    state = configs;
  }

  void remove(Key? canvasKey) {
    List<CanvasItem> configs = List.from(state);
    configs.removeWhere((CanvasItem b) => b.key == canvasKey);
    state = configs;
    resetCanvasKey();
  }

  void removeExcept(Key? canvasKey) {
    List<CanvasItem> configs = List.from(state);
    configs.removeWhere((CanvasItem b) => b.key != canvasKey);
    state = configs;
    resetCanvasKey();
  }

  bool contain(Key? canvasKey) {
    List<CanvasItem> configs = List.from(state);
    return configs.map((e) => e.key).contains(canvasKey);
  }

  void move(int oldIndex, int newIndex) {
    List<CanvasItem> configs = List.from(state);
    var tempChild = configs.removeAt(oldIndex);
    configs.insert(newIndex, tempChild);
    state = configs;
  }

  void clear() {
    state = [];
    resetCanvasKey();
  }
}
