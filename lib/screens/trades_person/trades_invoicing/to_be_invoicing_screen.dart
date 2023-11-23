import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/trades_person/tobemodel.dart';
import 'package:zungu_mobile/screens/trades_person/trades_invoicing/to_be_invoice_details.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class ToBeInvoicingscreen extends StatefulWidget {
  const ToBeInvoicingscreen({super.key});

  @override
  State<ToBeInvoicingscreen> createState() => _ToBeInvoicingscreenState();
}

class _ToBeInvoicingscreenState extends State<ToBeInvoicingscreen> {
  List<TobeInvoiceModel> toBeInvoiceList = [
    TobeInvoiceModel(
      idNumber: "#5RTC9250422",
      invoiceNumber: StaticString.invoiceNumber,
      id: StaticString.jobIDNumber,
      number: "#1BF7684",
      installation: "Hardwood Floor Installation",
      amountInvoiced: StaticString.amountInvoice,
      street: "274 Green Lane London SW29 1ML",
      amount: "£1 250",
      dateCompleted: StaticString.dateCompleted,
      date: "15 Oct 2021",
    ),
    TobeInvoiceModel(
      idNumber: "#PC57Q250422",
      invoiceNumber: StaticString.invoiceNumber,
      id: StaticString.jobIDNumber,
      number: "#1CN4627",
      installation: "Recarpet Whole House",
      amountInvoiced: StaticString.amountInvoice,
      street: "17 Park Lane London E51 6TH",
      amount: "£2 500",
      dateCompleted: StaticString.dateCompleted,
      date: "11 Oct 2021",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 30),
        itemCount: toBeInvoiceList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              tobeInvoiceOntapAction(index: index);
            },
            child: invoicedCard(toBeInvoiceList[index], index),
          );
        },
      ),
    );
  }

  Widget invoicedCard(
    TobeInvoiceModel tobeInvoiceModel,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        top: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Job Image
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: const CustImage(
                  imgURL:
                      "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
                ),
              ),
              if (index == 0)
                Positioned(
                  top: 10,
                  left: 15,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: ColorConstants.custGreenishyellowFFFC00
                          .withOpacity(.60),
                    ),
                    child: CustomText(
                      txtTitle: "private job",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: ColorConstants.backgroundColorFFFFFF,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                )
              else
                Container(),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                txtTitle: tobeInvoiceModel.id,
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              CustomText(
                txtTitle: tobeInvoiceModel.idNumber,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                txtTitle: tobeInvoiceModel.invoiceNumber,
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              CustomText(
                txtTitle: tobeInvoiceModel.number,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          CustomText(
            txtTitle: tobeInvoiceModel.street,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custGrey707070,
                ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ColorConstants.custWhiteF7F7F7,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CustImage(
                    imgURL: ImgName.installationImage,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              CustomText(
                txtTitle: tobeInvoiceModel.installation,
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.custParrotGreenAFCB1F,
                    ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                txtTitle: tobeInvoiceModel.amountInvoiced,
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.custGrey707070,
                    ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ColorConstants.custgreen09A814,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: CustomText(
                    txtTitle: tobeInvoiceModel.amount,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstants.backgroundColorFFFFFF,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                txtTitle: tobeInvoiceModel.dateCompleted,
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
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        padding: const EdgeInsets.only(top: 3),
                        child: CustomText(
                          align: TextAlign.center,
                          txtTitle: tobeInvoiceModel.date,
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
          ),
        ],
      ),
    );
  }

  void tobeInvoiceOntapAction({required int index}) {
    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ToBeInvoiceDetail(
              tobemodel: toBeInvoiceList[index],
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
