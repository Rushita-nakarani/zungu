import 'package:flutter/material.dart';
import 'package:zungu_mobile/models/landloard/attribute_info_model.dart';
import 'package:zungu_mobile/widgets/radiolist_tile_widget.dart';

import '../../../../constant/img_font_color_string.dart';
import '../../../../utils/cust_eums.dart';
import '../../../../widgets/custom_text.dart';

// ignore: must_be_immutable
class ApprovalFilter extends StatefulWidget {
  ApprovalFilter({
    super.key,
    required this.controller,
    this.filterType,
  });
  final TextEditingController controller;
  TenantReviewFilter? filterType;

  @override
  State<ApprovalFilter> createState() => ApprovalFilterState();
}

class ApprovalFilterState extends State<ApprovalFilter> {
  List<AttributeInfoModel> radioListTile = [
    AttributeInfoModel(
      attributeValue: StaticString.all,
    ),
    AttributeInfoModel(
      attributeValue: StaticString.awaitingApproval,
    ),
    AttributeInfoModel(
      attributeValue: StaticString.approved,
    ),
    AttributeInfoModel(
      attributeValue: StaticString.rejected,
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
                        txtTitle: StaticString.filterBy,
                        style: Theme.of(context).textTheme.headline4?.copyWith(
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
              CommonRadiolistTile(
                divider: true,
                btnText: StaticString.submit,
                btncolor: ColorConstants.custBlue1EC0EF,
                radioListTileList: radioListTile,
                selected: selectDefaultFilter(),
                onSelect: (val) {
                  widget.controller.text = val?.attributeValue ?? "";
                  switch (widget.controller.text) {
                    case StaticString.all:
                      widget.filterType = TenantReviewFilter.ALL;
                      break;
                    case StaticString.awaitingApproval:
                      widget.filterType = TenantReviewFilter.AWAITINGAPPROVAL;
                      break;
                    case StaticString.approved:
                      widget.filterType = TenantReviewFilter.APPROVED;
                      break;
                    case StaticString.rejected:
                      widget.filterType = TenantReviewFilter.REJECTED;
                      break;
                    default:
                  }
                  Navigator.of(context).pop(widget.filterType);
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
      case TenantReviewFilter.ALL:
        return radioListTile[0];
      case TenantReviewFilter.AWAITINGAPPROVAL:
        return radioListTile[1];
      case TenantReviewFilter.APPROVED:
        return radioListTile[2];
      case TenantReviewFilter.REJECTED:
        return radioListTile[4];
      default:
    }
    return null;
  }
}
