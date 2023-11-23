import 'package:flutter/material.dart';

import '../constant/img_font_color_string.dart';
import '../widgets/cust_image.dart';
import '../widgets/custom_text.dart';

class CustomTenancyCard extends StatefulWidget {
  const CustomTenancyCard({
    super.key,
    required this.title,
    required this.color,
    required this.image,
    required this.onTap,
    this.isSelected = false,
  });

  final String title;
  final Color color;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<CustomTenancyCard> createState() => _CustomTenancyCardState();
}

class _CustomTenancyCardState extends State<CustomTenancyCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      onTap: widget.onTap,
      child: Stack(
        children: [
          CustImage(
            imgURL: ImgName.tenancyCard,
            imgColor: widget.color,
            width: MediaQuery.of(context).size.width / 2.7,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2.7,
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorConstants.backgroundColorFFFFFF,
                        ),
                        child: CustImage(
                          imgURL: widget.image,
                        ),
                      ),
                    ),
                    // if (widget.isSelected)
                    //   const Icon(
                    //     Icons.check,
                    //     color: ColorConstants.custChartGreen,
                    //     size: 28,
                    //   )
                  ],
                ),
                const SizedBox(height: 10),
                CustomText(
                  txtTitle: widget.title,
                  maxLine: 2,
                  textOverflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: ColorConstants.custDarkPurple150934,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: CustomText(
                //     txtTitle: "View >",
                //     style: Theme.of(context).textTheme.bodyText1,
                //   ),
                // ),
              ],
            ),
          ),
          if (widget.isSelected)
            const Positioned(
              top: 0,
              right: 10,
              child: Icon(
                Icons.check,
                color: ColorConstants.custChartGreen,
                size: 28,
              ),
            ),
          Positioned(
            bottom: 10,
            right: 15,
            child: CustomText(
              txtTitle: "View >",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
