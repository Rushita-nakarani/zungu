import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/landloard/attribute_info_model.dart';
import 'package:zungu_mobile/widgets/radiolist_tile_widget.dart';

class TradesPersonProfession extends StatefulWidget {
  final String? professionValue;
  const TradesPersonProfession({super.key, this.professionValue});

  @override
  State<TradesPersonProfession> createState() => _TradesPersonProfessionState();
}

class _TradesPersonProfessionState extends State<TradesPersonProfession> {
  //------------------------------Variable-------------------------//
  String selectDeclineJob = StaticString.materialPartsNotavailable;

  AttributeInfoModel? selectedOption;

  //-----------------------------UI---------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildbody(),
    );
  }

  //---------------------------Widget------------------------------//

  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: ColorConstants.custDarkPurple500472,
      title: const Text(StaticString.tradesPersonProfession),
    );
  }

  Widget _buildbody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Theme(
          data: Theme.of(context).copyWith(
            textSelectionTheme: const TextSelectionThemeData(
              selectionColor: ColorConstants.custTeal60B0B1,
            ),
            unselectedWidgetColor: ColorConstants.custLightGreyB9B9B9,
            disabledColor: ColorConstants.custBlue1EC0EF,
          ),
          child: Column(
            children: [
              // makeRadioTileList(),
              CommonRadiolistTile(
                divider: true,
                radioListTileList: [
                  AttributeInfoModel(
                    attributeValue: StaticString.bathroomFitter,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.blacksmithMetalWorker,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.gasHeatingengineer,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.builder,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.cctvSatellite,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.carpenter,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.cleaner,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.drainageSpecialist,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.drivewayPavers,
                  ),
                ],
                btnText: StaticString.selectThisProffession,
                btncolor: ColorConstants.custskyblue22CBFE,
                onSelect: (val) {
                  if (mounted) {
                    setState(() {
                      selectedOption = val;
                    });
                  }
                  Navigator.of(context).pop(selectedOption);
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
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
