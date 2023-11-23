import 'package:flutter/material.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../constant/img_font_color_string.dart';
import '../widgets/custom_text.dart';

class DashboardRactangleCard extends StatelessWidget {
  final String iconImage;
  final String title;
  final void Function()? onTap;
  const DashboardRactangleCard({
    super.key,
    required this.iconImage,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return dashboardCard(
      context,
      iconImage: iconImage,
      title: title,
      onTap: onTap,
      size: size,
    );
  }

  Widget dashboardCard(
    BuildContext context, {
    required String iconImage,
    required String title,
    required void Function()? onTap,
    required Size size,
  }) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorConstants.backgroundColorFFFFFF,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.custBlack000000.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 0.2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustImage(
              imgURL: iconImage,
              height: size.height / 13,
              width: size.height / 13,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomText(
                txtTitle: title,
                align: TextAlign.center,
                maxLine: 2,
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.custBlack000000,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
