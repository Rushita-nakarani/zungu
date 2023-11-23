import 'package:flutter/material.dart';
import 'package:zungu_mobile/models/landloard/attribute_info_model.dart';
import 'package:zungu_mobile/widgets/radiolist_tile_widget.dart';

import '../../../../constant/img_font_color_string.dart';
import '../../../../widgets/custom_text.dart';

class CreatePropertyRentCycle extends StatefulWidget {
  const CreatePropertyRentCycle({
    super.key,
    required this.controller,
    required this.rentCycles,
    required this.onSelect,
    this.selectedOption,
  });
  final TextEditingController controller;
  final void Function(AttributeInfoModel?) onSelect;
  final List<AttributeInfoModel> rentCycles;
  final AttributeInfoModel? selectedOption;

  @override
  State<CreatePropertyRentCycle> createState() =>
      _CreatePropertyRentCycleState();
}

class _CreatePropertyRentCycleState extends State<CreatePropertyRentCycle> {
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
                          txtTitle: StaticString.rentCycle,
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
               
                CommonRadiolistTile(
                  divider: true,
                  btnText: StaticString.select,
                  btncolor: ColorConstants.custskyblue22CBFE,
                  radioListTileList: widget.rentCycles,
                  selected: widget.selectedOption,
                  onSelect: (val) {
                    widget.controller.text = val?.attributeValue ?? "";
                    widget.onSelect(val);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
   

}
