import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/date_selector.dart';

import '../../../../utils/cust_eums.dart';
import '../../../../utils/custom_extension.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_text.dart';

class PaymentHistoryFilterBottomSheet extends StatefulWidget {
  const PaymentHistoryFilterBottomSheet({
    super.key,
    required this.screenType,
  });
  final UserRole screenType;

  @override
  State<PaymentHistoryFilterBottomSheet> createState() =>
      _PaymentHistoryFilterBottomSheetState();
}

class _PaymentHistoryFilterBottomSheetState
    extends State<PaymentHistoryFilterBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _paymentTypeController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
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
      child: Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 30,
          right: 30,
          bottom: MediaQuery.of(context).viewInsets.bottom,
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
              Row(
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
                          color: widget.screenType == UserRole.LANDLORD
                              ? ColorConstants.custBlue1EC0EF
                              : ColorConstants.custDarkYellow838500,
                          fontWeight: FontWeight.w600,
                        ),
                  )
                ],
              ),
              const SizedBox(height: 25),

              //payment type text field
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                child: TextFormField(
                  autovalidateMode: _autovalidateMode,
                  validator: (value) => value?.validateType,
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
                ),
                child: Row(
                  children: [
                    // From date textfield
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        scrollPadding: EdgeInsets.zero,
                        autovalidateMode: _autovalidateMode,
                        validator: (value) => value?.validateEmpty,
                        controller: _fromDateController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: StaticString.fromDate,
                          suffixIcon: CustImage(
                            width: 24,
                            imgURL: ImgName.commonCalendar,
                            imgColor: widget.screenType == UserRole.LANDLORD
                                ? ColorConstants.custDarkPurple500472
                                : ColorConstants.custDarkPurple662851,
                          ),
                        ),
                        onTap: () async {
                          fromDate = await selectDate(
                            initialDate: fromDate,
                            controller: _fromDateController,
                            color: widget.screenType == UserRole.LANDLORD
                                ? ColorConstants.custDarkPurple500472
                                : ColorConstants.custDarkPurple662851,
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
                        validator: (value) => value?.validateEmpty,
                        controller: _endDateController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: StaticString.endDate,
                          suffixIcon: CustImage(
                            width: 24,
                            imgURL: ImgName.commonCalendar,
                            imgColor: widget.screenType == UserRole.LANDLORD
                                ? ColorConstants.custDarkPurple500472
                                : ColorConstants.custDarkPurple662851,
                          ),
                        ),
                        onTap: () async {
                          toDate = await selectDate(
                            initialDate: toDate,
                            controller: _endDateController,
                            color: widget.screenType == UserRole.LANDLORD
                                ? ColorConstants.custDarkPurple500472
                                : ColorConstants.custDarkPurple662851,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 35),

              //log payment elavated button
              CommonElevatedButton(
                bttnText: StaticString.applyFilters.toUpperCase(),
                color: widget.screenType == UserRole.LANDLORD
                    ? ColorConstants.custBlue1EC0EF
                    : ColorConstants.custDarkYellow838500,
                fontSize: 14,
                onPressed: applyFilterBtnAction,
              ),
              const SizedBox(height: 30),
            ],
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
  void resetBtnAction() {
    _paymentTypeController.text = "";
    _fromDateController.text = "";
    _endDateController.text = "";
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
