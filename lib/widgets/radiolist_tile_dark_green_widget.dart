import 'package:flutter/material.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';

import '../constant/color_constants.dart';
import 'custom_text.dart';

class DarkGreenCommonRadiolistTile extends StatefulWidget {
  final List<String> radioListTileList;
  final String btnText;
  final Color? btncolor;
  final bool divider;
  void Function(String? val) onSelect;
  DarkGreenCommonRadiolistTile({
    super.key,
    required this.btnText,
    required this.btncolor,
    this.divider = false,
    required this.radioListTileList,
    required this.onSelect,
  });
  @override
  State<DarkGreenCommonRadiolistTile> createState() =>
      _DarkGreenCommonRadiolistTileState();
}

class _DarkGreenCommonRadiolistTileState
    extends State<DarkGreenCommonRadiolistTile> {
  final List<Widget> list = <Widget>[];
  int? _selectedValue;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        selectedRowColor: ColorConstants.custskyblue22CBFE,
      ),
      child: Column(
        children: [
          ...List.generate(
            widget.radioListTileList.length,
            (index) => Column(
              children: [
                RadioListTile<int>(
                  activeColor: ColorConstants.custDarkGreen838500,
                  title: CustomText(
                    txtTitle: widget.radioListTileList[index],
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          color: _selectedValue == index
                              ? ColorConstants.custDarkGreen838500
                              : ColorConstants.custDarkPurple160935,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  value: index,
                  groupValue: _selectedValue,
                  onChanged: (val) {
                    if (mounted) {
                      setState(() {
                        _selectedValue = val;
                      });
                    }
                  },
                ),
                if (widget.divider) Container() else customDivider(),
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
                      : widget.radioListTileList[_selectedValue!],
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
