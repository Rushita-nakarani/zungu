import 'package:flutter/material.dart';

import '../constant/img_font_color_string.dart';

BoxDecoration appBarMenuIconDecoration({
  double borderRadius = 7,
  Color color = Colors.white,
}) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: [
      BoxShadow(
        color: ColorConstants.custGrey7A7A7A.withOpacity(0.3),
        blurRadius: borderRadius,
      ),
    ],
  );
}
