import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PercentBarWidget extends StatelessWidget {
  final Widget child;
  final double percent;
  final Color fillColor;
  final Color lineColor;
  final Color freeColor;
  final double lineWidth;
  final double width;
  final double height;

  const PercentBarWidget(
      {Key? key,
      required this.percent,
      required this.child,
      this.fillColor = const Color.fromARGB(255, 10, 23, 25),
      this.lineColor = const Color.fromARGB(255, 37, 194, 100),
      this.freeColor = const Color.fromARGB(255, 25, 54, 31),
      this.lineWidth = 5.0,
      this.height = 60,
      this.width = 60})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: MyPainter(
              percent: percent,
              fillColor: fillColor,
              lineColor: lineColor,
              freeColor: freeColor,
              lineWidth: lineWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: Center(child: child),
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double percent;
  final Color fillColor;
  final Color lineColor;
  final Color freeColor;
  final double lineWidth;

  MyPainter({
    required this.percent,
    required this.fillColor,
    required this.lineColor,
    required this.freeColor,
    required this.lineWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final arcRect = calculateArcsRect(size);
    drawBackground(canvas, size);
    drawFreeArc(canvas, arcRect);
    drawFilledArc(canvas, arcRect);
  }

  void drawFilledArc(Canvas canvas, Rect arcRect) {
    final paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = lineWidth;
    paint.strokeCap = StrokeCap.round;
    paint.color = getColorFilledPen(paint);

    canvas.drawArc(
      arcRect,
      -pi / 2,
      pi * 2 * percent,
      false,
      paint,
    );
  }

  Color getColorFilledPen(Paint paint) {
    if (percent <= 0.333) {
      const colorMultiplier = 255 / 33.3;
      return Color.fromARGB(
          255, (percent * 100 * colorMultiplier).toInt(), 0, 0);
    } else if (percent >= 0.334 && percent <= 0.666) {
      const colorMultiplier = 255 / 66.6;
      return Color.fromARGB(
          255, 255, (percent * 100 * colorMultiplier).toInt(), 0);
    } else {
      const colorMultiplier = 255 / 99.9;
      return Color.fromARGB(
          255, 255 - (percent * 100 * colorMultiplier).toInt(), 255, 0);
    }
  }

  void drawFreeArc(Canvas canvas, Rect arcRect) {
    final paint = Paint();
    paint.color = freeColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = lineWidth;

    canvas.drawArc(
      arcRect,
      pi * 2 * percent - (pi / 2),
      pi * 2 * (1.0 - percent),
      false,
      paint,
    );
  }

  void drawBackground(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = fillColor;
    paint.style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, paint);
  }

  Rect calculateArcsRect(Size size) {
    const linesMargin = 3;
    final offest = lineWidth / 2 + linesMargin;
    final arcRect = Offset(offest, offest) &
        Size(size.width - offest * 2, size.height - offest * 2);
    return arcRect;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
