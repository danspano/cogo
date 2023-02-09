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

    drawBackground(canvas, size);

    var path = Path();

    var x = 0.0;
    var y = 0.0;

    var angle = 0.0;

    var center = Offset(size.width / 2, size.height / 2);

    while (x < size.width + 10) {
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
            Colors.grey.shade200,
            getColor(coordinates ?? Offset.zero, size),
            (1 -
                    sqrt(pow(coordinates!.dx - x, 2) +
                            pow(coordinates!.dy - y, 2)) /
                        (size.shortestSide / 3))
                .clamp(0.0, 1.0),
          )!;
        }
        canvas.drawPath(path, paint);
        path.reset();
        y += 20;
      }
      x += 20;
    }
  }

  // Takes the coordinates and the canvas size as inputs
  // and returns a Color which is chosen based on the position
  // of the coordinates on the canvas. The canvas acts as a color
  // picker, so as the coordinates change, the color changes. The
  // colors cover the entire color spectrum.
  Color getColor(Offset coordinates, Size size) {
    var hue = coordinates.dx / size.width;
    var saturation = coordinates.dy / size.height;
    var value = 1.0;
    return HSVColor.fromAHSV(1.0, hue * 360, saturation, value).toColor();
  }

  // This function takes the color from the getColor function and
  // and uses the luminance value to pick a color lerp between
  // black and white.
  Color getBackgroundColor(Offset coordinates, Size size) {
    var color = getColor(coordinates, size);
    var luminance = color.computeLuminance();
    return Color.lerp(color, Colors.white, luminance)!;
  }

  // This function draws the background of the canvas using the color
  // from the getBackgroundColor function
  void drawBackground(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = getBackgroundColor(coordinates ?? Offset.zero, size);
    var path = Path();
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant LinesPainter oldDelegate) =>
      oldDelegate.coordinates != coordinates;
}
