import 'package:flutter/material.dart';

import 'img_font_color_string.dart';

// overline : 10.0
// caption  : 12.0
// bodytext1: 14.0
// bodytext2: 16.0
// headline1: 18.0
// headline2: 20.0
// headline3: 22.0
// headline4: 24.0
// headline5: 26.0
// headline6: 28.0

class TextStyleDecoration {
  TextStyleDecoration._();
  static TextStyleDecoration instance = TextStyleDecoration._();

  // App Default font...
  static String? fontFamily = CustomFont.ttCommons;

  // Get Text theme...
   TextTheme get getLightheme => TextTheme(
        overline: _overline, // 10.0
        caption: _caption, // 12.0
        bodyText1: _body1, // 14.0
        bodyText2: _body2, // 16.0
        headline1: _headline1, // 18.0
        headline2: _headline2, // 20.0
        headline3: _headline3, // 22.0
        headline4: _headline4, // 24.0
        headline5: _headline5, // 26.0
        headline6: _headline6, // 28.0
        subtitle1:
            _subTitle, // 14.0 this is also used when no style is given to textfield..
        subtitle2: _subHeadline, // 16.0
        button: _button, // 16.0
      );

  // Get Text theme...
  static TextTheme get getDarkheme => TextTheme(
        overline: _overline, // 10.0
        caption: _caption, // 12.0
        bodyText1: _body1, // 14.0
        bodyText2: _body2, // 16.0
        headline1: _headline1, // 18.0
        headline2: _headline2, // 20.0
        headline3: _headline3, // 22.0
        headline4: _headline4, // 24.0
        headline5: _headline5, // 26.0
        headline6: _headline6, // 28.0
        subtitle1:
            _subTitle, // 14.0 this is also used when no style is given to textfield..
        subtitle2: _subHeadline, // 16.0
        button: _button, // 16.0
      );

  static final lableStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.0,
    color: ColorConstants.custGrey707070,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get textfieldPlaceholder => TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        fontSize: 14.0,
      );

  static TextStyle get textStyle => TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        letterSpacing: 0.3,
        fontSize: 18.0,
      );

  static TextStyle get appBarTextStyle => TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontFamily: fontFamily,
        letterSpacing: 0.01,
        fontSize: 20.0,
      );

  static TextStyle get subtitleTextStyle => TextStyle(
        fontWeight: FontWeight.w400,
        color: ColorConstants.custDarkPurple150934.withOpacity(0.7),
        fontFamily: fontFamily,
        letterSpacing: 0.3,
        fontSize: 16.0,
      );

  static TextStyle get textUnderLine => TextStyle(
        decoration: TextDecoration.underline,
        color: ColorConstants.custDarkPurple150934,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        fontSize: 16.0,
      );

  static final _overline = TextStyle(
    fontFamily: fontFamily,
    color: ColorConstants.custDarkPurple150934,
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
  );

  static final _caption = TextStyle(
    fontFamily: fontFamily,
    color: ColorConstants.custDarkPurple150934,
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle _body1 = TextStyle(
    fontFamily: fontFamily,
    color: ColorConstants.custDarkPurple150934,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  static final _body2 = TextStyle(
    fontFamily: fontFamily,
    color: ColorConstants.custDarkPurple150934,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  static final _headline1 = TextStyle(
    fontFamily: fontFamily,
    color: ColorConstants.custDarkPurple150934,
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
  );

  static final _headline2 = TextStyle(
    fontFamily: fontFamily,
    color: ColorConstants.custDarkPurple150934,
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
  );

  static final _headline3 = TextStyle(
    fontFamily: fontFamily,
    color: ColorConstants.custDarkPurple150934,
    fontSize: 22.0,
    fontWeight: FontWeight.w400,
  );

  static final _headline4 = TextStyle(
    fontFamily: fontFamily,
    color: ColorConstants.custDarkPurple150934,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
  );

  static final _headline5 = TextStyle(
    fontFamily: fontFamily,
    color: ColorConstants.custDarkPurple150934,
    fontSize: 26.0,
    fontWeight: FontWeight.w400,
  );

  static final _headline6 = TextStyle(
    fontFamily: fontFamily,
    color: ColorConstants.custDarkPurple150934,
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
  );

  static final _subTitle = TextStyle(
    fontFamily: fontFamily,
    color: ColorConstants.custGrey707070,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
  );

  static final _subHeadline = TextStyle(
    fontFamily: fontFamily,
    color: ColorConstants.custDarkPurple150934,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  static final _button = TextStyle(
    fontFamily: fontFamily,
    color: ColorConstants.custDarkPurple150934,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );
}
