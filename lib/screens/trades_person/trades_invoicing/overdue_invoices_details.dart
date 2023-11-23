import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zungu_mobile/cards/dotted_line_card.dart';
import 'package:zungu_mobile/cards/invoice_details_card.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

import '../../../models/trades_person/tobemodel.dart';
import 'log_payment_popup.dart';

class OverdueInvoicesDetailsScreen extends StatefulWidget {
  final TobeInvoiceModel? tobeInvoiceModel;
  final String? titlename;
  const OverdueInvoicesDetailsScreen({
    super.key,
    this.tobeInvoiceModel,
    this.titlename,
  });

  @override
  State<OverdueInvoicesDetailsScreen> createState() =>
      _OverdueInvoicesDetailsScreenState();
}

class _OverdueInvoicesDetailsScreenState
    extends State<OverdueInvoicesDetailsScreen> {
  String? pickImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.titlename == StaticString.awaitingPayment
              ? StaticString.awaitingPaymentsDetails
              : StaticString.overdueInvoicesDetails,
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            _sliderView(),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  CommonInvoiceDetailsCard(
                    dateType: widget.tobeInvoiceModel?.date ?? "",
                    jobIdNumber: StaticString.jobIDNumber,
                    jobId: "#1EBS5200322",
                    invoicesNumber: StaticString.invoiceNumber,
                    numberInvoice: "#1SN8652",
                    descriptionDetails:
                        "Remove old carpets and fit new carpets with underlay",
                    invoiceType: "100 sqm Carpet Fitting",
                    invoiceTypeImgUrl: ImgName.carpetImage,
                    description: true,
                    street: "450 Central Ave, London, ON N6B",
                  ),
                  const SizedBox(height: 15),
                  invoiceamountDetails(
                    StaticString.amountInvoice,
                    "£296.00",
                    ColorConstants.cust0CCE1A,
                  ),
                  const SizedBox(height: 10),
                  invoiceDateCompletedDetails(
                    StaticString.dateCompleted,
                    "1 Nov 2021",
                    InvoiceDateType.dateCompleted,
                  ),
                  const SizedBox(height: 10),
                  invoiceDateCompletedDetails(
                    StaticString.dateInvoice,
                    "1 Nov 2021",
                    InvoiceDateType.dateInvoiced,
                  ),
                  const SizedBox(height: 10),
                  invoiceDateCompletedDetails(
                    "15 Sep 2021",
                    "7 Nov 2021",
                    InvoiceDateType.dueDate,
                  ),
                  const SizedBox(height: 10),
                  invoiceamountDetails(
                    StaticString.dueDate,
                    "6 Days",
                    ColorConstants.custLightRedFFE6E6,
                  ),
                  const SizedBox(height: 45),
                  DottedLineCard(
                    title: StaticString.viewInvoice,
                    imgUrl: ImgName.greenPdf,
                    onTap: (imagelist) {
                      if (mounted) {
                        setState(() {
                          pickImage = imagelist[0];
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      const Expanded(
                        child: CommonElevatedButton(
                          bttnText: StaticString.resendInvoice,
                          color: ColorConstants.custParrotGreenAFCB1F,
                        ),
                      ),
                      const SizedBox(
                        width: 22,
                      ),
                      Expanded(
                        child: CommonElevatedButton(
                          bttnText: StaticString.logPayment,
                          color: ColorConstants.custRedD7181F,
                          onPressed: () {
                            showAlert(
                              context: context,
                              title: StaticString.logInvoicePayment,
                              showIcon: false,
                              showCustomContent: true,
                              hideButton: true,
                              content: const LogPaymentPopup(),
                            );
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sliderView() {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        enlargeCenterPage: true,
        // enableInfiniteScroll: false,
      ),
      itemCount: 5,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget invoiceamountDetails(
    String invoicetype,
    String invoiceAmount,
    Color color,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        overDueDetailText(invoicetype),
        Container(
          width: MediaQuery.of(context).size.width / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 1),
            child: CustomText(
              txtTitle: invoiceAmount,
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

  Widget overDueDetailText(String invoicesText) {
    return CustomText(
      txtTitle: invoicesText,
      style: Theme.of(context).textTheme.bodyText2?.copyWith(
            color: ColorConstants.custGrey707070,
          ),
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
        overDueDetailText(datetitle),
        Container(
          width: MediaQuery.of(context).size.width / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: invoicetype == InvoiceDateType.dateCompleted
                ? ColorConstants.custlightwhitee
                : invoicetype == InvoiceDateType.dateInvoiced
                    ? ColorConstants.custGrey707070
                    : invoicetype == InvoiceDateType.dueDate
                        ? ColorConstants.custOrangeF28E20
                        : ColorConstants.custlightwhitee,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustImage(
                  imgURL: ImgName.calendar,
                  height: 15,
                  width: 15,
                  imgColor: invoicetype == InvoiceDateType.dateCompleted
                      ? ColorConstants.custDarkTeal017781
                      : ColorConstants.backgroundColorFFFFFF,
                ),
                const SizedBox(
                  width: 4,
                ),
                CustomText(
                  txtTitle: date,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: invoicetype == InvoiceDateType.dateCompleted
                            ? ColorConstants.custGrey707070
                            : ColorConstants.backgroundColorFFFFFF,
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
}
