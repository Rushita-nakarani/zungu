import 'package:flutter/material.dart';

import '../../../../constant/img_font_color_string.dart';
import '../../../../models/landloard/attribute_info_model.dart';
import '../../../../utils/cust_eums.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/radiolist_tile_widget.dart';

// ignore: must_be_immutable
class PropertyFilter extends StatefulWidget {
  PropertyFilter({
    super.key,
    // required this.controller,
    this.filterType,
    required this.onSelected,
  });
  // final TextEditingController controller;
  CurrentTenantsFilter? filterType;
  final Function(AttributeInfoModel) onSelected;
  @override
  State<PropertyFilter> createState() => PropertyFilterState();
}

class PropertyFilterState extends State<PropertyFilter> {
  List<AttributeInfoModel> radioListTile = [
    AttributeInfoModel(
      attributeValue: StaticString.residentialProperties,
    ),
    AttributeInfoModel(
      attributeValue: StaticString.commercialProperties,
    ),
    AttributeInfoModel(
      attributeValue: StaticString.hMOProperties,
    ),
  ];
  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.custDarkPurple150934,
                          ),
                    ),
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
              const SizedBox(height: 15),
              CommonRadiolistTile(
                divider: true,
                btnText: StaticString.submit,
                btncolor: ColorConstants.custBlue1EC0EF,
                radioListTileList: radioListTile,
                selected: selectDefaultFilter(),
                onSelect: (val) {
                  if (val != null) {
                    widget.onSelected(val);
                  }
                  // widget.controller.text = val?.attributeValue ?? "";
                  // switch (widget.controller.text) {
                  //   case StaticString.residentialProperties:
                  //     widget.filterType = CurrentTenantsFilter.RESIDENTIAL;
                  //     break;
                  //   case StaticString.commercialProperties:
                  //     widget.filterType = CurrentTenantsFilter.COMMERCIAL;
                  //     break;
                  //   case StaticString.hMOProperties:
                  //     widget.filterType = CurrentTenantsFilter.HMO;
                  //     break;
                  //   default:
                  // }
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  AttributeInfoModel? selectDefaultFilter() {
    switch (widget.filterType) {
      case CurrentTenantsFilter.RESIDENTIAL:
        return radioListTile[0];
      case CurrentTenantsFilter.COMMERCIAL:
        return radioListTile[1];
      case CurrentTenantsFilter.HMO:
        return radioListTile[2];
      default:
    }
    return null;
  }

  //------------------------Button Action------------------//

  void resetBtnAction() {
    widget.filterType = null;

    Navigator.of(context).pop(widget.filterType);
  }
}
