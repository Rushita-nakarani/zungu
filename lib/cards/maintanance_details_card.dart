import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/constant/img_constants.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

import '../constant/string_constants.dart';

class MaintatanceDetailsCard extends StatefulWidget {
  const MaintatanceDetailsCard({super.key});

  @override
  State<MaintatanceDetailsCard> createState() => _MaintatanceDetailsCardState();
}

class _MaintatanceDetailsCardState extends State<MaintatanceDetailsCard> {
  bool isReadmore = true;
  String firstHalf = "";
  String secondHalf = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            enlargeCenterPage: true,
            autoPlay: true,
          ),
          itemCount: 5,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
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
                  top: 10,
                  left: 15,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: ColorConstants.custBlue2A00FF.withOpacity(.5),
                        ),
                        child: CustomText(
                          txtTitle: StaticString.tenant,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: ColorConstants.custWhiteF9F9F9),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color:
                              ColorConstants.custPureRedFF0000.withOpacity(.5),
                        ),
                        child: CustomText(
                          txtTitle: StaticString.urgent,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: ColorConstants.custWhiteF9F9F9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        CustomText(
          txtTitle: "121 Cowley Road",
          style: Theme.of(context)
              .textTheme
              .headline1
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        CustomText(
          txtTitle: "Littlemore Oxford OX4 4PH",
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorConstants.custGrey707070,
              ),
        ),
        const SizedBox(height: 12),
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
              txtTitle: StaticString.showerLeak,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    color: ColorConstants.custskyblue22CBFE,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 10),
          ],
        ),
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
                    txtTitle: "15/2/2021",
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
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.custGrey707070,
                        ),
                  ),
                  TextSpan(
                    text: isReadmore ? "Show more" : "Show less",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          isReadmore = !isReadmore;
                        });
                      },
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ColorConstants.custDarkTeal017781,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _tenantDetailsCard({
    String? title,
    String? personName,
    int? rent,
  }) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        // color: propertyListModel.offerType == "TO LET" && isDeleted
        //     ? Colors.white.withOpacity(0.60)
        //     : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
            blurRadius: 12,
          )
        ],
      ),
      child: Row(
        children: [
          // Tenant Person Image
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: const CustImage(
                    imgURL: ImgName.editIcon,
                    height: 60,
                    width: 60,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.custGrey707070.withOpacity(0.60),
                  // color: propertyListModel.offerType == "TO LET" && isDeleted
                  //     ? ColorConstants.custGrey707070.withOpacity(0.60)
                  //     : null,
                ),
              ),
            ],
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TENANT Text
                CustomText(
                  txtTitle: title,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                // tenant person name text
                CustomText(
                  txtTitle: personName, // propertyList.tenantName,
                  textOverflow: TextOverflow.ellipsis,
                  maxLine: 1,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w400,
                      ),
                )
              ],
            ),
          ),

          // Tenant rent card
          Container(
            width: 115,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(65),
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: ColorConstants.custGrey707070.withOpacity(0.70),
              //propertyList.offerColor
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // RENT Text
                CustomText(
                  txtTitle: StaticString.rent,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custWhiteF1F0F0.withOpacity(0.70),
                      ),
                ),

                // rent text
                CustomText(
                  txtTitle:
                      "${StaticString.currency}${rent.toString()}", //propertyList.tenantRent
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custWhiteF1F0F0.withOpacity(0.70),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
