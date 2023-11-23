import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zungu_mobile/cards/dotted_line_card.dart';
import 'package:zungu_mobile/cards/invoice_details_card.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/trades_person/tobemodel.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class ToBeInvoiceDetail extends StatefulWidget {
  final TobeInvoiceModel tobemodel;
  const ToBeInvoiceDetail({super.key, required this.tobemodel});

  @override
  State<ToBeInvoiceDetail> createState() => _ToBeInvoiceDetailState();
}

class _ToBeInvoiceDetailState extends State<ToBeInvoiceDetail> {
  String? pickImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.custDarkTeal017781,
        title: const Text(
          StaticString.tobeinvoiceDetails,
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            _sliderView(),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  CommonInvoiceDetailsCard(
                    description: true,
                    dateType: widget.tobemodel.date,
                    descriptionDetails:
                        "Remove old floor, prepare subfloor and lay new flooring",
                    invoiceType: widget.tobemodel.installation,
                    invoiceTypeImgUrl: ImgName.installationImage,
                    invoicesNumber: StaticString.invoiceNumber,
                    numberInvoice: widget.tobemodel.number,
                    jobId: widget.tobemodel.idNumber ?? "",
                    jobIdNumber: StaticString.jobIDNumber,
                    street: widget.tobemodel.street,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  invoiceamountDetails(),
                  const SizedBox(height: 5),
                  invoiceDateCompletedDetails(
                    widget.tobemodel.dateCompleted ?? "",
                    "15 Oct 2021",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        txtTitle: StaticString.paymenTerm,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: ColorConstants.custGrey707070,
                            ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: CustomText(
                          txtTitle: StaticString.edit.toLowerCase(),
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: ColorConstants.custBlue2A00FF,
                                  ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
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
                  CommonElevatedButton(
                    bttnText: StaticString.sendInvoice,
                    color: ColorConstants.custParrotGreenAFCB1F,
                    onPressed: () {},
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
        enlargeCenterPage: true,
        autoPlay: true,
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

  Widget invoiceamountDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txtTitle: widget.tobemodel.amountInvoiced,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorConstants.custGrey707070,
              ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ColorConstants.custgreen09A814,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            child: CustomText(
              txtTitle: widget.tobemodel.amount,
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
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txtTitle: datetitle,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                // fontWeight: FontWeight.w500,
                color: ColorConstants.custGrey707070,
              ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 4,
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
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10),
                  child: CustomText(
                    align: TextAlign.center,
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

  // DottedBorder dottedlineContainer(BuildContext context) {
  //   return DottedBorder(
  //     radius: const Radius.circular(12),
  //     borderType: BorderType.RRect,
  //     color: ColorConstants.custGreyb4bfd8,
  //     strokeWidth: 2,
  //     child: Container(
  //       padding: const EdgeInsets.all(15.0),
  //       decoration: const BoxDecoration(
  //         color: ColorConstants.custlightwhitee,
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           CustomText(
  //             txtTitle: StaticString.viewInvoice,
  //             style: Theme.of(context).textTheme.bodyText2?.copyWith(
  //                   color: ColorConstants.custDarkBlue160935,
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //           ),
  //           Container(
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(15),
  //               color: ColorConstants.custlightwhitee,
  //               border: Border.all(
  //                 color: ColorConstants.custGreyEBEAEA,
  //               ),
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: SvgPicture.asset(ImgName.greenPdf),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
