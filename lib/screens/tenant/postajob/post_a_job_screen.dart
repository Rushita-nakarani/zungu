//--------------------------------- Post a Job Home Screen --------------------------/

import 'package:flutter/material.dart';
import 'package:zungu_mobile/screens/tenant/postajob/getquotes/get_quotes_screen.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

import '../../../constant/img_font_color_string.dart';
import 'allocatedjob/allocated_jobs_screen.dart';
import 'newquotes/new_quotes_screen.dart';

class PostAJobScreen extends StatefulWidget {
  const PostAJobScreen({super.key});

  @override
  State<PostAJobScreen> createState() => _PostAJobScreenState();
}

class _PostAJobScreenState extends State<PostAJobScreen> {
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
            txtTitle: StaticString.postAJob1,
          ),
          backgroundColor: ColorConstants.custDarkPurple662851,
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
              PostAJobGetQuotesScreen(),
              NewQuotesScreen(),
              AllocatedJobTabBarViewScreen(isTabbar: true),
            ],
          ),
        ),
      ),
    );
  }
}
//--------------------------------- TabBar Post a Job--------------------------------/

TabBar get _tabBar => TabBar(
      labelColor: ColorConstants.custDarkYellow838500,
      unselectedLabelColor: ColorConstants.custGrey707070,
      labelPadding: const EdgeInsets.all(0),
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2.0,
          color: ColorConstants.custDarkYellow838500,
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
          text: StaticString.getQuotes1.toUpperCase(),
        ),
        Tab(
          text: StaticString.newQuotes11.toUpperCase(),
        ),
        Tab(
          text: StaticString.allocatedJobs11.toUpperCase(),
        ),
      ],
    );
