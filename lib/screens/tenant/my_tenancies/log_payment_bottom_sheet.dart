import 'package:flutter/material.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/date_selector.dart';

import '../../../../utils/custom_extension.dart';
import '../../../constant/img_font_color_string.dart';
import '../../../main.dart';

Future<void> logPaymentBottomSheet() async {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _paymentAmountController =
      TextEditingController();
  final TextEditingController _rentPeriodController = TextEditingController();
  final TextEditingController _paymentDateController = TextEditingController();
  final TextEditingController _paymentTypeController = TextEditingController();
  final TextEditingController _lateFeeController = TextEditingController();

  await showModalBottomSheet(
    barrierColor: Colors.black.withOpacity(0.5),
    isScrollControlled: true,
    context: getContext,
    builder: (context) {
      return SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.custBlack000000.withOpacity(0.1),
                blurRadius: 15,
                spreadRadius: 0.2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // TODO: Exact center title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: ColorConstants.custLightGreyC6C6C6,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Align(
                          child: CustomText(
                            align: TextAlign.center,
                            txtTitle: StaticString.logPayment,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.custDarkPurple150934,
                                ),
                          ),
                        ),
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 24,
                    ),
                    child: TextFormField(
                      validator: (value) => value?.validateEmpty,
                      controller: _paymentAmountController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixText: StaticString.currency.addSpaceAfter,
                        labelText: StaticString.paymentAmount.addStarAfter,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: FormField(
                      builder: (FormFieldState<bool> field) {
                        return SwitchListTile(
                          title: const CustomText(
                            txtTitle: StaticString.autoLogPayment,
                          ),
                          subtitle: CustomText(
                            txtTitle: "*${StaticString.logPaymentMsg}",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                  color: ColorConstants.custDarkYellow838500,
                                ),
                          ),
                          activeColor: ColorConstants.custDarkYellow838500,
                          value: field.value == null ? false : field.value!,
                          onChanged: (val) {
                            field.didChange(val);
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 20,
                    ),
                    child: TextFormField(
                      onTap: () => selectDate(
                        controller: _rentPeriodController,
                        color: ColorConstants.custDarkPurple500472,
                      ),
                      validator: (value) => value?.validateDate,
                      readOnly: true,
                      controller: _rentPeriodController,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: "${StaticString.rentPeriod}*",
                        suffixIcon: CustImage(
                          imgURL: ImgName.commonCalendar,
                          imgColor: ColorConstants.custDarkPurple662851,
                          width: 24,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 20,
                    ),
                    child: TextFormField(
                      onTap: () => selectDate(
                        controller: _paymentDateController,
                        color: ColorConstants.custDarkPurple500472,
                      ),
                      validator: (value) => value?.validateDate,
                      readOnly: true,
                      controller: _paymentDateController,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: "${StaticString.paymentDate}*",
                        suffixIcon: CustImage(
                          imgURL: ImgName.commonCalendar,
                          imgColor: ColorConstants.custDarkPurple662851,
                          width: 24,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 20,
                    ),
                    child: TextFormField(
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
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 50,
                    ),
                    child: TextFormField(
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
                  CommonElevatedButton(
                    bttnText: StaticString.logPayment.toUpperCase(),
                    color: ColorConstants.custDarkYellow838500,
                    fontSize: 14,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
