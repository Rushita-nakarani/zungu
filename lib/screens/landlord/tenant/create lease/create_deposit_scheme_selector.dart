import 'package:flutter/material.dart';
import 'package:zungu_mobile/models/landloard/attribute_info_model.dart';
import 'package:zungu_mobile/widgets/radiolist_tile_widget.dart';

import '../../../../constant/img_font_color_string.dart';
import '../../../../widgets/custom_text.dart';

class CreateDepositSchemeSelector extends StatefulWidget {
  const CreateDepositSchemeSelector({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  State<CreateDepositSchemeSelector> createState() =>
      _CreateDepositSchemeSelectorState();
}

class _CreateDepositSchemeSelectorState
    extends State<CreateDepositSchemeSelector> {
  // createdepositeList...
  List<AttributeInfoModel> createDepositeList = [
    AttributeInfoModel(
      attributeValue: StaticString.noDepositScheme,
    ),
    AttributeInfoModel(
      attributeValue: StaticString.depositProtectionScheme,
    ),
    AttributeInfoModel(
      attributeValue: StaticString.tenancyDepositScheme,
    ),
    AttributeInfoModel(
      attributeValue: StaticString.myDeposits,
    ),
  ];
  @override
  void initState() {
    super.initState();
  }
  //  ----------------ui------------//
  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
  // --------------widget----------//
  // Body..
  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Container(
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
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
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
                const SizedBox(height: 20),
                // CommonRadioListtile
                CommonRadiolistTile(
                  divider: true,
                  btnText: StaticString.select,
                  btncolor: ColorConstants.custBlue1EC0EF,
                  radioListTileList: createDepositeList,
                  onSelect: (val) {
                    widget.controller.text = val?.attributeValue ?? "";
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Common customdivider...
  Widget customDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Divider(
        color: ColorConstants.custWhiteF1F0F0,
      ),
    );
  }
}
