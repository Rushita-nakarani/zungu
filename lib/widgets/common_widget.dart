import 'package:flutter/material.dart';

import '../constant/color_constants.dart';
import '../constant/string_constants.dart';
import '../main.dart';
import 'custom_text.dart';

Widget commonHeaderLable({
  String title = "",
  double spaceBetween = 30,
  required Widget child,
  Color firstLineColor = ColorConstants.custDarkPurple500472,
  Color secondLineColor = ColorConstants.custBlue1BC4F4,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        txtTitle: title,
        style: Theme.of(getContext).textTheme.headline1?.copyWith(
              fontWeight: FontWeight.w500,
              color: ColorConstants.custDarkBlue150934,
            ),
      ),
      const SizedBox(
        height: 6,
      ),
      Container(
        height: 2,
        width: 52,
        color: firstLineColor,
      ),
      const SizedBox(
        height: 3,
      ),
      Container(
        height: 2,
        width: 36,
        color: secondLineColor,
      ),
      SizedBox(
        height: spaceBetween,
      ),
      child
    ],
  );
}

// Common Add Property And Filter Card
Widget commonPropertyCard({
  required Function() ontap,
  required String propertyName,
  required bool isSelected,
}) {
  return InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: ontap,
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: 9,
        horizontal: 14,
      ),
      decoration: BoxDecoration(
        color: isSelected ? ColorConstants.custBlue1BC4F4 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
            blurRadius: 12,
          ),
        ],
      ),

      //Property type Name Text
      child: CustomText(
        txtTitle: propertyName,
        style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
              color: isSelected ? Colors.white : ColorConstants.custGrey707070,
              fontWeight: FontWeight.w500,
            ),
      ),
    ),
  );
}

// Custom Disable Friendly Switch
Widget custDisableFrdlySwitch({
  Color textColor = ColorConstants.custDarkBlue150934,
  required String switchValueText,
  required bool switchValue,
  required Function(bool val) switchOntap,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: CustomText(
          txtTitle: switchValueText,
          maxLine: 2,
          style: Theme.of(getContext).textTheme.headline1?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
      Switch.adaptive(
        thumbColor: MaterialStateProperty.all(Colors.white),
        activeColor: ColorConstants.custPurple500472,
        activeTrackColor: ColorConstants.custPurple500472,
        value: switchValue,
        onChanged: (value) => switchOntap(value),
      ),
    ],
  );
}
