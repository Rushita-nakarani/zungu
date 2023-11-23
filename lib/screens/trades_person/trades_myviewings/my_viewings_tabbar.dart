//------------------------- Trades My Viewings TabBar Screen ------------------------/

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/trades_person/trades_myviewings/confirmed_viewings.dart';
import 'package:zungu_mobile/screens/trades_person/trades_myviewings/landlord_rejected.dart';
import 'package:zungu_mobile/screens/trades_person/trades_myviewings/viewing_requests.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class TradesMyViewingsTabBarScreen extends StatefulWidget {
  const TradesMyViewingsTabBarScreen({super.key});

  @override
  State<TradesMyViewingsTabBarScreen> createState() =>
      _TradesMyViewingsTabBarScreenState();
}

class _TradesMyViewingsTabBarScreenState
    extends State<TradesMyViewingsTabBarScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const CustomText(
            txtTitle: StaticString.myViewings,
          ),
          backgroundColor: ColorConstants.custCyan017781,
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: Container(
              color: ColorConstants.backgroundColorFFFFFF,
              child: _tabBar,
            ),
          ),
        ),
        body: const SafeArea(
          child: TabBarView(
            children: [
              TradesViewingRequestsScreen(),
              TradesConfirmedViewingsScreen(),
              TradesLandLordRejecteScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
//---------------------------------- TabBar My Viewings -----------------------------/

TabBar get _tabBar => TabBar(
      labelColor: ColorConstants.custCyan017781,
      unselectedLabelColor: ColorConstants.custGrey707070,
      labelPadding: const EdgeInsets.all(0),
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2.0,
          color: ColorConstants.custCyan017781,
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
          child: CustomText(
            txtTitle: StaticString.viewingRequests.toUpperCase(),
            align: TextAlign.center,
          ),
        ),
        Tab(
          child: CustomText(
            txtTitle: StaticString.confirmedViewings.toUpperCase(),
            align: TextAlign.center,
          ),
        ),
        Tab(
          child: CustomText(
            txtTitle: StaticString.landlordRejected.toUpperCase(),
            align: TextAlign.center,
          ),
        ),
      ],
    );
