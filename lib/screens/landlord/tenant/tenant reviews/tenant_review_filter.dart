import 'package:flutter/material.dart';
import 'package:zungu_mobile/models/landloard/fetch_country_model.dart';

import 'package:zungu_mobile/widgets/custom_radio_btn_review_filter.dart';

import '../../../../constant/img_font_color_string.dart';
import '../../../../widgets/common_elevated_button.dart';

import '../../../../widgets/custom_text.dart';
import '../create lease/create_select_country.dart';

class ReviewFilter extends StatefulWidget {
  const ReviewFilter({
    super.key,
    // required this.controller,
  });
  // final TextEditingController controller;

  @override
  State<ReviewFilter> createState() => _ReviewFilterState();

  void onSubmit(FetchCountryModel val) {}
}

class _ReviewFilterState extends State<ReviewFilter> {
  List<RadioModel> depositScheme = [
    RadioModel(
      text: "All",
      color: ColorConstants.custBlue1EC0EF,
      isSelected: false,
    ),
    RadioModel(
      text: "Awaiting Approval",
      color: ColorConstants.custBlue1EC0EF,
      isSelected: false,
    ),
    RadioModel(
      text: "Approved",
      color: ColorConstants.custBlue1EC0EF,
      isSelected: false,
    ),
    RadioModel(
      text: "Rejected",
      color: ColorConstants.custBlue1EC0EF,
      isSelected: false,
    ),
  ];

  // List<String> reviewFilter = [
  //   "All",
  //   "Awaiting Approval",
  //   "Approved",
  //   "Rejected",
  // ];
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
                const SizedBox(height: 20),
                ListView.separated(
                  separatorBuilder: (context, index) => customDivider(),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: depositScheme.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return RadioButtonReviewFilter(
                      button: depositScheme[index],
                      selected: index == selectedOption,
                      onTap: () {
                        setState(() {
                          selectedOption = index;
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 30),
                CommonElevatedButton(
                  bttnText: StaticString.select,
                  color: ColorConstants.custBlue1EC0EF,
                  onPressed: () {
                    //widget.controller.text = depositScheme[selectedOption].text;
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget customDivider() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    child: Divider(
      color: ColorConstants.custWhiteF1F0F0,
    ),
  );
}

class ReviewRadiolistTile extends StatefulWidget {
  final List<String> radioListTileList;
  final String btnText;
  final Color? btncolor;
  final Color radioColor;
  final bool divider;
  FetchCountryModel? selected;
  void Function(FetchCountryModel? val) onSelect;
  ReviewRadiolistTile({
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
  State<CountryRadiolistTile> createState() => _RadiolistTileState();
}

class _RadiolistTileState extends State<CountryRadiolistTile> {
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
                    txtTitle: widget.radioListTileList[index].country,
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
                      .indexOf(widget.selected ?? FetchCountryModel()),
                  onChanged: (val) {
                    if (mounted) {
                      setState(() {
                        if (val != null) {
                          widget.selected = widget.radioListTileList[val];
                        }
                        // _selectedValue = val;
                      });
                    }
                  },
                ),
                if (widget.divider) Container() else customDivider()
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

  // Custom devider...
  Widget customDivider() {
    return const Divider(
      height: 2,
      endIndent: 25,
      indent: 25,
      color: ColorConstants.custLightGreyEBEAEA,
    );
  }
}
