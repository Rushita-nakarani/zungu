import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zungu_mobile/main.dart';
import 'package:zungu_mobile/screens/trades_person/my_jobs/confirmed_jobs/slider_button.dart';

import '../../../../cards/trades_person_jobs_custom_card.dart';
import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../models/trades_person/latest_job_screen_model.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_text.dart';
import 'confirmed_jobs_detail_screen.dart';

class ConfirmedJobsScreen extends StatefulWidget {
  final bool isTabBar;

  const ConfirmedJobsScreen({this.isTabBar = false});
  @override
  State<ConfirmedJobsScreen> createState() => _ConfirmedJobsScreenState();
}

class _ConfirmedJobsScreenState extends State<ConfirmedJobsScreen> {
  //----------------------------Variables-----------------------------//

  bool isOnTap = true;

  List<LatestJobModel> latestJobDummyData =
      latestJobModelFromJson(json.encode(myJobscreenDummyData));

  //----------------------------UI-----------------------------//
  @override
  Widget build(BuildContext context) {
    return widget.isTabBar
        ? Column(
            children: [
              const SizedBox(height: 20),
              _todaysJobAndAlljobsBtnRow(),
              if (isOnTap) _todaysJobView() else Container(),
            ],
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: ColorConstants.custDarkTeal017781,
              title: const Text(StaticString.confirmJobs),
            ),
            body: Column(
              children: [
                const SizedBox(height: 20),
                _todaysJobAndAlljobsBtnRow(),
                if (isOnTap) _todaysJobView() else Container(),
              ],
            ),
          );
  }

  //----------------------Widget-----------------------------//

  Widget _todaysJobAndAlljobsBtnRow() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 60),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: ColorConstants.custDarkTeal017781,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          Expanded(
            child: custElavetadeBtn(
              btnColor:
                  isOnTap ? Colors.white : ColorConstants.custDarkTeal017781,
              textColor:
                  isOnTap ? ColorConstants.custDarkTeal017781 : Colors.white,
              btnTitle: StaticString.todayssJob,
              btnOntap: () {
                setState(() {
                  isOnTap = !isOnTap;
                });
              },
            ),
          ),
          Expanded(
            child: custElavetadeBtn(
              btnColor:
                  !isOnTap ? Colors.white : ColorConstants.custDarkTeal017781,
              textColor:
                  !isOnTap ? ColorConstants.custDarkTeal017781 : Colors.white,
              btnTitle: StaticString.allJobs,
              btnOntap: () {
                setState(() {
                  isOnTap = !isOnTap;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  // Todays job view
  Widget _todaysJobView() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _filterTextAndIconRow(),
            const SizedBox(height: 15),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: latestJobDummyData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => cardOntapAction(
                    confirmedJobModel: latestJobDummyData[index],
                  ),
                  child: MyJobCustCard(
                    latestJobModel: latestJobDummyData[index],
                    childBtn: Container(
                      height: 40,
                      margin: const EdgeInsets.only(
                        top: 30,
                        left: 10,
                        right: 10,
                        bottom: 50,
                      ),
                      child: SliderButton(
                        buttonColor: ColorConstants.custPurple433AA8,
                        vibrationFlag: true,
                        buttonSize: 40,
                        width: MediaQuery.of(context).size.width,
                        highlightedColor: ColorConstants.custDarkTeal017781,
                        baseColor: Colors.white,
                        alignLabel: const Alignment(0.1, 0.1),
                        backgroundColor: ColorConstants.custDarkTeal5EAFB0,
                        action: () async {
                          slideToNavigateBtnAction(index: index);
                        },
                        label: Text(
                          StaticString.slideToNavigate,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                height: 1,
                                wordSpacing: 2,
                              ),
                        ),
                        icon: const Icon(
                          Icons.navigate_next,
                          color: ColorConstants.custGreen3CAC71,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

// Filter Text and icon Row
  Widget _filterTextAndIconRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txtTitle: StaticString.filterBy.toUpperCase(),
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custDarkTeal017781,
                  height: 1,
                ),
          ),
          IconButton(
            onPressed: filterButtonAction,
            icon: const CustImage(
              imgURL: ImgName.greenFilter,
            ),
          )
        ],
      ),
    );
  }

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

  //-------------------------Button action -------------------------//
  void filterButtonAction() {}

  void cardOntapAction({required LatestJobModel confirmedJobModel}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            ConfirmeJobDetailsScreen(confirmedJobModel: confirmedJobModel),
      ),
    );
  }

  Future<void> slideToNavigateBtnAction({required int index}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ConfirmeJobDetailsScreen(
          confirmedJobModel: latestJobDummyData[index],
        ),
      ),
    );
  }
}
