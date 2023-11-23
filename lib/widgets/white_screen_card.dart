import 'package:flutter/material.dart';

import '../constant/img_font_color_string.dart';
import '../constant/text_style_decoration.dart';

class DashboardCard extends StatelessWidget {
  final String iconImage;
  final String title;
  final String subtitle;
  final Color color;
  final Function onTap;
  final bool isLeft;
  const DashboardCard({
    super.key,
    required this.iconImage,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    return dashboardCard();
  }

  Widget dashboardCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(
        onTap: () => onTap(),
        child: SizedBox(
          width: 150,
          height: 170,
          child: CustomPaint(
            painter: FaceOutlinePainter(title, subtitle, color, onTap, isLeft),
          ),
        ),
      ),
    );
  }
}

class FaceOutlinePainter extends CustomPainter {
  FaceOutlinePainter(
    this.title,
    this.subtitle,
    this.color,
    this.onTap,
    this.isLeft,
  );

  final String title;
  final String subtitle;
  final Color color;
  final Function onTap;
  final bool isLeft;

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    // rectangle paint object
    final paintRectangle = Paint();
    paintRectangle.style = PaintingStyle.fill;
    paintRectangle.strokeWidth = 4.0;
    paintRectangle.color = color;

    RRect rectangle;

    if (isLeft) {
      // left rectangle
      rectangle = RRect.fromRectAndCorners(
        const Rect.fromLTWH(0, 40, 150, 140),
        topRight: const Radius.circular(30),
        bottomRight: const Radius.circular(20),
        topLeft: const Radius.circular(60),
        bottomLeft: const Radius.circular(60),
      );
    } else {
      // right rectable
      rectangle = RRect.fromRectAndCorners(
        const Rect.fromLTWH(0, 40, 150, 140),
        topRight: const Radius.circular(60),
        bottomRight: const Radius.circular(60),
        topLeft: const Radius.circular(30),
        bottomLeft: const Radius.circular(20),
      );
    }

    canvas.drawRRect(
      rectangle,
      paintRectangle,
    );

    // draw shadow first
    final Path oval = Path();
    Offset circleOffset;
    const double circleRadius = 68;

    if (isLeft) {
      circleOffset = const Offset(72, 70);
    } else {
      circleOffset = const Offset(78, 70);
    }

    oval.addOval(
      Rect.fromCircle(
        center: circleOffset,
        radius: circleRadius,
      ),
    );
    final Paint shadowPaint = Paint();
    shadowPaint.color = Colors.black.withOpacity(0.2);
    shadowPaint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    canvas.drawPath(oval, shadowPaint);

    // draw circle
    final paintCircle = Paint();
    paintCircle.style = PaintingStyle.fill;
    paintCircle.strokeWidth = 4.0;
    paintCircle.color = ColorConstants.backgroundColorFFFFFF;

    canvas.drawCircle(
      circleOffset,
      circleRadius,
      paintCircle,
    );

    // title painter
    final titleText = TextSpan(
      text: title,
      style: TextStyleDecoration.textStyle
          .copyWith(color: ColorConstants.custgreen19B445),
    );

    final titlePainter = TextPainter(
      text: titleText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    titlePainter.layout(
      maxWidth: size.width - 20,
    );
    double titleXCenter;
    double titleYCenter;
    if (isLeft) {
      titleXCenter = (size.width - titlePainter.width) / 2;
      titleYCenter = (size.height - titlePainter.height) / 2 - 10;
    } else {
      titleXCenter = (size.width - titlePainter.width) / 2 + 5;
      titleYCenter = (size.height - titlePainter.height) / 2 - 10;
    }

    final titleOffset = Offset(titleXCenter, titleYCenter);

    titlePainter.paint(canvas, titleOffset);

    // subtitle painter
    final subtitleText = TextSpan(
      text: subtitle,
      style: TextStyleDecoration.subtitleTextStyle,
    );

    final subtitlePainter = TextPainter(
      text: subtitleText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    subtitlePainter.layout(
      maxWidth: size.width,
    );
    double subtitleXCenter;
    double subtitleYCenter;
    if (isLeft) {
      subtitleXCenter = (size.width - subtitlePainter.width) / 2;
      subtitleYCenter = (size.height - subtitlePainter.height) / 2 + 10;
    } else {
      subtitleXCenter = (size.width - subtitlePainter.width) / 2 + 5;
      subtitleYCenter = (size.height - subtitlePainter.height) / 2 + 10;
    }
    final subtitleOffset = Offset(subtitleXCenter, subtitleYCenter);

    subtitlePainter.paint(canvas, subtitleOffset);

    // paint icon circle
    final paintIconCircle = Paint();
    paintIconCircle.style = PaintingStyle.stroke;
    paintIconCircle.strokeWidth = 3.0;
    paintIconCircle.color = ColorConstants.backgroundColorFFFFFF;

    Offset iconCircleOffset;

    if (isLeft) {
      iconCircleOffset = const Offset(120, 152);
    } else {
      iconCircleOffset = const Offset(30, 152);
    }
    canvas.drawCircle(
      iconCircleOffset,
      15,
      paintIconCircle,
    );

    // icon painter
    const icon = Icons.arrow_forward_ios_rounded;
    final TextPainter iconPainter =
        TextPainter(textDirection: TextDirection.ltr);
    iconPainter.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        color: ColorConstants.backgroundColorFFFFFF,
        fontSize: 25,
        fontFamily: icon.fontFamily,
        package:
            icon.fontPackage, // This line is mandatory for external icon packs
      ),
    );
    iconPainter.layout();
    Offset iconOffset;
    if (isLeft) {
      iconOffset = const Offset(108, 140);
    } else {
      iconOffset = const Offset(18, 140);
    }
    iconPainter.paint(canvas, iconOffset);
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) => false;
}
