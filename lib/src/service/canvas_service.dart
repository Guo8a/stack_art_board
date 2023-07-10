import 'dart:math';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/operation_state.dart';
import '../utils/matrix_gesture_controller.dart';

part 'canvas_service.g.dart';

@riverpod
class CanvasService extends _$CanvasService {
  @override
  CanvasState build({
    required Key key,
  }) {
    return CanvasState(
      matrix4: Matrix4.identity(),
    );
  }

  late MatrixGestureController _controller;

  void initialController(
    BuildContext context,
    double transformRatio,
    Matrix4 transform,
  ) {
    _controller = MatrixGestureController(
      context: context,
      transformRatio: transformRatio,
      shouldRotate: true,
      shouldScale: true,
      shouldTranslate: true,
    );
    _controller.onMatrixUpdate = (matrix, translationDeltaMatrix,
        scaleDeltaMatrix, rotationDeltaMatrix) {
      updateMatrix(matrix * transform);
    };
  }

  void updateMatrix(Matrix4 value) {
    state = state.copyWith(matrix4: value);
  }

  void updateOperationState(OperationState operationState) {
    state = state.copyWith(operationState: operationState);
  }

  void onScaleStart(ScaleStartDetails details) {
    _controller.onScaleStart(details);
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    _controller.onScaleUpdate(details);
  }
}

@immutable
class CanvasState {
  final Matrix4 matrix4;
  final OperationState operationState;

  const CanvasState({
    required this.matrix4,
    this.operationState = OperationState.idle,
  });

  double get scale => sqrt(
      (matrix4.row0[0] * matrix4.row1[1] - matrix4.row0[1] * matrix4.row1[0])
          .abs());

  CanvasState copyWith({
    Matrix4? matrix4,
    OperationState? operationState,
  }) {
    return CanvasState(
      matrix4: matrix4 ?? this.matrix4,
      operationState: operationState ?? this.operationState,
    );
  }
}
