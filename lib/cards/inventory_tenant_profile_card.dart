import 'package:flutter/material.dart';

import '../constant/img_font_color_string.dart';
import '../widgets/cust_image.dart';
import '../widgets/custom_text.dart';

class InventoryTenantProfileCard extends StatelessWidget {
  const InventoryTenantProfileCard({
    super.key,
    required this.tenantName,
    required this.tenantAddress,
    required this.leaseEndDate,
    required this.tenantImage,
    required this.calenderColor,
  });
  final String tenantName;
  final String tenantAddress;
  final String leaseEndDate;
  final String tenantImage;
  final Color calenderColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30, left: 18, right: 18),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ColorConstants.backgroundColorFFFFFF,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.custBlack000000.withOpacity(0.1),
                blurRadius: 15,
                spreadRadius: 0.2,
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 50),
              CustomText(
                txtTitle: tenantName,
                style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: ColorConstants.custDarkPurple150934,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              CustomText(
                txtTitle: tenantAddress,
                textOverflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstants.custGrey707070,
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    txtTitle: StaticString.leaseEndDate,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstants.custGrey707070,
                        ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: ColorConstants.custWhiteF7F7F7,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: CustImage(
                            imgURL: ImgName.commonCalendar,
                            imgColor: calenderColor,
                            width: 14,
                          ),
                        ),
                        CustomText(
                          txtTitle: leaseEndDate,
                          align: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.caption?.copyWith(
                                    color: ColorConstants.custGrey707070,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        Positioned(
          top: 0,
          child: CircleAvatar(
            maxRadius: 30,
            child: CustImage(
              imgURL: tenantImage,
              width: 60,
              height: 60,
            ),
          ),
        ),
      ],
    );
  }
}
