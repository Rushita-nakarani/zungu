import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/landloard/plumbing_details_model.dart';
import 'package:zungu_mobile/models/trades_person/latest_job_screen_model.dart';
import 'package:zungu_mobile/screens/landlord/maintenance/maintainence_request_details.dart';
import 'package:zungu_mobile/screens/landlord/maintenance/new_quotes_details_screen.dart';
import 'package:zungu_mobile/screens/landlord/maintenance/post_a_job_screen.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../../../cards/trades_person_jobs_custom_card.dart';
import '../../../widgets/custom_text.dart';
import 'allocatedjob_tabView_screen.dart';
import 'awaiting_quotes_job_screen.dart';

class MaintenanceRequest extends StatefulWidget {
  const MaintenanceRequest({super.key});

  @override
  State<MaintenanceRequest> createState() => _MaintenanceRequestState();
}

class _MaintenanceRequestState extends State<MaintenanceRequest>
    with TickerProviderStateMixin {
  //--------------------------------- variable-------------------------------//;

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  List<LatestJobModel> newRequestDummyData =
      latestJobModelFromJson(json.encode(maintenanceNewRequestdummyData));

  List<LatestJobModel> newQuotesDummyData =
      latestJobModelFromJson(json.encode(maintenanceNewQuotesdummyData));

  List<LatestJobModel> allocatedJobDummyData =
      latestJobModelFromJson(json.encode(maintenanceAllocatedJobdummyData));

  List<PlumbingDetailsModel> plumbingDetailModel4 =
      plumbingDetailsModelFromJson(
    json.encode(newquotesPlumbingDetailsDummyData4),
  );

  List<PlumbingDetailsModel> plumbingDetailModel23 =
      plumbingDetailsModelFromJson(
    json.encode(newquotesPlumbingDetailsDummyData23),
  );

  //--------------------------------- UI-------------------------------//;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  //-----------------------------Widgets----------------------------//

  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: ColorConstants.custPurple500472,
      title: const Text(StaticString.maintainanceRequest),
      actions: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: const CustImage(
            imgURL: ImgName.capImg,
            width: 22,
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: addIconButtonAction,
          icon: const Icon(Icons.add),
        )
      ],
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 20),
          _tabbar(),
          _tabbarView(),
        ],
      ),
    );
  }

  // Tabbar
  Widget _tabbar() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TabBar(
        labelPadding: EdgeInsets.zero,
        labelColor: ColorConstants.custBlue1EC0EF,
        unselectedLabelColor: ColorConstants.custGrey707070,
        indicatorColor: ColorConstants.custBlue1EC0EF,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
        controller: _tabController,
        tabs: [
          Tab(text: StaticString.newRequest.toUpperCase()),
          const Tab(text: StaticString.newQuotes1),
          const Tab(text: StaticString.allocatedJobs),
        ],
        labelStyle: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  // Tabbar view
  Widget _tabbarView() {
    return Expanded(
      child: TabBarView(
        // physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          _newRequestTabbarView(),
          _newQuotesTabbarView(),
          const AllocatedJobTabViewScreen(
            isTabbar: true,
          ),
        ],
      ),
    );
  }

  // New Request tab bar view
  Widget _newRequestTabbarView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 30),
      itemCount: newRequestDummyData.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: newRequestCardOntap,
          child: MyJobCustCard(
            latestJobModel: newRequestDummyData[index],
            childBtn: const SizedBox(height: 50),
            calenderImg: ImgName.calendar,
            txtColor: ColorConstants.custBlue1EC0EF,
          ),
        );
      },
    );
  }

  //New quotes TabbarView
  Widget _newQuotesTabbarView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 30),
      itemCount: newQuotesDummyData.length,
      itemBuilder: (context, index) {
        return MyJobCustCard(
          latestJobModel: newQuotesDummyData[index],
          childBtn: newQuotesDummyData[index].id == 0
              ? _awaitingQuotesBtn(index: index)
              : Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 50),
                  child: CommonElevatedButton(
                    onPressed: () => elevateBtnAction(index: index),
                    bttnText: newQuotesDummyData[index].quotationName,
                    color: ColorConstants.custBlue2AC4EF,
                    height: 40,
                  ),
                ),
          calenderColor: ColorConstants.custDarkPurple662851,
          txtColor: ColorConstants.custBlue1EC0EF,
        );
      },
    );
  }

  // Awaiting Quotes Button
  Widget _awaitingQuotesBtn({required int index}) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(top: 25, bottom: 50),
      child: ElevatedButton(
        onPressed: awaitingQuotesOntapAction,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: const BorderSide(
            color: ColorConstants.custPurple500472,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              35.0,
            ),
          ),
        ),
        child: CustomText(
          txtTitle: newQuotesDummyData[index].quotationName,
          style: Theme.of(context).textTheme.caption?.copyWith(
                wordSpacing: 1.5,
                fontSize: 16,
                color: ColorConstants.custPurple500472,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }

  //New quotes TabbarView
  // Widget _allocatedJobTabbarView() {
  //   return isOnTap
  //       ? Column(
  //           children: [
  //             const SizedBox(height: 30),
  //             _allocatedAndCompletedJobBtnRow(),
  //             Expanded(
  //               child: SingleChildScrollView(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     const SizedBox(height: 20),
  //                     _filterTextAndIconRow(),
  //                     const SizedBox(height: 10),
  //                     ListView.builder(
  //                       shrinkWrap: true,
  //                       physics: const NeverScrollableScrollPhysics(),
  //                       itemCount: allocatedJobDummyData.length,
  //                       itemBuilder: (context, index) {
  //                         return MyJobCustCard(
  //                           latestJobModel: allocatedJobDummyData[index],
  //                           childBtn: const SizedBox(height: 40),
  //                           calenderImg: ImgName.calenderPurpleTenant,
  //                           txtColor: ColorConstants.custBlue1EC0EF,
  //                         );
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         )
  //       : Container();
  // }

  // Widget _allocatedAndCompletedJobBtnRow() {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 30),
  //     padding: const EdgeInsets.all(5),
  //     decoration: BoxDecoration(
  //       color: ColorConstants.custBlue1EC0EF,
  //       borderRadius: BorderRadius.circular(9),
  //     ),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: custElavetadeBtn(
  //             btnColor: isOnTap ? Colors.white : ColorConstants.custBlue1EC0EF,
  //             textColor: isOnTap ? ColorConstants.custBlue1EC0EF : Colors.white,
  //             btnTitle: StaticString.allocatedJobs1,
  //             btnOntap: () {
  //               setState(() {
  //                 isOnTap = !isOnTap;
  //               });
  //             },
  //           ),
  //         ),
  //         Expanded(
  //           child: custElavetadeBtn(
  //             btnColor: !isOnTap ? Colors.white : ColorConstants.custBlue1EC0EF,
  //             textColor:
  //                 !isOnTap ? ColorConstants.custBlue1EC0EF : Colors.white,
  //             btnTitle: StaticString.completedJob,
  //             btnOntap: () {
  //               setState(() {
  //                 isOnTap = !isOnTap;
  //               });
  //             },
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget custElavetadeBtn({
    required Color btnColor,
    required Color textColor,
    required String btnTitle,
    required Function() btnOntap,
  }) {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        onPressed: btnOntap,
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        child: CustomText(
          txtTitle: btnTitle,
          style: Theme.of(context).textTheme.caption?.copyWith(
                wordSpacing: 1.5,
                fontSize: 15,
                color: textColor,
              ),
        ),
      ),
    );
  }

  //-----------------------------Button Action----------------------//

  //Add Icon Button action
  void addIconButtonAction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const MaintenancePostAJobScreen(),
      ),
    );
  }

  // New Request Card Ontap Action
  void newRequestCardOntap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const MaintainanceReuestDetails(),
      ),
    );
  }

  void awaitingQuotesOntapAction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AwaitingQuotesJobDetailScreen(),
      ),
    );
  }

  void filterButtonAction() {}

  void elevateBtnAction({required int index}) {
    switch (index) {
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => NewQuotesDetailScreen(
              allocatedJobList: newQuotesDummyData[index],
              plumbingDetailsModel: plumbingDetailModel23,
            ),
          ),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => NewQuotesDetailScreen(
              allocatedJobList: newQuotesDummyData[index],
              plumbingDetailsModel: plumbingDetailModel23,
            ),
          ),
        );
        break;
      case 3:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => NewQuotesDetailScreen(
              allocatedJobList: newQuotesDummyData[index],
              plumbingDetailsModel: plumbingDetailModel4,
            ),
          ),
        );
        break;
      default:
    }
  }
}
