import 'package:flutter/rendering.dart';

extension CanvasExt on Canvas {
  void drawDashedLine({
    required Path path,
    required Paint paint,
    required double dashLength,
    required double dashSpace,
  }) {
    final pathMetrics = path.computeMetrics();
    for (final pathMetric in pathMetrics) {
      for (double dist = 0;
          dist < pathMetric.length;
          dist += dashLength + dashSpace) {
        final dashPath = pathMetric.extractPath(dist, dist + dashLength);
        // .transform(_scaleMatrix4(scale))
        // .shift(alignmentOffset + negativeOffset);

        drawPath(dashPath, paint);
      }
    }
  }
}
