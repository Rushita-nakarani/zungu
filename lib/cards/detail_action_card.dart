import 'package:flutter/material.dart';

import '../constant/img_font_color_string.dart';
import '../widgets/cust_image.dart';
import '../widgets/custom_text.dart';

class DetailActionCard extends StatelessWidget {
  const DetailActionCard({
    super.key,
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorConstants.backgroundColorFFFFFF,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: ColorConstants.custBlack000000.withOpacity(0.1),
                blurRadius: 15,
                spreadRadius: 0.2,
              ),
            ],
          ),
          child: CustImage(
            imgURL: image,
            width: 40,
          ),
        ),
        const SizedBox(height: 8),
        CustomText(
          txtTitle: title,
          maxLine: 2,
          align: TextAlign.center,
          textOverflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: ColorConstants.custGrey707070,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
