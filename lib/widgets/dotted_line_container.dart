import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 5, dashSpace = 5, startX = 9, startY = 9;
    final paint = Paint()
      ..color = ColorConstants.custGrey707070
      ..strokeWidth = 2;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(startX, startY),
        Offset(startX, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
