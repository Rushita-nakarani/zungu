//--------------------- Previous Inventroies TabBar Screen --------------------------//

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/landlord/my%20properties/manageInventory/previous_edits.dart';
import 'package:zungu_mobile/screens/landlord/my%20properties/manageInventory/previous_inventory.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class PreviousInventroiesTabBarScreen extends StatefulWidget {
  const PreviousInventroiesTabBarScreen({super.key});

  @override
  State<PreviousInventroiesTabBarScreen> createState() =>
      _PreviousInventroiesTabBarScreenState();
}

class _PreviousInventroiesTabBarScreenState
    extends State<PreviousInventroiesTabBarScreen> {
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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const CustomText(
            txtTitle: "Manage Inventory Tab Bar",
          ),
          backgroundColor: ColorConstants.custDarkPurple500472,
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
              PreviousInventoryScreen(),
              PreviousEditsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
//------------------------ Previous Inventroies TabBar ------------------------------//

TabBar get _tabBar => const TabBar(
      labelColor: ColorConstants.custBlue1EC0EF,
      unselectedLabelColor: ColorConstants.custGrey707070,
      labelPadding: EdgeInsets.all(0),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2.0,
          color: ColorConstants.custBlue1EC0EF,
        ),
        insets: EdgeInsets.symmetric(horizontal: 16.0),
      ),
      labelStyle: TextStyle(
        fontSize: 16,
        fontFamily: CustomFont.ttCommons,
        fontWeight: FontWeight.w600,
      ),
      tabs: [
        Tab(
          text: "Previous Inventory",
        ),
        Tab(
          text: "Previous Edits",
        ),
      ],
    );
