import 'package:flutter/material.dart';

import 'model/canvas_item.dart';
import 'stack_art_board.dart';

class StackArtBoardController {
  StackArtBoardChildState? stackArtBoardState;

  void _check() {
    if (stackArtBoardState == null) throw '_stackArtBoardState is empty';
  }

  /// add canvas item
  void add<T extends CanvasItem>(T item) {
    _check();
    stackArtBoardState?.add<T>(item: item);
  }

  /// insert canvas item at index
  void insert<T extends CanvasItem>(T item, int index) {
    _check();
    stackArtBoardState?.insert<T>(item: item, index: index);
  }

  /// remove the canvas item with the same key
  void remove(Key key) {
    _check();
    stackArtBoardState?.remove(key: key);
  }

  /// remove canvas items other than key equality
  void removeExcept(Key key) {
    _check();
    stackArtBoardState?.removeExcept(key: key);
  }

  /// whether canvas items contains an element which key equal to [key].
  bool contain(Key key) {
    _check();
    return stackArtBoardState?.contain(key: key) ?? false;
  }

  /// clear all canvas items
  void clear() {
    _check();
    stackArtBoardState?.clear();
  }

  /// move canvas item up to one level
  void moveToTop() {
    _check();
    stackArtBoardState?.moveToTop();
  }

  /// move the canvas item down one level
  void moveToBottom() {
    _check();
    stackArtBoardState?.moveToBottom();
  }

  /// move canvas item from oldindex to newindex
  void move(int oldIndex, int newIndex) {
    _check();
    stackArtBoardState?.move(oldIndex, newIndex);
  }

  /// cancel select canvas item
  void reset() {
    stackArtBoardState?.reset();
  }

  /// dispose
  void dispose() {
    stackArtBoardState = null;
  }
}
