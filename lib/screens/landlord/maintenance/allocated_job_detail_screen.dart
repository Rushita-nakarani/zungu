import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/trades_person/latest_job_screen_model.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';

import '../../../cards/trades_person_jobs_custom_card.dart';
import '../../../widgets/cust_image.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/rate_star.dart';

class AllocatedJobDetailScreen extends StatefulWidget {
  final LatestJobModel allocatedJobList;
  final String contractorTitle;
  final String dateTitle;
  final String timeTitle;
  final String declineTitle;
  final String declineSubTitle;
  final String btnTitle;
  final Color msgCardColor;
  final bool isBtnColor;
  final bool isStatus;

  const AllocatedJobDetailScreen({
    required this.allocatedJobList,
    required this.contractorTitle,
    required this.dateTitle,
    required this.timeTitle,
    required this.declineTitle,
    required this.declineSubTitle,
    required this.btnTitle,
    this.isBtnColor = false,
    this.isStatus = true,
    this.msgCardColor = ColorConstants.custLightRedFFE6E6,
  });

  @override
  State<AllocatedJobDetailScreen> createState() =>
      _AllocatedJobDetailScreenState();
}

class _AllocatedJobDetailScreenState extends State<AllocatedJobDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.custPurple500472,
        title: const Text(StaticString.allocatedJobsDetail),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              _carouselSliderCard(),

              //Details Card
              MyJobCustCard(
                isImg: true,
                latestJobModel: widget.allocatedJobList,
                childBtn: const SizedBox(height: 30),
                txtColor: ColorConstants.custBlue1EC0EF,
              ),
              //Divider
              const Divider(
                indent: 30,
                endIndent: 30,
              ),
              const SizedBox(height: 20),

              //Plumbing Detail Card
              buildPlumbingWithMoreDetail(),

              //Reason Of Cancelling Card
              if (widget.declineTitle.isEmpty)
                Container()
              else
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  padding: const EdgeInsets.all(
                    10,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: widget.msgCardColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        txtTitle: widget.declineTitle,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 15),
                      CustomText(
                        txtTitle: widget.declineSubTitle,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.custGrey707070,
                            ),
                      )
                    ],
                  ),
                ),
              SizedBox(
                height: widget.declineTitle.isEmpty ? 0 : 30,
              ),

              if (widget.btnTitle.isEmpty)
                Container()
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CommonElevatedButton(
                    bttnText: widget.btnTitle,
                    onPressed: () {},
                    color: ColorConstants.custBlue1EC0EF,
                  ),
                ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  //-----------------------------Widgets-----------------------------//

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

  Widget buildPlumbingWithMoreDetail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
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
                  txtTitle: widget.allocatedJobList.jobType,
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: ColorConstants.custBlue1EC0EF,
                        fontWeight: FontWeight.w500,
                      ),
                ),

                if (widget.allocatedJobList.contractorRate.isEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        txtTitle: widget.contractorTitle,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: ColorConstants.custGrey707070,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      CustomText(
                        txtTitle: widget.allocatedJobList.price,
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.custGrey707070,
                            ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: CustomText(
                                  txtTitle: widget.contractorTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                        color: ColorConstants.custGrey707070,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              if (widget
                                  .allocatedJobList.contractorRate.isEmpty)
                                Container()
                              else
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: StarRating(
                                    rating: double.parse(
                                      widget.allocatedJobList.contractorRate,
                                    ),
                                    size: 14,
                                  ),
                                ),
                              const SizedBox(width: 5),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: CustomText(
                                  txtTitle:
                                      "(${widget.allocatedJobList.contractorRate})",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        color: ColorConstants.custGrey707070,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomText(
                        txtTitle: widget.allocatedJobList.price,
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.custGrey707070,
                            ),
                      ),
                    ],
                  ),
                SizedBox(
                  height:
                      widget.allocatedJobList.contractorRate.isEmpty ? 7 : 25,
                ),
                //completed Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      txtTitle: widget.dateTitle,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
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
                            txtTitle: widget.allocatedJobList.completedDate,
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
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

                // Completed Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      txtTitle: widget.timeTitle,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
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
                          SizedBox(
                            width: widget.btnTitle.isEmpty ? 5 : 10,
                          ),
                          CustomText(
                            align: TextAlign.center,
                            txtTitle: widget.allocatedJobList.completedTime,
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
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

                // Status
                if (widget.isStatus)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        txtTitle: StaticString.status,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: ColorConstants.custGrey707070,
                            ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: widget.isBtnColor
                                ? ColorConstants.custSaffronFF7E00
                                    .withOpacity(0.80)
                                : Color(
                                    int.parse(
                                      widget.allocatedJobList.jobHeaderList.last
                                          .jobHeaderColor,
                                    ),
                                  ),
                            width: 1.5,
                          ),
                        ),
                        child: CustomText(
                          txtTitle: widget
                              .allocatedJobList.jobHeaderList.last.jobHeader,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: widget.isBtnColor
                                    ? ColorConstants.custSaffronFF7E00
                                        .withOpacity(0.50)
                                    : Color(
                                        int.parse(
                                          widget.allocatedJobList.jobHeaderList
                                              .last.jobHeaderColor,
                                        ),
                                      ),
                              ),
                        ),
                      ),
                    ],
                  )
                else
                  Container(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
