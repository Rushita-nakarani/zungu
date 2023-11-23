import 'package:flutter/material.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

import '../constant/img_font_color_string.dart';

class RadioButtonReviewFilter extends StatefulWidget {
  const RadioButtonReviewFilter({
    super.key,
    required this.button,
    required this.onTap,
    required this.selected,
  });
  final void Function()? onTap;
  final RadioModel button;
  final bool selected;

  @override
  State<RadioButtonReviewFilter> createState() =>
      _RadioButtonReviewFilterState();
}

class _RadioButtonReviewFilterState extends State<RadioButtonReviewFilter> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTap,
      leading: CustomPaint(
        size: const Size(20, 20),
        painter: CirclePainter(
          button: widget.button,
          isSelected: widget.selected,
        ),
      ),
      title: CustomText(
        txtTitle: widget.button.text,
        style: Theme.of(context).textTheme.headline1?.copyWith(
              color: widget.selected
                  ? widget.button.color
                  : ColorConstants.custGrey707070,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String text;
  Color color;

  RadioModel({
    required this.isSelected,
    required this.text,
    required this.color,
  });
}

class CirclePainter extends CustomPainter {
  final RadioModel button;
  final bool isSelected;

  CirclePainter({required this.button, this.isSelected = false});
  // bool isSelected;
  // CirclePainter(bool isSelected};

  @override
  void paint(Canvas canvas, Size size) {
    final outerPaint = Paint();
    outerPaint.color = ColorConstants.custLightGreyB9B9B9;
    outerPaint.strokeWidth = 1;
    outerPaint.style = PaintingStyle.stroke;

    final innerPaint = Paint();
    innerPaint.color =
        isSelected ? button.color : ColorConstants.custLightGreyD7D7D7;
    innerPaint.strokeWidth = isSelected ? 0 : 1;
    innerPaint.style = isSelected ? PaintingStyle.fill : PaintingStyle.stroke;

    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      innerPaint,
    );
    canvas.drawOval(
      Rect.fromLTWH(-3, -3, size.width + 6, size.height + 6),
      outerPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
