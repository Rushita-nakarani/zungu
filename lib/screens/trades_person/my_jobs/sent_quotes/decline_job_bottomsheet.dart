import 'package:flutter/material.dart';
import 'package:zungu_mobile/models/landloard/attribute_info_model.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/radiolist_tile_widget.dart';

class DeclineJobBottomsheet extends StatefulWidget {
  const DeclineJobBottomsheet({super.key});

  @override
  State<DeclineJobBottomsheet> createState() => _DeclineJobBottomsheetState();
}

class _DeclineJobBottomsheetState extends State<DeclineJobBottomsheet> {
  AttributeInfoModel? selectedOption;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(
          20,
          // bottom: MediaQuery.of(context).viewInsets.bottom / 3,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: ColorConstants.custLightGreyB9B9B9,
            disabledColor: ColorConstants.custBlue1EC0EF,
          ),
          child: Column(
            children: [
              // Close button and Decline allocated job text row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: closeBtnAction,
                    icon: const CustImage(
                      imgURL: ImgName.closeIcon,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: CustomText(
                      align: TextAlign.center,
                      txtTitle: StaticString.declineAllocatedJob,
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.custDarkTeal017781,
                          ),
                    ),
                  ),
                  Expanded(child: Container())
                ],
              ),
              const SizedBox(height: 20),

              //------------------Decline allocated job msg-----------------//
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 17),
                decoration: BoxDecoration(
                  color: ColorConstants.custGreyF8F8F8,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CustomText(
                  txtTitle: StaticString.declineJobMsg,
                  align: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: ColorConstants.custGrey707070),
                ),
              ),
              const SizedBox(height: 20),

              CommonRadiolistTile(
                radioColor: ColorConstants.custDarkTeal017781,
                radioListTileList: [
                  AttributeInfoModel(
                    attributeValue: StaticString.imnoLongeravailable,
                  ),
                  AttributeInfoModel(
                    attributeValue: StaticString.tooktooLongtoAcceptQuote,
                  ),
                ],
                btnText: StaticString.iAgree,
                btncolor: ColorConstants.custDarkTeal017781,
                divider: true,
                onSelect: (val) {
                  if (mounted) {
                    setState(() {
                      selectedOption = val;
                    });
                  }
                  Navigator.of(context).pop(selectedOption);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //----------------------------- buttton action---------------------------//
  void closeBtnAction() {
    Navigator.of(context).pop();
  }

  void iAgreeBtnAction() {}
}
