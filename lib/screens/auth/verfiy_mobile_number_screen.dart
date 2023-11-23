// ignore_for_file: use_build_context_synchronously, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/models/auth/auth_model.dart';
import 'package:zungu_mobile/providers/auth/auth_provider.dart';
import 'package:zungu_mobile/screens/auth/set_password_screen.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';

import '../../constant/img_font_color_string.dart';
import '../../widgets/common_elevated_button.dart';
import '../../widgets/cust_image.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/rich_text.dart';

class VerfiyMobileNumberScreen extends StatelessWidget {
  final AuthModel auth;
  VerfiyMobileNumberScreen({
    Key? key,
    required this.auth,
  }) : super(key: key);

  //---------------------------- Variables-----------------------//

  //Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Auto validate mode
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  // Sign in Notifier
  final ValueNotifier _signInNotifier = ValueNotifier(true);
  // Loading Indicator
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  //---------------------------- UI------------------------------//

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => keyBoardHieOntap(context),
      child: LoadingIndicator(
        loadingStatusNotifier: _loadingIndicatorNotifier,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: _buildBody(context),
        ),
      ),
    );
  }
  //---------------------------- Widget------------------------------//

  //Body
  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Stack(
          children: [
            // Backgroung circle Image
            _buildBackgroundImage(context),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ValueListenableBuilder(
                valueListenable: _signInNotifier,
                builder: (context, val, child) {
                  return Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 5.8,
                        ),

                        //Reset Password Text
                        _buildresetPasswordText(),
                        const SizedBox(height: 20),

                        // Sub title text
                        _buildSubtitle(),
                        const SizedBox(height: 50),

                        // Enter Code Text
                        _entercodeText(),
                        const SizedBox(height: 10),

                        // Otp Textfield
                        _buildOtpField(context),
                        const SizedBox(height: 50),

                        // Verification Code button
                        _buildVerificationCodeButton(context),
                        const SizedBox(height: 24),

                        // Didn’t receive any code? Resend code Text
                        _buildDidntReceivedCodeText(context),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Backgroung circle Image
  Positioned _buildBackgroundImage(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: SafeArea(
        child: CustImage(
          imgURL: ImgName.authBgCircle,
          height: MediaQuery.of(context).size.height / 4.5,
        ),
      ),
    );
  }

  // Reset Password Text
  Widget _buildresetPasswordText() {
    return const CustomText(
      txtTitle: StaticString.verfiyMobileNumber,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: ColorConstants.custBlue1BC4F4,
      ),
    );
  }

  // sub Title Text
  Widget _buildSubtitle() {
    return const CustomText(
      txtTitle: StaticString.enterTheverification,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: ColorConstants.custDarkPurple160935,
      ),
    );
  }

  // Enter Code Text
  Widget _entercodeText() {
    return const Padding(
      padding: EdgeInsets.only(left: 10),
      child: CustomText(
        txtTitle: StaticString.enterCode,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: ColorConstants.custGrey707070,
        ),
      ),
    );
  }

  // Otep Textfield
  Widget _buildOtpField(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: FittedBox(
            child: OtpTextField(
              numberOfFields: 6,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              autoFocus: true,
              fieldWidth: 54,
              cursorColor: ColorConstants.custDarkPurple160935,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderColor: ColorConstants.custGrey707070,
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,

              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) {
                auth.otp = verificationCode;
                sendCodeButtonAction(context);
              }, // end onSubmit
            ),
          ),
        ),
      ],
    );
  }

  // Sign in button
  Widget _buildVerificationCodeButton(BuildContext context) {
    return CommonElevatedButton(
      bttnText: StaticString.verifyCode,
      onPressed: () => sendCodeButtonAction(context),
    );
  }

  // Didn’t receive any code? Resend code Text
  Widget _buildDidntReceivedCodeText(BuildContext context) {
    return Align(
      child: CustomRichText(
        title: StaticString.didntReceiveAnyCode,
        normalTextStyle: const TextStyle(
          fontSize: 18,
          color: ColorConstants.custDarkPurple160935,
          fontWeight: FontWeight.w600,
        ),
        fancyTextStyle: const TextStyle(
          fontSize: 18,
          color: ColorConstants.custBlue1BC4F4,
          fontWeight: FontWeight.w600,
        ),
        onTap: (val) {
          resendCodeButtonAction(context);
        },
      ),
    );
  }

  //------------------------- Button action -------------------------//

  // Key Board  Hide On tap
  void keyBoardHieOntap(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  // Send Code Button Action
  Future<void> sendCodeButtonAction(BuildContext context) async {
    try {
      _loadingIndicatorNotifier.show();
      if (!(_formKey.currentState?.validate() ?? true)) {
        _autovalidateMode = AutovalidateMode.always;

        // ignore: invalid_use_of_visible_for_testing_member
        _signInNotifier.notifyListeners();
        return;
      }
      if (auth.otp.length < 6) {
        throw AlertMessageString.validyCode;
      }
      keyBoardHieOntap(context);
      auth.id = await Provider.of<AuthProvider>(context, listen: false)
          .verfiyOTP(auth);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => SetPasswordScreen(authModel: auth),
        ),
      );
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  // Resend Code Button Action
  Future<void> resendCodeButtonAction(BuildContext context) async {
    try {
      _loadingIndicatorNotifier.show();
      final String token =
          await Provider.of<AuthProvider>(context, listen: false)
              .generateOTP(auth);
      auth.token = token;
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
