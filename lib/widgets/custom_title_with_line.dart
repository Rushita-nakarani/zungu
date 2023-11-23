import 'package:flutter/material.dart';
import 'package:zungu_mobile/main.dart';

import '../constant/img_font_color_string.dart';
import 'custom_text.dart';
import 'lenear_container.dart';

class CustomTitleWithLine extends StatelessWidget {
  final String title;
  final Color primaryColor;
  final Color secondaryColor;
  final TextStyle? style;
  const CustomTitleWithLine({
    Key? key,
    required this.title,
    required this.primaryColor,
    required this.secondaryColor,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          txtTitle: title,
          style: style ?? Theme.of(getContext).textTheme.headline1?.copyWith(
                color: ColorConstants.custDarkPurple150934,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        LinearContainer(
          width: MediaQuery.of(getContext).size.width / 8,
          color: primaryColor,
        ),
        const SizedBox(height: 3),
        LinearContainer(
          width: MediaQuery.of(getContext).size.width / 10,
          color: secondaryColor,
        ),
      ],
    );
  }
}
