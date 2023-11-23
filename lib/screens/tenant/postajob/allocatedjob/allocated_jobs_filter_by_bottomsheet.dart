// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/constant/img_constants.dart';
import 'package:zungu_mobile/constant/string_constants.dart';
import 'package:zungu_mobile/utils/custom_extension.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/date_selector.dart';

class AllocatedJobFilterByBottomsheet extends StatefulWidget {
  const AllocatedJobFilterByBottomsheet({super.key});

  @override
  State<AllocatedJobFilterByBottomsheet> createState() =>
      _AllocatedJobFilterByBottomsheetState();
}

class _AllocatedJobFilterByBottomsheetState
    extends State<AllocatedJobFilterByBottomsheet> {
  //---------------------------Variables----------------------------//
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final ValueNotifier _valueNotifier = ValueNotifier(true);
  final TextEditingController _formDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  //-------------------------------UI-------------------------------//
  DateTime? fromDate;
  DateTime? toDate;
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
                    //Close Icon and Filter By and Reset Text
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
                  //From Date TextField
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, bottom: 30, right: 30),
                    child: TextFormField(
                      autovalidateMode: _autovalidateMode,
                      onTap: () async {
                        fromDate = await selectDate(
                          initialDate: fromDate,
                          controller: _formDateController,
                          color: ColorConstants.custDarkPurple500472,
                        );
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
                  //To Date TextField
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, bottom: 30, right: 30),
                    child: TextFormField(
                      autovalidateMode: _autovalidateMode,
                      onTap: () async {
                        toDate = await selectDate(
                          initialDate: toDate,
                          controller: _toDateController,
                          color: ColorConstants.custDarkPurple500472,
                        );
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
                  //Submit Button
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, bottom: 30, right: 30),
                    child: CommonElevatedButton(
                      onPressed: () => submitBtnAction(),
                      bttnText: StaticString.submit.toUpperCase(),
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
