import 'package:flutter/material.dart';
import 'package:zungu_mobile/cards/invoice_details_card.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/trades_person/tobemodel.dart';
import 'package:zungu_mobile/screens/trades_person/trades_invoicing/overdue_invoices_details.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class SentInvoicingscreen extends StatefulWidget {
  const SentInvoicingscreen({super.key});

  @override
  State<SentInvoicingscreen> createState() => _SentInvoicingscreenState();
}

class _SentInvoicingscreenState extends State<SentInvoicingscreen> {
  bool isOnTap = true;
  PaymentInvoicesType paymentInvoicesType = PaymentInvoicesType.awaitingPayment;

  List<TobeInvoiceModel> awaitInfinvoiceList = [
    TobeInvoiceModel(
      idNumber: "#RCS30201221",
      invoiceNumber: StaticString.invoiceNumber,
      id: StaticString.jobIDNumber,
      number: "#1NV5248",
      installation: StaticString.rearExtensionConservatory,
      street: "392 Richmond St, London, ON N6AL",
      amount: "£1 250",
      dateCompleted: "Date Completed",
      date: "27 Jun 2021",
    ),
    TobeInvoiceModel(
      idNumber: "#UC5DT110121",
      invoiceNumber: StaticString.invoiceNumber,
      id: StaticString.jobIDNumber,
      number: "#1BV6872",
      installation: StaticString.rearExtensionConservatory,
      street: "1105 Wellington Rd, London, ON N6E",
      amount: "£1 250",
      dateCompleted: "Date Completed",
      date: "27 Jun 2021",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              _awaitingPaymentAndOverduePayment(),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 30,
                  ),
                  itemCount: awaitInfinvoiceList.length,
                  itemBuilder: (context, index) {
                    return isOnTap
                        ? InkWell(
                            onTap: () {
                              awaitingInvoiceOntapAction(index: index);
                            },
                            child: _buildAwaitingInvoices(
                              context,
                              awaitInfinvoiceList[index],
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              dueInvoiceOntapAction(index: index);
                            },
                            child: _buildDueInvoices(
                              context,
                              awaitInfinvoiceList[index],
                            ),
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAwaitingInvoices(
    BuildContext context,
    TobeInvoiceModel? tobeInvoiceModel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: const CustImage(
            imgURL:
                "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
          ),
        ),
        const SizedBox(height: 30),
        CommonInvoiceDetailsCard(
          description: true,
          jobId: tobeInvoiceModel?.idNumber ?? "",
          jobIdNumber: tobeInvoiceModel?.id ?? "",
          invoicesNumber: tobeInvoiceModel?.invoiceNumber ?? "",
          numberInvoice: tobeInvoiceModel?.number ?? "",
          dateType: tobeInvoiceModel?.date ?? "",
          descriptionDetails:
              "Remove old floor, prepare subfloor and lay new flooring",
          invoiceType: tobeInvoiceModel?.installation,
          invoiceTypeImgUrl: ImgName.installationImage,
          street: tobeInvoiceModel?.street,
        )
      ],
    );
  }

  Widget _buildDueInvoices(
    BuildContext context,
    TobeInvoiceModel? tobeInvoiceModel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: const CustImage(
            imgURL:
                "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
          ),
        ),
        const SizedBox(height: 30),
        CommonInvoiceDetailsCard(
          description: true,
          jobIdNumber: tobeInvoiceModel?.id ?? "",
          jobId: "#HR8X9070721",
          invoicesNumber: tobeInvoiceModel?.invoiceNumber ?? "",
          numberInvoice: "#1SN8652",
          dateType: tobeInvoiceModel?.date ?? "",
          descriptionDetails:
              "Remove old carpets and fit new carpets with underlay",
          invoiceType: "100 sqm Carpet Fitting",
          invoiceTypeImgUrl: ImgName.carpetImage,
          street: "450 Central Ave, London, ON N6B",
        ),
      ],
    );
  }

  Widget _awaitingPaymentAndOverduePayment() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: ColorConstants.custDarkTeal017781,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          Expanded(
            child: custElavetadeBtn(
              btnColor:
                  isOnTap ? Colors.white : ColorConstants.custDarkTeal017781,
              textColor:
                  isOnTap ? ColorConstants.custDarkTeal017781 : Colors.white,
              btnTitle: StaticString.awaitingPayment,
              btnOntap: () {
                if (mounted) {
                  setState(() {
                    isOnTap = !isOnTap;
                  });
                }
              },
            ),
          ),
          Expanded(
            child: custElavetadeBtn(
              btnColor:
                  !isOnTap ? Colors.white : ColorConstants.custDarkTeal017781,
              textColor:
                  !isOnTap ? ColorConstants.custDarkTeal017781 : Colors.white,
              btnTitle: StaticString.overdueInvoices,
              btnOntap: () {
                if (mounted) {
                  setState(() {
                    isOnTap = !isOnTap;
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget custElavetadeBtn({
    required Color btnColor,
    required Color textColor,
    required String btnTitle,
    required Function() btnOntap,
  }) {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        onPressed: btnOntap,
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        child: CustomText(
          txtTitle: btnTitle,
          style: Theme.of(context).textTheme.caption?.copyWith(
                wordSpacing: 1.5,
                fontSize: 15,
                color: textColor,
              ),
        ),
      ),
    );
  }

  void awaitingInvoiceOntapAction({required int index}) {
    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => OverdueInvoicesDetailsScreen(
              tobeInvoiceModel: awaitInfinvoiceList[index],
              titlename: StaticString.awaitingPayment,
            ),
          ),
        );
        break;
      case 1:
        break;

      default:
    }
  }

  void dueInvoiceOntapAction({required int index}) {
    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => OverdueInvoicesDetailsScreen(
              tobeInvoiceModel: awaitInfinvoiceList[index],
              titlename: StaticString.overdueInvoices,
            ),
          ),
        );
        break;
      case 1:
        break;

      default:
    }
  }
}

enum PaymentInvoicesType {
  awaitingPayment,
  overdueInvoices,
}
