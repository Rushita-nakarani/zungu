import 'package:flutter/material.dart';

import '../constant/img_font_color_string.dart';
import 'custom_text.dart';

class CommonElevatedButton extends StatelessWidget {
  final String bttnText;
  final Function()? onPressed;
  final double? fontSize;
  final Color? color;
  final Color textColor;
  final double height;
  final bool disable;
  final FontWeight fontWeight;
  final MaterialStateProperty<BorderSide?>? side;
  const CommonElevatedButton({
    Key? key,
    this.bttnText = "Button Text",
    this.onPressed,
    this.color,
    this.fontSize,
    this.height = 50,
    this.fontWeight = FontWeight.w600,
    this.disable = false,
    this.side,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return commonElevatedButton();
  }

  Widget commonElevatedButton() {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          side: side,
          elevation: MaterialStateProperty.all<double>(0.0),
          backgroundColor: MaterialStateProperty.all<Color>(
            disable
                ? ColorConstants.greyColor
                : (color ?? ColorConstants.custDarkPurple160935),
          ),
        ),
        onPressed: disable ? () {} : onPressed,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 4,
          ),
          child: CustomText(
            align: TextAlign.center,
            txtTitle: bttnText.toUpperCase(),
            style: TextStyle(
              fontSize: fontSize ?? 18,
              color: textColor,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}






// ZZZ
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(top: 4),
//           child: CustomText(
//             txtTitle: bttnText.toUpperCase(),
//             style: Theme.of(context).textTheme.bodyText1?.copyWith(
//                   fontSize: fontSize ?? 18,
//                   color: textColor,
//                   fontWeight: fontWeight,
//                 ),
//           ),
//         ),
//       ),
//     );
//   }
// }
