import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:zungu_mobile/cards/custom_expenses_select_card.dart';
import 'package:zungu_mobile/models/submit_property_detail_model.dart';
import 'package:zungu_mobile/screens/landlord/my%20properties/landlord_my_properties_details/landlord_my_properties_details_screen.dart';
import 'package:zungu_mobile/screens/trades_person/income_expenses/income/select_job_screen.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';
import 'package:zungu_mobile/widgets/common_widget.dart';
import 'package:zungu_mobile/widgets/image_upload_widget.dart';
import '../../../../constant/decoration.dart';
import '../../../../constant/img_font_color_string.dart';

import '../../../../utils/custom_extension.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_title_with_line.dart';
import '../../../../widgets/date_selector.dart';

class AddExpanseScreen extends StatefulWidget {
  bool? isEdit;
  AddExpanseScreen({super.key, this.isEdit});

  @override
  State<AddExpanseScreen> createState() => _AddExpanseScreenState();
}

class _AddExpanseScreenState extends State<AddExpanseScreen> {
  final List<String> country = [
    "England",
    "Scotland",
    "Wales",
  ];

  //---------Select Country controller--------
  TextEditingController selectCountryController = TextEditingController();

  //---------Agreement Date controller--------
  TextEditingController purchaseDateInput = TextEditingController();

  //---------property details form controller--------

  final TextEditingController _propertyAddressController =
      TextEditingController();

  final TextEditingController _propertyRentAmountController =
      TextEditingController();

  final TextEditingController _propertyDepositPaidController =
      TextEditingController();

  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();

  //---------form Key--------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final ValueNotifier _valueNotifier = ValueNotifier(true);

  int numberOfForm = 1;
  bool _switchValue = true;
  String level = "abc";

  // ignore: prefer_final_fields
  String _currentSelection = StaticString.purchase;

