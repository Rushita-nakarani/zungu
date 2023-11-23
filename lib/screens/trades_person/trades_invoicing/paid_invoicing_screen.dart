import 'package:flutter/material.dart';
import 'package:zungu_mobile/cards/invoice_details_card.dart';
import 'package:zungu_mobile/screens/trades_person/trades_invoicing/invoice_filter_popup.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

import '../../../constant/color_constants.dart';
import '../../../constant/img_constants.dart';
import '../../../constant/string_constants.dart';

class PaidInvoicingscren extends StatefulWidget {
  const PaidInvoicingscren({super.key});

  @override
  State<PaidInvoicingscren> createState() => _PaidInvoicingscrenState();
}

class _PaidInvoicingscrenState extends State<PaidInvoicingscren> {
  InvoiceDateType invoicetype = InvoiceDateType.dateCompleted;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  txtTitle: StaticString.filterBy.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custDarkTeal017781,
                        height: 1,
                      ),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            30,
                          ),
                          topRight: Radius.circular(
                            30,
                          ),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return const InvoiceFilterPopupScreen();
                      },
                    );
                  },
                  icon: const CustImage(
                    imgURL: ImgName.greenFilter,
                  ),
                )
              ],
            ),
            const SizedBox(height: 25),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ColorConstants.backgroundColorFFFFFF,
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CommonInvoiceDetailsCard(
                      jobIdNumber: StaticString.jobIDNumber,
                      jobId: "#UIR7M141221",
                      invoicesNumber: StaticString.invoiceNumber,
                      numberInvoice: "#1BF7684",
                      invoiceTypeImgUrl: ImgName.bathTub1,
                      invoiceType: StaticString.replacetiles,
                      street: "40 Cherwell Drive Marston Oxford OX3 0LZ",
                      dateType: "27 Jun 2021",
                      description: false,
                    ),
                    invoiceamountDetails(),
                    const SizedBox(height: 10),
                    invoiceDateCompletedDetails(
                      StaticString.dateCompleted,
                      "27 Jun 2021",
                      InvoiceDateType.dateCompleted,
                    ),
                    const SizedBox(height: 16),
                    invoiceDateCompletedDetails(
                      StaticString.paidDate,
                      "30 Jul 2021",
                      InvoiceDateType.paidDate,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        paidInvoicesText(
                          StaticString.invoice,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: ColorConstants.cust0CCE1A),
                            color: ColorConstants.backgroundColorFFFFFF,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              const CustImage(
                                imgURL: ImgName.landlordPdf,
                                height: 15,
                                width: 15,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              CustomText(
                                txtTitle: StaticString.view,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                      color: ColorConstants.cust0CCE1A,
                                      fontWeight: FontWeight.w600,
                                    ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        paidInvoicesText(
                          StaticString.status,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              color: ColorConstants.cust0CCE1A,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CustomText(
                              txtTitle: StaticString.paid,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    color: ColorConstants.custGrey707070,
                                  ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget invoiceamountDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txtTitle: StaticString.amountInvoice,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: ColorConstants.custGrey707070,
              ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ColorConstants.cust0CCE1A,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 1),
            child: CustomText(
              txtTitle: "£296.00",
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.backgroundColorFFFFFF,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Widget invoiceDateCompletedDetails(
    String datetitle,
    String date,
    InvoiceDateType invoicetype,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        paidInvoicesText(datetitle),
        Container(
          width: MediaQuery.of(context).size.width / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: invoicetype == InvoiceDateType.dateCompleted
                ? ColorConstants.cust0CCE1A
                : invoicetype == InvoiceDateType.paidDate
                    ? ColorConstants.custDarkPurple662851
                    : ColorConstants.custlightwhitee,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustImage(
                  imgURL: ImgName.calendar,
                  height: 15,
                  width: 15,
                  imgColor: ColorConstants.backgroundColorFFFFFF,
                ),
                const SizedBox(
                  width: 4,
                ),
                CustomText(
                  txtTitle: date,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: ColorConstants.backgroundColorFFFFFF,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget paidInvoicesText(String invoicesText) {
    return CustomText(
      txtTitle: invoicesText,
      style: Theme.of(context).textTheme.bodyText2?.copyWith(
            color: ColorConstants.custGrey707070,
          ),
    );
  }

  Widget invoiceDetails(
    String title,
    String value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txtTitle: title,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        CustomText(
          txtTitle: value,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
