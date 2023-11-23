import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/models/landloard/fetch_country_model.dart';
import 'package:zungu_mobile/providers/landlord/tenant/create_leases_provider.dart';

import '../../../../constant/img_font_color_string.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/custom_text.dart';

class CreateCountrySelector extends StatefulWidget {
  const CreateCountrySelector({
    super.key,
    required this.onSubmit,
    this.selectedCountry,
  });

  final Function(FetchCountryModel fetchCountryModel) onSubmit;
  final FetchCountryModel? selectedCountry;
  @override
  State<CreateCountrySelector> createState() => _CreateCountrySelectorState();
}

class _CreateCountrySelectorState extends State<CreateCountrySelector> {
  @override
  void initState() {
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
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Consumer<CreateLeasesProvider>(
              builder: (context, country, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // TODO: Exact center title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
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
                                txtTitle: StaticString.selectCountry,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color:
                                          ColorConstants.custDarkPurple150934,
                                    ),
                              ),
                            ),
                          ),
                          Expanded(child: Container())
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // CommonListTile...
                    CountryRadiolistTile(
                      btnText: StaticString.select,
                      divider: true,
                      btncolor: ColorConstants.custBlue1EC0EF,
                      radioListTileList: country.fetchCountryList,
                      selected: widget.selectedCountry,
                      onSelect: (val) {
                        if (val != null) {
                          widget.onSubmit(val);
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CountryRadiolistTile extends StatefulWidget {
  final List<FetchCountryModel> radioListTileList;
  final String btnText;
  final Color? btncolor;
  final Color radioColor;
  final bool divider;
  FetchCountryModel? selected;
  void Function(FetchCountryModel? val) onSelect;
  CountryRadiolistTile({
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
