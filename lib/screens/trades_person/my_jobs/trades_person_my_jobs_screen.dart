import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/trades_person/my_jobs/add_private_job_screen.dart';
import 'package:zungu_mobile/screens/trades_person/my_jobs/confirmed_jobs/confirmed_jobs_screen.dart';
import 'package:zungu_mobile/screens/trades_person/my_jobs/latest_jobs/latest_job_screen.dart';
import 'package:zungu_mobile/screens/trades_person/my_jobs/sent_quotes/sent_quotes_screen.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

import '../../../models/settings/feedback_regarding_model.dart';

class TradesPersonMyJobsScreen extends StatefulWidget {
  const TradesPersonMyJobsScreen({super.key});

  @override
  State<TradesPersonMyJobsScreen> createState() =>
      _TradesPersonMyJobsScreenState();
}

class _TradesPersonMyJobsScreenState extends State<TradesPersonMyJobsScreen>
    with TickerProviderStateMixin {
  //--------------------------------Variables---------------------------------//

  TabController? _tabController;



  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  //--------------------------------UI---------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  //--------------------------------Widgets---------------------------------//

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorConstants.custDarkTeal017781,
      title: const CustomText(txtTitle: StaticString.myJobs),
      actions: [
        IconButton(
          onPressed: addBtnAction,
          icon: const CustImage(
            imgURL: ImgName.addIcon,
          ),
        )
      ],
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TabBar(
              labelColor: ColorConstants.custDarkTeal5EAFB0,
              unselectedLabelColor: ColorConstants.custDarkTeal8A8989,
              indicatorColor: ColorConstants.custBlue1EC0EF,
              controller: _tabController,
              tabs: [
                Tab(
                  text: StaticString.latestJobs.toUpperCase(),
                ),
                Tab(
                  text: StaticString.sentQuotes.toUpperCase(),
                ),
                Tab(text: StaticString.confirmedJobs.toUpperCase()),
              ],
              labelStyle: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                LatestJobScreen(),
                SentQuotesscreen(),
                const ConfirmedJobsScreen(isTabBar: true),
              ],
            ),
          )
        ],
      ),
    );
  }

  //--------------------------------button action-----------------------------//

  // add button action
  void addBtnAction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddPrivateJobScreen(),
      ),
    );
  }
}
