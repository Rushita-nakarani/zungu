//------------------------------- Choose A Profession Screen ----------------------//

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/constant/string_constants.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/radiolist_tile_dark_green_widget.dart';

class ChooseAProfessionScreen extends StatefulWidget {
  const ChooseAProfessionScreen({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  State<ChooseAProfessionScreen> createState() =>
      _ChooseAProfessionScreenState();
}

class _ChooseAProfessionScreenState extends State<ChooseAProfessionScreen> {
  //------------------------------------ Variables ----------------------------------//

  List<String> chooseAProfessionList = [
    StaticString.bathroomFitter,
    StaticString.blacksmithMetalWorker,
    StaticString.gasHeatingEngineer,
    StaticString.builder,
    StaticString.cctvSatellite,
    StaticString.carpenter,
    StaticString.drainageSpecialist,
    StaticString.drivewayPavers
  ];

  int selectedOption = -1;
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
          txtTitle: StaticString.chooseAProfession,
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
                //Radio ListTile and Button
                DarkGreenCommonRadiolistTile(
                  btnText: StaticString.selectThisProfession,
                  btncolor: ColorConstants.custDarkGreen838500,
                  radioListTileList: chooseAProfessionList,
                  onSelect: (val) {
                    widget.controller.text = val ?? "";
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
