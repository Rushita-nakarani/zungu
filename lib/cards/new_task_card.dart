import 'package:flutter/material.dart';

import '../../widgets/custom_text.dart';
import '../constant/img_font_color_string.dart';
import '../widgets/cust_image.dart';

class NewTaskCard extends StatelessWidget {
  final String iconImage;
  final String title;
  final int itemCount;
  final Color primaryColor;
  final Color secondaryColor;
  final Function onTap;
  const NewTaskCard({
    super.key,
    required this.iconImage,
    required this.title,
    required this.itemCount,
    required this.primaryColor,
    required this.secondaryColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return newTaskCard(context);
  }

  Widget newTaskCard(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: 85,
            width: 85,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(top: 8, bottom: 10, right: 6),
            decoration: BoxDecoration(
              color: ColorConstants.backgroundColorFFFFFF,
              borderRadius: BorderRadius.circular(
                15,
              ),
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustImage(
                  // height: 28,
                  width: 28,
                  imgURL: iconImage,
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomText(
                  txtTitle: title.replaceAll(" ", "\n"),
                  maxLine: 2,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.custDarkPurple160935,
                        overflow: TextOverflow.ellipsis,
                        height: 1,
                      ),
                )
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: CircleAvatar(
              maxRadius: 10,
              minRadius: 10,
              backgroundColor: ColorConstants.custDarkYellow838500,
              child: CustomText(
                txtTitle: itemCount.toString(),
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration commonDecoration({
    double borderRadius = 7,
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
