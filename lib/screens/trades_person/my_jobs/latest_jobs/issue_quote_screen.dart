import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';

import '../../../../../utils/custom_extension.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/date_selector.dart';
import '../../../../widgets/range_time_selector.dart';

class IssueQuoteScreen extends StatefulWidget {
  const IssueQuoteScreen({super.key});

  @override
  State<IssueQuoteScreen> createState() => _IssueQuoteScreenState();
}

class _IssueQuoteScreenState extends State<IssueQuoteScreen> {
  //----------------------------Variable---------------------//
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidationMode = AutovalidateMode.disabled;

  final TextEditingController _availableDateController =
      TextEditingController();
  final TextEditingController _availableTimeController =
      TextEditingController();
  final TextEditingController _quoteExpiryDateController =
      TextEditingController();
  final TextEditingController _jobPriceController = TextEditingController();
  final TextEditingController _labourCostsController = TextEditingController();
  final TextEditingController _partsMaterialsCostController =
      TextEditingController();
  final TextEditingController _vatController = TextEditingController();

  bool costBreakdown = false;
  bool addVAT = false;
  //----------------------------UI---------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.custDarkTeal017781,
        title: const Text(StaticString.issueQuote1),
      ),
      body: _buildBody(),
    );
  }

  //----------------------------Widgets-------------------//
  Widget _buildBody() {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: formKey,
            autovalidateMode: autoValidationMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Available Date Controller
                _availableDateTextField(),
                const SizedBox(height: 30),

                //Available Time Controller
                _availableTimeTextField(),
                const SizedBox(height: 30),

                //Quote Expiry Date Controller
                _quoteExpiryDateTextField(),
                const SizedBox(height: 30),

                //Job Price Controller
                _jobPriceTextField(),
                const SizedBox(height: 25),

                //Cost BreakDown text and switch row
                _costBreakdownTextandSwitchRow(),
                const SizedBox(height: 30),

                //Labour costs textfield
                _labourCostsTextField(),
                const SizedBox(height: 30),

                // Parts/ Materials costs textfield
                _partsMaterialsCostsTextField(),
                const SizedBox(height: 30),

                // Add VAT  text and switch row
                _addVATTextAndSwitchRow(),
                const SizedBox(height: 20),

                // Vat% textField
                _vatTextField(),
                const SizedBox(height: 30),

                // Summary Card
                summaryCard(),
                const SizedBox(height: 35),

                //edit AND resend ElavtedButton
                CommonElevatedButton(
                  bttnText: StaticString.submitQuotes,
                  color: ColorConstants.custDarkTeal017781,
                  fontSize: 14,
                  height: 40,
                  onPressed: submitQuoteOntapAction,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Available Date Textfield
  Widget _availableDateTextField() {
    return TextFormField(
      autovalidateMode: autoValidationMode,
      onTap: () => selectDate(
        controller: _availableDateController,
        color: ColorConstants.custDarkTeal017781,
      ),
      validator: (value) => value?.validateDateMessage,
      readOnly: true,
      controller: _availableDateController,
      keyboardType: TextInputType.datetime,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: "${StaticString.availableDate}*",
        suffixIcon: CustImage(
          width: 15,
          height: 15,
          imgURL: ImgName.greenCalender,
        ),
      ),
    );
  }

  //Available Time Textfield
  Widget _availableTimeTextField() {
    return TextFormField(
      autovalidateMode: autoValidationMode,
      onTap: () => selectRangeTime(controller: _availableTimeController),
      validator: (value) => value?.validateTimeMessage,
      readOnly: true,
      controller: _availableTimeController,
      keyboardType: TextInputType.datetime,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: "${StaticString.availableTime}*",
        suffixIcon: CustImage(
          width: 15,
          height: 15,
          imgURL: ImgName.greenClock,
        ),
      ),
    );
  }

  //Quote Expiry Date Textfield
  Widget _quoteExpiryDateTextField() {
    return TextFormField(
      autovalidateMode: autoValidationMode,
      onTap: () => selectDate(
        controller: _quoteExpiryDateController,
        color: ColorConstants.custDarkTeal017781,
      ),
      validator: (value) => value?.validateDateMessage,
      readOnly: true,
      controller: _quoteExpiryDateController,
      keyboardType: TextInputType.datetime,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: "${StaticString.quoteExpiryDate}*",
        suffixIcon: CustImage(
          width: 15,
          height: 15,
          imgURL: ImgName.greenCalender,
        ),
      ),
    );
  }

  //Job Price textfield
  Widget _jobPriceTextField() {
    return TextFormField(
      autovalidateMode: autoValidationMode,
      validator: (value) => value?.validateJobPrice,
      controller: _jobPriceController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: "${StaticString.jobPrice1}${"*"}",
        prefix: CustomText(
          txtTitle: "£",
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: ColorConstants.custGrey707070),
        ),
      ),
    );
  }

  //Cost BreakDown text and switch row
  Widget _costBreakdownTextandSwitchRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txtTitle: StaticString.costBreakdown,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  color: ColorConstants.custGrey707070,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Switch.adaptive(
            activeColor: ColorConstants.custDarkTeal017781,
            thumbColor: MaterialStateProperty.all(
              ColorConstants.custGreyECECEC,
            ),
            value: costBreakdown,
            onChanged: (val) {
              if (mounted) {
                setState(() {
                  costBreakdown = val;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  //Labour Costs Textfield
  Widget _labourCostsTextField() {
    return TextFormField(
      autovalidateMode: autoValidationMode,
      validator: (value) => value?.validateLabourcost,
      controller: _labourCostsController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "${StaticString.labourCosts}${"*"}",
        prefix: CustomText(
          txtTitle: "£",
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: ColorConstants.custGrey707070),
        ),
      ),
    );
  }

  //Parts/Materials Costs Textfield
  Widget _partsMaterialsCostsTextField() {
    return TextFormField(
      autovalidateMode: autoValidationMode,
      validator: (value) => value?.validatePartsMaterialCost,
      controller: _partsMaterialsCostController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "${StaticString.partsMaterialsCost}${"*"}",
        prefix: CustomText(
          txtTitle: "£",
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: ColorConstants.custGrey707070),
        ),
      ),
    );
  }

  //Add VAT text and switch row
  Widget _addVATTextAndSwitchRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txtTitle: StaticString.addVat,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  color: ColorConstants.custGrey707070,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Switch.adaptive(
            activeColor: ColorConstants.custDarkTeal017781,
            thumbColor: MaterialStateProperty.all(
              ColorConstants.custGreyECECEC,
            ),
            value: addVAT,
            onChanged: (val) {
              if (mounted) {
                setState(() {
                  addVAT = val;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  // Vat% Textfield
  Widget _vatTextField() {
    return TextFormField(
      autovalidateMode: autoValidationMode,
      validator: (value) => value?.validatePercentageOfVAT,
      controller: _vatController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        labelText: "${StaticString.vat1}${"%*"}",
      ),
    );
  }

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
                amount: "£ 354.00",
              ),
              _custTitleAndAmountrow(
                title: StaticString.vat1,
                amount: "£ 70.80",
              ),
              _custTitleAndAmountrow(
                title: StaticString.total1,
                amount: "£ 424.80",
              )
            ],
          ),
        ),
        Positioned(
          left: 25,
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
      padding: const EdgeInsets.only(left: 25, top: 12, bottom: 12, right: 5),
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

  //----------------------Button Action--------------------//

  // submit quotes button action
  void submitQuoteOntapAction() {
    if (mounted) {
      setState(() {
        autoValidationMode = AutovalidateMode.always;
      });
    }
    if (formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      final FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }
  }
}
