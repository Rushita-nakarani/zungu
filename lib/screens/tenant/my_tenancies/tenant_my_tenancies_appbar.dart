import 'package:flutter/material.dart';
import 'package:zungu_mobile/screens/tenant/my_tenancies/add_tenancy.dart';

import '../../../constant/img_font_color_string.dart';
import '../../../main.dart';
import '../../../widgets/custom_text.dart';

AppBar tenantMyTenanciesBuildAppbar({
  required String title,
}) {
  return AppBar(
    title: CustomText(
      txtTitle: title,
    ),
    backgroundColor: ColorConstants.custDarkPurple662851,
    actions: <Widget>[
      IconButton(
        icon: const Icon(
          Icons.add,
          color: ColorConstants.backgroundColorFFFFFF,
        ),
        onPressed: () {
          Navigator.of(getContext).push(
            MaterialPageRoute(
              builder: (ctx) => const TenantMyTenancyAddTenancy(),
            ),
          );
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
      indicatorColor: ColorConstants.custDarkYellow838500,
      labelColor: ColorConstants.custDarkYellow838500,
      unselectedLabelColor: ColorConstants.custGrey707070,
      labelStyle: Theme.of(getContext).textTheme.bodyText1?.copyWith(
            fontWeight: FontWeight.w600,
          ),
      tabs: [
        Tab(
          text: StaticString.currentTenancy.toUpperCase(),
        ),
        Tab(
          text: StaticString.previousTenancy.toUpperCase(),
        ),
      ],
    );
