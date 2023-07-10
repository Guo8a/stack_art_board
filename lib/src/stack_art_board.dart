import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'canvas/border_art_board_canvas.dart';
import 'canvas/custom_art_board_canvas.dart';
import 'canvas/transparent_bg_image_artboard_canvas.dart';
import 'model/canvas_config.dart';
import 'model/canvas_item.dart';
import 'model/canvas_type.dart';
import 'service/canvas_list_service.dart';
import 'service/select_canvas_service.dart';

import 'stack_art_board_controller.dart';

class StackArtBoard extends StatelessWidget {
  final Key stackArtBoardKey;
  final StackArtBoardController controller;
  final ArtBoardConfig artBoardConfig;
  final Widget? background;
  final GlobalKey? screenShotKey;

  const StackArtBoard({
    Key? key,
    required this.stackArtBoardKey,
    required this.controller,
    required this.artBoardConfig,
    this.background,
    this.screenShotKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ClipRRect(
        child: _StackArtBoardChild(
          stackArtBoardKey: stackArtBoardKey,
          controller: controller,
          artBoardConfig: artBoardConfig,
          background: background,
          screenShotKey: screenShotKey,
        ),
      ),
    );
  }
}

class _StackArtBoardChild extends ConsumerStatefulWidget {
  final Key stackArtBoardKey;
  final StackArtBoardController controller;
  final ArtBoardConfig artBoardConfig;
  final Widget? background;
  final GlobalKey? screenShotKey;

  const _StackArtBoardChild({
    Key? key,
    required this.stackArtBoardKey,
    required this.controller,
    required this.artBoardConfig,
    this.background,
    this.screenShotKey,
  }) : super(key: key);

  @override
  ConsumerState<_StackArtBoardChild> createState() => StackArtBoardChildState();
}

