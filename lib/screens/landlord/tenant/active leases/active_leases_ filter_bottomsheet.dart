// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:zungu_mobile/models/landloard/attribute_info_model.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/filter_constant.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/radiolist_tile_widget.dart';

class ActiveLeasesFiltterBottomsheet extends StatefulWidget {
  final void Function(AttributeInfoModel?) onItemSelect;
  AttributeInfoModel? selected;
  ActiveLeasesFiltterBottomsheet({
    super.key,
    required this.onItemSelect,
    this.selected,
  });

  @override
  State<ActiveLeasesFiltterBottomsheet> createState() =>
      _ActiveLeasesFiltterBottomsheetState();
}

class _ActiveLeasesFiltterBottomsheetState
    extends State<ActiveLeasesFiltterBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  // Build body...
  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SafeArea(
          child: Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: ColorConstants.custLightGreyB9B9B9,
              disabledColor: ColorConstants.custBlue1EC0EF,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                // Close button and Filter title row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
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
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              fontWeight: FontWeight.w700,
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
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CommonRadiolistTile(
                    divider: true,
                    radioListTileList: FilterConstant.activeLeaseFilterList,
                    btnText: StaticString.submit.toUpperCase(),
                    btncolor: ColorConstants.custBlue1EC0EF,
                    onSelect: widget.onItemSelect,
                    selected: widget.selected,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // custom divider...
  Widget customDivider() {
    return const Divider(
      height: 2,
      endIndent: 25,
      indent: 25,
      color: ColorConstants.custLightGreyEBEAEA,
    );
  }

  //--------------------------------Button action-------------------------------//
//  close btnOntap action...
  void closeBtnAction() {
    Navigator.of(context).pop();
  }

  // next btnontap action...
  void nextBtnAction() {
    Navigator.of(context).pop();
    showAlert(
      context: context,
      icon: ImgName.activesubscriptionImage,
      title: StaticString.deleteProperty,
      message: StaticString.deletePropertysubtitle,
      // subscriptionBtn: true,
      subScriptionBtn: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            side: const BorderSide(
              color: Colors.red,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                35.0,
              ),
            ),
          ),
          child: CustomText(
            txtTitle: StaticString.endsubbtnText,
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: Colors.red,
                ),
          ),
        ),
      ),
    );
  }

  // Reset Button action
  void resetBtnAction() {
    widget.selected = null;
    widget.onItemSelect(widget.selected);
  }
}
