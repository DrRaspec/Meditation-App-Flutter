import 'dart:math' as math;

import 'package:flutter/material.dart';

class WelcomeWaveSection extends StatelessWidget {
  final double? maxHeight;

  const WelcomeWaveSection({super.key, this.maxHeight});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final naturalHeight = width * (502 / 414);
    final height = maxHeight == null
        ? naturalHeight
        : math.min(naturalHeight, maxHeight!);

    return SizedBox(
      width: double.infinity,
      height: height,
      child: CustomPaint(painter: _TopWavePainter()),
    );
  }
}

class _TopWavePainter extends CustomPainter {
  static const double _shapeW = 414.0;
  static const double _shapeH = 502.0;
  static const double _lineW = 414.0;
  static const double _lineH = 71.0;

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = const Color(0xFFFAF8F5)
      ..isAntiAlias = true;

    double sx(double x) => x * size.width / _shapeW;
    double sy(double y) => y * size.height / _shapeH;

    // Match the provided main SVG wave exactly.
    final fillPath = Path()
      ..moveTo(sx(0), sy(0))
      ..lineTo(sx(0), sy(381.053))
      ..cubicTo(
        sx(0),
        sy(381.053),
        sx(32.2351),
        sy(449.788),
        sx(115.112),
        sy(441.811),
      )
      ..cubicTo(
        sx(197.989),
        sy(433.835),
        sx(215.177),
        sy(390.876),
        sx(315.243),
        sy(470.049),
      )
      ..cubicTo(
        sx(315.243),
        sy(470.049),
        sx(350.543),
        sy(503.185),
        sx(415),
        sy(501.967),
      )
      ..lineTo(sx(415), sy(0))
      ..close();

    canvas.drawPath(fillPath, fillPaint);

    final strokePaint = Paint()
      ..color = const Color(0xFFF9F0E3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..isAntiAlias = true;

    final lineScaleX = size.width / _lineW;
    final lineScaleY = (size.height * (_lineH / _shapeH)) / _lineH;
    final lineOffsetY = size.height - (size.height * (_lineH / _shapeH));

    double lx(double x) => x * lineScaleX;
    double ly(double y) => lineOffsetY + y * lineScaleY;

    // Match the provided small SVG curve line.
    final strokePath = Path()
      ..moveTo(lx(-2.01196), ly(0))
      ..cubicTo(
        lx(-1.62476),
        ly(0.42722),
        lx(37.8967),
        ly(42.4417),
        lx(118.275),
        ly(27.9562),
      )
      ..cubicTo(
        lx(134.858),
        ly(24.9657),
        lx(149.385),
        ly(21.4144),
        lx(163.444),
        ly(17.97),
      )
      ..cubicTo(
        lx(216.878),
        ly(4.89971),
        lx(255.478),
        ly(-4.53919),
        lx(318.553),
        ly(45.005),
      )
      ..cubicTo(
        lx(318.94),
        ly(45.3121),
        lx(356.899),
        ly(74.817),
        lx(419.853),
        ly(68.422),
      );

    canvas.drawPath(strokePath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
