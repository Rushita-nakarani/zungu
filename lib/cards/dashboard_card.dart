import "dart:math" as math;

import 'package:flutter/material.dart';

import '../../widgets/custom_text.dart';
import '../constant/img_font_color_string.dart';
import '../widgets/cust_image.dart';

class DashboardCard extends StatelessWidget {
  final String iconImage;
  final String title;
  final String? subtitle;
  final int? subtitleValue;
  final Color primaryColor;
  final Color bgColor;
  final VoidCallback onTap;
  final bool isLeft;
  final Widget? customSubtitle;
  const DashboardCard({
    super.key,
    required this.iconImage,
    required this.title,
    required this.subtitle,
    required this.subtitleValue,
    required this.primaryColor,
    required this.bgColor,
    required this.onTap,
    required this.isLeft,
    this.customSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return dashboardCard(context);
  }

  Widget dashboardCard(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Column(
        children: [
          SizedBox(
            height: 160,
            width: 136,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: isLeft
                      ? CustImage(
                          height: 130,
                          width: 136,
                          imgURL: ImgName.cardShape,
                          imgColor: bgColor,
                        )
                      : Transform(
                          //Wrap your widget with the Transform widget
                          alignment: Alignment.center, //Default is left
                          transform: Matrix4.rotationY(math.pi), //Mirror Widget
                          child: CustImage(
                            height: 130,
                            width: 136,
                            imgURL: ImgName.cardShape,
                            imgColor: bgColor,
                          ),
                        ),
                ),
                Positioned(
                  left: isLeft ? null : 8,
                  right: isLeft ? 8 : null,
                  bottom: 8,
                  child: const CustImage(
                    height: 30,
                    width: 30,
                    imgURL: ImgName.nextIcon,
                    imgColor: Colors.white,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: EdgeInsets.only(
                      right: isLeft ? 9 : 3.5,
                      left: isLeft ? 0.0 : 5,
                    ),
                    height: 124,
                    width: 124,
                    decoration: commonDecoration(borderRadius: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustImage(
                          width: 36,
                          boxfit: BoxFit.contain,
                          imgURL: iconImage,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        FittedBox(
                          child: Column(
                            children: [
                              CustomText(
                                txtTitle: title,
                                align: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
                                      height: 1,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              _buildSubtitle(context),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    if (subtitle != null) {
      return Row(
        children: [
          if (subtitleValue != null) ...[
            CustomText(
              txtTitle: subtitleValue.toString(),
              textOverflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(width: 5),
          ],
          CustomText(
            txtTitle: subtitle,
            maxLine: 2,
            textOverflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custGrey707070,
                ),
          ),
        ],
      );
    } else if (customSubtitle != null) {
      return customSubtitle!;
    } else {
      return Container();
    }
  }

  BoxDecoration commonDecoration({
    double borderRadius = 6,
    Color color = Colors.white,
  }) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: ColorConstants.custGrey7A7A7A.withOpacity(0.3),
          blurRadius: borderRadius,
        ),
      ],
    );
  }
}
