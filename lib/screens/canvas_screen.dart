// A blank screen that contains a CustomPainter widget. The CustomPainter is
// sized to fit the screen and draws a circle in the center of the screen.
import 'dart:math';

import 'package:cogo/painters/lines_painter.dart';
import 'package:cogo/painters/sine_painter.dart';
import 'package:flutter/material.dart';

class CanvasScreen extends StatefulWidget {
  const CanvasScreen({super.key});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Offset pointer = const Offset(0, 0);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: AnimatedBuilder(
  //         animation: _animation,
  //         builder: (context, value) {
  //           return CustomPaint(
  //             size: MediaQuery.of(context).size,
  //             painter: LinesPainter(),
  //           );
  //         }),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onPanUpdate: (details) => {
          setState(() {
            pointer = details.localPosition;
          })
        },
        child: MouseRegion(
          onHover: (event) => {
            setState(() {
              pointer = event.localPosition;
            })
          },
          child: CustomPaint(
            size: MediaQuery.of(context).size,
            painter: LinesPainter(coordinates: pointer),
          ),
        ),
      ),
    );
  }
}
