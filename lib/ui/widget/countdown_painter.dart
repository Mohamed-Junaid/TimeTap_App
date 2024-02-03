import 'dart:math';
import 'package:flutter/material.dart';

class CountdownPainter extends CustomPainter {
  final int count;
  final double strokeWidth;
  final Color color;

  CountdownPainter({
    required this.count,
    required this.strokeWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double radius = size.width / 2;
    Offset center = Offset(size.width / 2, size.height / 2);

    double arcAngle = 2 * pi * (count / 5);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
