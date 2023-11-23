import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:zungu_mobile/main.dart';
import 'package:zungu_mobile/utils/custom_extension.dart';
import 'package:zungu_mobile/widgets/rate_star.dart';

import '../../../constant/img_font_color_string.dart';
import '../../../widgets/cust_image.dart';
import '../../../widgets/custom_text.dart';
import 'edit_invoice_bottomsheet.dart';

Widget buildJobIdNumber({required String jobId}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        txtTitle: StaticString.jobIdNumber,
        style: Theme.of(getContext).textTheme.headline1?.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorConstants.custDarkPurple150934,
            ),
      ),
      CustomText(
        txtTitle: jobId,
        style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
              fontWeight: FontWeight.w500,
              color: ColorConstants.custDarkPurple150934,
            ),
      )
    ],
  );
}

Widget buildInvoiceNumber({required String invoiceNumber}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        txtTitle: StaticString.invoiceNumber,
        style: Theme.of(getContext).textTheme.headline1?.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorConstants.custDarkPurple150934,
            ),
      ),
      CustomText(
        txtTitle: invoiceNumber,
        style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
              fontWeight: FontWeight.w500,
              color: ColorConstants.custDarkPurple150934,
            ),
      )
    ],
  );
}

Widget buildDescription({required String address}) {
  return CustomText(
    txtTitle: address,
    style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
          color: ColorConstants.custGrey707070,
        ),
  );
}

