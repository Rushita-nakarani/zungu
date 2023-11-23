import 'package:flutter/material.dart';

import '../constant/text_style_decoration.dart';
import '../constant/textfield_decoration.dart';
import 'img_font_color_string.dart';

//App Theme... (Set all defaults after complete project ui analysis, take time to decide defaults which will help reducing development time further)
class CustomAppTheme {
  CustomAppTheme._();
  //Colors for theme

  static ThemeData lightTheme = ThemeData(
    unselectedWidgetColor: Colors.white,
    brightness: Brightness.light,
    primarySwatch: ColorConstants.custMaterialOrange,
    primaryColor: ColorConstants.custMaterialOrange,
    textTheme: TextStyleDecoration.instance.getLightheme,
    primaryTextTheme: TextStyleDecoration.instance.getLightheme,
    backgroundColor: ColorConstants.backgroundColorE5E5E5,
    dividerColor: const Color(0xFFDEDEDE),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFDEDEDE),
      thickness: 1,
    ),
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: Colors.white),
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme:
        TextFieldDecoration.instance.getOutLineInputDecoration,
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      height: 50.0,
      buttonColor: Colors.blue,
      minWidth: double.infinity,
    ),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: Colors.transparent),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        elevation: MaterialStateProperty.all(0),
        fixedSize: MaterialStateProperty.all(
          const Size(double.maxFinite, 55),
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        elevation: MaterialStateProperty.all(0),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        side: MaterialStateProperty.all(
          const BorderSide(
            color: ColorConstants.custMaterialOrange,
            width: 2,
          ),
        ),
        fixedSize: MaterialStateProperty.all(
          const Size(double.maxFinite, 55),
        ),
      ),
    ),
    fontFamily: TextStyleDecoration.fontFamily,
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyleDecoration.appBarTextStyle,
      color: ColorConstants.custDarkPurple160935,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
  );
}
