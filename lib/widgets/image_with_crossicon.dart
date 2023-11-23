import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

class ImageWithCrossIcon extends StatelessWidget {
  final double top;
  final double right;
  final String imageIcon;
  final void Function()? onTap;
  final EdgeInsetsGeometry padding;
  final String imgName;

  const ImageWithCrossIcon({
    Key? key,
    required this.imgName,
    required this.top,
    required this.right,
    required this.onTap,
    this.padding = EdgeInsets.zero,
    this.imageIcon = ImgName.landlordCross,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: padding,
          child: SizedBox(
            height: 70,
            width: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CustImage(
                imgURL: imgName,
              ),
            ),
          ),
        ),
        // Container(
        //   margin: const EdgeInsets.all(5),
        //   alignment: Alignment.centerLeft,
        //   height: 70,
        //   width: 70,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(25),
        //   ),
        //   child: CustImage(
        //     imgURL: imgName,
        //   ),
        // ),
        Positioned(
          right: right,
          top: top,
          child: GestureDetector(
            onTap: onTap,
            child: SvgPicture.asset(imageIcon),
          ),
        ),
      ],
    );
  }
}
