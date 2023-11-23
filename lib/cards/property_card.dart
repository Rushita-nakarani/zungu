import 'package:flutter/material.dart';
import 'package:zungu_mobile/widgets/bookmark_widget.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../constant/img_font_color_string.dart';
import '../widgets/custom_text.dart';

class PropertyCard extends StatelessWidget {
  final String imageUrl;
  final String propertyTitle;
  final String propertySubtitle;
  final Color color;
  final Color? bookmarkColor;
  final String? bookmarkText;
  final bool isClicked;
  final bool showBookmark;

  const PropertyCard({
    super.key,
    required this.imageUrl,
    required this.propertyTitle,
    required this.propertySubtitle,
    required this.color,
    this.bookmarkColor = ColorConstants.custDarkPurple500472,
    this.bookmarkText = "",
    this.isClicked = false,
    this.showBookmark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isClicked ? color : ColorConstants.backgroundColorFFFFFF,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custBlack000000.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 0.2,
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustImage(
                imgURL: imageUrl,
                height: 170,
                cornerRadius: 8,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 10),
                child: CustomText(
                  txtTitle: propertyTitle,
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 6),
                child: CustomText(
                  txtTitle: propertySubtitle,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ],
          ),
          if (showBookmark)
            Positioned(
              right: 20,
              top: 170,
              child: buildBookmark(
                text: bookmarkText!,
                color: bookmarkColor!,
                size: const Size(38, 50),
              ),
            ),
        ],
      ),
    );
  }
}
