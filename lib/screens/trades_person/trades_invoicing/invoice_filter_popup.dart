import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/date_selector.dart';

import '../../../models/landloard/attribute_info_model.dart';
import '../../../utils/custom_extension.dart';
import '../../../widgets/radiolist_tile_widget.dart';

class InvoiceFilterPopupScreen extends StatefulWidget {
  const InvoiceFilterPopupScreen({super.key});

  @override
  State<InvoiceFilterPopupScreen> createState() =>
      _InvoiceFilterPopupScreenState();
}

class _InvoiceFilterPopupScreenState extends State<InvoiceFilterPopupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  AttributeInfoModel? selectedOption;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: ColorConstants.custLightGreyB9B9B9,
            disabledColor: ColorConstants.custParrotGreenAFCB1F,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Form(
              autovalidateMode: autovalidateMode,
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: CustomText(
                            txtTitle: StaticString.filterby,
                            align: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      fontSize: 24,
                                    ),
                          ),
                        ),
                        Expanded(
                          child: CustomText(
                            onPressed: () {},
                            txtTitle: StaticString.reset,
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                ?.copyWith(
                                  color: ColorConstants.custParrotGreenAFCB1F,
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      autovalidateMode: autovalidateMode,
                      onTap: () => selectDate(
                        controller: _fromDateController,
                        color: ColorConstants.custParrotGreenAFCB1F,
                      ),
                      validator: (value) => value?.validateDateMessage,
                      readOnly: true,
                      controller: _fromDateController,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: StaticString.fromDate,
                        suffixIcon: CustImage(
                          width: 18,
                          height: 18,
                          imgURL: ImgName.greenCalender,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      autovalidateMode: autovalidateMode,
                      onTap: () => selectDate(
                        controller: _toDateController,
                        color: ColorConstants.custParrotGreenAFCB1F,
                      ),
                      validator: (value) => value?.validateDateMessage,
                      readOnly: true,
                      controller: _toDateController,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: StaticString.toDate,
                        suffixIcon: CustImage(
                          width: 18,
                          // height: 18,
                          height:18,
                          imgURL: ImgName.greenCalender,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CommonRadiolistTile(
                      radioListTileList: [
                        AttributeInfoModel(
                          attributeValue: StaticString.all,
                        ),
                        AttributeInfoModel(
                          attributeValue: StaticString.endingin30Days,
                        ),
                        AttributeInfoModel(
                          attributeValue: StaticString.endingin60Days,
                        ),
                      ],
                      btnText: StaticString.submit,
                      btncolor: ColorConstants.custGreenAFCB1F,
                      radioColor: ColorConstants.custGreenAFCB1F,
                      divider: true,
                      onSelect: (val) {
                        if (mounted) {
                          setState(() {
                            selectedOption = val;
                          });
                        }
                        if (!_formKey.currentState!.validate()) {
                          if (mounted) {
                            setState(() {
                              autovalidateMode = AutovalidateMode.always;
                            });
                          }

                          return;
                        }
                        Navigator.of(context).pop(selectedOption);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
