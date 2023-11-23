import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import 'custom_text.dart';

class CommonCalenderCard extends StatelessWidget {
  final String title;
  final Color titleColor;
  final String? date;
  final String dateMonth;
  final String calenderUrl;
  final Color? bgColor;
  final Color? imgColor;
  const CommonCalenderCard({
    super.key,
    required this.title,
    this.titleColor = ColorConstants.custDarkPurple500472,
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
        borderRadius: BorderRadius.circular(2),
        color: bgColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: titleColor,
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
                        text: " $dateMonth",
                        style: Theme.of(context).textTheme.caption?.copyWith(
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
