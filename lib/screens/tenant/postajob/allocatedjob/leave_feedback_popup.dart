import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/rate_star.dart';

import '../../../../utils/custom_extension.dart';

class LeaveFeedbackPopup extends StatefulWidget {
  const LeaveFeedbackPopup({super.key});

  @override
  State<LeaveFeedbackPopup> createState() => _LeaveFeedbackPopupState();
}

class _LeaveFeedbackPopupState extends State<LeaveFeedbackPopup> {
  //------------------------Variables-----------------------------------------//

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController _reviewController = TextEditingController();
  double rating = 0.0;

  //------------------------UI------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _chooseYourRatingCard(),
            const SizedBox(height: 40),

            //Write Review Textfield
            _reviewTextField(),
            const SizedBox(height: 50),

            // Submit Feedback button
            CommonElevatedButton(
              height: 40,
              bttnText: StaticString.submit,
              color: ColorConstants.custDarkGreen838500,
              onPressed: submitFeedBackOntap,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  //-------------------------------Widgets------------------------------------//

  //Choose your rating
  Widget _chooseYourRatingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      decoration: BoxDecoration(
        color: ColorConstants.custPurple500472.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            txtTitle: StaticString.chooseYourRating,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custPurple500472,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 15),
          Align(
            child: StarRating(
              rating: rating,
              onRatingChanged: (rating1) {
                if (mounted) {
                  setState(() => rating = rating1);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  //Review Textfield
  Widget _reviewTextField() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.validatereview,
      controller: _reviewController,
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        labelText: StaticString.writeReview,
      ),
    );
  }

  //------------------------Button Action-------------------------------------//

  void submitFeedBackOntap() {
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
