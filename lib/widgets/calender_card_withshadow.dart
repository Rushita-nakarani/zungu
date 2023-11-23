import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import 'custom_text.dart';

class CommonCalenderCardWithShadow extends StatelessWidget {
  final String title;
  final String? date;
  final String dateMonth;
  final String calenderUrl;
  final Color? bgColor;
  final Color? imgColor;
  const CommonCalenderCardWithShadow({
    super.key,
    required this.title,
    this.date,
    required this.dateMonth,
    required this.calenderUrl,
    this.imgColor,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custBlack000000.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 0.2,
          ),
        ],
        borderRadius: BorderRadius.circular(2),
      ),
      padding: const EdgeInsets.all(10),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          children: [
            // calender image
            CustImage(
              imgURL: calenderUrl,
              imgColor: imgColor,
              width: 24,
              height: 24,
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: 1,
              height: 30,
              color: ColorConstants.custGreyBBBABA,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  txtTitle: title,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: ColorConstants.custDarkPurple500472,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                RichText(
                  text: TextSpan(
                    text: date,
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          color: ColorConstants.custGrey707070,
                          fontWeight: FontWeight.w500,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: dateMonth,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: ColorConstants.custGrey707070,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
