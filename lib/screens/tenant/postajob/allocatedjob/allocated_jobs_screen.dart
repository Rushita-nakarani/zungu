//------------------------------- Allocated Jobs Screen -----------------------------//

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/constant/img_constants.dart';
import 'package:zungu_mobile/constant/string_constants.dart';
import 'package:zungu_mobile/main.dart';
import 'package:zungu_mobile/screens/tenant/postajob/allocatedjob/allocated_jobs_details_screen.dart';
import 'package:zungu_mobile/screens/tenant/postajob/allocatedjob/leave_feedback_popup.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

import 'allocated_jobs_filter_by_bottomsheet.dart';

class AllocatedJobTabBarViewScreen extends StatefulWidget {
  final bool isTabbar;

  const AllocatedJobTabBarViewScreen({required this.isTabbar});

  @override
  State<AllocatedJobTabBarViewScreen> createState() =>
      _AllocatedJobTabBarViewScreenState();
}

class _AllocatedJobTabBarViewScreenState
    extends State<AllocatedJobTabBarViewScreen> {
//------------------------------------ Variables -----------------------------------//
  bool isOnTap = true;

//-------------------------------------- UI ----------------------------------------//
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

//------------------------------------ Widgets -------------------------------------//

  // Allocated job view
  Widget _allocatedJobView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          _allocatedAndCompletedJobBtnRow(),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AllocatedJobsDetailsScreen(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _filterTextAndIconRow(),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Image
                          _buildImageAllocatedJobs(),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                //Title
                                _buildTitleAllocatedJobs("40 Cherwell Drive"),
                                const SizedBox(height: 3),
                                //SubTitle
                                _buildSubTitleAllocatedJobs(
                                  "Marston Oxford OX3 OLZ",
                                ),
                                const SizedBox(height: 20),
                                //BathDetails
                                _buildBathDetailsAllocatedJobs(),
                                const SizedBox(height: 13),
                                //Tenant Description Title
                                _buildTenantDescTitleAllocatedJobs(),
                                const SizedBox(height: 5),
                                //Tenant Description
                                _buildTenantDescAllocatedJobs(),
                                const SizedBox(height: 48),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
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
          const SizedBox(height: 30),
          _allocatedAndCompletedJobBtnRow(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 17),
                _filterTextAndIconRow(),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Image
                        _buildImageCompletedJobs(),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              //Title
                              _buildTitleCompletedJobs("121 Cowley Road"),
                              const SizedBox(height: 3),
                              //SubTitle
                              _buildSubTitleCompletedJobs(
                                "Littlemore Oxford OX4 4PH",
                              ),
                              const SizedBox(height: 20),
                              //Bath Details
                              _buildBathDetailsCompletedJobs(),
                              const SizedBox(height: 13),
                              //Tenant Description Title
                              _buildTenantDescTitleCompletedJobs(),
                              const SizedBox(height: 5),
                              //Tenant Description
                              _buildTenantDescCompletedJobs(),
                              const SizedBox(height: 18),
                              //Divider
                              const Divider(),
                              const SizedBox(height: 18),
                              //FeedBack,Rating
                              _buildPlumbingWithMoreDetail(),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
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
        color: ColorConstants.custDarkGreen838500,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          Expanded(
            child: custElavetadeBtn(
              btnColor:
                  isOnTap ? Colors.white : ColorConstants.custDarkGreen838500,
              textColor:
                  isOnTap ? ColorConstants.custDarkGreen838500 : Colors.white,
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
              btnColor:
                  !isOnTap ? Colors.white : ColorConstants.custDarkGreen838500,
              textColor:
                  !isOnTap ? ColorConstants.custDarkGreen838500 : Colors.white,
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
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                wordSpacing: 1.5,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
        ),
      ),
    );
  }

  // Filter Text and icon Row
  Widget _filterTextAndIconRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txtTitle: StaticString.filterBy.toUpperCase(),
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custDarkPurple500472,
                  height: 1,
                  fontWeight: FontWeight.w500,
                ),
          ),
          IconButton(
            onPressed: filterButtonAction,
            icon: const CustImage(
              imgURL: ImgName.filterpostajob,
            ),
          )
        ],
      ),
    );
  }

//--------------------------------- Button Action -----------------------------------/

  // Filter button Ontap Avtion
  void filterButtonAction() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return const AllocatedJobFilterByBottomsheet();
      },
    );
  }

//------------------------------ AllocatedJobs UI Design ---------------------------//

