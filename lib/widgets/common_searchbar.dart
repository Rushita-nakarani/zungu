import 'package:flutter/material.dart';

import '../constant/img_font_color_string.dart';
import 'cust_image.dart';

Widget buildCommonSearchBar({
  required BuildContext context,
  required Color color,
  required String image,
  required String title,
  required TextEditingController controller,
  required Function() searchFunc,
  double doubleBorderRadius = 15,
  TextStyle? hintStyle,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Form(
      // key: _formKey,
      // autovalidateMode: _autovalidateMode,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: ColorConstants.backgroundColorFFFFFF,
          borderRadius: BorderRadius.circular(doubleBorderRadius),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.custBlack000000.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 0.2,
            ),
          ],
        ),
        child: TextFormField(
          validator: (value) {
            if (value == "") {
              return "";
            }
            return null;
          },
          textInputAction: TextInputAction.search,
          style: Theme.of(context).textTheme.headline2,
          cursorColor: color,
          controller: controller,
          onEditingComplete: searchFunc,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 10.0,
            ),
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: title,
            hintStyle: hintStyle,
            suffixIcon: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: searchFunc,
              icon: CustImage(
                imgURL: image,
                width: 24,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
