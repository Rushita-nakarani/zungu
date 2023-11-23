import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_constants.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../constant/color_constants.dart';
import 'custom_text.dart';

class CommonChecklistTile extends StatefulWidget {
  final List<String> checkListTileList;
  final String btnText;
  final Color? btncolor;
  final bool divider;
  void Function(String? val) onSelect;
  CommonChecklistTile({
    super.key,
    required this.btnText,
    required this.btncolor,
    this.divider = false,
    required this.checkListTileList,
    required this.onSelect,
  });

  @override
  State<CommonChecklistTile> createState() => _ChecklistTileState();
}

class _ChecklistTileState extends State<CommonChecklistTile> {
  final List<Widget> list = <Widget>[];
  List<bool> listCheck = [false, false, false, false, false];
  int? _selectedValue;
  final bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        selectedRowColor: ColorConstants.custskyblue22CBFE,
      ),
      child: Column(
        children: [
          ...List.generate(
            widget.checkListTileList.length,
            (index) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          listCheck[index] = !listCheck[index];
                          //  _isChecked = !_isChecked;
                        });
                      }
                    },
                    child: Row(
                      children: [
                        CustImage(
                          imgURL: ImgName.checkIcon,
                          imgColor: listCheck[index]
                              ? ColorConstants.custGreen0CCE1A
                              : ColorConstants.custLightGreyC6C6C6,
                        ),
                        const SizedBox(width: 10),
                        CustomText(
                          txtTitle: widget.checkListTileList[index],
                          style:
                              Theme.of(context).textTheme.headline1?.copyWith(
                                    color: listCheck[index]
                                        ? ColorConstants.custBlue1EC0EF
                                        : ColorConstants.custDarkBlue150934,
                                  ),
                        )
                      ],
                    ),
                  ),
                ),
                if (widget.divider) Container() else customDivider()
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: CommonElevatedButton(
              bttnText: widget.btnText,
              color: widget.btncolor,
              onPressed: () {
                widget.onSelect(
                  _selectedValue == null
                      ? null
                      : widget.checkListTileList[_selectedValue!],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget customDivider() {
    return const Divider(
      height: 2,
      endIndent: 25,
      indent: 25,
      color: ColorConstants.custLightGreyEBEAEA,
    );
  }
}
