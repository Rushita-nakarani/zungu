import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/constant/img_constants.dart';
import 'package:zungu_mobile/constant/string_constants.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class IncomeExpensesDetailsCard extends StatelessWidget {
    final String number;
    final String imageURL;
    final String jobTitle;
    final String jobSubTitle;
    final Widget? child;
    final String value;


  const IncomeExpensesDetailsCard({super.key,
  required this.number,
  required this.imageURL,
  required this.jobTitle,
  required this.jobSubTitle,
  this.child,
  required this.value,});

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
          txtTitle:	number,
            style: Theme.of(context).textTheme.headline6?.copyWith(
              color: Colors.white,
            ),
          ),
           CustImage(imgURL: imageURL,)
      ],),
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 60),
            child: CustomText(
     txtTitle:	jobTitle,
      style: Theme.of(context).textTheme.bodyText2?.copyWith(
        color: ColorConstants.custWhiteFFFFFF,
      ),
     ),
          ),
     CustomText(
     txtTitle:	jobSubTitle,
      style: Theme.of(context).textTheme.bodyText2?.copyWith(
        color: ColorConstants.custWhiteFFFFFF,
      ),),
        ],
      ),
      Container(
                //   alignment: Alignment.center,
                // height: 110,
                // width: 110,
                // decoration: BoxDecoration(
                // shape: BoxShape.circle,
                // border: Border.all(
                //   color: ColorConstants.custCyanB4DFDC,
                //   width: 8,
                // ),),
                child: child,
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //   CustomText(
                //   txtTitle:	"13",
                //     style: Theme.of(context).textTheme.headline6?.copyWith(
                //       color: ColorConstants.custWhiteFFFFFF,
                //     ),
                //   ),
                //   CustomText(
                //   txtTitle:	StaticString.invoiced,
                //     style: Theme.of(context).textTheme.bodyText2?.copyWith(
                //       color: ColorConstants.custWhiteFFFFFF,
                //     ),
                //   )
                // ],),                   
                  ),
                  CustomText(
                  txtTitle:	value,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: ColorConstants.custParrotGreenAFCB1F,
                    ),
                  )
],),
  );
  }
}