import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/landloard/attribute_info_model.dart';
import 'package:zungu_mobile/widgets/common_outline_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

import '../../../utils/custom_extension.dart';
import '../../../widgets/radiolist_tile_widget.dart';

class ReasonOFRejectPopup extends StatefulWidget {
  const ReasonOFRejectPopup({super.key});

  @override
  State<ReasonOFRejectPopup> createState() => _ReasonOFRejectPopupState();
}

class _ReasonOFRejectPopupState extends State<ReasonOFRejectPopup> {
  AttributeInfoModel? selectedOption;
  final TextEditingController otherReasonController = TextEditingController();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier _reasonNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: ColorConstants.custGrey707070,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          children: [
            _alertMsgCard(),
            const SizedBox(height: 30),
            CommonRadiolistTile(
              radioListTileList: [
                AttributeInfoModel(
                  attributeValue: StaticString.landlordNotResponsible,
                ),
                AttributeInfoModel(
                  attributeValue: StaticString.totFairWearTear,
                ),
                AttributeInfoModel(
                  attributeValue: StaticString.other,
                ),
              ],
              // btnText: StaticString.iAgree,
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
            const SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: _reasonNotifier,
              builder: (context, value, child) => Form(
                autovalidateMode: autovalidateMode,
                key: _formKey,
                child: TextFormField(
                  autovalidateMode: autovalidateMode,
                  validator: (value) => value?.emptyOtherReason,
                  decoration: const InputDecoration(
                    labelText: StaticString.otherReason,
                    hintText: StaticString.tennatResponsibleIsuue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            CommonOutlineElevatedButton(
              borderColor: Colors.red,
              bttnText: StaticString.rejectRequest,
              textColor: Colors.red,
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  autovalidateMode = AutovalidateMode.always;
                  _reasonNotifier.notifyListeners();
                  return;
                }
              },
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _alertMsgCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorConstants.custGreyF8F8F8,
      ),
      child: Row(
        children: [
          const Expanded(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              child: CustImage(
                imgURL: ImgName.rejectReason,
                height: 50,
                width: 50,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 3,
            child: CustomText(
              txtTitle: StaticString.reasonOfRejectionMsg,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custGrey707070,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