Widget buildBath({required String title, required String date}) {
  return Row(
    children: [
      Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ColorConstants.custWhiteF7F7F7,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const CustImage(
                imgURL: ImgName.bathTub1,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    txtTitle: title,
                    style: Theme.of(getContext).textTheme.headline1?.copyWith(
                          color: ColorConstants.custBlue1EC0EF,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        txtTitle: StaticString.reported,
                        style:
                            Theme.of(getContext).textTheme.bodyText2?.copyWith(
                                  color: ColorConstants.custGrey707070,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: ColorConstants.custWhiteF7F7F7,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustImage(
                              imgURL: ImgName.commonCalendar,
                              width: 14,
                              imgColor: ColorConstants.custDarkPurple500472,
                            ),
                            const SizedBox(width: 4),
                            CustomText(
                              txtTitle: date,
                              style: Theme.of(getContext)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.custGrey707070,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildPlumbing({required String rating, required String amount}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.all(10),
        child: CustImage(
          imgURL: ImgName.fillheartinvoicesicon,
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              txtTitle: "M Lewis Plumbing",
              style: Theme.of(getContext).textTheme.headline1?.copyWith(
                    color: ColorConstants.custBlue1EC0EF,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      txtTitle: StaticString.contractor,
                      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                            color: ColorConstants.custGrey707070,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(width: 5),
                    const StarRating(
                      rating: 3.5,
                      size: 14,
                    ),
                    const SizedBox(width: 5),
                    CustomText(
                      txtTitle: rating,
                      style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
                            color: ColorConstants.custGrey707070,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
                CustomText(
                  txtTitle:
                      "${StaticString.currency}${amount.convertToDecimal}",
                  style: Theme.of(getContext).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
              ],
            )
          ],
        ),
      ),
    ],
  );
}

Widget buildDateCompleted({required String date}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 7,
        child: CustomText(
          txtTitle: StaticString.dateCompleted,
          style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                color: ColorConstants.custGrey707070,
              ),
        ),
      ),
      Expanded(
        flex: 3,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: ColorConstants.custGreen0CCE1A,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustImage(
                imgURL: ImgName.commonCalendar,
                imgColor: ColorConstants.backgroundColorFFFFFF,
                width: 14,
              ),
              const SizedBox(width: 4),
              CustomText(
                txtTitle: date,
                style: Theme.of(getContext).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.backgroundColorFFFFFF,
                    ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget buildPaidDate({required String date}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 7,
        child: CustomText(
          txtTitle: StaticString.paidDate,
          style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                color: ColorConstants.custGrey707070,
              ),
        ),
      ),
      Expanded(
        flex: 3,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: ColorConstants.custDarkPurple500472,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustImage(
                imgURL: ImgName.commonCalendar,
                imgColor: ColorConstants.backgroundColorFFFFFF,
                width: 14,
              ),
              const SizedBox(width: 4),
              CustomText(
                txtTitle: date,
                style: Theme.of(getContext).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.backgroundColorFFFFFF,
                    ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget buildInvoice() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 7,
        child: CustomText(
          txtTitle: StaticString.invoice,
          style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                color: ColorConstants.custGrey707070,
              ),
        ),
      ),
      Expanded(
        flex: 3,
        child: Container(
          // width: constraints.maxWidth * 0.26,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorConstants.custGreen0CCE1A,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustImage(
                imgURL: ImgName.landlordPdf,
                width: 12,
              ),
              const SizedBox(width: 4),
              CustomText(
                txtTitle: StaticString.view.toUpperCase(),
                style: Theme.of(getContext).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.custGreen0CCE1A,
                    ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget buildStatus() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 7,
        child: CustomText(
          txtTitle: StaticString.status,
          style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                color: ColorConstants.custGrey707070,
              ),
        ),
      ),
      Expanded(
        flex: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustImage(
              imgURL: ImgName.greenCheckCircle,
              width: 18,
            ),
            const SizedBox(width: 4),
            CustomText(
              txtTitle: StaticString.paid,
              style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custGrey707070,
                  ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildEditBtn() {
  return Positioned(
    bottom: 0,
    right: 20,
    child: InkWell(
      onTap: () {
        editInvoiceBottomSheet(
          title: StaticString.editInvoicePayment,
          primaryColor: ColorConstants.custDarkPurple500472,
          btnText: StaticString.update.toUpperCase(),
          onTap: () {
            Navigator.of(getContext).pop();
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 6.0,
          vertical: 6,
        ),
        decoration: const BoxDecoration(
          color: ColorConstants.custBlue1EC0EF,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(8.0),
          ),
        ),
        child: const CustImage(imgURL: ImgName.editIcon),
      ),
    ),
  );
}

Widget buildPlumbingWithMoreDetail({
  required String rating,
  required String amount,
  required String dateCompleted,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.all(10),
        child: CustImage(
          imgURL: ImgName.fillheartinvoicesicon,
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              txtTitle: "M Lewis Plumbing",
              style: Theme.of(getContext).textTheme.headline1?.copyWith(
                    color: ColorConstants.custBlue1EC0EF,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      txtTitle: StaticString.contractor,
                      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                            color: ColorConstants.custGrey707070,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(width: 5),
                    const StarRating(
                      rating: 3.5,
                      size: 14,
                    ),
                    const SizedBox(width: 5),
                    CustomText(
                      txtTitle: rating,
                      style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
                            color: ColorConstants.custGrey707070,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
                CustomText(
                  txtTitle:
                      "${StaticString.currency}${amount.convertToDecimal}",
                  style: Theme.of(getContext).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Date completed
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  txtTitle: StaticString.dateCompleted,
                  style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: ColorConstants.custWhiteF7F7F7,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustImage(
                        imgURL: ImgName.commonCalendar,
                        width: 14,
                        imgColor: ColorConstants.custDarkTeal017781,
                      ),
                      const SizedBox(width: 4),
                      CustomText(
                        txtTitle: dateCompleted,
                        style: Theme.of(getContext).textTheme.caption?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),

            // Due date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  txtTitle: "Due Date",
                  style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: ColorConstants.custOrangeF28E20,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustImage(
                        imgURL: ImgName.commonCalendar,
                        imgColor: ColorConstants.backgroundColorFFFFFF,
                        width: 14,
                      ),
                      const SizedBox(width: 4),
                      CustomText(
                        txtTitle: dateCompleted,
                        style: Theme.of(getContext).textTheme.caption?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.backgroundColorFFFFFF,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildTenantDescription({required String description}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        txtTitle: "Tenant Description",
        style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
              color: ColorConstants.custDarkPurple150934,
              fontWeight: FontWeight.w500,
            ),
      ),
      const SizedBox(height: 5),
      ReadMoreText(
        description,
        style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
              color: ColorConstants.custGrey707070,
              fontWeight: FontWeight.w500,
            ),
        colorClickableText: ColorConstants.custDarkYellow838500,
        trimMode: TrimMode.Line,
        trimCollapsedText: StaticString.readMoreInAction,
        trimExpandedText: StaticString.showLessInAction,
      ),
    ],
  );
}
