import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/canvas_config.dart';
import '../model/operation_state.dart';
import '../utils/post_frame_mixin.dart';
import '../service/canvas_list_service.dart';
import '../service/canvas_service.dart';
import '../service/scale_service.dart';
import '../service/select_canvas_service.dart';

class ArtBoardCanvas extends ConsumerStatefulWidget {
  final Key canvasKey;
  final Key stackArtboardKey;
  final CanvasConfig canvasConfig;
  final double transformRatio;
  final Widget child;
  final Widget Function(Widget?) childBuilder;

  const ArtBoardCanvas({
    super.key,
    required this.canvasKey,
    required this.stackArtboardKey,
    required this.canvasConfig,
    required this.transformRatio,
    required this.child,
    required this.childBuilder,
  });

  @override
  ConsumerState<ArtBoardCanvas> createState() => _ArtBoardCanvasState();
}

class _ArtBoardCanvasState extends ConsumerState<ArtBoardCanvas>
    with PostFrameMixin {
  CanvasServiceProvider get canvasProvider =>
      canvasServiceProvider(key: widget.canvasKey);
  @override
  void initState() {
    super.initState();

    postFrame(() {
      final scaleStart = ref.read(scaleStartProvider);
      scaleStart.addListener(() {
        _canvasEqual(
          equalCallback: () {
            _onScaleStart(scaleStart.value);
          },
        );
      });
      final scaleUpdate = ref.read(scaleUpdateProvider);
      scaleUpdate.addListener(() {
        _canvasEqual(
          equalCallback: () {
            _onScaleUpdate(scaleUpdate.value);
          },
        );
      });
      final canvasService = ref.read(canvasProvider.notifier);
      canvasService.initialController(
        context,
        widget.transformRatio,
        widget.canvasConfig.transform,
      );
      canvasService.updateMatrix(widget.canvasConfig.transform);
    });
  }

  void _canvasEqual({
    required VoidCallback equalCallback,
  }) {
    if (!mounted) return;
    final selectCanvas = ref.read(selectCanvasServiceProvider);
    if (selectCanvas == null) {
      return;
    } else {
      if (selectCanvas.canvasKey == widget.canvasKey) {
        equalCallback();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        ref.watch(scaleStartProvider);
        ref.watch(scaleUpdateProvider);
        final canvasState = ref.watch(canvasProvider);
        return Transform(
          transform: canvasState.matrix4,
          child: widget.childBuilder(
            GestureDetector(
              onScaleStart: _onScaleStart,
              onScaleUpdate: _onScaleUpdate,
              onTap: _onTap,
              child: _child,
            ),
          ),
        );
      },
    );
  }

  Widget get _child {
    return Consumer(
      builder: (context, ref, child) {
        final selectCanvas = ref.watch(selectCanvasServiceProvider);
        if (selectCanvas == null) {
          return _childSizeBox;
        } else {
          if (selectCanvas.canvasKey == widget.canvasKey) {
            return _childSizeBox;
          } else {
            return IgnorePointer(
              child: _childSizeBox,
            );
          }
        }
      },
    );
  }

  Widget get _childSizeBox {
    double width = widget.canvasConfig.size.width;
    double height = widget.canvasConfig.size.height;
    return SizedBox.fromSize(
      size: Size(width, height),
      child: widget.child,
    );
  }

  void _onScaleStart(ScaleStartDetails details) {
    final selectCanvas = ref.read(selectCanvasServiceProvider);
    if (selectCanvas == null) {
      final canvasService = ref.read(canvasProvider.notifier);
      canvasService.updateOperationState(OperationState.idle);
    } else {
      if (!widget.canvasConfig.allowUserInteraction) return;
      final canvasState = ref.read(canvasProvider);
      if (canvasState.operationState == OperationState.idle) return;
      final canvasService = ref.read(canvasProvider.notifier);
      canvasService.onScaleStart(details);
    }
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final selectCanvas = ref.read(selectCanvasServiceProvider);
    if (selectCanvas == null) {
      final canvasService =
          ref.read(canvasServiceProvider(key: widget.canvasKey).notifier);
      canvasService.updateOperationState(OperationState.idle);
    } else {
      if (!widget.canvasConfig.allowUserInteraction) return;
      final canvasState = ref.read(canvasProvider);
      if (canvasState.operationState == OperationState.idle) return;
      final canvasService = ref.read(canvasProvider.notifier);
      canvasService.onScaleUpdate(details);
    }
  }

  void _onTap() {
    if (!widget.canvasConfig.allowUserInteraction) return;
    final selectCanvasService = ref.read(selectCanvasServiceProvider.notifier);
    final canvasList =
        ref.read(canvasListServiceProvider(key: widget.stackArtboardKey));
    for (final canvas in canvasList) {
      OperationState state;
      if (canvas.key != widget.canvasKey) {
        state = OperationState.idle;
      } else {
        final canvasState = ref.read(canvasServiceProvider(key: canvas.key));
        if (canvasState.operationState == OperationState.idle) {
          state = OperationState.editing;
          selectCanvasService.update(
            SelectCanvas(
              canvasKey: widget.canvasKey,
              canvasConfig: widget.canvasConfig,
            ),
          );
        } else {
          state = OperationState.idle;
          final canvasListService = ref.read(
              canvasListServiceProvider(key: widget.stackArtboardKey).notifier);
          canvasListService.resetCanvasKey();
        }
      }
      final canvasService =
          ref.read(canvasServiceProvider(key: canvas.key).notifier);
      canvasService.updateOperationState(state);
    }
  }
}
