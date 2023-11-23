import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/screens/landlord/invoices/invoices_common_components.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../../../widgets/custom_text.dart';
import 'invoices_new_invoices_detail.dart';

class LandlordInvoicesNewInvoices extends StatefulWidget {
  const LandlordInvoicesNewInvoices({super.key});

  @override
  State<LandlordInvoicesNewInvoices> createState() =>
      LandlordInvoicessNewInvoicesState();
}

class LandlordInvoicessNewInvoicesState
    extends State<LandlordInvoicesNewInvoices> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return newInvoiceCard();
      },
    );
  }

  Widget newInvoiceCard() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const LandlordInvoicesNewInvoicesDetail(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Stack(
              children: [
                const CustImage(
                  cornerRadius: 12,
                  imgURL:
                      "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
                ),
                Positioned(
                  top: 15,
                  left: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstants.custRedFF0000.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: CustomText(
                      txtTitle: "Urgent",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: ColorConstants.backgroundColorFFFFFF,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildJobIdNumber(jobId: "#YQ6CA040521"),
                  buildInvoiceNumber(invoiceNumber: "#1CN4627"),
                  buildDescription(
                    address: "121 Cowley Road Littlemore Oxford OX4 4PH",
                  ),
                  const SizedBox(height: 18),
                  buildBath(
                    title: "Shower Leak",
                    date: "27 Jun 2021",
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  buildPlumbingWithMoreDetail(
                    rating: "(3.5)",
                    amount: "236",
                    dateCompleted: "15 Oct 2021",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
