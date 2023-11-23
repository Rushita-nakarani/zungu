import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../providers/landlord/tenant/e_signed_lease_provider.dart';
import '../../../../utils/custom_extension.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/date_selector.dart';
import '../../../../widgets/loading_indicator.dart';

class ESignedLeasesFilterBottomsheet extends StatefulWidget {
  final Function({required DateTime? fromDate, required DateTime? toDate})
      applyFilterOnTap;
  final DateTime? fromDate;
  final DateTime? toDate;
  const ESignedLeasesFilterBottomsheet({
    super.key,  
    required this.applyFilterOnTap,
    this.fromDate,
    this.toDate,
  });

  @override
  State<ESignedLeasesFilterBottomsheet> createState() =>
      _ESignedLeasesFilterBottomsheetState();
}

class _ESignedLeasesFilterBottomsheetState
    extends State<ESignedLeasesFilterBottomsheet> {
  //------------------------------Variables----------------------------//

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final ValueNotifier _valueNotifier = ValueNotifier(true);
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  DateTime? _fromDate;
  DateTime? _toDate;
  // Loading indicator...
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  // providers
  ESignedLeaseProvider get eSignedLeaseProvider =>
      Provider.of<ESignedLeaseProvider>(
        context,
        listen: false,
      );

  @override
  void initState() {
    super.initState();
    if (widget.fromDate != null) {
      _fromDate = widget.fromDate;
      _fromDateController.text = widget.fromDate?.toMobileString ?? "";
    }
    if (widget.toDate != null) {
      _toDate = widget.toDate;
      _endDateController.text = widget.toDate?.toMobileString ?? "";
    }
  }

  //------------------------------UI----------------------------//

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
          padding: const EdgeInsets.symmetric(
            horizontal: 30, vertical: 20,
            // bottom: MediaQuery.of(context).viewInsets.bottom / 3,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ValueListenableBuilder(
            valueListenable: _valueNotifier,
            builder: (context, val, child) {
              return Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: Column(
                  children: [
                    // Close button and filter text and reset button row
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
                          style:
                              Theme.of(context).textTheme.headline1?.copyWith(),
                        ),
                        CustomText(
                          onPressed: resetBtnAction,
                          txtTitle: StaticString.reset,
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(color: ColorConstants.custBlue1EC0EF),
                        )
                      ],
                    ),
                    const SizedBox(height: 25),

                    // From Date Text field
                    TextFormField(
                      readOnly: true,
                      scrollPadding: EdgeInsets.zero,
                      autovalidateMode: _autovalidateMode,
                      // validator: (value) => value?.validateEmpty,
                      controller: _fromDateController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        labelText: StaticString.fromDate,
                        suffixIcon: CustImage(
                          width: 20,
                          imgURL: ImgName.calendar,
                          imgColor: ColorConstants.custDarkBlue150934,
                        ),
                      ),
                      onTap: formDateOnTapAction,
                    ),
                    const SizedBox(height: 35),

                    // End Date Text Field
                    TextFormField(
                      readOnly: true,
                      scrollPadding: EdgeInsets.zero,
                      autovalidateMode: _autovalidateMode,
                      validator: (value) => value?.validateEndDateOptional(
                        startDate: _fromDate,
                        endDate: _toDate,
                      ),
                      controller: _endDateController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        labelText: StaticString.endDate,
                        suffixIcon: CustImage(
                          width: 20,
                          imgURL: ImgName.calendar,
                          imgColor: ColorConstants.custDarkBlue150934,
                        ),
                      ),
                      onTap: toDateOnTapAction,
                    ),
                    const SizedBox(height: 40),

                    //Submit elavated button
                    CommonElevatedButton(
                      bttnText: StaticString.applyFilters.toUpperCase(),
                      color: ColorConstants.custBlue1EC0EF,
                      fontSize: 14,
                      onPressed: applyFilterBtnAction,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  //------------------------------Button action----------------------------//
  // FromDate texformfield ontap action...
  Future<void> formDateOnTapAction() async {
    await selectDate(
      initialDate: _fromDate,
      controller: _fromDateController,
      color: ColorConstants.custPurple500472,
    ).then(
      (value) => {
        if (value != null) {_fromDate = value}
      },
    );
  }

  // Todate texformfield ontap action...
  Future<void> toDateOnTapAction() async {
    await selectDate(
      initialDate: _toDate,
      controller: _endDateController,
      color: ColorConstants.custPurple500472,
    ).then(
      (value) => {
        if (value != null) {_toDate = value}
      },
    );
  }

  // Close button action
  void closeBtnAction() {
    Navigator.of(context).pop();
  }

  // reset button action
  void resetBtnAction() {
    _fromDate = null;
    _toDate = null;
    _fromDateController.clear();
    _endDateController.clear();
  }

  // submit button action
  Future<void> applyFilterBtnAction() async {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      widget.applyFilterOnTap(
        fromDate: _fromDate,
        toDate: _toDate,
      );
    } else {
      _autovalidateMode = AutovalidateMode.always;
      _valueNotifier.notifyListeners();
    }
  }
}
