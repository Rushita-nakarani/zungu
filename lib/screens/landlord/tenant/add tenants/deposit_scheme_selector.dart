import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constant/img_font_color_string.dart';
import '../../../../models/landloard/attribute_info_model.dart';
import '../../../../providers/landlord/tenant/fetch_property_provider.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/radiolist_tile_widget.dart';

// ignore: must_be_immutable
class DepositSchemeSelector extends StatefulWidget {
  DepositSchemeSelector({
    super.key,
    required this.controller,
    this.selectedOption,
    required this.onSelect,
  });
  final void Function(AttributeInfoModel?) onSelect;
  final TextEditingController controller;
  AttributeInfoModel? selectedOption;

  @override
  State<DepositSchemeSelector> createState() => _DepositSchemeSelectorState();
}

class _DepositSchemeSelectorState extends State<DepositSchemeSelector> {
  @override
  // ------------ui---------------//
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  //  body...
  Widget _buildBody(BuildContext context) {
    return Container(
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
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // TODO: Exact center title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    Expanded(
                      flex: 5,
                      child: Align(
                        child: CustomText(
                          align: TextAlign.center,
                          txtTitle: StaticString.depositScheme,
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.custDarkPurple150934,
                                  ),
                        ),
                      ),
                    ),
                    Expanded(child: Container())
                  ],
                ),
                const SizedBox(height: 15),

                //Deposite Scheme RadioListTile
                Consumer<LandlordTenantPropertyProvider>(
                  builder: (context, provider, child) {
                    return CommonRadiolistTile(
                      radioListTileList: provider.getAttributeList,
                      btnText: StaticString.select,
                      btncolor: ColorConstants.custBlue1EC0EF,
                      divider: true,
                      selected: widget.selectedOption,
                      onSelect: (val) {
                        if (mounted) {
                          setState(() {
                            if (val != null) {
                              widget.selectedOption = val;
                              widget.controller.text = val.attributeValue;
                            }
                          });
                        }
                        widget.onSelect(widget.selectedOption);
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