  final ValueNotifier _purchaseNotifier = ValueNotifier(true);
  final SubmitPropertyDetailModel _submitPropertyDetailModel =
      SubmitPropertyDetailModel(
    photos: [],
    videos: [],
    floorPlan: [],
    features: [],
    rooms: [],
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.custCyan017781,
          title: _buildTitle(),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: ValueListenableBuilder(
          valueListenable: _valueNotifier,
          builder: (context, val, child) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          CustomTitleWithLine(
                            title: StaticString.expenseType,
                            primaryColor: ColorConstants.custCyan017781,
                            secondaryColor:
                                ColorConstants.custParrotGreenAFCB1F,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  _buildCardLeaseType(),
                  const SizedBox(
                    height: 35,
                  ),

                  //---------------------Purchase Type--------------------
                  // _buildFurnishingSelections(),
                  // ignore: avoid_print
                  //----------------------Assign to a Job-----------------
                  _buildInfoCard(
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        bottom: 19,
                        top: 12,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomTitleWithLine(
                                title: StaticString.assignToAJob,
                                primaryColor: ColorConstants.custCyan017781,
                                secondaryColor:
                                    ColorConstants.custParrotGreenAFCB1F,
                              ),
                              if (widget.isEdit == true)
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) =>
                                            const TradesSelectJob(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: ColorConstants.custCyan017781,
                                    ),
                                    child: CustomText(
                                      txtTitle: StaticString.selectJOb,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                            color:
                                                ColorConstants.custWhiteFFFFFF,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                )
                              else
                                InkWell(
                                  onTap: () {
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (ctx) =>
                                    //         const EditLandloardBussinessProfileScreen(
                                    //       roleId: "",
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color:
                                          ColorConstants.custParrotGreenAFCB1F,
                                    ),
                                    child: CustomText(
                                      txtTitle: StaticString.edit,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                            color:
                                                ColorConstants.custWhiteFFFFFF,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          _buildAssignToAJobDetails(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //-----------------------Add Vat--------------------
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: _buildAddVatSwitch(),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Column(
                      children: [
                        _buildAddVat(),
                        const SizedBox(height: 20),
                        //-----------------------Summary----------------------
                        summaryCard(),
                        const SizedBox(height: 20),
                        //-----------------------Purchase date--------------------
                        _buildPurchaseDate(),
                        const SizedBox(height: 20),
                        //-----------------------Expense Note--------------------
                        _buildExpensesNote(),
                        const SizedBox(height: 20),
                        const CustomTitleWithLine(
                          title: StaticString.uploadReceipt,
                          primaryColor: ColorConstants.custCyan017781,
                          secondaryColor: ColorConstants.custParrotGreenAFCB1F,
                        ),
                        const SizedBox(height: 20),
                        //-----------------------Upload Receipt--------------------
                        UploadMediaWidget(
                          images: [],
                          image: ImgName.tradesmanCamera,
                          userRole: UserRole.TRADESPERSON,
                          imageList: (images) {
                            debugPrint(images.toString());
                          },
                        ),
                        const SizedBox(height: 20),
                        //-----------------------Add Expenses Button--------------------
                        _buildSendCodeButton(),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

//----------Add Expanse Appbar Name-------------
  Widget _buildTitle() {
    return const CustomText(
      txtTitle: StaticString.addExpanse,
    );
  }

  //------------------------- Button action -------------------------

  void sendCodeSelectButtonAction() {
    Navigator.of(context).pop();
    // Navigator.of(getContext).push(
    //   MaterialPageRoute(
    //     builder: (context) => ResetPasswordScreen(),
    //   ),
    // );
  }

//-------------Expense type-----------

  Widget _buildCardLeaseType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AddExpenseCard(
          title: StaticString.purchase,
          color: ColorConstants.custLightGreenEAFDB2,
          image: ImgName.tenantCurrentTenancy,
          isSelected: _currentSelection == StaticString.purchase,
          colors: ColorConstants.custParrotGreenAFCB1F,
          onTap: () {
            if (mounted) {
              setState(() {
                _currentSelection = StaticString.purchase;
              });
            }
          },
        ),
        const SizedBox(width: 10),
        AddExpenseCard(
          title: StaticString.payBill,
          color: ColorConstants.custRoseFCE1E4,
          image: ImgName.tenantCurrentTenancy,
          isSelected: _currentSelection == StaticString.previousTenancy,
          colors: ColorConstants.custDarkPurple500472,
          onTap: () {
            if (mounted) {
              setState(() {
                _currentSelection = StaticString.previousTenancy;
              });
            }
          },
        ),
      ],
    );
  }

  //-----------------Purchase Type-----------

  // Widget _buildFurnishingSelections() {
  //   return commonHeaderLable(
  //     title: StaticString.purchaseType,
  //     child: ValueListenableBuilder(
  //       valueListenable: _purchaseNotifier,
  //       builder: (context, val, child) {
  //         return Wrap(
  //           spacing: 10,
  //           runSpacing: 10,
  //           children: List.generate(
  //             _addPropertyScreenModel.propertyType.length,
  //             (index) => InkWell(
  //               splashColor: Colors.transparent,
  //               highlightColor: Colors.transparent,
  //               onTap: () {
  //                 _submitPropertyDetailModel.propertyTypeName =
  //                     _addPropertyScreenModel
  //                         .propertyType[index].propertyTypeName;

  //                 _purchaseNotifier.notifyListeners();
  //               },
  //               child: Container(
  //                 padding: const EdgeInsets.symmetric(
  //                   vertical: 9,
  //                   horizontal: 14,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   color: _submitPropertyDetailModel.propertyTypeName ==
  //                           _addPropertyScreenModel
  //                               .propertyType[index].propertyTypeName
  //                       ? ColorConstants.custBlue1BC4F4
  //                       : Colors.white,
  //                   borderRadius: BorderRadius.circular(20),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
  //                       blurRadius: 12,
  //                     ),
  //                   ],
  //                 ),
  //                 child: CustomText(
  //                   txtTitle: _addPropertyScreenModel
  //                       .propertyType[index].propertyTypeName,
  //                   style: Theme.of(context).textTheme.bodyText1?.copyWith(
  //                         color: _submitPropertyDetailModel.propertyTypeName ==
  //                                 _addPropertyScreenModel
  //                                     .propertyType[index].propertyTypeName
  //                             ? Colors.white
  //                             : ColorConstants.custGrey707070,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

//--------Purchase Date textformfield-----------

  Widget _buildPurchaseDate() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      onTap: () => selectDate(
        controller: purchaseDateInput,
        color: ColorConstants.custDarkPurple500472,
      ),
      validator: (value) => value?.validateDate,
      readOnly: true,
      controller: purchaseDateInput,
      keyboardType: TextInputType.datetime,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: "${StaticString.purchaseDate}*",
        suffixIcon: const CustImage(
          imgURL: ImgName.greenCalender,
          width: 24,
        ),
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

  // Assign to a Job... funaction...
  Widget _buildAssignToAJobDetails() {
    return Column(
      children: [
        _buildExpensesName(),
        const SizedBox(
          height: 20,
        ),
        _buildExpensesRentAmount(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildExpensesName() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.validateName,
      controller: _propertyAddressController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: "${StaticString.expenseName}*",
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

  Widget _buildExpensesRentAmount() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.validateEmpty,
      controller: _propertyRentAmountController,
      keyboardType: TextInputType.number,
      maxLength: 9,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: "${StaticString.expenseAmount}*",
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

//-----------------Add Vat-----------------

  Widget _buildAddVatSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txtTitle: StaticString.addVat,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                color: ColorConstants.custGrey7A7A7A,
                fontWeight: FontWeight.w400,
              ),
        ),
        Switch.adaptive(
          activeColor: ColorConstants.custCyan017781,
          thumbColor: MaterialStateProperty.all(
            ColorConstants.custGreyECECEC,
          ),
          value: _switchValue,
          onChanged: (value) {
            if (mounted) {
              setState(() {
                _switchValue = value;
              });
            }
          },
        ),
      ],
    );
  }

//------------------ Add vat text form field----------

  Widget _buildAddVat() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.validVatEmpty,
      controller: _propertyDepositPaidController,
      keyboardType: TextInputType.number,
      maxLength: 9,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: "${StaticString.vatExpense}%*",
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

  // Summary Card
  Widget summaryCard() {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: ColorConstants.custGreyCFCFCF,
            ),
          ),
          child: Column(
            children: [
              _custTitleAndAmountrow(
                title: StaticString.subTotal,
                amount: "£ 1500",
              ),
              _custTitleAndAmountrow(
                title: StaticString.vat1,
                amount: "£ 300",
              ),
              _custTitleAndAmountrow(
                title: StaticString.total1,
                amount: "£ 1800",
              )
            ],
          ),
        ),
        Positioned(
          left: 15,
          top: -2,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            color: Colors.white,
            child: CustomText(
              txtTitle: StaticString.summary,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
      ],
    );
  }

  // Custom title and amount text row
  Widget _custTitleAndAmountrow({
    required String title,
    required String amount,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 12, bottom: 12, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txtTitle: title,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey656567,
                ),
          ),
          CustomText(
            txtTitle: amount,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey656567,
                ),
          )
        ],
      ),
    );
  }

//------------- Expense Note------------------

  Widget _buildExpensesNote() {
    return TextFormField(
      controller: _propertyAddressController,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: StaticString.notes,
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

// Generate Lease button
  Widget _buildSendCodeButton() {
    return CommonElevatedButton(
      color: ColorConstants.custCyan017781,
      bttnText: StaticString.addExpanse.toUpperCase(),
      onPressed: sendCodeButtonAction,
    );
  }

  //------------------------- Button action -------------------------

  void sendCodeButtonAction() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) =>
              const LandlordMyPropertiesDetailsScreen(), // this page navigator check only
        ),
      );
    } else {
      _autovalidateMode = AutovalidateMode.always;
      _valueNotifier.notifyListeners();
    }
  }

  Widget _buildInfoCard(Widget? child) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.backgroundColorFFFFFF,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),

            blurRadius: 8,
            offset: const Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }
}
