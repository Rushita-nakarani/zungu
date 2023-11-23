import 'package:flutter/material.dart';

import 'img_font_color_string.dart';

const CommonInputdecoration = InputDecoration(
  counterText: "",
  border: OutlineInputBorder(
    borderSide: BorderSide(
      color: ColorConstants.custLightGreyD1D3D4,
      width: 1.5,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: ColorConstants.custLightGreyD1D3D4,
      width: 1.5,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: ColorConstants.custLightGreyD1D3D4,
      width: 1.5,
    ),
  ),
  // labelStyle: Theme.of(getContext).textTheme.bodyText2?.copyWith(
  //       color: ColorConstants.custDarkPurple160935,
  //     ),
  // floatingLabelStyle: Theme.of(getContext).textTheme.headline2?.copyWith(
  //       color: ColorConstants.custDarkPurple160935,
  //     ),
);
