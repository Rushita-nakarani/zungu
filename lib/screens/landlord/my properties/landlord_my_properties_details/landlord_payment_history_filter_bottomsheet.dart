import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/date_selector.dart';

import '../../../../models/settings/feedback_regarding_model.dart';
import '../../../../utils/custom_extension.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/custom_text.dart';
import 'payment_type_popup.dart';

class LandlordPaymentHistoryfilterBottomSheet extends StatefulWidget {
  const LandlordPaymentHistoryfilterBottomSheet({super.key});

  @override
  State<LandlordPaymentHistoryfilterBottomSheet> createState() =>
      _LandlordPaymentHistoryfilterBottomSheetState();
}

class _LandlordPaymentHistoryfilterBottomSheetState
    extends State<LandlordPaymentHistoryfilterBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final TextEditingController _paymentTypeController = TextEditingController();

   List<FeedbackRegardingModel> paymentTypeList = [
    FeedbackRegardingModel(
      id: 0,
      feedbackType: "Online",
    ),
    FeedbackRegardingModel(
      id: 1,
      feedbackType: "Cash on Delivery",
    ),
    FeedbackRegardingModel(
      id: 2,
      feedbackType: "Bank Transfer",
    ),
  ];
  DateTime? fromDate;
  DateTime? toDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 10,
            // bottom: MediaQuery.of(context).viewInsets.bottom / 3,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close button and filter text and reset butoon row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: closeBtnAction,
                        icon: const CustImage(
                          imgURL: ImgName.closeIcon,
                        ),
                      ),
                      CustomText(
                        align: TextAlign.center,
                        txtTitle: StaticString.filter,
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      CustomText(
                        onPressed: resetBtnAction,
                        txtTitle: StaticString.reset,
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                              color: ColorConstants.custBlue1EC0EF,
                              fontWeight: FontWeight.w600,
                            ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                //payment type text field
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    readOnly: true,
                    onTap: paymentTypeOntapAction,
                    autovalidateMode: _autovalidateMode,
                    validator: (value) => value?.validateEmpty,
                    controller: _paymentTypeController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: "${StaticString.paymentType}*",
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 30,
                        color: ColorConstants.custGrey707070,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                  child: Row(
                    children: [
                      // From date textfield
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          scrollPadding: EdgeInsets.zero,
                          autovalidateMode: _autovalidateMode,
                          validator: (value) => value?.validateDate,
                          controller: _fromDateController,
                          keyboardType: TextInputType.datetime,
                          decoration: const InputDecoration(
                            labelText: StaticString.fromDate,
                            suffixIcon: CustImage(
                              width: 20,
                              imgURL: ImgName.calendar,
                              imgColor: ColorConstants.custDarkPurple500472,
                            ),
                          ),
                          onTap: () async {
                            fromDate = await selectDate(
                              initialDate: fromDate,
                              controller: _fromDateController,
                              color: ColorConstants.custDarkPurple500472,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      // End date textfield
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          scrollPadding: EdgeInsets.zero,
                          autovalidateMode: _autovalidateMode,
                          validator: (value) => value?.validateDate,
                          controller: _endDateController,
                          keyboardType: TextInputType.datetime,
                          decoration: const InputDecoration(
                            labelText: StaticString.endDate,
                            suffixIcon: CustImage(
                              width: 20,
                              imgURL: ImgName.calendar,
                              imgColor: ColorConstants.custDarkPurple500472,
                            ),
                          ),
                          onTap: () async {
                            toDate = await selectDate(
                              initialDate: toDate,
                              controller: _endDateController,
                              color: ColorConstants.custDarkPurple500472,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 35),

                //log payment elavated button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CommonElevatedButton(
                    bttnText: StaticString.applyFilters.toUpperCase(),
                    color: ColorConstants.custBlue1EC0EF,
                    fontSize: 14,
                    height: 40,
                    onPressed: applyFilterBtnAction,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //----------------------------- buttton action---------------------------//

  // Close button action
  void closeBtnAction() {
    Navigator.of(context).pop();
  }

  // reset button action
  void resetBtnAction() {}

  // Payment Type Ontal Action action
  void paymentTypeOntapAction() {
    showAlert(
      hideButton: true,
      context: context,
      showCustomContent: true,
      showIcon: false,
      singleBtnTitle: StaticString.submit,
      singleBtnColor: ColorConstants.custskyblue22CBFE,
      title: StaticString.whatisThisRegarding,
      content: PaymentTypePoppup(
        paymentTypeList: paymentTypeList,
        onSubmit: (paymentTypeModel) {
          if (mounted) {
            setState(() {
              _paymentTypeController.text =
                  paymentTypeModel?.feedbackType ?? "";
            });
          }
        },
      ),
    );
  }

  void applyFilterBtnAction() {
    if (mounted) {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      final FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }
  }
}
