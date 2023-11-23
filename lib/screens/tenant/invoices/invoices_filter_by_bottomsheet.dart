// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';

import '../../../constant/color_constants.dart';
import '../../../constant/img_constants.dart';
import '../../../constant/string_constants.dart';
import '../../../utils/custom_extension.dart';
import '../../../widgets/common_elevated_button.dart';
import '../../../widgets/cust_image.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/date_selector.dart';

class InvoicesFilterByBottomsheet extends StatefulWidget {
  const InvoicesFilterByBottomsheet({super.key});

  @override
  State<InvoicesFilterByBottomsheet> createState() =>
      _InvoicesFilterByBottomsheetState();
}

class _InvoicesFilterByBottomsheetState
    extends State<InvoicesFilterByBottomsheet> {
  //---------------------------Variables----------------------------//
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final ValueNotifier _valueNotifier = ValueNotifier(true);
  final TextEditingController _formDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  //-------------------------------UI-------------------------------//
  DateTime? _formDate;
  DateTime? _toDate;

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
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
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
                          flex: 2,
                          child: CustomText(
                            txtTitle: StaticString.filterBy,
                            align: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.custDarkPurple150934,
                                ),
                          ),
                        ),
                        Expanded(
                          child: CustomText(
                            txtTitle: StaticString.tenantReset,
                            style:
                                Theme.of(context).textTheme.headline1?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.custDarkGreen838500,
                                    ),
                            onPressed: resetBtnAction,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, bottom: 30, right: 30),
                    child: TextFormField(
                      autovalidateMode: _autovalidateMode,
                      onTap: () async {
                        _formDate = await selectDate(
                          initialDate: _formDate,
                          controller: _formDateController,
                          color: ColorConstants.custDarkPurple500472,
                        );
                        print("*********$_formDate");
                      },
                      validator: (value) => value?.validateDate,
                      readOnly: true,
                      controller: _formDateController,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: "${StaticString.fromDate}*",
                        suffixIcon: CustImage(
                          height: 15,
                          width: 15,
                          imgURL: ImgName.tenantCalender,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, bottom: 30, right: 30),
                    child: TextFormField(
                      autovalidateMode: _autovalidateMode,
                      onTap: () async {
                        _toDate = await selectDate(
                          initialDate: _toDate,
                          controller: _toDateController,
                          color: ColorConstants.custDarkPurple500472,
                        );
                        print(_toDate);
                      },
                      validator: (value) => value?.validateDate,
                      readOnly: true,
                      controller: _toDateController,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        labelText: "${StaticString.toDate}*",
                        suffixIcon: CustImage(
                          height: 15,
                          width: 15,
                          imgURL: ImgName.tenantCalender,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, bottom: 30, right: 30),
                    child: CommonElevatedButton(
                      onPressed: () => submitBtnAction(),
                      bttnText: StaticString.logPayment.toUpperCase(),
                      color: ColorConstants.custDarkYellow838500,
                      fontSize: 16,
                    ),
                  ),
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

  void submitBtnAction() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
    } else {
      _autovalidateMode = AutovalidateMode.always;

      _valueNotifier.notifyListeners();
    }
  }

  void resetBtnAction() {
    _formDateController.clear();
    _toDateController.clear();
  }
}
