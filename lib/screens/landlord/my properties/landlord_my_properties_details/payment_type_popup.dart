import 'package:flutter/material.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../models/settings/feedback_regarding_model.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_text.dart';

class PaymentTypePoppup extends StatefulWidget {
  final List<FeedbackRegardingModel> paymentTypeList;
  final void Function(FeedbackRegardingModel? feedbackRegardingModel) onSubmit;

  const PaymentTypePoppup({
    super.key,
    required this.paymentTypeList,
    required this.onSubmit,
  });

  @override
  State<PaymentTypePoppup> createState() => _PaymentTypePoppupState();
}

class _PaymentTypePoppupState extends State<PaymentTypePoppup> {
  int selectedIndex = 0;
  FeedbackRegardingModel? feedbackRegarding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            itemCount: widget.paymentTypeList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              // widget.paymentTypeList[index].isSelected = index == selectedIndex;

              return InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      for (final element in widget.paymentTypeList) {
                        if (element.id == widget.paymentTypeList[index].id) {
                          element.isSelected = true;
                        } else {
                          element.isSelected = false;
                        }
                      }
                      // selectedIndex = index;
                      feedbackRegarding = widget.paymentTypeList[index];
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustImage(
                              imgURL: ImgName.greyCheckImage,
                              imgColor: widget.paymentTypeList[index].isSelected
                                  ? ColorConstants.custgreen19B445
                                  : ColorConstants.custGrey707070,
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: CustomText(
                              txtTitle:
                                  widget.paymentTypeList[index].feedbackType ??
                                      "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    color:
                                        widget.paymentTypeList[index].isSelected
                                            ? ColorConstants.custskyblue22CBFE
                                            : ColorConstants.custGrey707070,
                                    fontWeight: FontWeight.w500,
                                  ),
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
                ),
              );
            },
          ),
          const SizedBox(height: 15),
          CommonElevatedButton(
            color: ColorConstants.custskyblue22CBFE,
            bttnText: StaticString.submit,
            fontSize: 14,
            onPressed: () {
              Navigator.of(context).pop();
              widget.onSubmit(feedbackRegarding);
            },
          )
        ],
      ),
    );
  }
}
