import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';

import 'custom_text.dart';

class CommonOutlineElevatedButton extends StatelessWidget {
  final String bttnText;
  final Function()? onPressed;
  final double? fontSize;
  final Color? borderColor;
  final Color textColor;
  final double height;
  final bool disable;
  final FontWeight fontWeight;

  const CommonOutlineElevatedButton({
    Key? key,
    this.bttnText = "Button Text",
    this.onPressed,
    this.borderColor,
    this.fontSize,
    this.height = 50,
    this.fontWeight = FontWeight.w600,
    this.disable = false,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return commonOutlineElevatedButton(context);
  }

  Widget commonOutlineElevatedButton(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: disable ? () {} : onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          side: MaterialStateProperty.all(
            BorderSide(
              color: borderColor ?? ColorConstants.custDarkBlue150934,
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.transparent,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: CustomText(
            align: TextAlign.center,
            txtTitle: bttnText.toUpperCase(),
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: fontSize ?? 18,
                  color: textColor,
                  fontWeight: fontWeight,
                ),
          ),
        ),
      ),
    );
  }
}
