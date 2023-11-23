import 'package:flutter/material.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../utils/custom_extension.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/date_selector.dart';
import '../../../../widgets/month_year_selector.dart';

class EditRentPaymentBottomsheet extends StatefulWidget {
  const EditRentPaymentBottomsheet({super.key, required this.screenType});
  final UserRole screenType;

  @override
  State<EditRentPaymentBottomsheet> createState() =>
      _EditRenlPaymentBottomsheetState();
}

class _EditRenlPaymentBottomsheetState
    extends State<EditRentPaymentBottomsheet> {
  //------------------------------Variable-----------------------------//

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _paymentAmountController =
      TextEditingController();
  final TextEditingController _rentPeriodController = TextEditingController();
  final TextEditingController _paymentDateController = TextEditingController();
  final TextEditingController _paymentTypeController = TextEditingController();
  final TextEditingController _lateFeeController = TextEditingController();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool autoLog = false;

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
          padding: const EdgeInsets.all(
            30,
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
                // Close button and
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.custDarkPurple150934,
                            ),
                      ),
                    ),
                    Expanded(child: Container())
                  ],
                ),
                const SizedBox(height: 30),

                //Payment amount textfield
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    autovalidateMode: _autovalidateMode,
                    validator: (value) => value?.validateEmpty,
                    controller: _paymentAmountController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      prefixText: StaticString.currency.addSpaceAfter,
                      labelText: StaticString.paymentAmount.addStarAfter,
                    ),
                  ),
                ),

                // Rent period textfield
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: TextFormField(
                    autovalidateMode: _autovalidateMode,
                    onTap: () => selectMonthAndYear(
                      controller: _rentPeriodController,
                      color: widget.screenType == UserRole.LANDLORD
                          ? ColorConstants.custDarkPurple500472
                          : ColorConstants.custDarkPurple662851,
                    ),
                    validator: (value) => value?.validateEmpty,
                    controller: _rentPeriodController,
                    keyboardType: TextInputType.datetime,
                    // textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "${StaticString.rentPeriod}*",
                      suffixIcon: CustImage(
                        width: 24,
                        imgURL: ImgName.commonCalendar,
                        imgColor: widget.screenType == UserRole.LANDLORD
                            ? ColorConstants.custDarkPurple500472
                            : ColorConstants.custDarkPurple662851,
                      ),
                    ),
                  ),
                ),

                // Payment date textfield
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: TextFormField(
                    autovalidateMode: _autovalidateMode,
                    onTap: () => selectDate(
                      controller: _paymentDateController,
                      color: widget.screenType == UserRole.LANDLORD
                          ? ColorConstants.custDarkPurple500472
                          : ColorConstants.custDarkPurple662851,
                    ),
                    validator: (value) => value?.validateDate,
                    readOnly: true,
                    controller: _paymentDateController,
                    keyboardType: TextInputType.datetime,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "${StaticString.paymentDate}*",
                      suffixIcon: CustImage(
                        width: 24,
                        imgURL: ImgName.commonCalendar,
                        imgColor: widget.screenType == UserRole.LANDLORD
                            ? ColorConstants.custDarkPurple500472
                            : ColorConstants.custDarkPurple662851,
                      ),
                    ),
                  ),
                ),

                //payment type text field
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: TextFormField(
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
                const SizedBox(height: 20),

                //log payment elavated button
                CommonElevatedButton(
                  bttnText: StaticString.update.toUpperCase(),
                  color: widget.screenType == UserRole.LANDLORD
                      ? ColorConstants.custBlue1EC0EF
                      : ColorConstants.custDarkYellow838500,
                  fontSize: 14,
                  onPressed: logPaymentBtnAction,
                ),
              ],
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
}
