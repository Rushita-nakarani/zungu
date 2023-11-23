import 'package:flutter/material.dart';

import '../../../constant/color_constants.dart';
import '../../../constant/img_constants.dart';
import '../../../constant/string_constants.dart';
import '../../../utils/custom_extension.dart';
import '../../../widgets/common_elevated_button.dart';
import '../../../widgets/cust_image.dart';
import '../../../widgets/date_selector.dart';

class LogPaymentPopup extends StatefulWidget {
  const LogPaymentPopup({super.key});

  @override
  State<LogPaymentPopup> createState() => _LogPaymentPopupState();
}

class _LogPaymentPopupState extends State<LogPaymentPopup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _paymentDateController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Form(
        key: _formKey,
        autovalidateMode: autovalidateMode,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 25,
            right: 25,
            top: 15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                autovalidateMode: autovalidateMode,
                controller: _amountController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) => value?.validatemptyAmount,
                decoration: InputDecoration(
                  prefixText: StaticString.currency.addSpaceAfter,
                  labelText: StaticString.paymentAmount,
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                autovalidateMode: autovalidateMode,
                onTap: () => selectDate(
                  controller: _paymentDateController,
                  color: ColorConstants.custParrotGreenAFCB1F,
                ),
                validator: (value) => value?.validateDate,
                readOnly: true,
                controller: _paymentDateController,
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: StaticString.paymentDate,
                  suffixIcon: CustImage(
                    width: 18,
                    height: 18,
                    imgURL: ImgName.greenCalender,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              CommonElevatedButton(
                bttnText: StaticString.markasPaid,
                color: ColorConstants.custParrotGreenAFCB1F,
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    if (mounted) {
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
