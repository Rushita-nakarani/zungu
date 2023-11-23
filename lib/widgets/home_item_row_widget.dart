import 'package:flutter/material.dart';

import '../constant/color_constants.dart';
import '../models/items_and_count_model.dart';
import 'cust_image.dart';
import 'custom_text.dart';

class CustHomeItemRowWidget extends StatelessWidget {
  const CustHomeItemRowWidget({
    super.key,
    required this.item,
    // required this.showClose,
  });

  final ItemAndCount item;
  // final bool showClose;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          CustImage(
            imgURL: item.image,
            height: 30,
            width: 36,
          ),
          const SizedBox(width: 10),

          CustomText(
            txtTitle: item.count.toString(),
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custBlack808080,
                ),
          ),

          //  if (item.count != null && !showClose) ...[
          //   const SizedBox(width: 10),
          //   CustomText(
          //     txtTitle: item.count.toString(),
          //     style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
          //           color: ColorConstants.custBlack808080,
          //         ),
          //   ),
          //   const SizedBox(width: 35),
          // ],
          // if (showClose)
          //   const CustImage(
          //     imgURL: ImgName.commonRedCross,
          //     width: 24,
          //   ),
        ],
      ),
    );
  }
}
