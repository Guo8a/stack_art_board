import 'dart:math';

import 'package:flutter/material.dart';

typedef MatrixGestureDetectorCallback = void Function(
  Matrix4 matrix,
  Matrix4 translationDeltaMatrix,
  Matrix4 scaleDeltaMatrix,
  Matrix4 rotationDeltaMatrix,
);

typedef OnUpdate<T> = T Function(T oldValue, T newValue);

class ValueUpdater<T> {
  final OnUpdate<T> onUpdate;
  late T value;

  ValueUpdater({required this.onUpdate});

  T update(T newValue) {
    T updated = onUpdate(value, newValue);
    value = newValue;
    return updated;
  }
}

class MatrixGestureController {
  final BuildContext context;
  final double transformRatio;
  final bool shouldScale;
  final bool shouldTranslate;
  final bool shouldRotate;

  MatrixGestureDetectorCallback onMatrixUpdate = (matrix,
      translationDeltaMatrix, scaleDeltaMatrix, rotationDeltaMatrix) {};

  MatrixGestureController({
    required this.context,
    required this.transformRatio,
    required this.shouldRotate,
    required this.shouldScale,
    required this.shouldTranslate,
  });

  Offset startGlobalPoint = Offset.zero;
  Matrix4 startMatrix = Matrix4.identity();
  Offset centerPoint = Offset.zero;

  ValueUpdater<Offset> translationUpdater = ValueUpdater(
    onUpdate: (oldVal, newVal) => newVal - oldVal,
  );
  ValueUpdater<double> rotationUpdater = ValueUpdater(
    onUpdate: (oldVal, newVal) => newVal - oldVal,
  );
  ValueUpdater<double> scaleUpdater = ValueUpdater(
    onUpdate: (oldVal, newVal) => newVal / oldVal,
  );

  void onScaleStart(ScaleStartDetails details) {
    translationUpdater.value = details.focalPoint;
    rotationUpdater.value = double.nan;
    scaleUpdater.value = 1.0;
  }

  Matrix4 translationDeltaMatrix = Matrix4.identity();
  Matrix4 scaleDeltaMatrix = Matrix4.identity();
  Matrix4 rotationDeltaMatrix = Matrix4.identity();
  Matrix4 matrix = Matrix4.identity();

  void onScaleUpdate(ScaleUpdateDetails details) {
    translationDeltaMatrix = Matrix4.identity();
    scaleDeltaMatrix = Matrix4.identity();
    rotationDeltaMatrix = Matrix4.identity();

    if (shouldTranslate) {
      Offset translationDelta = translationUpdater.update(details.focalPoint);
      translationDeltaMatrix = _translate(translationDelta);
      matrix = translationDeltaMatrix * matrix;
    }

    Offset focalPoint = Offset.zero;
    RenderBox? renderBox = context.findRenderObject() as RenderBox;
    focalPoint = renderBox.globalToLocal(details.focalPoint);
    if (shouldScale && details.scale != 1.0) {
      double scaleDelta = scaleUpdater.update(details.scale);
      scaleDeltaMatrix = _scale(scaleDelta, focalPoint);
      matrix = scaleDeltaMatrix * matrix;
    }

    if (shouldRotate && details.rotation != 0.0) {
      if (rotationUpdater.value.isNaN) {
        rotationUpdater.value = details.rotation;
      } else {
        double rotationDelta = rotationUpdater.update(details.rotation);
        rotationDeltaMatrix = _rotate(rotationDelta, focalPoint);
        matrix = rotationDeltaMatrix * matrix;
      }
    }
    onMatrixUpdate(
        matrix, translationDeltaMatrix, scaleDeltaMatrix, rotationDeltaMatrix);
  }

  Matrix4 _translate(Offset translation) {
    var dx = translation.dx * transformRatio;
    var dy = translation.dy * transformRatio;

    return Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, dx, dy, 0, 1);
  }

  Matrix4 _scale(double scale, Offset focalPoint) {
    var dx = (1 - scale) * focalPoint.dx;
    var dy = (1 - scale) * focalPoint.dy;

    return Matrix4(scale, 0, 0, 0, 0, scale, 0, 0, 0, 0, 1, 0, dx, dy, 0, 1);
  }

  Matrix4 _rotate(double angle, Offset focalPoint) {
    var c = cos(angle);
    var s = sin(angle);
    var dx = (1 - c) * focalPoint.dx + s * focalPoint.dy;
    var dy = (1 - c) * focalPoint.dy - s * focalPoint.dx;

    return Matrix4(c, s, 0, 0, -s, c, 0, 0, 0, 0, 1, 0, dx, dy, 0, 1);
  }
}