class StackArtBoardChildState extends ConsumerState<_StackArtBoardChild> {
  Widget get backgroundWidget => widget.background ?? const SizedBox.shrink();
  CanvasListServiceProvider get listProvider =>
      canvasListServiceProvider(key: widget.stackArtBoardKey);
  double get transformRatio =>
      sqrt(
        widget.artBoardConfig.artBoardSize.width *
                widget.artBoardConfig.artBoardSize.width +
            widget.artBoardConfig.artBoardSize.height *
                widget.artBoardConfig.artBoardSize.height,
      ) /
      sqrt(
        widget.artBoardConfig.containerSize.width *
                widget.artBoardConfig.containerSize.width +
            widget.artBoardConfig.containerSize.height *
                widget.artBoardConfig.containerSize.height,
      );
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.controller.stackArtBoardState = this;
  }

  void add<T extends CanvasItem>({
    required CanvasItem item,
  }) {
    final canvasList = ref.read(listProvider);
    if (canvasList.contains(item)) throw 'duplicate id';
    final canvasListService = ref.read(listProvider.notifier);
    for (final canvasItem in canvasList) {
      if (canvasItem.canvasType == CanvasType.border) {
        canvasListService.remove(canvasItem.key);
      }
    }
    canvasListService.add(item);
    canvasListService.add(BorderCanvasItem());
  }

  void insert<T extends CanvasItem>({
    required CanvasItem item,
    required int index,
  }) {
    final canvasList = ref.read(listProvider);
    if (canvasList.contains(item)) throw 'duplicate id';
    final canvasListService = ref.read(listProvider.notifier);
    canvasListService.insert(item, index);
  }

  void remove({
    required Key key,
  }) {
    final canvasListService = ref.read(listProvider.notifier);
    canvasListService.remove(key);
  }

  void removeExcept({
    required Key key,
  }) {
    final canvasListService = ref.read(listProvider.notifier);
    canvasListService.removeExcept(key);
  }

  bool contain({
    required Key key,
  }) {
    final canvasListService = ref.read(listProvider.notifier);
    return canvasListService.contain(key);
  }

  void moveToTop() {
    final canvasList = ref.read(listProvider);
    final selectCanvas = ref.read(selectCanvasServiceProvider);
    if (selectCanvas == null) {
      return;
    } else {
      final canvasIndex = canvasList
          .indexWhere((element) => element.key == selectCanvas.canvasKey);
      if (canvasIndex == -1) return;
      if (canvasIndex + 1 < canvasList.length - 1) {
        move(canvasIndex, canvasIndex + 1);
      }
    }
  }

  void moveToBottom() {
    final canvasList = ref.read(listProvider);
    final selectCanvas = ref.read(selectCanvasServiceProvider);
    if (selectCanvas == null) {
      return;
    } else {
      final canvasIndex = canvasList
          .indexWhere((element) => element.key == selectCanvas.canvasKey);
      if (canvasIndex == -1) return;
      if (canvasIndex - 1 >= 0) {
        move(canvasIndex, canvasIndex - 1);
      }
    }
  }

  void move(int oldIndex, int newIndex) {
    final canvasListService = ref.read(listProvider.notifier);
    canvasListService.move(oldIndex, newIndex);
  }

  void clear() {
    final canvasListService = ref.read(listProvider.notifier);
    canvasListService.clear();
  }

  void reseat() {
    final canvasListService = ref.read(listProvider.notifier);
    canvasListService.resetCanvasKey();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.artBoardConfig.containerSize.width,
      height: widget.artBoardConfig.containerSize.height,
      child: FittedBox(
        child: RepaintBoundary(
          key: widget.screenShotKey,
          child: SizedBox(
            width: widget.artBoardConfig.artBoardSize.width,
            height: widget.artBoardConfig.artBoardSize.height,
            child: Consumer(
              builder: (context, ref, child) {
                final canvasList = ref.watch(listProvider);
                List<Widget> children = [];
                for (final canvasItem in canvasList) {
                  final item = _buildItem(canvasItem);
                  children.add(item);
                }
                return Stack(
                  children: <Widget>[
                    backgroundWidget,
                    ...children,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(CanvasItem item) {
    Widget child = const SizedBox.shrink();
    if (item is TransparentBgImageCanvasItem) {
      final imageArtboardCanvas = TransparentBgImageArtboardCanvas(
        canvasKey: item.key,
        stackArtboardKey: widget.stackArtBoardKey,
        canvasConfig: item.canvasConfig,
        image: item.image,
        imageBytes: item.imageBytes,
        toolIconWidth: widget.artBoardConfig.toolIconWidth,
        transformRatio: transformRatio,
      );
      child = Positioned(
        key: item.key,
        width: item.canvasConfig.size.width,
        height: item.canvasConfig.size.height,
        child: imageArtboardCanvas,
      );
    } else if (item is BorderCanvasItem) {
      child = Consumer(
        builder: (context, ref, child) {
          final selectCanvas = ref.watch(selectCanvasServiceProvider);
          if (selectCanvas == null) {
            return const SizedBox.shrink();
          } else {
            return Positioned(
              width: selectCanvas.canvasConfig.size.width,
              height: selectCanvas.canvasConfig.size.height,
              child: BorderArtBoardCanvas(
                canvasKey: selectCanvas.canvasKey,
                stackArtboardKey: widget.stackArtBoardKey,
                size: selectCanvas.canvasConfig.size,
                toolIconWidth: widget.artBoardConfig.toolIconWidth,
                borderWidth: widget.artBoardConfig.borderWidth,
                borderColor: widget.artBoardConfig.borderColor,
                rotateWidget: widget.artBoardConfig.rotateWidget,
                deleteWidget: widget.artBoardConfig.deleteWidget,
                transformRatio: transformRatio,
              ),
            );
          }
        },
      );
    } else if (item is CustomCanvasItem) {
      child = Positioned(
        width: item.canvasConfig.size.width,
        height: item.canvasConfig.size.height,
        key: item.key,
        child: CustomArtboardCanvas(
          canvasKey: item.key,
          stackArtboardKey: widget.stackArtBoardKey,
          canvasConfig: item.canvasConfig,
          transformRatio: transformRatio,
          child: item.child,
        ),
      );
    }
    return child;
  }
}
