import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/trades_person/latest_job_screen_model.dart';
import 'package:zungu_mobile/screens/landlord/maintenance/contractor_profile.dart';
import 'package:zungu_mobile/widgets/custom_title_with_line.dart';
import 'package:zungu_mobile/widgets/rich_text.dart';

import '../../../cards/trades_person_jobs_custom_card.dart';
import '../../../models/landloard/plumbing_details_model.dart';
import '../../../widgets/common_elevated_button.dart';
import '../../../widgets/cust_image.dart';
import '../../../widgets/custom_alert.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/rate_star.dart';

class NewQuotesSelectTradesmanDetailScreen extends StatefulWidget {
  final LatestJobModel allocatedJobList;
  final PlumbingDetailsModel plumbingDetailsModel;

  const NewQuotesSelectTradesmanDetailScreen({
    required this.allocatedJobList,
    required this.plumbingDetailsModel,
  });

  @override
  State<NewQuotesSelectTradesmanDetailScreen> createState() =>
      _NewQuotesSelectTradesmanDetailScreenState();
}

class _NewQuotesSelectTradesmanDetailScreenState
    extends State<NewQuotesSelectTradesmanDetailScreen> {
  //----------------------------Variables--------------------------//
  bool isReadmore = true;
  String firstHalf = StaticString.contractorDescriptions;

  String secondHalf = "";

  List<String> getConnectedImgLit = [
    ImgName.landlordWebCircle,
    ImgName.landlordEmailCircle,
    ImgName.callImage,
    ImgName.chatIcon
  ];

  @override
  void initState() {
    super.initState();
    if (StaticString.serversLocated.length > 50) {
      firstHalf = StaticString.contractorDescriptions.substring(0, 50);
      secondHalf = StaticString.contractorDescriptions.substring(
        50,
        StaticString.contractorDescriptions.length,
      );
    } else {
      firstHalf = StaticString.contractorDescriptions;
      secondHalf = "";
    }
  }

  //----------------------------Ui--------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(context),
    );
  }
  //-----------------------------Widgets-----------------------------//

  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: ColorConstants.custPurple500472,
      title: const Text("NewQuotes Select Tradesman Detail"),
    );
  }

  SafeArea _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            //Alert Message card
            _alertMsgCard(),
            const SizedBox(height: 10),

            _carouselSliderCard(),

            //Details Card
            MyJobCustCard(
              isImg: true,
              latestJobModel: widget.allocatedJobList,
              childBtn: const SizedBox(height: 30),
              calenderImg: ImgName.landlordCalender,
              txtColor: ColorConstants.custBlue1EC0EF,
            ),
            //Divider
            const Divider(
              indent: 30,
              endIndent: 30,
            ),
            const SizedBox(height: 20),

            // Plumbing with more details caard
            buildPlumbingWithMoreDetail(
              plumbingDetailsModel: widget.plumbingDetailsModel,
            ),

            // Contractor Details card
            _buildContractorDetailsCard(),

            //Divider
            const Divider(
              indent: 30,
              endIndent: 30,
            ),
            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomText(
                txtTitle: StaticString.getConnected,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  getConnectedImgLit.length,
                  (index) => CustImage(
                    imgURL: getConnectedImgLit[index],
                    width: 55,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CommonElevatedButton(
                bttnText: StaticString.selectThisTrademan,
                onPressed: selectThisTrademanBtnAction,
                color: ColorConstants.custBlue1EC0EF,
                height: 40,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
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
              txtTitle: StaticString.newRquestDetailAlertMsg,
              maxLine: 3,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: ColorConstants.custGrey707070),
            ),
          )
        ],
      ),
    );
  }

  // Carousel Slider Image
  Widget _carouselSliderCard() {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 160,
        enlargeCenterPage: true,
        autoPlay: true,
      ),
      itemCount: 5,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.015,
              left: MediaQuery.of(context).size.width * 0.03,
              child: Row(
                children: List.generate(
                  widget.allocatedJobList.jobHeaderList.length,
                  (index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 7),
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(
                          int.parse(
                            widget.allocatedJobList.jobHeaderList[index]
                                .jobHeaderColor,
                          ),
                        ).withOpacity(0.65),
                      ),
                      child: CustomText(
                        txtTitle: widget
                            .allocatedJobList.jobHeaderList[index].jobHeader,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: ColorConstants.custWhiteF9F9F9,
                            ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget buildPlumbingWithMoreDetail({
    required PlumbingDetailsModel plumbingDetailsModel,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const ContractorProfileScreen(),
          ),
        );
      },
      child: Padding(
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
                        txtTitle: plumbingDetailsModel.jobType,
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                              color: ColorConstants.custBlue1EC0EF,
                              fontWeight: FontWeight.w500,
                            ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                children: [
                                  CustomText(
                                    txtTitle: StaticString.contractor,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                          color: ColorConstants.custGrey707070,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  const SizedBox(width: 3),
                                  StarRating(
                                    rating: double.parse(
                                      plumbingDetailsModel.contractorRate,
                                    ),
                                    size: 14,
                                  ),
                                  const SizedBox(width: 5),
                                  CustomText(
                                    txtTitle:
                                        "(${plumbingDetailsModel.contractorRate})",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                          color: ColorConstants.custGrey707070,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          CustomText(
                            txtTitle: plumbingDetailsModel.price,
                            style:
                                Theme.of(context).textTheme.headline2?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.custGrey707070,
                                    ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: widget.allocatedJobList.contractorRate.isEmpty
                            ? 7
                            : 25,
                      ),
                      //--------------------available Date------------------//
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            txtTitle: StaticString.availableDate,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      color: ColorConstants.custGrey707070,
                                    ),
                          ),
                          Container(
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
                                  imgColor: ColorConstants.custDarkPurple500472,
                                  width: 14,
                                ),
                                const SizedBox(width: 4),
                                CustomText(
                                  txtTitle: plumbingDetailsModel.availableDate,
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
                        ],
                      ),
                      const SizedBox(height: 10),

                      //------------------------Available Time-------------------------//
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            txtTitle: StaticString.availableTime,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      color: ColorConstants.custGrey707070,
                                    ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: ColorConstants.custLightGreenE4FEE2,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 5),
                                const CustImage(
                                  imgURL: ImgName.purpleClock,
                                ),
                                const SizedBox(width: 10),
                                CustomText(
                                  align: TextAlign.center,
                                  txtTitle: plumbingDetailsModel.availableTime,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstants.custGrey707070,
                                      ),
                                ),
                                const SizedBox(width: 5),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      //-------------------------Quote Expiry Date---------------------//

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            txtTitle: StaticString.quoteExpiryDate,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      color: ColorConstants.custGrey707070,
                                    ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: ColorConstants.custLightRedFFE6E6,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustImage(
                                  imgURL: ImgName.commonCalendar,
                                  imgColor: ColorConstants.custDarkPurple500472,
                                  width: 14,
                                ),
                                const SizedBox(width: 4),
                                CustomText(
                                  txtTitle:
                                      plumbingDetailsModel.quoteExpiryDate,
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
                        ],
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
            //Divider
            const Divider(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Contractor Details card
  Widget _buildContractorDetailsCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Contractor Details Header text
          const CustomTitleWithLine(
            title: StaticString.contractorDetails,
            primaryColor: ColorConstants.custPurple500472,
            secondaryColor: ColorConstants.custBlue1EC0EF,
          ),
          const SizedBox(height: 30),

          // Contactore Details
          _buildContaractorDetails(),
          const SizedBox(height: 20),

          // Ratings text
          CustomText(
            txtTitle: StaticString.ratings,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 5),

          // Rating Star
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const StarRating(
                    mainAxisAlignment: MainAxisAlignment.start,
                    rating: 3.5,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  CustomText(
                    txtTitle: "(3.5)",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstants.custGrey707070,
                        ),
                  ),
                ],
              ),
              CustomText(
                txtTitle: "2.6 miles",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstants.custBlue1EC0EF,
                    ),
              )
            ],
          ),
          const SizedBox(height: 25),

          if (secondHalf.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(firstHalf),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: isReadmore
                          ? ("$firstHalf...")
                          : (firstHalf + secondHalf),
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.custGrey707070,
                          ),
                    ),
                    TextSpan(
                      text: isReadmore ? "Show more" : "Show less",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          if (mounted) {
                            setState(() {
                              isReadmore = !isReadmore;
                            });
                          }
                        },
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: ColorConstants.custskyblue22CBFE,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 15),
        ],
      ),
    );
  }

  // Contactore Details
  Widget _buildContaractorDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Contractor name and location text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              txtTitle: StaticString.mLewisPlumbing,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_sharp,
                  size: 15,
                  color: ColorConstants.custGrey707070,
                ),
                CustomText(
                  txtTitle: StaticString.contractorDetail,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custGrey707070,
                      ),
                )
              ],
            )
          ],
        ),

        IconButton(
          onPressed: blockUserOntapAction,
          icon: const CustImage(
            imgURL: ImgName.landlordBlockUser,
            width: 36,
          ),
        )
      ],
    );
  }

  //----------------------------button Action----------------------//

  // Select This Trademan Button Action
  void selectThisTrademanBtnAction() {
    showAlert(
      context: context,
      showCustomContent: true,
      showIcon: false,
      singleBtnTitle: StaticString.allocateJob.toUpperCase(),
      singleBtnColor: ColorConstants.custBlue1EC0EF,
      title: StaticString.allocateJob,
      content: Column(
        children: [
          CustomText(
            txtTitle: StaticString.allocateJobMsg,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey707070,
                ),
          ),
          const SizedBox(height: 10),
          CustomText(
            txtTitle: StaticString.mLewisPlumbers,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  color: ColorConstants.custPurple500472,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Block User Ontap Action
  void blockUserOntapAction() {
    showAlert(
      context: context,
      showCustomContent: true,
      showIcon: false,
      singleBtnTitle: StaticString.blockTradesman,
      singleBtnColor: ColorConstants.custBlue1EC0EF,
      title: StaticString.blockThisUser,
      content: Column(
        children: [
          CustomText(
            txtTitle: StaticString.areYousureWantToBlockThisUser,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey707070,
                ),
          ),
          const SizedBox(height: 10),
          CustomText(
            txtTitle: StaticString.mLewisPlumbing,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  color: ColorConstants.custPurple500472,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomRichText(
              textAlign: TextAlign.center,
              maxLines: 4,
              title: StaticString.blockThisUserMsg,
              fancyTextStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custBlue1EC0EF,
                  ),
              normalTextStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custGrey707070,
                  ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
