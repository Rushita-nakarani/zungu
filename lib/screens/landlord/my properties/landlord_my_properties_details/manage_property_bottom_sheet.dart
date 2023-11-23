// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:zungu_mobile/models/landloard/attribute_info_model.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../models/landloard/property_detail_model.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/radiolist_tile_widget.dart';
import '../landloard_add_property_screen.dart';
import 'delete_property_bottomsheet.dart';

class ManagePropertyBottomSheet extends StatefulWidget {
  final PropertiesDetailModel propertiesDetailModel;
  final void Function() onDelete;
  const ManagePropertyBottomSheet({
    super.key,
    required this.propertiesDetailModel,
    required this.onDelete,
  });

  @override
  State<ManagePropertyBottomSheet> createState() =>
      _ManagePropertyBottomSheetState();
}

class _ManagePropertyBottomSheetState extends State<ManagePropertyBottomSheet> {
  //-------------------------Widgets----------------------//
  AttributeInfoModel? selectedOption;

  //-------------------------UI----------------------//
  String selectProperty = StaticString.deleteProperty;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).viewInsets,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: ColorConstants.custLightGreyB9B9B9,
          disabledColor: ColorConstants.custBlue1EC0EF,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CommonRadiolistTile(
                divider: true,
                radioListTileList: [
                  AttributeInfoModel(
                    attributeValue: StaticString.editProperty,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.deleteProperty,
                  ),
                ],
                btnText: StaticString.nextCapital,
                btncolor: ColorConstants.custskyblue22CBFE,
                onSelect: (val) {
                  if (mounted) {
                    setState(() {
                      selectedOption = val;
                    });
                  }
                  nextBtnAction(selectedOption);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customDivider() {
    return const Divider(
      height: 2,
      endIndent: 30,
      indent: 30,
      color: ColorConstants.custLightGreyEBEAEA,
    );
  }

  //--------------------------------Button action-------------------------------//

  void closeBtnAction() {
    Navigator.of(context).pop();
  }

  Future<void> nextBtnAction(AttributeInfoModel? selectedOption) async {
    Navigator.of(context).pop();
    if (selectedOption?.attributeValue == StaticString.deleteProperty) {
      showAlert(
        hideButton: true,
        showCustomContent: true,
        context: context,
        icon: ImgName.activesubscriptionImage,
        title: StaticString.deleteProperty,
        content: DeletePropertyScreen(onDelete: widget.onDelete),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => LandlordAddFlateScreen(
            propertiesDetailModel: widget.propertiesDetailModel,
          ),
        ),
      );
    }
  }
}
