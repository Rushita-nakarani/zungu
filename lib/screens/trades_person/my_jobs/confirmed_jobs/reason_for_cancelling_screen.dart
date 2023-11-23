import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/landloard/attribute_info_model.dart';

import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/radiolist_tile_widget.dart';

class ReasonOfCancellingScreen extends StatefulWidget {
  const ReasonOfCancellingScreen({super.key});

  @override
  State<ReasonOfCancellingScreen> createState() =>
      _ReasonOfCancellingScreenState();
}

class _ReasonOfCancellingScreenState extends State<ReasonOfCancellingScreen> {
  //------------------------------Variable-------------------------//
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
      backgroundColor: ColorConstants.custDarkTeal017781,
      title: const Text(StaticString.tradesPersonservice),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            txtTitle: StaticString.cancelJobMsg,
            align: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey707070,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 10),
          CustomText(
            align: TextAlign.center,
            txtTitle: StaticString.cancelJobMsg1,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey707070,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
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
              _alertMsgCard(),

              CommonRadiolistTile(
                divider: true,
                radioListTileList: [
                  AttributeInfoModel(
                    attributeValue: StaticString.materialPartsNotavailable,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.clientRequesttoCancel,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.couldntReachAnAgreement,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.jobPostedNotAsDescribed,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.imnoLongerAvailable,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.other,
                  ),
                ],
                btncolor: ColorConstants.custskyblue22CBFE,
                radioColor: ColorConstants.custDarkTeal017781,
                onSelect: (val) {
                  if (mounted) {
                    setState(() {
                      selectedOption = val;
                    });
                  }
                },
              ),
              const SizedBox(height: 40),

              //---------------------------Note: This will be sent to the client text -------------------------------//

              CustomText(
                txtTitle:
                    "${StaticString.note}${" "}${StaticString.thisWillBeSentToTheClient}",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: ColorConstants.custGrey999999,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 25),

              //----------------------Cancel this job button------------------//

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CommonElevatedButton(
                  bttnText: StaticString.cancelthisJob,
                  color: ColorConstants.custDarkTeal017781,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
