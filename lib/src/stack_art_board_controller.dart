import 'package:flutter/material.dart';

import 'model/canvas_item.dart';
import 'stack_art_board.dart';

class StackArtBoardController {
  StackArtBoardChildState? stackArtBoardState;

  void _check() {
    if (stackArtBoardState == null) throw '_stackArtBoardState is empty';
  }

  void add<T extends CanvasItem>(T item) {
    _check();
    stackArtBoardState?.add<T>(item: item);
  }

  void insert<T extends CanvasItem>(T item, int index) {
    _check();
    stackArtBoardState?.insert<T>(item: item, index: index);
  }

  void remove(Key key) {
    _check();
    stackArtBoardState?.remove(key: key);
  }

  void removeExcept(Key key) {
    _check();
    stackArtBoardState?.removeExcept(key: key);
  }

  bool contain(Key key) {
    _check();
    return stackArtBoardState?.contain(key: key) ?? false;
  }

  void clear() {
    _check();
    stackArtBoardState?.clear();
  }

  void moveToTop() {
    _check();
    stackArtBoardState?.moveToTop();
  }

  void moveToBottom() {
    _check();
    stackArtBoardState?.moveToBottom();
  }

  void move(int oldIndex, int newIndex) {
    _check();
    stackArtBoardState?.move(oldIndex, newIndex);
  }

  void reset() {
    stackArtBoardState?.reseat();
  }

  void dispose() {
    stackArtBoardState = null;
  }
}
