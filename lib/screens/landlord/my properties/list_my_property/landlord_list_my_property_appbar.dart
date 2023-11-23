import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:zungu_mobile/screens/tenant/my_tenancies/add_tenancy.dart';
import 'package:zungu_mobile/widgets/common_badge_icon_widget.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../main.dart';
import '../../../../widgets/custom_text.dart';

AppBar landlordListMyPropertyBuildAppbar({
  required String title,
}) {
  return AppBar(
    title: CustomText(
      txtTitle: title,
    ),
    backgroundColor: ColorConstants.custDarkPurple500472,
    actions: <Widget>[
      CommonBadgeWithIcon(
        icon: const Icon(
          Icons.add,
          color: ColorConstants.backgroundColorFFFFFF,
        ),
        badgeCount: "2",
        color: Colors.red,
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(
          Icons.info_outline_rounded,
          color: ColorConstants.backgroundColorFFFFFF,
        ),
        onPressed: () {
          // Navigator.of(getContext).push(
          //   MaterialPageRoute(
          //     builder: (ctx) => const TenantMyTenancyAddTenancy(),
          //   ),
          // );
        },
      )
    ],
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
      labelColor: ColorConstants.custBlue1EC0EF,
      unselectedLabelColor: ColorConstants.custGrey707070,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2.0,
          color: ColorConstants.custBlue1EC0EF,
        ),
        insets: EdgeInsets.symmetric(horizontal: 16.0),
      ),
      labelStyle: const TextStyle(
        fontSize: 14,
        fontFamily: CustomFont.ttCommons,
        fontWeight: FontWeight.w600,
      ),
      tabs: [
        Tab(
          text: StaticString.myListing.toUpperCase(),
        ),
        Tab(
          text: StaticString.listProperty.toUpperCase(),
        ),
      ],
    );
