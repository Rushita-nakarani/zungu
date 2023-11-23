import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/image_picker_button.dart';

import '../constant/color_constants.dart';
import '../widgets/custom_text.dart';

class DottedLineCard extends StatelessWidget {
  final String title;
  final String imgUrl;
  final void Function(List<String>) onTap;
  const DottedLineCard({
    super.key,
    required this.title,
    required this.imgUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      radius: const Radius.circular(12),
      borderType: BorderType.RRect,
      color: ColorConstants.custGreyb4bfd8,
      strokeWidth: 2,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
          color: ColorConstants.custlightwhitee,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              txtTitle: title,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custDarkBlue160935,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            ImagePickerButton(
              onImageSelected: (p0) => onTap,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ColorConstants.custlightwhitee,
                  border: Border.all(
                    color: ColorConstants.custGreyEBEAEA,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    imgUrl,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
