import 'package:flutter/material.dart';
import 'package:zungu_mobile/widgets/common_widget.dart';

import '../../constant/color_constants.dart';
import '../../constant/string_constants.dart';
import '../../widgets/common_elevated_button.dart';
import '../../widgets/custom_text.dart';

class LandlordAddDescriptionScreen extends StatefulWidget {
  final String descriptionText;
  const LandlordAddDescriptionScreen({required this.descriptionText});

  @override
  State<LandlordAddDescriptionScreen> createState() =>
      _LandlordAddDescriptionScreenState();
}

class _LandlordAddDescriptionScreenState
    extends State<LandlordAddDescriptionScreen> {
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.descriptionText.isNotEmpty) {
      descriptionController.text = widget.descriptionText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonHeaderLable(
                  title: StaticString.addDescription,
                  spaceBetween: 26,
                  child: _buildDescriptionField(context),
                ),
                const SizedBox(
                  height: 46,
                ),
                CommonElevatedButton(
                  bttnText: StaticString.save,
                  onPressed: () {
                    final FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    Navigator.of(context).pop(descriptionController.text);
                  },
                  fontSize: 14,
                  color: ColorConstants.custBlue1EC0EF,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorConstants.custDarkPurple500472,
      title: const CustomText(
        txtTitle: "Add Property",
      ),
    );
    // style: Theme.of(context).textTheme.headline3?.copyWith(
    //       color: Colors.white,
    //       fontWeight: FontWeight.w600,
    //     ),
  }

  TextFormField _buildDescriptionField(BuildContext context) {
    return TextFormField(
      controller: descriptionController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      maxLines: 5,
      style: Theme.of(context).textTheme.headline2?.copyWith(
            color: ColorConstants.custGrey707070,
            fontWeight: FontWeight.w500,
          ),
      decoration: commonImputdecoration(
        labletext: "${StaticString.enterDescription}*",
      ),
    );
  }

  InputDecoration commonImputdecoration({required String labletext}) {
    return InputDecoration(
      counterText: "",
      labelText: labletext,
    );
  }
}
