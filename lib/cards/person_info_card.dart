import 'package:flutter/material.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../constant/img_font_color_string.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_title_with_line.dart';

class PersonInfoCard extends StatelessWidget {
  const PersonInfoCard({
    super.key,
    required this.title,
    required this.name,
    required this.caption,
    required this.image,
    required this.primaryColor,
    required this.secondaryColor,
    required this.onEdit,
  });
  final String title;
  final String name;
  final String caption;
  final String image;
  final Color primaryColor;
  final Color secondaryColor;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorConstants.backgroundColorFFFFFF,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custBlack000000.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 0.2,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitleWithLine(
                title: title,
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
              ),
              CustomText(
                txtTitle: StaticString.edit,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: secondaryColor,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              CustImage(
                imgURL: image,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    txtTitle: name,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.custGrey707070,
                        ),
                  ),
                  const SizedBox(height: 2),
                  CustomText(
                    txtTitle: caption,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.custGrey8F8F8F,
                        ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
