import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../cards/trades_person_jobs_custom_card.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/img_constants.dart';
import '../../../constant/string_constants.dart';
import '../../../models/settings/feedback_regarding_model.dart';
import '../../../models/trades_person/latest_job_screen_model.dart';
import '../../../widgets/cust_image.dart';
import '../../../widgets/custom_alert.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/rate_star.dart';
import 'allocated_job_detail_screen.dart';
import 'allocated_job_filter_popup.dart';
import 'leave_feedback_popup.dart';

class AllocatedJobTabViewScreen extends StatefulWidget {
  final bool isTabbar;
  const AllocatedJobTabViewScreen({required this.isTabbar});

  @override
  State<AllocatedJobTabViewScreen> createState() =>
      _AllocatedJobTabViewScreenState();
}

class _AllocatedJobTabViewScreenState extends State<AllocatedJobTabViewScreen> {
  //--------------------------------- variable-------------------------------//;
  bool isOnTap = true;

  List<LatestJobModel> allocatedJobDummyData =
      latestJobModelFromJson(json.encode(maintenanceAllocatedJobdummyData));

  List<LatestJobModel> completedJobDummyData =
      latestJobModelFromJson(json.encode(maintenanceCompletedJobdummyData));

  List<FeedbackRegardingModel> filterList = [
    FeedbackRegardingModel(
      id: 0,
      feedbackType: "Online",
    ),
    FeedbackRegardingModel(
      id: 1,
      feedbackType: "Cash on Delivery",
    ),
    FeedbackRegardingModel(
      id: 2,
      feedbackType: "Bank Transfer",
    ),
  ];

  List<FeedbackRegardingModel> jobHederFilterList = [
    FeedbackRegardingModel(
      id: 0,
      feedbackType: "Awaiting Acceptance",
    ),
    FeedbackRegardingModel(
      id: 1,
      feedbackType: "Job Declined",
    ),
    FeedbackRegardingModel(
      id: 2,
      feedbackType: "Job Confirmed",
    ),
  ];

