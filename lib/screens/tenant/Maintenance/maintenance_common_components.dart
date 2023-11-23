import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/constant/img_constants.dart';
import 'package:zungu_mobile/constant/string_constants.dart';
import 'package:zungu_mobile/main.dart';
import 'package:zungu_mobile/screens/landlord/invoices/edit_invoice_bottomsheet.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

Widget buildJobDate({required String date}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        txtTitle: "Job Date",
        style: Theme.of(getContext).textTheme.headline1?.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorConstants.custDarkPurple150934,
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
              imgURL: ImgName.calenderPurple,
            ),
            const SizedBox(width: 4),
            CustomText(
              txtTitle: date,
              style: Theme.of(getContext).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.custGrey707070,
                  ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildJobTime({required String time}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        txtTitle: "Job Time",
        style: Theme.of(getContext).textTheme.headline1?.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorConstants.custDarkPurple150934,
            ),
      ),
      Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: ColorConstants.custGreen0CCE1A,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustImage(
              imgURL: ImgName.tenantTime,
            ),
            const SizedBox(width: 4),
            CustomText(
              txtTitle: time,
              style: Theme.of(getContext).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.custWhiteF1F0F0,
                  ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildInvoiceNumber({required String invoiceNumber}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        txtTitle: "Invoice Number",
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

Widget buildAddress({required String address}) {
  return Row(
    children: [
      CustomText(
        txtTitle: address,
        style: Theme.of(getContext).textTheme.headline2?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
    ],
  );
}

Widget buildAddressDescription({required String address}) {
  return CustomText(
    txtTitle: address,
    style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
          color: ColorConstants.custGrey707070,
        ),
  );
}

// Widget buildTenantDescription({required String address}) {
//   return Column(
//     children: [
//         CustomText(
//                 txtTitle: "121 Cowely Road",
//                 style: Theme.of(getContext).textTheme.headline2?.copyWith(
//                       fontWeight: FontWeight.w700,
//                     ),
//               ),

//       CustomText(
//         txtTitle: address,
//         style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
//               color: ColorConstants.custGrey707070,
//             ),
//       ),
//     ],
//   );
// }

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
                      Flexible(
                        flex: 7,
                        child: CustomText(
                          txtTitle: StaticString.reported,
                          style: Theme.of(getContext)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                color: ColorConstants.custGrey707070,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Container(
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

Widget buildReportedDate({required String date}) {
  return Row(
    children: [
      Expanded(
        child: Row(
          children: [
            const SizedBox(
              width: 50,
            ),
            CustomText(
              txtTitle: "Reported",
              style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custGrey707070,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
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
              imgURL: ImgName.calenderPurple,
            ),
            const SizedBox(width: 4),
            CustomText(
              txtTitle: date,
              style: Theme.of(getContext).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.custGrey707070,
                  ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildRejectedDate({required String date}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Expanded(
        child: Row(
          children: [
            const SizedBox(
              width: 50,
            ),
            CustomText(
              txtTitle: "Rejected",
              style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custGrey707070,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
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
              imgURL: ImgName.calenderPurple,
            ),
            const SizedBox(width: 4),
            CustomText(
              txtTitle: date,
              style: Theme.of(getContext).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.custGrey707070,
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
    children: [
      Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: const CustImage(
                imgURL: ImgName.fillheartinvoicesicon,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  txtTitle: "M Lewis Plumbing",
                  style: Theme.of(getContext).textTheme.headline1?.copyWith(
                        color: ColorConstants.custBlue1EC0EF,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                      txtTitle: "Contractor",
                      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                            color: ColorConstants.custGrey707070,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(width: 5),
                    const CustImage(
                      imgURL: ImgName.starsratinginvoices,
                    ),
                    CustomText(
                      txtTitle: rating,
                      style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
                            color: ColorConstants.custGrey707070,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      CustomText(
        txtTitle: "${StaticString.currency}$amount",
        style: Theme.of(getContext).textTheme.headline2?.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorConstants.custGrey707070,
            ),
      ),
    ],
  );
}

Widget buildDateCompleted({required String date}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        txtTitle: "Date Completed",
        style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
              color: ColorConstants.custGrey707070,
            ),
      ),
      Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: ColorConstants.custGreen0CCE1A,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustImage(
              imgURL: ImgName.landlordCalender,
              imgColor: ColorConstants.backgroundColorFFFFFF,
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
    ],
  );
}

Widget buildPaidDate({required String date}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        txtTitle: "Paid Date",
        style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
              color: ColorConstants.custGrey707070,
            ),
      ),
      Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: ColorConstants.custDarkPurple500472,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustImage(
              imgURL: ImgName.landlordCalender,
              imgColor: ColorConstants.backgroundColorFFFFFF,
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
    ],
  );
}

Widget buildStatus() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        txtTitle: "Status",
        style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
              color: ColorConstants.custGrey707070,
            ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          horizontal: 12,
          vertical: 6,
        ),
        decoration: const BoxDecoration(
          color: ColorConstants.custBlue1EC0EF,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
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
      Container(
        padding: const EdgeInsets.all(10),
        child: const CustImage(
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
              children: [
                Row(
                  children: [
                    CustomText(
                      txtTitle: "Contractor",
                      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                            color: ColorConstants.custGrey707070,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(width: 5),
                    const CustImage(
                      imgURL: ImgName.starsratinginvoices,
                    ),
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
                  txtTitle: "${StaticString.currency}$amount",
                  style: Theme.of(getContext).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
              ],
            ),
            // Date completed
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  txtTitle: "Date Completed",
                  style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custGrey707070,
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
                        imgURL: ImgName.landlordCalender,
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

            // Due date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  txtTitle: "Due Date",
                  style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custGrey707070,
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
                        imgURL: ImgName.landlordCalender,
                        imgColor: ColorConstants.backgroundColorFFFFFF,
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
      CustomText(
        txtTitle: description,
        maxLine: 3,
        textOverflow: TextOverflow.ellipsis,
        style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
              color: ColorConstants.custGrey707070,
              fontWeight: FontWeight.w500,
            ),
      ),
    ],
  );
}

Widget buildContractorName({required String contractorName}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        txtTitle: "Contractor Name",
        style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
              color: ColorConstants.custDarkPurple150934,
              fontWeight: FontWeight.w500,
            ),
      ),
      const SizedBox(height: 5),
      CustomText(
        txtTitle: contractorName,
        maxLine: 3,
        textOverflow: TextOverflow.ellipsis,
        style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
              color: ColorConstants.custDarkGreen838500,
              fontWeight: FontWeight.w500,
            ),
      ),
    ],
  );
}

Widget buildRejectMassege() {
  return Container(
    // alignment: Alignment.center,
    height: 100,
    width: 350,
    decoration: BoxDecoration(
      color: ColorConstants.custLightRedFFE6E6,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomText(
            txtTitle: "Reason for Rejection",
            style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custDarkPurple160935,
                ),
          ),
          CustomText(
            txtTitle: "Tenant is responsible for  Fixing issue",
            style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custGrey707070,
                ),
          ),
        ],
      ),
    ),
  );
}
