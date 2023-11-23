import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../widgets/custom_text.dart';

class CommonInvoiceDetailsCard extends StatelessWidget {
  final String? jobIdNumber;
  final String? jobId;
  final String? invoicesNumber;
  final String? numberInvoice;
  final String? street;
  final String? invoiceType;
  final String? invoiceTypeImgUrl;
  final String? dateType;
  final String? descriptionDetails;
  final bool description;
  
  const CommonInvoiceDetailsCard({
    super.key,
    this.jobIdNumber,
    this.jobId,
    this.invoicesNumber,
    this.numberInvoice,
    this.street,
    this.dateType,
    this.descriptionDetails,
    this.invoiceType,
    this.invoiceTypeImgUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              txtTitle: jobIdNumber,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            CustomText(
              txtTitle: jobId,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              txtTitle: invoicesNumber,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            CustomText(
              txtTitle: numberInvoice,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        CustomText(
          txtTitle: street,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: ColorConstants.custGrey707070,
              ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: ColorConstants.custWhiteF7F7F7,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustImage(
                  imgURL: invoiceTypeImgUrl ?? "",
                ),
              ),
            ),
            const SizedBox(width: 10),
            CustomText(
              txtTitle: invoiceType,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custParrotGreenAFCB1F,
                  ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.15,
          ),
          child: invoiceDateCompletedDetails(
            context,
            StaticString.reported,
            dateType ?? "",
          ),
        ),
        const SizedBox(height: 15),
        if (description)
          CustomText(
            txtTitle: StaticString.description,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.custGrey707070,
                ),
          )
        else
          Container(),
        const SizedBox(height: 6),
        CustomText(
          txtTitle: descriptionDetails,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: ColorConstants.custGrey707070,
                fontWeight: FontWeight.w500,
              ),
        ),
        // const SizedBox(height: 25),
      ],
    );
  }

  Widget invoiceDateCompletedDetails(
    BuildContext context,
    String datetitle,
    String date,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txtTitle: datetitle,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorConstants.custGrey707070,
              ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ColorConstants.custlightwhitee,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustImage(
                  imgURL: ImgName.calendar,
                  imgColor: ColorConstants.custTeal60B0B1,
                  height: 12,
                  width: 12,
                ),
                const SizedBox(
                  width: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3, left: 5),
                  child: CustomText(
                    txtTitle: date,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: ColorConstants.custGrey707070,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
