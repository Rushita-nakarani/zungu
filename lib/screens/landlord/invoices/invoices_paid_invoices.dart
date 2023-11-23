import 'package:flutter/material.dart';

import '../../../constant/img_font_color_string.dart';
import 'invoices_common_components.dart';

class LandlordInvoicesPaidInvoices extends StatefulWidget {
  const LandlordInvoicesPaidInvoices({
    super.key,
  });

  @override
  State<LandlordInvoicesPaidInvoices> createState() =>
      LandlordInvoicessPaidInvoicesState();
}

class LandlordInvoicessPaidInvoicesState
    extends State<LandlordInvoicesPaidInvoices> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(10),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildJobIdNumber(jobId: "#UIR7M141221"),
                    buildInvoiceNumber(invoiceNumber: "#1BF7684"),
                    buildDescription(
                      address: "40 Cherwell Drive Marston Oxford OX3 0LZ",
                    ),
                    const SizedBox(height: 10),
                    buildBath(
                      title: "Replace Tiles",
                      date: "27 Jun 2021",
                    ),
                    const SizedBox(height: 15),
                    buildPlumbing(
                      rating: "(3.5)",
                      amount: "296.00",
                    ),
                    const SizedBox(height: 20),
                    buildDateCompleted(date: "27 Jun 2021"),
                    const SizedBox(height: 15),
                    buildPaidDate(date: "27 Jun 2021"),
                    const SizedBox(height: 15),
                    buildInvoice(),
                    const SizedBox(height: 15),
                    buildStatus(),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
              buildEditBtn(),
            ],
          ),
        ],
      ),
    );
  }
}
