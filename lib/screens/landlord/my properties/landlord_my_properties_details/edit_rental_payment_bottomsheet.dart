// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:zungu_mobile/screens/landlord/my%20properties/landlord_my_properties_details/payment_type_popup.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../models/settings/feedback_regarding_model.dart';
import '../../../../utils/custom_extension.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/date_selector.dart';
import '../../../../widgets/month_year_selector.dart';

class EditRentalPaymentBottomsheet extends StatefulWidget {
  const EditRentalPaymentBottomsheet({super.key});

  @override
  State<EditRentalPaymentBottomsheet> createState() =>
      _EditRentalPaymentBottomsheetState();
}

class _EditRentalPaymentBottomsheetState
    extends State<EditRentalPaymentBottomsheet> {
  //------------------------------Variable-----------------------------//

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _paymentAmountController =
      TextEditingController();
  final TextEditingController _rentPeriodController = TextEditingController();
  final TextEditingController _paymentDateController = TextEditingController();
  final TextEditingController _paymentTypeController = TextEditingController();
  final TextEditingController _lateFeeController = TextEditingController();
  DateTime? paymentDate;
  DateTime? rentPeriod;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool autoLog = false;

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: MediaQuery.of(context).viewInsets,
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
                  const SizedBox(height: 10),
                  // Close button and
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 5),
                        IconButton(
                          onPressed: closeBtnAction,
                          icon: const CustImage(
                            imgURL: ImgName.closeIcon,
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: CustomText(
                            align: TextAlign.center,
                            txtTitle: StaticString.editPaymentAmount,
                            style:
                                Theme.of(context).textTheme.headline1?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  //Payment amount textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 30,
                    ),
                    child: TextFormField(
                      autovalidateMode: _autovalidateMode,
                      validator: (value) => value?.validateEmpty,
                      controller: _paymentAmountController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: StaticString.paymentAmount.addStarAfter,
                        prefixText: StaticString.currency.addSpaceAfter,
                      ),
                    ),
                  ),

                  // Rent period textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 30,
                    ),
                    child: TextFormField(
                      autovalidateMode: _autovalidateMode,
                      onTap: () async {
                        rentPeriod = await selectMonthAndYear(
                          initialDate: rentPeriod,
                          controller: _rentPeriodController,
                          color: ColorConstants.custDarkPurple500472,
                        );
                      },
                      validator: (value) => value?.validateEmpty,
                      controller: _rentPeriodController,
                      keyboardType: TextInputType.datetime,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: "${StaticString.rentPeriod}*",
                        suffixIcon: CustImage(
                          width: 24,
                          imgURL: ImgName.commonCalendar,
                          imgColor: ColorConstants.custPurple500472,
                        ),
                      ),
                    ),
                  ),

                  // Payment date textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 30,
                    ),
                    child: TextFormField(
                      autovalidateMode: _autovalidateMode,
                      onTap: () async {
                        paymentDate = await selectDate(
                          initialDate: paymentDate,
                          controller: _paymentDateController,
                          color: ColorConstants.custDarkPurple500472,
                        );
                      },
                      validator: (value) => value?.validateDate,
                      readOnly: true,
                      controller: _paymentDateController,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: "${StaticString.paymentDate}*",
                        suffixIcon: CustImage(
                          width: 24,
                          imgURL: ImgName.commonCalendar,
                          imgColor: ColorConstants.custPurple500472,
                        ),
                      ),
                    ),
                  ),

                  //payment type text field
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 30,
                    ),
                    child: TextFormField(
                      onTap: paymentTypeOntapAction,
                      readOnly: true,
                      autovalidateMode: _autovalidateMode,
                      validator: (value) => value?.validateEmpty,
                      controller: _paymentTypeController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
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

                  // late fee textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 30,
                    ),
                    child: TextFormField(
                      autovalidateMode: _autovalidateMode,
                      validator: (value) => value?.validateEmpty,
                      controller: _lateFeeController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixText: StaticString.currency.addSpaceAfter,
                        labelText: StaticString.lateFee.addStarAfter,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  //log payment elavated button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    child: CommonElevatedButton(
                      bttnText: StaticString.update.toUpperCase(),
                      color: ColorConstants.custPurple500472,
                      fontSize: 14,
                      height: 40,
                      onPressed: logPaymentBtnAction,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //----------------------------- buttton action---------------------------//
  void closeBtnAction() {
    Navigator.of(context).pop();
  }

  void logPaymentBtnAction() {
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
}
