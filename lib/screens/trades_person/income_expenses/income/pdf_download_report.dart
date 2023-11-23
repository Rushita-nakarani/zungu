import 'package:flutter/material.dart';
import 'package:zungu_mobile/screens/trades_person/income_expenses/income/download_report_screen.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../models/settings/feedback_regarding_model.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_text.dart';

class PdfPopup extends StatefulWidget {
  final List<ReportTypePDF> filterList;

  const PdfPopup({
    super.key,
    required this.filterList,
  });

  @override
  State<PdfPopup> createState() => _PdfPopupState();
}

class _PdfPopupState extends State<PdfPopup> {
  FeedbackRegardingModel? feedbackRegarding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            itemCount: widget.filterList.length,
            shrinkWrap: true,
            //physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: CustImage(
                            imgURL: ImgName.pdfIcon,
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: CustomText(
                            txtTitle: widget.filterList[index].pdfName,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      color: ColorConstants.custGrey707070
                          .withOpacity(0.7)
                          .withOpacity(0.5),
                      thickness: 0.5,
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