  //--------------------------------- UI-------------------------------//;
  @override
  Widget build(BuildContext context) {
    return widget.isTabbar
        ? isOnTap
            ? _allocatedJobView()
            : _completedJobView()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: ColorConstants.custBlue1EC0EF,
              title: const Text("Completed Job"),
            ),
            body: SafeArea(
              child: isOnTap ? _allocatedJobView() : _completedJobView(),
            ),
          );
  }

  //--------------------------------- Widgets-------------------------------//;

  // Allocated job view
  Widget _allocatedJobView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          _allocatedAndCompletedJobBtnRow(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _filterTextAndIconRow(),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allocatedJobDummyData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => allocatedCardOntap(index: index),
                    child: MyJobCustCard(
                      ontap: allocatedJobDummyData[index].id == 2
                          ? () {
                              showAlert(
                                hideButton: true,
                                context: context,
                                showCustomContent: true,
                                showIcon: false,
                                singleBtnTitle: StaticString.done.toUpperCase(),
                                singleBtnColor:
                                    ColorConstants.custskyblue22CBFE,
                                title: StaticString.filterBy,
                                content: AllocatedJobFilterPopup(
                                  filterList: jobHederFilterList,
                                  onSubmit: (paymentTypeModel) {},
                                ),
                              );
                            }
                          : () {},
                      showJobId: true,
                      latestJobModel: allocatedJobDummyData[index],
                      childBtn: const SizedBox(height: 40),
                      txtColor: ColorConstants.custBlue1EC0EF,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  //Completed job View
  Widget _completedJobView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _alertMsgCard(),
          const SizedBox(height: 10),
          _allocatedAndCompletedJobBtnRow(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _filterTextAndIconRow(),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: completedJobDummyData.length,
                itemBuilder: (context, index) {
                  return Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyJobCustCard(
                        latestJobModel: completedJobDummyData[index],
                        childBtn: const SizedBox(height: 25),
                        txtColor: ColorConstants.custBlue1EC0EF,
                      ),
                      const Divider(
                        indent: 30,
                        endIndent: 30,
                      ),
                      const SizedBox(height: 20),
                      buildPlumbingWithMoreDetail(
                        feedbackRate: completedJobDummyData[index].feedbackRate,
                        contractorRate:
                            completedJobDummyData[index].contractorRate,
                        amount: completedJobDummyData[index].price,
                        dateCompleted:
                            completedJobDummyData[index].completedDate,
                        jobType: completedJobDummyData[index].jobType,
                        timeCompleted:
                            completedJobDummyData[index].completedTime,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  //Allocated and Completed job tab card
  Widget _allocatedAndCompletedJobBtnRow() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: ColorConstants.custBlue1EC0EF,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          Expanded(
            child: custElavetadeBtn(
              btnColor: isOnTap ? Colors.white : ColorConstants.custBlue1EC0EF,
              textColor: isOnTap ? ColorConstants.custBlue1EC0EF : Colors.white,
              btnTitle: StaticString.allocatedJobs1,
              btnOntap: () {
                if (mounted) {
                  setState(() {
                    isOnTap = !isOnTap;
                  });
                }
              },
            ),
          ),
          Expanded(
            child: custElavetadeBtn(
              btnColor: !isOnTap ? Colors.white : ColorConstants.custBlue1EC0EF,
              textColor:
                  !isOnTap ? ColorConstants.custBlue1EC0EF : Colors.white,
              btnTitle: StaticString.completedJob,
              btnOntap: () {
                if (mounted) {
                  setState(() {
                    isOnTap = !isOnTap;
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }

  // Custom Elaveted button
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
                  // color: ColorConstants.custDarkPurple500472,
                  color: ColorConstants.custDarkPurple150934,
                  fontWeight: FontWeight.w500,
                ),
          ),
          IconButton(
            onPressed: filterButtonAction,
            icon: const CustImage(
              imgURL: ImgName.purpleFilter,
            ),
          )
        ],
      ),
    );
  }

  // Alert Msg card
  Widget _alertMsgCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.custGreyF7F7F7,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const CustImage(
              imgURL: ImgName.landlordMaintenance,
              width: 36,
            ),
          ),
          Expanded(
            child: CustomText(
              txtTitle: StaticString.completedJobsAlertMsg,
              maxLine: 3,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custGrey707070,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildPlumbingWithMoreDetail({
    required String jobType,
    required String amount,
    required String dateCompleted,
    required String timeCompleted,
    required String feedbackRate,
    required String contractorRate,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustImage(
                imgURL: ImgName.fillheartinvoicesicon,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      txtTitle: jobType,
                      style: Theme.of(context).textTheme.headline1?.copyWith(
                            color: ColorConstants.custBlue1EC0EF,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          txtTitle: StaticString.landlordSmall,
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: ColorConstants.custGrey707070,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(width: 5),
                        if (contractorRate.isEmpty)
                          Container()
                        else
                          StarRating(
                            rating: double.parse(contractorRate),
                            size: 14,
                          ),
                        const SizedBox(width: 5),
                        if (contractorRate.isEmpty)
                          Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                          )
                        else
                          CustomText(
                            txtTitle: "($contractorRate)",
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: ColorConstants.custGrey707070,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.07,
                        ),
                        Expanded(
                          child: amount.isEmpty
                              ? Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                )
                              : CustomText(
                                  txtTitle: amount,
                                  align: TextAlign.end,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: ColorConstants.custGrey707070,
                                      ),
                                ),
                        ),
                      ],
                    ),

                    SizedBox(height: contractorRate.isEmpty ? 7 : 10),
                    //completed Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 7,
                          child: CustomText(
                            txtTitle: StaticString.jobDate,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      color: ColorConstants.custGrey707070,
                                    ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: ColorConstants.custWhiteF7F7F7,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustImage(
                                  imgURL: ImgName.commonCalendar,
                                  width: 14,
                                ),
                                const SizedBox(width: 4),
                                CustomText(
                                  txtTitle: dateCompleted,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: ColorConstants.custGrey707070,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Completed Time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 7,
                          child: CustomText(
                            txtTitle:
                                // (completedJobDummyData[index].id == 0 &&
                                //         completedJobDummyData[index].id == 1)
                                //     ? StaticString.completedTime
                                //     :
                                StaticString.jobTime,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      color: ColorConstants.custGrey707070,
                                    ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: ColorConstants.custLightGreenE4FEE2,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(height: 10),
                                const CustImage(
                                  imgURL: ImgName.purpleClock,
                                ),
                                const SizedBox(width: 20),
                                CustomText(
                                  align: TextAlign.center,
                                  txtTitle: timeCompleted,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstants.custGrey707070,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: feedbackRate.isEmpty ? 0 : 10),

                    // Feedback Submitted
                    if (feedbackRate.isEmpty)
                      Container()
                    else
                      InkWell(
                        onTap:
                            // completedJobDummyData[index].id == 0
                            //     ?
                            () {
                          showAlert(
                            hideButton: true,
                            context: context,
                            showCustomContent: true,
                            showIcon: false,
                            singleBtnTitle: StaticString.submitFeedback,
                            singleBtnColor: ColorConstants.custskyblue22CBFE,
                            title: StaticString.leaveFeedback,
                            content: const LeaveFeedbackPopup(),
                          );
                        },
                        // : () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 7,
                              child: CustomText(
                                txtTitle:
                                    //  completedJobDummyData[index].id == 0
                                    //     ? StaticString.leaveFeedback
                                    //     :
                                    StaticString.feedbackSubmitted,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      color: ColorConstants.custGrey707070,
                                    ),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: StarRating(
                                rating: double.parse(feedbackRate),
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 45),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //----------------------------Button Action -----------------------------//

  // Filter button Ontap Avtion
  void filterButtonAction() {
    showAlert(
      hideButton: true,
      context: context,
      showCustomContent: true,
      showIcon: false,
      singleBtnTitle: StaticString.done.toUpperCase(),
      singleBtnColor: ColorConstants.custskyblue22CBFE,
      title: StaticString.filterBy,
      content: AllocatedJobFilterPopup(
        filterList: filterList,
        onSubmit: (paymentTypeModel) {},
      ),
    );
  }

  //allocated card on tap action
  void allocatedCardOntap({required int index}) {
    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => AllocatedJobDetailScreen(
              contractorTitle: StaticString.contractor,
              allocatedJobList: allocatedJobDummyData[index],
              dateTitle: StaticString.declinedDate,
              timeTitle: StaticString.declinedTime,
              declineTitle: StaticString.reasonForDeclineTitle,
              declineSubTitle: StaticString.reasonForDeclineMsg,
              btnTitle: StaticString.reallocateJob,
            ),
          ),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => AllocatedJobDetailScreen(
              contractorTitle: StaticString.contractor,
              allocatedJobList: allocatedJobDummyData[index],
              dateTitle: StaticString.allocatedDate,
              timeTitle: StaticString.allocatedTime,
              declineTitle: StaticString.awaitingTitle,
              declineSubTitle: StaticString.awaitingMsg,
              btnTitle: StaticString.rePostThisJob,
              isBtnColor: true,
              msgCardColor: ColorConstants.custSaffronFF7E00.withOpacity(0.30),
            ),
          ),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => AllocatedJobDetailScreen(
              contractorTitle: StaticString.contractor,
              allocatedJobList: allocatedJobDummyData[index],
              dateTitle: StaticString.availableDate,
              timeTitle: StaticString.availableTime,
              declineTitle: "",
              declineSubTitle: "",
              btnTitle: "",
              msgCardColor: Colors.transparent,
            ),
          ),
        );
        break;
      case 3:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => AllocatedJobDetailScreen(
              contractorTitle: StaticString.landlordSmall,
              allocatedJobList: allocatedJobDummyData[index],
              dateTitle: StaticString.jobDate,
              timeTitle: StaticString.jobTime,
              declineTitle: "",
              declineSubTitle: "",
              btnTitle: StaticString.markJobAsCompleted,
              isBtnColor: true,
              isStatus: false,
            ),
          ),
        );

        break;
      case 4:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => AllocatedJobDetailScreen(
              contractorTitle: StaticString.ownContractor,
              allocatedJobList: allocatedJobDummyData[index],
              dateTitle: StaticString.jobDate,
              timeTitle: StaticString.jobTime,
              declineTitle: "",
              declineSubTitle: "",
              btnTitle: StaticString.markJobAsCompleted,
              isStatus: false,
            ),
          ),
        );
        break;
      default:
    }
  }
}
