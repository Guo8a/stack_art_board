import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/post_frame_mixin.dart';
import '../service/canvas_list_service.dart';
import '../service/canvas_service.dart';
import '../service/scale_service.dart';

class BorderArtBoardCanvas extends ConsumerStatefulWidget {
  final Key canvasKey;
  final Key stackArtboardKey;
  final Size size;
  final double toolIconWidth;
  final double borderWidth;
  final Color borderColor;
  final Widget rotateWidget;
  final Widget deleteWidget;
  final double transformRatio;

  const BorderArtBoardCanvas({
    super.key,
    required this.stackArtboardKey,
    required this.canvasKey,
    required this.size,
    required this.toolIconWidth,
    required this.borderWidth,
    required this.borderColor,
    required this.rotateWidget,
    required this.deleteWidget,
    required this.transformRatio,
  });

  @override
  ConsumerState<BorderArtBoardCanvas> createState() =>
      _BorderArtBoardCanvasState();
}

class _BorderArtBoardCanvasState extends ConsumerState<BorderArtBoardCanvas>
    with PostFrameMixin {
  Offset startGlobalPoint = Offset.zero;
  Matrix4 startMatrix = Matrix4.identity();
  Offset centerPoint = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final canvasState =
            ref.watch(canvasServiceProvider(key: widget.canvasKey));
        return Transform(
          transform: canvasState.matrix4,
          child: _stack,
        );
      },
    );
  }

  Widget get _stack {
    return Consumer(
      builder: (context, ref, child) {
        final canvasState =
            ref.watch(canvasServiceProvider(key: widget.canvasKey));
        final scale = canvasState.scale;
        return Stack(
          children: <Widget>[
            _border(scale),
            _scaleHandle(scale),
            _deleteHandle(scale),
          ],
        );
      },
    );
  }

  Widget _border(double scale) {
    double width = widget.borderWidth / scale * widget.transformRatio;
    return Positioned(
      top: 0,
      bottom: 0,
      right: 0,
      left: 0,
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.borderColor,
              width: width,
            ),
          ),
        ),
      ),
    );
  }

  Widget _scaleHandle(double scale) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        child: _toolCase(
          RotatedBox(
            quarterTurns: 1,
            child: widget.rotateWidget,
          ),
          scale,
        ),
      ),
    );
  }

  Widget _deleteHandle(double scale) {
    return Positioned(
      top: 0,
      left: 0,
      child: Consumer(
        builder: (context, ref, child) {
          final canvasListService = ref.read(
              canvasListServiceProvider(key: widget.stackArtboardKey).notifier);
          return GestureDetector(
            onTap: () {
              canvasListService.remove(widget.canvasKey);
            },
            child: _toolCase(
              RotatedBox(
                quarterTurns: 1,
                child: widget.deleteWidget,
              ),
              scale,
            ),
          );
        },
      ),
    );
  }

  Widget _toolCase(Widget child, double scale) {
    double width = widget.toolIconWidth / scale * widget.transformRatio;
    return Container(
      width: width,
      height: width,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }

  void _onPanStart(DragStartDetails details) {
    final canvasState = ref.watch(canvasServiceProvider(key: widget.canvasKey));
    startMatrix = canvasState.matrix4;
    RenderBox? renderBox = context.findRenderObject() as RenderBox;
    final width = widget.size.width;
    final height = widget.size.height;
    centerPoint = Offset(
      startMatrix.row0[0] * width / 2 +
          startMatrix.row0[1] * height / 2 +
          startMatrix.row0[3],
      startMatrix.row1[0] * width / 2 +
          startMatrix.row1[1] * height / 2 +
          startMatrix.row1[3],
    );
    centerPoint = renderBox.localToGlobal(centerPoint);
    startGlobalPoint = details.globalPosition;
    final scaleStart = ref.read(scaleStartProvider);
    scaleStart.value = ScaleStartDetails(focalPoint: centerPoint);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    double startToCenterX = startGlobalPoint.dx - centerPoint.dx;
    double startToCenterY = startGlobalPoint.dy - centerPoint.dy;
    double endToCenterX = details.globalPosition.dx - centerPoint.dx;
    double endToCenterY = details.globalPosition.dy - centerPoint.dy;
    double direct =
        startToCenterX * endToCenterY - startToCenterY * endToCenterX;
    double startToCenter = sqrt(pow(centerPoint.dx - startGlobalPoint.dx, 2) +
        pow(centerPoint.dy - startGlobalPoint.dy, 2));
    double endToCenter = sqrt(
        pow(centerPoint.dx - details.globalPosition.dx, 2) +
            pow(centerPoint.dy - details.globalPosition.dy, 2));
    double startToEnd = sqrt(
        pow(startGlobalPoint.dx - details.globalPosition.dx, 2) +
            pow(startGlobalPoint.dy - details.globalPosition.dy, 2));
    double cosA =
        (pow(startToCenter, 2) + pow(endToCenter, 2) - pow(startToEnd, 2)) /
            (2 * startToCenter * endToCenter);
    double angle = acos(cosA);
    if (direct < 0) {
      angle = -angle;
    } else {
      angle = angle;
    }
    final originalDistance = _caculateDistance(startGlobalPoint, centerPoint);
    final newDistance = _caculateDistance(details.globalPosition, centerPoint);
    final scale = newDistance / originalDistance;
    final scaleUpdate = ref.read(scaleUpdateProvider);
    scaleUpdate.value = ScaleUpdateDetails(
      focalPoint: centerPoint,
      scale: scale,
      rotation: angle,
    );
  }

  static double _caculateDistance(Offset p1, Offset p2) {
    return sqrt(
      (p1.dx - p2.dx) * (p1.dx - p2.dx) + (p1.dy - p2.dy) * (p1.dy - p2.dy),
    );
  }
}
