import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learning_pathway_list/src/ui/widgets/draw_dashed_path.dart';

class PathLinePainter extends CustomPainter {
  final GlobalKey itemKey;
  final GlobalKey? endItemKey;
  final int previousIndex;
  final EdgeInsetsGeometry itemPadding;
  final double scrollOffset;
  final Color color;

  PathLinePainter({
    super.repaint,
    required this.itemKey,
    required this.endItemKey,
    required this.previousIndex,
    required this.itemPadding,
    required this.scrollOffset,
    required this.color,
  });

  Rect? get startRect => getRect(itemKey);
  Rect? get endRect => getRect(endItemKey);

  Rect? getRect(GlobalKey? key) {
    if (key == null) {
      return null;
    }

    final context = key.currentContext;
    if (context == null) {
      return null;
    }

    RenderBox box = context.findRenderObject() as RenderBox;
    return box.localToGlobal(Offset(0, scrollOffset)) & box.size;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final startRect = this.startRect;
    final endRect = this.endRect;

    if (startRect == null || endRect == null) {
      return;
    }

    final startOffset =
        startRect.topCenter - Offset(0, size.height * (previousIndex + 1));
    final endOffset =
        endRect.bottomCenter - Offset(0, size.height * (previousIndex + 1));

    const margin = 0.0;
    final spaceBetween = startOffset.dy - endOffset.dy - (margin * 2);
    final endIsBeforeStart = startOffset.dx >= endOffset.dx;
    final cornerRadius = min(
        8.0,
        endIsBeforeStart
            ? (startOffset.dx - endOffset.dx)
            : (endOffset.dx - startOffset.dx));

    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;
    final Path path = Path();

    path.moveTo(startOffset.dx, startOffset.dy - margin);
    path.relativeLineTo(0, (-spaceBetween / 2) + cornerRadius);
    if (endIsBeforeStart) {
      path.relativeArcToPoint(
        Offset(-cornerRadius, -cornerRadius),
        radius: Radius.circular(cornerRadius),
        clockwise: false,
      );
    } else {
      path.relativeArcToPoint(
        Offset(cornerRadius, -cornerRadius),
        radius: Radius.circular(cornerRadius),
        clockwise: true,
      );
    }

    path.relativeLineTo(
        endOffset.dx -
            startOffset.dx +
            cornerRadius * (endIsBeforeStart ? 2 : -2),
        0);
    if (!endIsBeforeStart) {
      path.relativeArcToPoint(
        Offset(cornerRadius, -cornerRadius),
        radius: Radius.circular(cornerRadius),
        clockwise: false,
      );
    } else {
      path.relativeArcToPoint(
        Offset(-cornerRadius, -cornerRadius),
        radius: Radius.circular(cornerRadius),
        clockwise: true,
      );
    }
    path.relativeLineTo(0, -spaceBetween / 2 + margin);

    // canvas.drawPath(path, paint);

    canvas.drawDashedLine(
      path: path,
      paint: paint,
      dashLength: 16,
      dashSpace: 8,
    );

    // canvas.drawCircle(
    //   startOffset,
    //   4,
    //   paint
    //     ..color = Colors.blue
    //     ..style = PaintingStyle.fill,
    // );
    // canvas.drawCircle(
    //   endOffset,
    //   4,
    //   paint
    //     ..color = Colors.yellow
    //     ..style = PaintingStyle.fill,
    // );

    /* 

    final textPainter = TextPainter(
      text: TextSpan(
        text: previousIndex.toString(),
        style: const TextStyle(
          color: Colors.red,
          fontSize: 12,
        ),
        children: <InlineSpan>[
          TextSpan(
            text: ' - $endItemKey',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ],
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset(bottomOffset.dx + 8, bottomOffset.dy - 8) );*/
  }

  @override
  bool shouldRepaint(PathLinePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(PathLinePainter oldDelegate) => true;
}
