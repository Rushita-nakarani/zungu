import 'package:flutter/material.dart';

class Chevron extends CustomPainter {
  final Color color;

  Chevron({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [color, color],
    );

    final Rect colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final Paint paint = Paint()..shader = gradient.createShader(colorBounds);

    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width / 2, size.height - size.height / 3);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
