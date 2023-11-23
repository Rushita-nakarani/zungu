import 'package:flutter/material.dart';
import 'package:zungu_mobile/main.dart';

import '../constant/img_font_color_string.dart';

CustomPaint buildBookmark({
  required String text,
  required Color color,
  Size? size,
}) {
  return CustomPaint(
    size: size ?? const Size(50, 60),
    painter: BookmarkPainter(
      text: text,
      color: color,
    ),
  );
}

class BookmarkPainter extends CustomPainter {
  final String text;
  final Color color;

  BookmarkPainter({required this.text, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Path bookmarkPath = Path();
    bookmarkPath.moveTo(0, 0);
    bookmarkPath.lineTo(0, size.height);
    bookmarkPath.lineTo(size.width / 2, size.height - size.height / 4);
    bookmarkPath.lineTo(size.width, size.height);
    bookmarkPath.lineTo(size.width, 0);
    bookmarkPath.close();

    final Paint bookmarkPathFill = Paint();
    bookmarkPathFill.style = PaintingStyle.fill;
    bookmarkPathFill.strokeWidth = 1;
    bookmarkPathFill.color = color;
    canvas.drawPath(bookmarkPath, bookmarkPathFill);

    // canvas.drawShadow(
    //   bookmarkPath,
    //   const Color(0xFF9e9e9e).withOpacity(0.66),
    //   -2,
    //   false,
    // );

    final TextSpan titleText = TextSpan(
      text: text,
      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
            color: ColorConstants.backgroundColorFFFFFF,
            fontWeight: FontWeight.w500,
          ),
    );

    final titlePainter = TextPainter(
      text: titleText,
      textScaleFactor: 0.8,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    titlePainter.layout(
      maxWidth: 40,
    );
    final double titleXCenter = (size.width - titlePainter.width) / 2;
    final double titleYCenter = (size.height - titlePainter.height) / 2 - 5;

    final titleOffset = Offset(titleXCenter, titleYCenter);

    titlePainter.paint(canvas, titleOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
