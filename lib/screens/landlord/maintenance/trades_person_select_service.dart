import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/landloard/attribute_info_model.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../../../../widgets/custom_text.dart';
import '../../../widgets/radiolist_tile_widget.dart';

class LandLoardServiceScreen extends StatefulWidget {
  const LandLoardServiceScreen({super.key});

  @override
  State<LandLoardServiceScreen> createState() => _LandLoardServiceScreenState();
}

class _LandLoardServiceScreenState extends State<LandLoardServiceScreen> {
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
      backgroundColor: ColorConstants.custPurple500472,
      title: const Text(StaticString.selectService),
    );
  }

  // Alert Message card
  Widget _alertMsgCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorConstants.custGreyF8F8F8,
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: CustImage(
              imgURL: ImgName.landlordMaintenance,
              width: 36,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                txtTitle: StaticString.selectedProfession,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: ColorConstants.custGrey707070,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              CustomText(
                txtTitle: StaticString.gasHeatingEngineer,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstants.custGrey707070,
                      fontWeight: FontWeight.w700,
                    ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildbody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
              _alertMsgCard(),
              const SizedBox(height: 21),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    txtTitle: StaticString.nowSelectaService,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ColorConstants.custBlue00C0FF,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ),
              CommonRadiolistTile(
                divider: true,
                radioListTileList: [
                  AttributeInfoModel(
                    attributeValue: StaticString.iamNotSure,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.gasBoilerInstallation,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.gasBoilerServiceRepair,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.hotWaterTank,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.oilFiredBoiler,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.radiator,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.solarPanelInstallation,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.whatisThisRegarding,
                  ),
                ],
                btnText: StaticString.selectThisService,
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
