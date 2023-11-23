import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

Widget buildEditIconWidget({
  required String image,
  required Color color,
}) {
  return CustomPaint(
    size: const Size(50, 40),
    painter: EditIconPainter(
      image: image,
      color: color,
    ),
  );
}

class EditIconPainter extends CustomPainter {
  final String image;
  final Color color;
  // ui.Image image;

  EditIconPainter({required this.image, required this.color});

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final Path path = Path();
    path.moveTo(20, 0);
    path.lineTo(size.width, 0);
    path.arcToPoint(
      Offset(size.width, 0),
    );
    path.lineTo(size.width, size.height);
    path.arcToPoint(
      Offset(size.width, size.height),
    );
    path.lineTo(0, size.height);
    path.arcToPoint(
      Offset(0, size.height),
    );
    path.lineTo(0, 20);
    path.arcToPoint(
      const Offset(20, 0),
      radius: const Radius.elliptical(20, 20),
    );
    path.close();

    final Paint pathFill = Paint();
    pathFill.style = PaintingStyle.fill;
    pathFill.color = color;
    canvas.drawPath(path, pathFill);

    // canvas.drawImage(image, Offset.zero, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

Future<ui.Image> loadImage(String imageAssetPath) async {
  final ByteData data = await rootBundle.load(imageAssetPath);
  final codec = await ui.instantiateImageCodec(
    data.buffer.asUint8List(),
    targetHeight: 300,
    targetWidth: 300,
  );
  final frame = await codec.getNextFrame();
  return frame.image;
}
