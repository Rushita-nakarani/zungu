import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../cards/trades_person_jobs_custom_card.dart';
import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../models/trades_person/latest_job_screen_model.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_text.dart';
import 'latest_job_detail_screen.dart';

class LatestJobScreen extends StatefulWidget {
  @override
  State<LatestJobScreen> createState() => _LatestJobScreenState();
}

class _LatestJobScreenState extends State<LatestJobScreen> {
  //----------------------------Variables-----------------------------//

  bool isReadmore = true;
  String firstHalf = "";
  String secondHalf = "";

  List<LatestJobModel> latestJobDummyData =
      latestJobModelFromJson(json.encode(myJobscreenDummyData));

  static final controller = PageController(
    initialPage: 1,
  );

  //----------------------------UI-----------------------------//
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          _filterTextAndIconRow(),
          _alertMsgCard(),
          const SizedBox(height: 30),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: latestJobDummyData.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () =>
                    cardOntapAction(latestJobModel: latestJobDummyData[index]),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: MyJobCustCard(
                    latestJobModel: latestJobDummyData[index],
                    childBtn: Container(),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  //----------------------Widget-----------------------------//
  // Alert Msg card
  Widget _alertMsgCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorConstants.custGreyF8F8F8,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const CustImage(
              imgURL: ImgName.commonInformation,
              width: 24,
              imgColor: ColorConstants.custDarkTeal017781,
            ),
          ),
          Expanded(
            child: CustomText(
              txtTitle: StaticString.alertMsgLatestJobs,
              maxLine: 2,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: ColorConstants.custGreyA4A3A4),
            ),
          )
        ],
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

  //-------------------------Button action -------------------------//
  void filterButtonAction() {}

  // Card OnTap action
  void cardOntapAction({required LatestJobModel latestJobModel}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            LatestJobDetailsScreen(latestJobModel: latestJobModel),
      ),
    );
  }
}
