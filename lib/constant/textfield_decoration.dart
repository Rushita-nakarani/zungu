import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';

import '../constant/text_style_decoration.dart';

class TextFieldDecoration {
  TextFieldDecoration._();
  static TextFieldDecoration instance = TextFieldDecoration._();

  static BorderRadius get textBorderRadius => BorderRadius.circular(4);
  static Color get borderColor => ColorConstants.borderColorACB4B0;
  static double get borderWidth => 0.5;

  // Outline border...
  InputDecorationTheme get getOutLineInputDecoration => InputDecorationTheme(
        filled: true,
        errorMaxLines: 2,
        hintStyle: TextStyleDecoration.lableStyle,
        fillColor: Colors.transparent,
        iconColor: ColorConstants.borderColorACB4B0,
        errorStyle: TextStyle(
          fontFamily: TextStyleDecoration.fontFamily,
          color: Colors.red,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
        labelStyle: TextStyleDecoration.lableStyle,
        floatingLabelStyle:
            MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
          final Color color = states.contains(MaterialState.focused) &&
                  !states.contains(MaterialState.error)
              ? ColorConstants.custDarkPurple160935
              : states.contains(MaterialState.error)
                  ? Colors.red
                  : ColorConstants.custDarkPurple160935;
          return TextStyleDecoration.lableStyle.copyWith(color: color);
        }),
        focusedErrorBorder: _focusedErrorBorder,
        errorBorder: _errorBorder,
        focusedBorder: _focusedBorder,
        border: _border,
        enabledBorder: _enabledBorder,
        disabledBorder: _disabledBorder,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20.0,
        ),
      );

  final OutlineInputBorder _border = OutlineInputBorder(
    borderRadius: textBorderRadius,
    borderSide: BorderSide(
      color: borderColor,
      width: borderWidth,
    ),
  );

  final OutlineInputBorder _enabledBorder = OutlineInputBorder(
    borderRadius: textBorderRadius,
    borderSide: BorderSide(
      color: borderColor,
      width: borderWidth,
    ),
  );

  final OutlineInputBorder _disabledBorder = OutlineInputBorder(
    borderRadius: textBorderRadius,
    borderSide: BorderSide(
      color: borderColor,
      width: borderWidth,
    ),
  );

  final OutlineInputBorder _focusedBorder = OutlineInputBorder(
    borderRadius: textBorderRadius,
    borderSide: BorderSide(
      color: ColorConstants.custDarkPurple160935,
      width: borderWidth,
    ),
  );

  final OutlineInputBorder _errorBorder = OutlineInputBorder(
    borderRadius: textBorderRadius,
    borderSide: BorderSide(
      color: Colors.red,
      width: borderWidth,
    ),
  );

  final OutlineInputBorder _focusedErrorBorder = OutlineInputBorder(
    borderRadius: textBorderRadius,
    borderSide: BorderSide(
      color: Colors.red,
      width: borderWidth,
    ),
  );
}