//---------------------------- Tenant BathDetails AllocatedJobs ---------------------/

  Widget _buildBathDetailsAllocatedJobs() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConstants.custWhiteF7F7F7,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const CustImage(
                  imgURL: ImgName.bathTub1,
                ),
              ),
            ),
            const SizedBox(width: 15),
            CustomText(
              txtTitle: StaticString.replacetiles,
              style: Theme.of(getContext).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custDarkYellow838500,
                  ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Container(),
                ),
                const SizedBox(width: 15),
                CustomText(
                  txtTitle: StaticString.reported,
                  style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
              width: 100,
              child: Card(
                color: ColorConstants.custGreyF7F7F7,
                elevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CustImage(
                      imgURL: ImgName.commonCalendar,
                      imgColor: ColorConstants.custDarkPurple662851,
                      width: 14,
                    ),
                    CustomText(
                      txtTitle: "27 Jun 2021",
                      style: Theme.of(getContext).textTheme.caption?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.custGrey707070,
                          ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

//---------------------------- Tenant Description AllocatedJobs ---------------------/

  Widget _buildTenantDescAllocatedJobs() {
    return CustomText(
      txtTitle:
          "Bathroom tiles have become undone and is falling off the wall and needs replacing.",
      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
            color: ColorConstants.custGrey707070,
            fontWeight: FontWeight.w500,
          ),
    );
  }

//------------------------- Tenant Description Title AllocatedJobs ------------------/

  Widget _buildTenantDescTitleAllocatedJobs() {
    return CustomText(
      txtTitle: StaticString.tenantDescription,
      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorConstants.custDarkBlue150934,
          ),
    );
  }

//-------------------------------- SubTitle Name AllocatedJobs ----------------------/

  Widget _buildSubTitleAllocatedJobs(text) {
    return CustomText(
      txtTitle: text,
      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorConstants.custGrey707070,
          ),
    );
  }

//------------------------------------ Title AllocatedJobs --------------------------/

  Widget _buildTitleAllocatedJobs(text) {
    return CustomText(
      txtTitle: text,
      style: Theme.of(getContext).textTheme.headline1?.copyWith(
            fontWeight: FontWeight.w700,
            color: ColorConstants.custDarkBlue150934,
          ),
    );
  }

