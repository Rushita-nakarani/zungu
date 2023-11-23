import 'package:flutter/material.dart';

import '../../../constant/img_font_color_string.dart';
import '../../../widgets/cust_image.dart';
import '../../../widgets/custom_text.dart';

class CustomCalender extends StatelessWidget {
  const CustomCalender({
    super.key,
    required this.title,
    required this.date,
    required this.monthYear,
    required this.backgroundcolor,
    required this.fontColor,
  });

  final String title;
  final String date;
  final String monthYear;
  final Color backgroundcolor;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(3)),
        color: backgroundcolor,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustImage(
              imgURL: ImgName.commonCalendar,
              width: 24,
              imgColor: fontColor,
            ),
            const VerticalDivider(
              color: ColorConstants.custGrey969696,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  txtTitle: title,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: fontColor,
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
                        text: " ",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: ColorConstants.custGrey707070,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      TextSpan(
                        text: monthYear,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: ColorConstants.custGrey707070,
                              fontWeight: FontWeight.w500,
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
    );
  }
}
