import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/rate_star.dart';

class ContractorProfileScreen extends StatefulWidget {
  const ContractorProfileScreen({super.key});

  @override
  State<ContractorProfileScreen> createState() =>
      _ContractorProfileScreenState();
}

class _ContractorProfileScreenState extends State<ContractorProfileScreen> {
  // (x / 100 + 1) × y
  @override
  List<String> iconList = [
    ImgName.landlordWebCircle,
    ImgName.landlordEmailCircle,
    ImgName.callImage,
    ImgName.chatIcon
  ];
  List<RatingstarModel> ratingList = [
    RatingstarModel(
      star: StaticString.fiveStar,
      Percentage: 0.7,
      PrecentageText: "70%",
    ),
    RatingstarModel(
      star: StaticString.fourStar,
      Percentage: 0.15,
      PrecentageText: "15%",
    ),
    RatingstarModel(
      star: StaticString.threeStar,
      Percentage: 0.08,
      PrecentageText: "8%",
    ),
    RatingstarModel(
      star: StaticString.twoStar,
      Percentage: 0.14,
      PrecentageText: "14%",
    ),
    RatingstarModel(
      star: StaticString.oneStar,
      Percentage: 0.2,
      PrecentageText: "2%",
    ),
  ];
  bool isReadmore = true;
  String firstHalf = "";
  String secondHalf = "";
  @override
  void initState() {
    if (StaticString.plumberEngineer.length > 100) {
      firstHalf = StaticString.plumberEngineer.substring(0, 100);
      secondHalf = StaticString.plumberEngineer.substring(
        100,
        StaticString.plumberEngineer.length,
      );
    } else {
      firstHalf = StaticString.plumberEngineer;
      secondHalf = "";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.custPurple500472,
        title: const Text(StaticString.contractorProfile),
      ),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustImage(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 4,
                      imgURL:
                          "https://thumbs.dreamstime.com/z/architects-work-19123747.jpg",
                    ),
                  ),
                  contractorProfileContent()
                ],
              ),
            )
          ],
          body: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 4,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          //-------------Profile Image-----------//
                          Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: const CustImage(
                                imgURL: ImgName.tenantPersonImage,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),

                          //-------------Profile Details Column-----------//
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                txtTitle: "John Smith",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const StarRating(
                                size: 18,
                                rating: 4.5,
                              )
                            ],
                          ),
                        ],
                      ),

                      //--------Date------//
                      CustomText(
                        txtTitle: "16 Dec 2021",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: ColorConstants.custGrey707070,
                            ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomText(
                    txtTitle: "Supply and fit thermostat to boiler",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 5),
                  if (secondHalf.isEmpty)
                    Text(firstHalf)
                  else
                    Text.rich(
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
                                      color: ColorConstants.custskyblue22CBFE,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 22),
                  customDivider(),
                  const SizedBox(height: 22),

                  // const SizedBox(height: 24),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget contractorProfileContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      width: double.infinity,
      margin: const EdgeInsets.only(top: 150),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            txtTitle: "M Lewis Plumbing",
            style: Theme.of(context).textTheme.headline3?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 10),
          CustomText(
            txtTitle: "314 Park Avenue",
            style: Theme.of(context).textTheme.headline3?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          CustomText(
            txtTitle: "Brent Cross London E16 2DS",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custGrey707070,
                ),
          ),
          const SizedBox(height: 26),
          customDivider(),
          const SizedBox(height: 26),
          CustomText(
            txtTitle: StaticString.getConnected,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              iconList.length,
              (index) => CustImage(
                imgURL: iconList[index],
                width: 55,
              ),
            ),
          ),
          const SizedBox(height: 22),
          customDivider(),
          const SizedBox(height: 30),
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
                      text: isReadmore
                          ? StaticString.readMore
                          : StaticString.readLess,
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
          const SizedBox(height: 26),
          customDivider(),
          const SizedBox(height: 26),
          Center(
            child: CustomText(
              txtTitle: StaticString.customerReviews,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
              align: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ColorConstants.custlightBlueF9FBFF,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const StarRating(
                  rating: 5,
                  size: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                CustomText(
                  txtTitle: "4.7 out of 5",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: CustomText(
              align: TextAlign.center,
              txtTitle: "2250 global ratings",
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custGrey707070,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          const SizedBox(height: 35),
          Column(
            children: List.generate(
              ratingList.length,
              (index) => ratingStar(ratingList[index]),
            ),
          ),
          const SizedBox(height: 22),
          customDivider(),
          const SizedBox(height: 22),
          CustomText(
            txtTitle: StaticString.topReviews,
            style: Theme.of(context).textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget ratingStar(RatingstarModel ratingstarModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: LinearPercentIndicator(
          width: MediaQuery.of(context).size.width / 1.3,
          animation: true,
          animationDuration: 1000,
          lineHeight: 15.0,
          curve: Curves.easeIn,
          leading: CustomText(
            txtTitle: ratingstarModel.star,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey707070,
                ),
          ),
          trailing: CustomText(
            txtTitle: ratingstarModel.PrecentageText,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey707070,
                ),
          ),
          percent: ratingstarModel.Percentage ?? 00,
          barRadius: const Radius.circular(30),
          progressColor: ColorConstants.custOrangeF28E20,
          backgroundColor: ColorConstants.custYellowFFF000,
        ),
      ),
    );
  }

  // Custom Divider...
  Widget customDivider() {
    return const Divider(
      height: 2,
      thickness: 1.5,
      color: ColorConstants.custLightGreyEBEAEA,
    );
  }
}

class RatingstarModel {
  final String? star;
  final double? Percentage;
  final String? PrecentageText;

  RatingstarModel({this.star, this.Percentage, this.PrecentageText});
}
