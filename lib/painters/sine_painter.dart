import 'dart:math';

import 'package:flutter/material.dart';

// A CustomPainter that takes a double called animation (0.0 - 1.0) and animates a sine wave
// moving across the screen based on the animation value.
class SinePainter extends CustomPainter {
  double animation;

  SinePainter({this.animation = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    var path = Path();

    var x = 0.0;
    var y = 0.0;

    var amplitude = 100.0;
    var frequency = 0.01;

    var center = Offset(size.width / 2, size.height / 2);

    path.moveTo(0, center.dy);

    while (x < size.width) {
      y = sin(x * frequency + animation * 2 * pi) * amplitude + center.dy;
      path.lineTo(x, y);
      x++;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant SinePainter oldDelegate) =>
      oldDelegate.animation != animation;
}
