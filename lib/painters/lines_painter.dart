import 'dart:math';

import 'package:flutter/material.dart';

// A CustomPainter that draws lots of small lines across the screen.
// Each line is 10px long and there is enough space in between each line
// for the line to be rotated 360 degrees without intersecting with another line.
// There is a set of coordinates that is passed into the painter which can be null.
// If the coordinates are provided, then all of the lines will point in the direction
// of the coordinates. Otherwise the lines will all be rotated on the same angle which
// is a diagonal axis. Each line will be colored with an accent color that is
// passed in. The strength of the color depends on how close the coordinates are to the
// line. The closer the coordinates are to the line, the stronger the color. The further
// away the line is, the weaker the color.
class LinesPainter extends CustomPainter {
  final Offset? coordinates;
  final Color color;

  LinesPainter({this.coordinates, this.color = Colors.red});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    var path = Path();

    var x = 0.0;
    var y = 0.0;

    var angle = 0.0;

    var center = Offset(size.width / 2, size.height / 2);

    while (x < size.width) {
      y = 0.0;
      while (y < size.height) {
        path.moveTo(x, y);
        if (coordinates != null) {
          angle = atan2(
            coordinates!.dy - y,
            coordinates!.dx - x,
          );
        }
        path.lineTo(
          x + cos(angle) * 10,
          y + sin(angle) * 10,
        );
        if (coordinates != null) {
          paint.color = Color.lerp(
            Colors.white,
            color,
            1 -
                sqrt(pow(coordinates!.dx - x, 2) +
                        pow(coordinates!.dy - y, 2)) /
                    (size.shortestSide / 3),
          )!;
        }
        canvas.drawPath(path, paint);
        path.reset();
        y += 20;
      }
      x += 20;
    }
  }

  @override
  bool shouldRepaint(covariant LinesPainter oldDelegate) =>
      oldDelegate.coordinates != coordinates;
}
