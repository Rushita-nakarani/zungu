import 'package:flutter/material.dart';

import '../constant/img_font_color_string.dart';
import '../widgets/cust_image.dart';
import '../widgets/custom_text.dart';

class BuisnessInfoCard extends StatelessWidget {
  const BuisnessInfoCard({
    super.key,
    required this.title,
    this.subTitle,
    required this.leading,
  });

  final String title;
  final String? subTitle;
  final String leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorConstants.backgroundColorFFFFFF,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: CustImage(
              imgURL: leading,
              width: 24,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  txtTitle: title,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 1),
                CustomText(
                  txtTitle: subTitle,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custGrey7A7A7A,
                        fontWeight: FontWeight.w500,
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