//------------------------------------ Image AllocatedJobs --------------------------/

  Widget _buildImageAllocatedJobs() {
    return Stack(
      children: [
        const CustImage(
          width: double.infinity,
          height: 175,
          cornerRadius: 12,
          imgURL:
              "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        ),
        Positioned(
          top: 15,
          left: 15,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: ColorConstants.custRedFF0000.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: CustomText(
                  txtTitle: StaticString.jobDeclined,
                  style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custWhiteF9F9F9,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

//----------------------------- Completed Job UI Design ----------------------------//

//----------------------------- Plumbing With More Detail ---------------------------/

  Widget _buildPlumbingWithMoreDetail() {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 30,
              height: 30,
              child: CustImage(
                imgURL: ImgName.fillheartinvoicesicon,
              ),
            ),
            const SizedBox(width: 15),
            CustomText(
              txtTitle: "M Lewis Plumbing",
              style: Theme.of(getContext).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custDarkYellow838500,
                  ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Container(),
                ),
                const SizedBox(width: 15),
                CustomText(
                  txtTitle: StaticString.contractor,
                  style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
                const SizedBox(width: 6),
                SizedBox(
                  child: RatingBar.builder(
                    initialRating: 5,
                    minRating: 5,
                    allowHalfRating: true,
                    unratedColor: ColorConstants.custGreyEBEAEA,
                    itemSize: 12.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                    updateOnDrag: true,
                    itemBuilder: (context, index) => Container(
                      color: Colors.amber,
                      child: const Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                    ),
                    onRatingUpdate: (value) {
                      if (mounted) {
                        setState(() {});
                      }
                    },
                  ),
                ),
                const SizedBox(width: 6),
                CustomText(
                  txtTitle: "(3.5)",
                  style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
              ],
            ),
            const SizedBox(width: 3),
            Flexible(
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: CustomText(
                    txtTitle: "£157.54",
                    style: Theme.of(getContext).textTheme.headline2?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.custGrey707070,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 17),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Container(),
                ),
                const SizedBox(width: 15),
                CustomText(
                  txtTitle: StaticString.completedDate,
                  style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
              width: 100,
              child: Card(
                color: ColorConstants.custGreyF7F7F7,
                elevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CustImage(
                      imgURL: ImgName.commonCalendar,
                      imgColor: ColorConstants.custDarkPurple662851,
                      width: 12,
                    ),
                    CustomText(
                      txtTitle: "20 Mar 2022",
                      style: Theme.of(getContext).textTheme.caption?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.custGrey707070,
                          ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Container(),
                ),
                const SizedBox(width: 15),
                CustomText(
                  txtTitle: StaticString.completedTime,
                  style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
              width: 100,
              child: Card(
                color: ColorConstants.custLightGreenE4FEE2,
                elevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const CustImage(
                      imgURL: ImgName.timeallocatedjob,
                      width: 14,
                    ),
                    CustomText(
                      txtTitle: "18:00",
                      style: Theme.of(getContext).textTheme.caption?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.custGrey707070,
                          ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Container(),
                ),
                const SizedBox(width: 15),
                CustomText(
                  txtTitle: StaticString.leaveFeedback1,
                  style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
              ],
            ),
            SizedBox(
              child: RatingBar.builder(
                initialRating: 5,
                minRating: 5,
                allowHalfRating: true,
                unratedColor: ColorConstants.custGreyEBEAEA,
                itemSize: 18.0,
                itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                updateOnDrag: true,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
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
                  child: Container(
                    color: ColorConstants.custGrey707070.withOpacity(0.5),
                    child: const Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                  ),
                ),
                onRatingUpdate: (value) {},
              ),
            ),
          ],
        ),
      ],
    );
  }

//------------------------- Tenant Description CompletedJobs ------------------------/

  Widget _buildTenantDescCompletedJobs() {
    return ReadMoreText(
      "Shower has a leak from the faucet, it seems like it is a washer which has deteriorated. The hose also seems to be worn badly and will...",
      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
            color: ColorConstants.custGrey707070,
            fontWeight: FontWeight.w500,
          ),
      colorClickableText: ColorConstants.custDarkYellow838500,
      trimMode: TrimMode.Line,
      trimCollapsedText: StaticString.readMoreInAction,
      trimExpandedText: StaticString.showLessInAction,
    );
  }
//----------------------- Tenant Description Title CompletedJobs --------------------/

  Widget _buildTenantDescTitleCompletedJobs() {
    return CustomText(
      txtTitle: StaticString.tenantDescription,
      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorConstants.custDarkBlue150934,
          ),
    );
  }

//------------------------- Tenant BathDetails CompletedJobs ------------------------/

  Widget _buildBathDetailsCompletedJobs() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConstants.custWhiteF7F7F7,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const CustImage(
                  imgURL: ImgName.bathTub1,
                ),
              ),
            ),
            const SizedBox(width: 15),
            CustomText(
              txtTitle: StaticString.showerLeak,
              style: Theme.of(getContext).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custDarkYellow838500,
                  ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Container(),
                ),
                const SizedBox(width: 15),
                CustomText(
                  txtTitle: StaticString.reported,
                  style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
              width: 100,
              child: Card(
                color: ColorConstants.custGreyF7F7F7,
                elevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CustImage(
                      imgURL: ImgName.commonCalendar,
                      imgColor: ColorConstants.custDarkPurple662851,
                      width: 14,
                    ),
                    CustomText(
                      txtTitle: "27 Jun 2021",
                      style: Theme.of(getContext).textTheme.caption?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.custGrey707070,
                          ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

//----------------------------- SubTitle Name CompletedJobs -------------------------/

  Widget _buildSubTitleCompletedJobs(text) {
    return CustomText(
      txtTitle: text,
      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorConstants.custGrey707070,
          ),
    );
  }

//---------------------------------- Title CompletedJobs ----------------------------/

  Widget _buildTitleCompletedJobs(text) {
    return CustomText(
      txtTitle: text,
      style: Theme.of(getContext).textTheme.headline1?.copyWith(
            fontWeight: FontWeight.w700,
            color: ColorConstants.custDarkBlue150934,
          ),
    );
  }

//---------------------------------- Image CompletedJobs ----------------------------/

  Widget _buildImageCompletedJobs() {
    return Stack(
      children: [
        const CustImage(
          height: 175,
          width: double.infinity,
          cornerRadius: 12,
          imgURL:
              "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        ),
        Positioned(
          top: 15,
          left: 15,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: ColorConstants.custRedFF0000.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: CustomText(
                  txtTitle: StaticString.urgent.toUpperCase(),
                  style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custWhiteF9F9F9,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: ColorConstants.custPurple500472.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: CustomText(
                  txtTitle: StaticString.jobCompleted,
                  style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custWhiteF9F9F9,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
