import 'package:flutter/material.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';
import 'package:zungu_mobile/widgets/image_upload_widget.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../utils/custom_extension.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/date_selector.dart';
import '../../../../widgets/rich_text.dart';

class CompletedJobImageBottomSheet extends StatefulWidget {
  const CompletedJobImageBottomSheet({super.key});

  @override
  State<CompletedJobImageBottomSheet> createState() =>
      _CompletedJobImageBottomSheetState();
}

class _CompletedJobImageBottomSheetState
    extends State<CompletedJobImageBottomSheet> {
  //------------------------Variables-----------------------------//

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> photosVideoList = [];

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController _renewalDateController = TextEditingController();

  //------------------------UI------------------------------//

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Alert Message Card
              _alertMsgCard(),
              const SizedBox(height: 20),

              //Renewal Date Textfield
              _renewalDateTextField(),
              const SizedBox(height: 30),

              //Upload Photos/Doc Text
              CustomText(
                txtTitle: StaticString.uploadPhotosDoc,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(height: 10),

              //photos/Doc List
              // _imageListAndCameraImage(),
              UploadMediaWidget(
                images: [],
                image: ImgName.tradesmanCamera,
                userRole: UserRole.TRADESPERSON,
                imageList: (images) {
                  debugPrint(images.toString());
                },
              ),
              const SizedBox(height: 50),

              //------------------mark job as completed button------------//
              CommonElevatedButton(
                height: 40,
                bttnText: StaticString.completeJob.toUpperCase(),
                color: ColorConstants.custDarkTeal017781,
                onPressed: completedJobOntapAction,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Alert Msg card
  Widget _alertMsgCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.custGreyF8F8F8,
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: CustImage(
              imgURL: ImgName.gasSafty,
              height: 25,
              width: 25,
            ),
          ),
          Expanded(
            child: CustomRichText(
              title: StaticString.completedJobMsg1,
              fancyTextStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custDarkTeal017781,
                    fontWeight: FontWeight.w600,
                  ),
              normalTextStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custGrey707070,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          )
        ],
      ),
    );
  }

  //Renewal Date Textfield
  Widget _renewalDateTextField() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      onTap: () => selectDate(
        controller: _renewalDateController,
        color: ColorConstants.custDarkTeal017781,
      ),
      validator: (value) => value?.validateDateMessage,
      readOnly: true,
      controller: _renewalDateController,
      keyboardType: TextInputType.datetime,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: StaticString.renewalDate,
        suffixIcon: CustImage(
          width: 18,
          height: 18,
          imgURL: ImgName.greenCalender,
        ),
      ),
    );
  }

  //List of Image and camera option
  // Widget _imageListAndCameraImage() {
  //   return SizedBox(
  //     height: 80,
  //     child: ListView.builder(
  //       // padding: const EdgeInsets.symmetric(horizontal: 30),
  //       scrollDirection: Axis.horizontal,
  //       itemCount: photosVideoList.length + 1,
  //       shrinkWrap: true,
  //       itemBuilder: (context, index) {
  //         if (index == (photosVideoList.length)) {
  //           return ImagePickerButton(
  //             onImageSelected: (images) {
  //               if (images.isNotEmpty && mounted) {
  //                 setState(() {
  //                   photosVideoList.addAll(images);
  //                 });
  //               }
  //             },
  //             child: Container(
  //               height: 70,
  //               width: 70,
  //               margin: const EdgeInsets.symmetric(
  //                 horizontal: 5,
  //                 vertical: 5,
  //               ),
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(15),
  //                 color: ColorConstants.custlightwhitee,
  //                 border: Border.all(
  //                   color: ColorConstants.custGreyEBEAEA,
  //                   width: 0.2,
  //                 ),
  //               ),
  //               child: const Padding(
  //                 padding: EdgeInsets.all(10.0),
  //                 child: CustImage(
  //                   imgURL: ImgName.tradesmanCamera,
  //                 ),
  //               ),
  //             ),
  //           );
  //         }
  //         return ImageWithCrossIcon(
  //           padding: const EdgeInsets.only(right: 14, top: 5),
  //           imageIcon: ImgName.greenCrossIcon,
  //           onTap: () {
  //             setState(() {
  //               photosVideoList.removeAt(index);
  //             });
  //           },
  //           imgName: photosVideoList[index],
  //           top: 0,
  //           right: 10,
  //         );
  //       },
  //     ),
  //   );
  // }

  //----------------------Button Action------------------//

  // Mark job as button action
  void completedJobOntapAction() {
    if (mounted) {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      final FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }
  }
}
