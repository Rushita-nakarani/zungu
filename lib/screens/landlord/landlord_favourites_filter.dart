import 'package:flutter/material.dart';
import 'package:zungu_mobile/widgets/checklist_tile_widget.dart';

import '../../../../constant/img_font_color_string.dart';
import '../../../../widgets/custom_text.dart';

class FilterSelector extends StatefulWidget {
  const FilterSelector({
    super.key,
    // required this.controller,
  });
  // final TextEditingController controller;

  @override
  State<FilterSelector> createState() => _FilterSelectorState();
}

class _FilterSelectorState extends State<FilterSelector> {
  // List<RadioModel> depositScheme = [
  //   RadioModel(
  //     text: "England",
  //     color: ColorConstants.custBlue1EC0EF,
  //     isSelected: false,
  //   ),
  //   RadioModel(
  //     text: "Scotland",
  //     color: ColorConstants.custBlue1EC0EF,
  //     isSelected: false,
  //   ),
  //   RadioModel(
  //     text: "Wales",
  //     color: ColorConstants.custBlue1EC0EF,
  //     isSelected: false,
  //   ),
  //   RadioModel(
  //     text: "Northern Ireland",
  //     color: ColorConstants.custBlue1EC0EF,
  //     isSelected: false,
  //   ),
  // ];
  List<String> depositScheme = [
    "Tradesman",
    "Accountants",
    "Solicitors",
    "Mortgage Brokers",
    "Tenant Referencing"
  ];
  int selectedOption = -1;

  @override
  void initState() {
    // selectedOption = depositScheme.indexOf(
    //   depositScheme.firstWhere(
    //     (element) => element.text == widget.controller.text,
    //     orElse: () => RadioModel(
    //       isSelected: false,
    //       text: "",
    //       color: Colors.transparent,
    //     ),
    //   ),
    // );
    super.initState();
  }

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
                          txtTitle: StaticString.filterBy,
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
                CommonChecklistTile(
                  btnText: StaticString.done,
                  btncolor: ColorConstants.custBlue1EC0EF,
                  checkListTileList: depositScheme,
                  onSelect: (val) {
                    //  widget.controller.text = val ?? "";
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

  // static Widget customDivider() {
  //   return const Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 8.0),
  //     child: Divider(
  //       color: ColorConstants.custWhiteF1F0F0,
  //     ),
  //   );
  // }
}
