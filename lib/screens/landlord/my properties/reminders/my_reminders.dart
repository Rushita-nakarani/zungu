//-------------------------------- My Reminders Screen ----------------------------//

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class MyRemindersScreen extends StatefulWidget {
  const MyRemindersScreen({super.key});

  @override
  State<MyRemindersScreen> createState() => _MyRemindersScreenState();
}

class _MyRemindersScreenState extends State<MyRemindersScreen> {
  //-------------------------------------- UI ---------------------------------------//

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 50),
          _buildMyRemindersDetails(),
        ],
      ),
    );
  }
//------------------------------------- Widgets -----------------------------------//

//-------------------------------- My Reminders Details ---------------------------/

  Widget _buildMyRemindersDetails() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _custMyRemindersCard(
              "Yearly Gas\nSafety Check",
              ColorConstants.backgroundColorFFFFFF,
              ImgName.gasstove,
              ColorConstants.custGreen1FCE9E,
              "6",
            ),
            _custMyRemindersCard(
              "Yearly\nPAT Testing",
              ColorConstants.backgroundColorFFFFFF,
              ImgName.wire,
              ColorConstants.custOrangeFDA859,
              "4",
            ),
            _custMyRemindersCard(
              "Energy\nPerformance",
              ColorConstants.custPinkD72DAD,
              ImgName.performance,
              ColorConstants.custPinkD72DAE,
              "3",
            ),
          ],
        ),
        const SizedBox(height: 55),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _custMyRemindersCard(
              "Electrical\nCertification",
              ColorConstants.backgroundColorFFFFFF,
              ImgName.improve,
              ColorConstants.custLightGreenCDCB1C,
              "7",
            ),
            _custMyRemindersCard(
              "HMO\nLicensing",
              ColorConstants.backgroundColorFFFFFF,
              ImgName.guarantee,
              ColorConstants.custOrangeFF9575,
              "1",
            ),
            _custMyRemindersCard(
              "Home\nInsurance",
              ColorConstants.backgroundColorFFFFFF,
              ImgName.guarantee,
              ColorConstants.custLightBlue2DA9D7,
              "8",
            ),
          ],
        ),
        const SizedBox(height: 55),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _custMyRemindersCard(
              "Contents\nInsurance",
              ColorConstants.backgroundColorFFFFFF,
              ImgName.shield,
              ColorConstants.custRedEC461A,
              "2",
            ),
            _custMyRemindersCard(
              "Public\nLiability",
              ColorConstants.backgroundColorFFFFFF,
              ImgName.liability,
              ColorConstants.custBlue1BC4F4,
              "5",
            ),
            _custMyRemindersCard(
              "Employers\nLiability",
              ColorConstants.backgroundColorFFFFFF,
              ImgName.professional,
              ColorConstants.custParrotGreen91E912,
              "9",
            ),
          ],
        ),
      ],
    );
  }

  Widget _custMyRemindersCard(
    String txtTitle,
    Color bgColor,
    String img,
    Color color,
    String value,
  ) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: 90,
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.custBlack000000.withOpacity(0.1),
                      blurRadius: 15,
                      spreadRadius: 0.2,
                    ),
                  ],
                ),
                child: Center(
                  child: CustImage(
                    imgURL: img,
                    width: 29,
                    height: 35,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomText(
                align: TextAlign.center,
                txtTitle: txtTitle,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstants.custDarkBlue160935,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 8,
          top: 0,
          child: CircleAvatar(
            maxRadius: 10,
            minRadius: 10,
            backgroundColor: color,
            child: CustomText(
              txtTitle: value,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
