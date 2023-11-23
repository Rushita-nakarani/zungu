import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/main.dart';

Widget PriceTagWidget({required Color color, required String rentPrice}) {
  return CustomPaint(
    size: const Size(85, 56),
    painter: PriceTagPainter(color: color, rentPrice: rentPrice),
  );
}

class PriceTagPainter extends CustomPainter {
  final Color color;
  final String rentPrice;
  PriceTagPainter({required this.color, required this.rentPrice});

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(78, 0);
    path.arcToPoint(
      Offset(size.width, 7),
      radius: const Radius.elliptical(7, 7),
    );

    path.lineTo(size.width, 49);
    path.arcToPoint(
      Offset(78, size.height),
      radius: const Radius.elliptical(7, 7),
    );
    path.lineTo(43, size.height);
    path.arcToPoint(
      const Offset(0, 12.5),
      radius: const Radius.elliptical(43, 43),
    );
    path.lineTo(0, 0);
    path.arcToPoint(
      Offset.zero,
    );
    path.close();

    final Paint pathFill = Paint();
    pathFill.style = PaintingStyle.fill;
    pathFill.color = color;
    canvas.drawPath(path, pathFill);

    // rent text
    final TextSpan rentText = TextSpan(
      text: "RENT",
      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
            color: ColorConstants.backgroundColorFFFFFF,
            fontWeight: FontWeight.w500,
          ),
    );

    final rentPainter = TextPainter(
      text: rentText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    rentPainter.layout(
      maxWidth: 40,
    );
    final double rentXCenter = (size.width - rentPainter.width) / 2 + 5;
    final double rentYCenter = (size.height - rentPainter.height) / 2 - 10;

    final rentOffset = Offset(rentXCenter, rentYCenter);

    rentPainter.paint(canvas, rentOffset);

    // rent price
    final TextSpan rentPriceSpan = TextSpan(
      text: rentPrice,
      style: Theme.of(getContext).textTheme.headline2?.copyWith(
            color: ColorConstants.backgroundColorFFFFFF,
            fontWeight: FontWeight.w600,
          ),
    );

    final rentPricePainter = TextPainter(
      text: rentPriceSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    rentPricePainter.layout();
    final double rentPriceXCenter =
        (size.width - rentPricePainter.width) / 2 + 5;
    final double rentPriceYCenter =
        (size.height - rentPricePainter.height) / 2 + 10;

    final rentPriceOffset = Offset(rentPriceXCenter, rentPriceYCenter);

    rentPricePainter.paint(canvas, rentPriceOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
