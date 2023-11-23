import 'package:flutter/material.dart';
import 'package:zungu_mobile/widgets/time_selector.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../utils/custom_extension.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/date_selector.dart';

class CompletedJobBottomSheet extends StatefulWidget {
  const CompletedJobBottomSheet({super.key});

  @override
  State<CompletedJobBottomSheet> createState() =>
      _CompletedJobBottomSheetState();
}

class _CompletedJobBottomSheetState extends State<CompletedJobBottomSheet> {
  //------------------------Variables-----------------------------//

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _contractorNoteController =
      TextEditingController();

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
            children: [
              //---------------Alert Message Card-------------//
              _alertMsgCard(),
              const SizedBox(height: 20),
              //---------------Date and Time Textfield Row-------------//

              Row(
                children: [
                  // From date textfield
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      scrollPadding: EdgeInsets.zero,
                      autovalidateMode: _autovalidateMode,
                      validator: (value) => value?.validateDateMessage,
                      controller: _dateController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        labelText: StaticString.fromDate,
                        suffixIcon: CustImage(
                          width: 20,
                          imgURL: ImgName.greenCalender,
                        ),
                      ),
                      onTap: () {
                        selectDate(
                          controller: _dateController,
                          color: ColorConstants.custDarkTeal017781,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),

                  // End date textfield
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      scrollPadding: EdgeInsets.zero,
                      autovalidateMode: _autovalidateMode,
                      validator: (value) => value?.validateTimeMessage,
                      controller: _timeController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        labelText: StaticString.endDate,
                        suffixIcon: Icon(Icons.access_time_rounded),
                      ),
                      onTap: () {
                        selectTime(
                          controller: _timeController,
                          color: ColorConstants.custDarkTeal017781,
                        );
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 45),

              //--------------Contractor Notes TextField------------//
              TextFormField(
                autovalidateMode: _autovalidateMode,
                validator: (value) => value?.validateEmpty,
                controller: _contractorNoteController,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: StaticString.contractorNotes,
                ),
              ),
              const SizedBox(height: 40),

              //------------------mark job as completed button------------//
              CommonElevatedButton(
                height: 40,
                bttnText: StaticString.markJobAsCompleted,
                fontSize: 14,
                color: ColorConstants.custDarkTeal017781,
                onPressed: markJobAsCompletedBtnAction,
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const CustImage(
              imgURL: ImgName.completedJob,
            ),
          ),
          Expanded(
            child: CustomText(
              txtTitle: StaticString.completeJobMsg,
              maxLine: 2,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: ColorConstants.custGrey707070),
            ),
          )
        ],
      ),
    );
  }

  //----------------------Button Action------------------//

  // Mark job as button action
  void markJobAsCompletedBtnAction() {
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
