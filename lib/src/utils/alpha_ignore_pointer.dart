import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img_lib;

class TransparentIgnorePointer extends SingleChildRenderObjectWidget {
  final img_lib.Image image;
  final Size transformSize;
  final double toolIconWidth;

  const TransparentIgnorePointer({
    Key? key,
    required Widget child,
    required this.image,
    required this.transformSize,
    required this.toolIconWidth,
  }) : super(key: key, child: child);

  @override
  void updateRenderObject(BuildContext context,
      covariant TransparentRenderIgnorePointer renderObject) {
    renderObject.image = image;
    renderObject.transformSize = transformSize;
  }

  @override
  TransparentRenderIgnorePointer createRenderObject(BuildContext context) {
    return TransparentRenderIgnorePointer(
      image: image,
      transformSize: transformSize,
      toolIconWidth: toolIconWidth,
    );
  }
}

class TransparentRenderIgnorePointer extends RenderProxyBox {
  img_lib.Image image;
  Size transformSize;
  final double toolIconWidth;

  TransparentRenderIgnorePointer({
    required this.image,
    required this.transformSize,
    required this.toolIconWidth,
  });

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    return _hitUnIgnores(position) && super.hitTest(result, position: position);
  }

  bool _hitUnIgnores(Offset offset) {
    double imageOffset = toolIconWidth / 2;
    final pixelX =
        ((offset.dx - imageOffset) / transformSize.width * image.width).round();
    final pixelY =
        ((offset.dy - imageOffset) / transformSize.height * image.height)
            .round();
    // rotate button intercept
    if (offset.dx >= transformSize.width &&
        offset.dx <= (transformSize.width + toolIconWidth) &&
        offset.dy >= transformSize.height / 2 &&
        offset.dy <= (transformSize.height / 2 + toolIconWidth)) {
      return true;
    }
    // scale button intercept
    if (offset.dx >= transformSize.width &&
        offset.dx <= (transformSize.width + toolIconWidth) &&
        offset.dy >= transformSize.height &&
        offset.dy <= (transformSize.height + toolIconWidth)) {
      return true;
    }
    if (pixelX < 0 ||
        pixelY < 0 ||
        pixelX >= image.width ||
        pixelY >= image.height) {
      return false;
    }
    final pixel = image.getPixel(pixelX, pixelY);
    return pixel.a != 0;
  }
}
