import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zungu_mobile/models/trades_person/latest_job_screen_model.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_text.dart';

class QuoteDeclinedScreen extends StatefulWidget {
  final LatestJobModel latestJobModel;
  const QuoteDeclinedScreen({super.key, required this.latestJobModel});

  @override
  State<QuoteDeclinedScreen> createState() => _QuoteDeclinedScreenState();
}

class _QuoteDeclinedScreenState extends State<QuoteDeclinedScreen> {
  //------------------------------------Variables---------------------------//
  bool isReadmore = true;
  String firstHalf = "";
  String secondHalf = "";

  //------------------------------------UI---------------------------//
  @override
  Widget build(BuildContext context) {
    if (StaticString.serversLocated.length > 50) {
      firstHalf = widget.latestJobModel.tenantDescription.substring(0, 50);
      secondHalf = widget.latestJobModel.tenantDescription.substring(
        50,
        widget.latestJobModel.tenantDescription.length,
      );
    } else {
      firstHalf = widget.latestJobModel.tenantDescription;
      secondHalf = "";
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.custDarkTeal017781,
        title: const CustomText(
          txtTitle: StaticString.sentQuotesQuoteDeclineJobs,
        ),
      ),
      body: _buildBody(),
    );
  }

  // ---------------------------------Widget--------------------------//
  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //-------------------- job image card and header------------------//
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: const CustImage(
                  imgURL:
                      "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
                ),
              ),

              //------------------- job id number row--------------------------//
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      txtTitle: StaticString.jobIdNo,
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    CustomText(
                      txtTitle: "#A8C87150521",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),

              //-------------------job title and subtitle text and call card ------------------//
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //job title and subtitle text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          txtTitle: widget.latestJobModel.jobTitle,
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        CustomText(
                          txtTitle: widget.latestJobModel.jobSubtitle,
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstants.custGrey707070,
                                  ),
                        )
                      ],
                    ),

                    // call card
                    _customconCard(icon: ImgName.callGreen)
                  ],
                ),
              ),

              //------------------Reoprted Title text and bath image----------------//
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      color: ColorConstants.custLightBlueF5F9FA,
                    ),
                    child: const CustImage(
                      imgURL: ImgName.bathTub1,
                    ),
                  ),
                  const SizedBox(width: 10),
                  CustomText(
                    txtTitle: widget.latestJobModel.reportedTitle,
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          color: ColorConstants.custDarkTeal017781,
                          fontWeight: FontWeight.w500,
                        ),
                  )
                ],
              ),

              //----------------Reported text and date row--------------------//
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: CustomText(
                      txtTitle: StaticString.reported,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstants.custGrey707070,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: ColorConstants.custLightBlueF5F9FA,
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: CustImage(
                            imgURL: ImgName.greenCalender,
                          ),
                        ),
                        const SizedBox(width: 5),
                        CustomText(
                          txtTitle: widget.latestJobModel.reportedDate,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: ColorConstants.custGrey707070,
                                height: 1,
                              ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),

              // --------------------------Description header text and detail text---------------//

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomText(
                  txtTitle: "Tenant Description",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),

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
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
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
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: ColorConstants.custDarkTeal017781,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 40),

              //--------------------------Quote text and edit icon row-------------------//
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomText(
                  txtTitle: StaticString.quote,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              const SizedBox(height: 20),

              //-------------------Available date text and date text row-----------------//

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      txtTitle: StaticString.availableDate,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.custGrey656567,
                          ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: ColorConstants.custLightBlueF5F9FA,
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: CustImage(
                              imgURL: ImgName.greenCalender,
                              height: 10,
                              width: 10,
                            ),
                          ),
                          const SizedBox(width: 5),
                          CustomText(
                            txtTitle: "20 May,2021",
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: ColorConstants.custGrey7C7B7B,
                                      height: 1,
                                    ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              //---------------------- available time---------------------------//
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      txtTitle: StaticString.availableTime,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.custGrey656567,
                          ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: ColorConstants.custGreen1ACF72,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 2),
                            child: Icon(
                              Icons.access_time,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                          const SizedBox(width: 2),
                          CustomText(
                            txtTitle: "11:00 - 14:00",
                            align: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: Colors.white,
                                      height: 1,
                                    ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              //---------------------- job Price(including VAT)---------------------------//
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      txtTitle: StaticString.jobPrice,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.custGrey656567,
                          ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstants.custGreen1ACF72,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: CustomText(
                        txtTitle: "£500",
                        align: TextAlign.center,
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: Colors.white,
                              height: 1,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              //---------------------Summary card--------------------//

              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: ColorConstants.custGreyCFCFCF,
                      ),
                    ),
                    child: Column(
                      children: [
                        _custTitleAndAmountrow(
                          title: StaticString.subTotal,
                          amount: "£ 416.66",
                        ),
                        _custTitleAndAmountrow(
                          title: StaticString.vat1,
                          amount: "£ 83.34",
                        ),
                        _custTitleAndAmountrow(
                          title: StaticString.total1,
                          amount: "£ 500",
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 25,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      color: Colors.white,
                      child: CustomText(
                        txtTitle: StaticString.summary,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: ColorConstants.custGrey696969),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              //------------------Delete and confirm job------------------//

              //Quote Decline Job button
              Container(
                height: 35,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: quoteDeclineBtnAction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(
                      color: ColorConstants.custRedFF0000,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        35.0,
                      ),
                    ),
                  ),
                  child: CustomText(
                    align: TextAlign.center,
                    txtTitle: StaticString.quoteDeclined,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          wordSpacing: 1.5,
                          fontSize: 15,
                          color: ColorConstants.custRedFF0000,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom title and amount text row
  Widget _custTitleAndAmountrow({
    required String title,
    required String amount,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 12, bottom: 12, right: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txtTitle: title,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey656567,
                ),
          ),
          CustomText(
            txtTitle: amount,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey656567,
                ),
          )
        ],
      ),
    );
  }

  // Custom Icon Card
  Widget _customconCard({required String icon}) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: ColorConstants.custGrey707070.withOpacity(0.35),
          )
        ],
      ),
      child: CustImage(
        imgURL: icon,
      ),
    );
  }

  //-------------------------Button action-------------------//

  //Quote Decline buttom action
  void quoteDeclineBtnAction() {
    // showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   builder: (context) {
    //     return const DeclineJobBottomsheet();
    //   },
    // );
  }
}
