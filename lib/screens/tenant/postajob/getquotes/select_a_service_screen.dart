//-------------------------------- Select A Service Screen ------------------------//

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/radiolist_tile_dark_green_widget.dart';

class SelectAServiceScreen extends StatefulWidget {
  const SelectAServiceScreen({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  State<SelectAServiceScreen> createState() => _SelectAServiceScreenState();
}

class _SelectAServiceScreenState extends State<SelectAServiceScreen> {
  //------------------------------------ Variables ----------------------------------//
  final List<String> selectServiceList = [
    StaticString.iamNotSure,
    StaticString.gasBoilerInstallation,
    StaticString.gasBoilerServiceRepair,
    StaticString.hotWaterTank,
    StaticString.oilFiredBoiler,
    StaticString.radiator,
    StaticString.solarPanelInstallation,
    StaticString.whatisThisRegarding,
  ];
  final int selectedOption = -1;

  @override
  void initState() {
    super.initState();
  }
//-------------------------------------- UI ---------------------------------------//

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          txtTitle: StaticString.selectAService1,
        ),
        backgroundColor: ColorConstants.custDarkPurple662851,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                //Alert Message Card
                _alertMsgCard(),
                const SizedBox(height: 10),
                //Radio ListTile and Button
                DarkGreenCommonRadiolistTile(
                  btnText: StaticString.selectThisService1,
                  btncolor: ColorConstants.custDarkGreen838500,
                  radioListTileList: selectServiceList,
                  onSelect: (val) {
                    widget.controller.text = val ?? "";
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

//--------------------------------- Alert Message Card -----------------------------/

  Widget _alertMsgCard() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ColorConstants.custGreyF8F8F8,
          ),
          child: Row(
            children: [
              const Expanded(
                child: CircleAvatar(
                  backgroundColor: ColorConstants.backgroundColorFFFFFF,
                  radius: 30,
                  child: CustImage(
                    imgURL: ImgName.postajobmaintenance,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 4,
                child: CustomText(
                  txtTitle: StaticString.selectAServiceAlertMessage,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
