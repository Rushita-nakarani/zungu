// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member=,
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/constant/decoration.dart';
import 'package:zungu_mobile/constant/img_constants.dart';
import 'package:zungu_mobile/constant/string_constants.dart';
import 'package:zungu_mobile/models/landloard/financial_overview_model.dart';
import 'package:zungu_mobile/providers/landlord_provider.dart';
import 'package:zungu_mobile/utils/custom_extension.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/date_selector.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';

class AddFinancialsScreen extends StatefulWidget {
  const AddFinancialsScreen({super.key, this.financialOverViewModel});
  final FinancialOverViewModel? financialOverViewModel;

  @override
  State<AddFinancialsScreen> createState() => _AddFinancialsScreenState();
}

class _AddFinancialsScreenState extends State<AddFinancialsScreen> {
  //---------------------------Variables----------------------------//

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final ValueNotifier _valueNotifier = ValueNotifier(true);
  final TextEditingController _purchaseDateController = TextEditingController();
  final TextEditingController _purchasePriceController =
      TextEditingController();
  final TextEditingController _outstandingMortgageAmountController =
      TextEditingController();
  final TextEditingController _monthlyMortagePaymentController =
      TextEditingController();
  final TextEditingController _mortgagePaymentDayController =
      TextEditingController();
  final FinancialOverViewModel _financialOverViewModel =
      FinancialOverViewModel();
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  //-------------------------------UI-------------------------------//
  @override
  void initState() {
    super.initState();
    if (widget.financialOverViewModel != null) {
      _purchaseDateController.text =
          widget.financialOverViewModel!.purchaseDate?.toMobileString ?? "";
      _purchasePriceController.text =
          widget.financialOverViewModel!.purchasePrice.toString();
      _outstandingMortgageAmountController.text =
          widget.financialOverViewModel!.outstandingMortgage.toString();
      _monthlyMortagePaymentController.text =
          widget.financialOverViewModel!.mortgagePayment.toString();
      _mortgagePaymentDayController.text =
          widget.financialOverViewModel!.mortgagePaymentDay!.day.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: SingleChildScrollView(
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
                      //Close Icon and Add Financials Text
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: ColorConstants.custgreyE0E0E0,
                            ),
                            color: ColorConstants.custgreyE0E0E0,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: CustomText(
                              txtTitle: widget.financialOverViewModel == null
                                  ? StaticString.addFinancials
                                  : StaticString.editFinacials,
                              align: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.custDarkPurple150934,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 30),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    //Purchase Date TextField
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        bottom: 30,
                        right: 30,
                      ),
                      child: TextFormField(
                        autovalidateMode: _autovalidateMode,
                        onTap: () {
                          selectDate(
                            controller: _purchaseDateController,
                            color: ColorConstants.custDarkPurple500472,
                            initialDate: _financialOverViewModel.purchaseDate,
                          ).then(
                            (value) => {
                              if (value != null)
                                {_financialOverViewModel.purchaseDate = value}
                            },
                          );
                        },
                        validator: (value) => value?.emptyPurchaseDate1,
                        readOnly: true,
                        controller: _purchaseDateController,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                        decoration: CommonInputdecoration.copyWith(
                          labelText: StaticString.purchaseDate1.addStarAfter,
                          suffixIcon: const CustImage(
                            imgURL: ImgName.commonCalendar,
                            imgColor: ColorConstants.custDarkPurple500472,
                            height: 18,
                            width: 18,
                          ),
                        ),
                        cursorColor: ColorConstants.custDarkPurple500472,
                      ),
                    ),
                    //Purchase Price TextField
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        bottom: 30,
                        right: 30,
                      ),
                      child: TextFormField(
                        autovalidateMode: _autovalidateMode,
                        validator: (value) => value?.emptyPurchasePrice1,
                        controller: _purchasePriceController,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _financialOverViewModel.purchasePrice =
                              value?.toInt ?? 0;
                        },
                        maxLength: 9,
                        textInputAction: TextInputAction.next,
                        decoration: CommonInputdecoration.copyWith(
                          prefixText: StaticString.currency.addSpaceAfter,
                          labelText: StaticString.purchasePrice1.addStarAfter,
                        ),
                        cursorColor: ColorConstants.custDarkPurple500472,
                      ),
                    ),

                    // Outstanding Mortgage Amount TextField
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        bottom: 30,
                        right: 30,
                      ),
                      child: TextFormField(
                        autovalidateMode: _autovalidateMode,
                        validator: (value) =>
                            value?.emptyOutstandingMortgageAmount,
                        controller: _outstandingMortgageAmountController,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _financialOverViewModel.outstandingMortgage =
                              value?.toInt ?? 0;
                        },
                        maxLength: 9,
                        textInputAction: TextInputAction.next,
                        decoration: CommonInputdecoration.copyWith(
                          prefixText: StaticString.currency.addSpaceAfter,
                          labelText: StaticString
                              .outstandingMortgageAmount.addStarAfter,
                        ),
                        cursorColor: ColorConstants.custDarkPurple500472,
                      ),
                    ),

                    //Monthly Mortgage Payment TextField
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        bottom: 30,
                        right: 30,
                      ),
                      child: TextFormField(
                        autovalidateMode: _autovalidateMode,
                        validator: (value) =>
                            value?.emptyMonthlyMortgagePayment,
                        controller: _monthlyMortagePaymentController,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _financialOverViewModel.mortgagePayment =
                              value?.toInt ?? 0;
                        },
                        maxLength: 9,
                        textInputAction: TextInputAction.next,
                        decoration: CommonInputdecoration.copyWith(
                          prefixText: StaticString.currency.addSpaceAfter,
                          labelText:
                              StaticString.monthlyMortgagePayment.addStarAfter,
                        ),
                        cursorColor: ColorConstants.custDarkPurple500472,
                      ),
                    ),
                    //Mortgage Payment Day TextField
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        bottom: 30,
                        right: 30,
                      ),
                      child: TextFormField(
                        autovalidateMode: _autovalidateMode,
                        validator: (value) => value?.emptyMortgagePaymentDay,
                        controller: _mortgagePaymentDayController,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _financialOverViewModel.intmortgagePaymentDay =
                              value?.toInt ?? 0;
                        },
                        maxLength: 9,
                        textInputAction: TextInputAction.next,
                        decoration: CommonInputdecoration.copyWith(
                          prefixText: StaticString.currency.addSpaceAfter,
                          labelText:
                              StaticString.mortgagePaymentDay.addStarAfter,
                        ),
                        cursorColor: ColorConstants.custDarkPurple500472,
                      ),
                    ),

                    const SizedBox(height: 10),
                    //Submit Button
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        bottom: 30,
                        right: 30,
                      ),
                      child: CommonElevatedButton(
                        onPressed: () {
                          {
                            if (_formKey.currentState!.validate()) {
                              addFinancialDetails();
                            } else {
                              _autovalidateMode = AutovalidateMode.always;
                              _valueNotifier.notifyListeners();
                            }
                          }
                        },
                        bttnText: StaticString.submit.toUpperCase(),
                        color: ColorConstants.custBlue1EC0EF,
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
      ),
    );
  }

  //---------------------------Button action------------------//

  Future<void> addFinancialDetails() async {
    try {
      _formKey.currentState?.save();
      if (!(_formKey.currentState?.validate() ?? true)) {
        _autovalidateMode = AutovalidateMode.always;
        _valueNotifier.notifyListeners();
      }
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      await Provider.of<LandlordProvider>(context, listen: false).addFinancials(
        widget.financialOverViewModel?.propertyDetailId,
        _financialOverViewModel.purchaseDate,
        _financialOverViewModel.purchasePrice,
        _financialOverViewModel.outstandingMortgage,
        _financialOverViewModel.mortgagePayment,
        _financialOverViewModel.intmortgagePaymentDay,
      );
      // await Provider.of<LandlordProvider>(context, listen: false)
      //     .fetchFinancialOverviewData(
      //   financeId: widget.financialOverViewModel?.propertyDetailId,
      // );
      Navigator.of(context).pop();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  void submitBtnAction() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
    } else {
      _autovalidateMode = AutovalidateMode.always;
      _valueNotifier.notifyListeners();
    }
  }
}
