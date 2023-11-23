// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';

import '../../../../constant/img_font_color_string.dart';
import '../../../../utils/custom_extension.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/custom_text.dart';
import '../../../widgets/cust_image.dart';
import '../../../widgets/date_selector.dart';

class InvoicesFilter extends StatefulWidget {
  const InvoicesFilter({
    super.key,
  });

  @override
  State<InvoicesFilter> createState() => InvoicesFilterState();
}

class InvoicesFilterState extends State<InvoicesFilter> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final ValueNotifier _valueNotifier = ValueNotifier(true);
  DateTime? fromDate;
  DateTime? toDate;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
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
            builder: (
              context,
              val,
              child,
            ) {
              return Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // TODO: Exact center title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Align(
                          child: CustomText(
                            align: TextAlign.center,
                            txtTitle: StaticString.filterBy,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.custDarkPurple150934,
                                ),
                          ),
                        ),
                        CustomText(
                          onPressed: () {
                            _fromDateController.clear();
                            _toDateController.clear();
                            FocusScope.of(context).unfocus();
                          },
                          txtTitle: StaticString.reset,
                          style:
                              Theme.of(context).textTheme.headline1?.copyWith(
                                    color: ColorConstants.custBlue1EC0EF,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    TextFormField(
                      onTap: () async {
                        fromDate = await selectDate(
                          initialDate: fromDate,
                          controller: _fromDateController,
                          color: ColorConstants.custDarkPurple500472,
                        );
                      },
                      validator: (value) => value?.validateDate,
                      readOnly: true,
                      controller: _fromDateController,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: "${StaticString.fromDate}*",
                        suffixIcon: CustImage(
                          width: 24,
                          imgURL: ImgName.commonCalendar,
                          imgColor: ColorConstants.custDarkPurple500472,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
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
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: "${StaticString.toDate}*",
                        suffixIcon: CustImage(
                          width: 24,
                          imgURL: ImgName.commonCalendar,
                          imgColor: ColorConstants.custDarkPurple500472,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    CommonElevatedButton(
                      bttnText: StaticString.submit.toUpperCase(),
                      color: ColorConstants.custBlue1EC0EF,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pop();
                        } else {
                          _autovalidateMode = AutovalidateMode.always;
                          _valueNotifier.notifyListeners();
                        }
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
