import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/trades_person/latest_job_screen_model.dart';

import '../../../cards/trades_person_jobs_custom_card.dart';
import '../../../models/landloard/plumbing_details_model.dart';
import '../../../widgets/cust_image.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/rate_star.dart';
import 'new_quotes_select_tradesman_details_screen.dart';

class NewQuotesDetailScreen extends StatefulWidget {
  final LatestJobModel allocatedJobList;
  final List<PlumbingDetailsModel> plumbingDetailsModel;

  const NewQuotesDetailScreen({
    required this.allocatedJobList,
    required this.plumbingDetailsModel,
  });

  @override
  State<NewQuotesDetailScreen> createState() => _NewQuotesDetailScreenState();
}

class _NewQuotesDetailScreenState extends State<NewQuotesDetailScreen> {
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
              //Alert Message card
              _alertMsgCard(),
              const SizedBox(height: 10),

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
              const SizedBox(height: 30),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.plumbingDetailsModel.length,
                separatorBuilder: (context, index) {
                  return Column(
                    children: const [
                      SizedBox(height: 30),
                      Divider(
                        indent: 30,
                        endIndent: 30,
                      ),
                      SizedBox(height: 30),
                    ],
                  );
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: widget.plumbingDetailsModel[index].jobType ==
                            "M Lewis Plumbing"
                        ? () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) =>
                                    NewQuotesSelectTradesmanDetailScreen(
                                  allocatedJobList: widget.allocatedJobList,
                                  plumbingDetailsModel:
                                      widget.plumbingDetailsModel[index],
                                ),
                              ),
                            );
                          }
                        : () {},
                    child: buildPlumbingWithMoreDetail(
                      plumbingDetailsModel: widget.plumbingDetailsModel[index],
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  //-----------------------------Widgets-----------------------------//

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
                                txtTitle: plumbingDetailsModel.quoteExpiryDate,
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
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
