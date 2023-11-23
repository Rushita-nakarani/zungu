// ignore_for_file: use_build_context_synchronously, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/main.dart';

import '../../constant/img_font_color_string.dart';
import '../../models/auth/auth_model.dart';
import '../../providers/auth/auth_provider.dart';
import '../../providers/auth/personal_profile_provider/personal_provider.dart';
import '../../screens/auth/set_password_screen.dart';
import '../../widgets/common_elevated_button.dart';
import '../../widgets/cust_image.dart';
import '../../widgets/custom_alert.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/rich_text.dart';

// ignore: must_be_immutable
class ResetPasswordScreen extends StatefulWidget {
  final bool isFromSecurity;
  final AuthModel auth;
  const ResetPasswordScreen({
    Key? key,
    this.isFromSecurity = false,
    required this.auth,
  }) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  //------------------------------Variables-------------------------//
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Autovalidate Mode
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  // Sign In Notifier
  final ValueNotifier _signInNotifier = ValueNotifier(true);

  //Loading Indicator
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  AuthProvider get getAuthProvider =>
      Provider.of<AuthProvider>(getContext, listen: false);

  PersonalProfileProvider get getPersonalProvider =>
      Provider.of<PersonalProfileProvider>(getContext, listen: false);

  //------------------------------UI----------------------------//
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => keyBoardHieOntap(),
      child: LoadingIndicator(
        loadingStatusNotifier: _loadingIndicatorNotifier,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: _buildBody(),
        ),
      ),
    );
  }

  //------------------------------Widgets----------------------------//
  Widget _buildBody() {
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

                        // Reset Password Text
                        _buildresetPasswordText(),
                        const SizedBox(height: 20),

                        // Sub title text
                        _buildSubtitle(),
                        const SizedBox(height: 50),

                        _enterCodeTExt(),
                        const SizedBox(height: 10),

                        // Otp TextField
                        _buildOtpTextField(),
                        const SizedBox(height: 50),

                        // Verification Code Button
                        _buildVerificationCodeButton(),
                        const SizedBox(height: 25),

                        // Didn’t receive any code? Resend
                        _buildDidntReceivedCodeText(),
                        const SizedBox(height: 25),
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
  Widget _buildBackgroundImage(BuildContext context) {
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
    return CustomText(
      txtTitle: widget.isFromSecurity
          ? StaticString.newMobileNumbers
          : StaticString.resetPassword,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: ColorConstants.custBlue1BC4F4,
      ),
    );
  }

  // SubTitle Text
  Widget _buildSubtitle() {
    return const CustomText(
      txtTitle: StaticString.enterTheverification,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  // Enter Code Text
  Widget _enterCodeTExt() {
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

  // Otp TextField
  Widget _buildOtpTextField() {
    return SizedBox(
      height: 54,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: FittedBox(
              child: OtpTextField(
                numberOfFields: 6,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                autoFocus: true,
                fieldWidth: 54,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderColor: ColorConstants.custGrey707070,
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) => otpTextFieldOntap(
                  verificationCode,
                ), // end onSubmit
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Sign in button
  Widget _buildVerificationCodeButton() {
    return CommonElevatedButton(
      bttnText: StaticString.verifyCode,
      onPressed: () => sendCodeButtonAction(context),
    );
  }

  // Didn’t receive any code? Resend
  Widget _buildDidntReceivedCodeText() {
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
          resendCodeButtonAction();
        },
      ),
    );
  }

  //------------------------- Button action -------------------------//
  void keyBoardHieOntap() {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void otpTextFieldOntap(
    String verificationCode,
  ) {
    widget.auth.otp = verificationCode;
    sendCodeButtonAction(context);
  }

  Future<void> sendCodeButtonAction(BuildContext context) async {
    try {
      _loadingIndicatorNotifier.show();
      if (!(_formKey.currentState?.validate() ?? true)) {
        _autovalidateMode = AutovalidateMode.always;

        _signInNotifier.notifyListeners();
        return;
      }
      if (widget.auth.otp.length < 6) {
        throw AlertMessageString.validyCode;
      }

      widget.auth.id = await Provider.of<AuthProvider>(context, listen: false)
          .verfiyOTP(widget.auth);
      if (widget.isFromSecurity) {
        await Provider.of<AuthProvider>(context, listen: false)
            .numberChange(widget.auth);
        Provider.of<PersonalProfileProvider>(context, listen: false)
            .fetchUserDetails();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => SetPasswordScreen(authModel: widget.auth),
          ),
        );
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  Future<void> resendCodeButtonAction() async {
    try {
      _loadingIndicatorNotifier.show();
      final String token =
          await Provider.of<AuthProvider>(context, listen: false)
              .generateOTP(widget.auth);
      widget.auth.token = token;
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
