import 'package:flutter/material.dart';

import '../../../constant/img_font_color_string.dart';
import '../../../main.dart';
import '../../../widgets/custom_text.dart';
//import 'add_tenancy.dart';

AppBar tenantMiantenanceBuildAppbar({
  required String title,
}) {
  return AppBar(
    title: CustomText(
      txtTitle: title,
    ),
    backgroundColor: ColorConstants.custDarkPurple662851,
    bottom: PreferredSize(
      preferredSize: _tabBar.preferredSize,
      child: Container(
        color: ColorConstants.backgroundColorFFFFFF,
        child: _tabBar,
      ),
    ),
  );
}

TabBar get _tabBar => TabBar(
     indicatorColor: ColorConstants.custDarkYellow838500,
      labelColor: ColorConstants.custDarkYellow838500,
      unselectedLabelColor: ColorConstants.custGrey707070,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2.0,
          color: ColorConstants.custDarkYellow838500,
        ),
        insets: EdgeInsets.symmetric(horizontal: 10),
      ),
     
      labelStyle: Theme.of(getContext).textTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.w600,
          ),
      tabs: [
        Tab(
          text: StaticString.createRequest.toUpperCase(),
        ),
        Tab(
          text: StaticString.sentRequest.toUpperCase(),
        ),
        Tab(
          text: StaticString.bookedJobs.toUpperCase(),
        ),
      ],
    );
