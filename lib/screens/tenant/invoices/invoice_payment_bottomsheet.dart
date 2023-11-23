import 'package:flutter/material.dart';

import '../../../constant/color_constants.dart';
import '../../../constant/img_constants.dart';
import '../../../constant/string_constants.dart';
import '../../../utils/custom_extension.dart';
import '../../../widgets/common_elevated_button.dart';
import '../../../widgets/cust_image.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/date_selector.dart';

class InvoicePaymentBottomsheet extends StatefulWidget {
  const InvoicePaymentBottomsheet({super.key});

  @override
  State<InvoicePaymentBottomsheet> createState() =>
      _InvoicePaymentBottomsheetState();
}

class _InvoicePaymentBottomsheetState extends State<InvoicePaymentBottomsheet> {
  //---------------------------Variables----------------------------//
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final ValueNotifier _valueNotifier = ValueNotifier(true);
  final TextEditingController _paymentDateController = TextEditingController();
  final TextEditingController _invoiceAmountController =
      TextEditingController();
  //-------------------------------UI-------------------------------//
 DateTime? paymentTime;
 DateTime? invoiceTime;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: ColorConstants.backgroundColorFFFFFF,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: _valueNotifier,
          builder: (context, val, child) {
            return Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: ColorConstants.custgreyE0E0E0,
                            ),
                            color: ColorConstants.custgreyE0E0E0,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: CustomText(
                              align: TextAlign.center,
                              txtTitle: StaticString.invoicesPayment,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.custDarkPurple150934,
                                  ),
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, bottom: 30, right: 30),
                    child: TextFormField(
                      autovalidateMode: _autovalidateMode,
                      validator: (value) => value?.validateInvoiceAmount,
                      controller: _invoiceAmountController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: StaticString.invoiceAmount.addStarAfter,
                        prefixText: StaticString.currency.addSpaceAfter,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, bottom: 30, right: 30),
                    child: TextFormField(
                      autovalidateMode: _autovalidateMode,
                      onTap: ()async {
                   invoiceTime = await selectDate(
                    initialDate: invoiceTime,
                          controller: _paymentDateController,
                          color: ColorConstants.custDarkPurple500472,
                        );
                      },
                      validator: (value) => value?.validateDate,
                      readOnly: true,
                      controller: _paymentDateController,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        labelText: "${StaticString.paymentDate}*",
                        suffixIcon: CustImage(
                          height: 15,
                          width: 15,
                          imgURL: ImgName.tenantCalender,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _builInvoiceLogPaymentBtn(),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  //---------------------------Button action------------------//

  Widget _builInvoiceLogPaymentBtn() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, bottom: 30, right: 30),
      child: CommonElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.of(context).pop();
          } else {
            _autovalidateMode = AutovalidateMode.always;

            _valueNotifier.notifyListeners();
          }
        },
        bttnText: StaticString.logPayment.toUpperCase(),
        color: ColorConstants.custDarkYellow838500,
        fontSize: 16,
      ),
    );
  }
}
