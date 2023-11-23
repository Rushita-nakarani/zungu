


import 'package:flutter/material.dart';

class CustomShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 15;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height * 0.8);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(0, size.height * 0.8);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }
     
    
  @override
  bool shouldRepaint(CustomShapePainter oldDelegate) {
    return false;
  }
}
