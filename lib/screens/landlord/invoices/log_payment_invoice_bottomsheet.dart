import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/date_selector.dart';

import '../../../../utils/custom_extension.dart';
import '../../../main.dart';

Future<void> logPaymentInvoiceBottomSheet({
  required String title,
  required Color primaryColor,
  required String btnText,
  required VoidCallback onTap,
}) async {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _invoiceAmountController =
      TextEditingController();
  final TextEditingController _paymentDateController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final ValueNotifier _valueNotifier = ValueNotifier(true);
  DateTime? paymentDate;
  await showModalBottomSheet(
    barrierColor: Colors.black.withOpacity(0.5),
    isScrollControlled: true,
    context: getContext,
    builder: (context) {
      return GestureDetector(
        onTap: () {
          final FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          padding: MediaQuery.of(context).viewInsets,
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
          // height: 550,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: ValueListenableBuilder(
                valueListenable: _valueNotifier,
                builder: (context, val, child) {
                  return Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
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
                                  txtTitle: title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color:
                                            ColorConstants.custDarkPurple150934,
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
                            bottom: 30,
                          ),
                          child: TextFormField(
                            validator: (value) => value?.validateEmpty,
                            autovalidateMode: _autovalidateMode,
                            controller: _invoiceAmountController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixText: StaticString.currency.addSpaceAfter,
                              labelText: StaticString.invoiceAmount.addStarAfter,
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
                            autovalidateMode: _autovalidateMode,
                            onTap: () async {
                              paymentDate = await selectDate(
                                controller: _paymentDateController,
                                color: primaryColor,
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
                                imgColor: ColorConstants.custDarkPurple500472,
                              ),
                            ),
                          ),
                        ),
                        CommonElevatedButton(
                          bttnText: btnText,
                          color: primaryColor,
                          fontSize: 14,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              onTap();
                            } else {
                              _autovalidateMode = AutovalidateMode.always;
                              _valueNotifier.notifyListeners();
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    },
  );
}
