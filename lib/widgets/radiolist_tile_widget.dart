import 'package:flutter/material.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';

import '../constant/color_constants.dart';
import '../models/landloard/attribute_info_model.dart';
import 'custom_text.dart';

class CommonRadiolistTile extends StatefulWidget {
  final List<AttributeInfoModel> radioListTileList;
  final String btnText;
  final Color? btncolor;
  final Color radioColor;
  final bool divider;
  AttributeInfoModel? selected;
  void Function(AttributeInfoModel? val) onSelect;
  CommonRadiolistTile({
    super.key,
    this.btnText = "",
    required this.btncolor,
    this.radioColor = ColorConstants.custskyblue22CBFE,
    this.divider = false,
    required this.radioListTileList,
    required this.onSelect,
    this.selected,
  });

  @override
  State<CommonRadiolistTile> createState() => _RadiolistTileState();
}

class _RadiolistTileState extends State<CommonRadiolistTile> {
  final List<Widget> list = <Widget>[];
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
                  activeColor: widget.radioColor,
                  title: CustomText(
                    txtTitle: widget.radioListTileList[index].attributeValue,
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          color:
                              widget.selected == widget.radioListTileList[index]
                                  ? widget.radioColor
                                  : ColorConstants.custDarkPurple160935,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  value: index,
                  groupValue: widget.radioListTileList
                      .indexOf(widget.selected ?? AttributeInfoModel()),
                  onChanged: (val) {
                    if (mounted) {
                      setState(() {
                        widget.selected = widget.radioListTileList[val!];
                        // _selectedValue = val;
                      });
                    }
                  },
                ),
                if (!widget.divider) Container() else customDivider()
              ],
            ),
          ),
          if (widget.btnText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: CommonElevatedButton(
                bttnText: widget.btnText,
                color: widget.btncolor,
                onPressed: () {
                  widget.onSelect(
                    widget.selected,
                  );
                },
              ),
            )
          else
            Container(),
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
