// ignore_for_file: must_be_immutable, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../screens/auth/forgot_password_screen.dart';
import '../../../screens/auth/register_screen.dart';
import '../../constant/img_font_color_string.dart';
import '../../models/auth/auth_model.dart';
import '../../providers/auth/auth_provider.dart';
import '../../utils/custom_extension.dart';
import '../../widgets/common_elevated_button.dart';
import '../../widgets/cust_image.dart';
import '../../widgets/custom_alert.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/rich_text.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  //-----------------------------Variables----------------------//

  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // auto validate Mode
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  //Sign In Notifier
  final ValueNotifier _signInNotifier = ValueNotifier(true);
  // Auth Model
  final AuthModel _authModel = AuthModel();

  // Loading Indicator
  final LoadingIndicatorNotifier _indicatorNotifier =
      LoadingIndicatorNotifier();

  //-----------------------------UI------------------------//

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _indicatorNotifier,
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  //-----------------------------Widget----------------------//

  // Body
  Widget _buildBody(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => keyBoardHieOntap(context),
      child: SingleChildScrollView(
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

                          // Welcome back
                          _buildWelcomeBack(),
                          const SizedBox(height: 20),

                          // sub title
                          _buildSubtitle(context),
                          const SizedBox(height: 40),

                          // Mobile number
                          _buildMobileNumber(),
                          const SizedBox(height: 20),

                          // Password
                          _buildPasswordField(),

                          // Forgot password button
                          _buildForgotPasswordButton(context),
                          const SizedBox(height: 24),

                          // Sign in button
                          _buildSignInButton(context),
                          const SizedBox(height: 24),

                          // Don`t have an account? Sign up
                          _buildDontHaveAccountText(context),
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

  // Welcome Back Text
  CustomText _buildWelcomeBack() {
    return const CustomText(
      txtTitle: StaticString.welcomeBack,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: ColorConstants.custBlue1BC4F4,
      ),
    );
  }

  // Sub Title Text
  CustomText _buildSubtitle(BuildContext context) {
    return CustomText(
      txtTitle: StaticString.pleaseEnter,
      style: Theme.of(context).textTheme.headline2?.copyWith(
            fontWeight: FontWeight.w400,
            color: ColorConstants.custDarkPurple160935,
          ),
    );
  }

  // Mobile Number TextField
  Widget _buildMobileNumber() {
    return TextFormField(
      validator: (value) => value?.validatePhoneNumber,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      autofocus: true,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.mobileNumber,
      ),
      onSaved: (mobile) {
        _authModel.mobile = mobile ?? "";
      },
    );
  }

  // Password TextField
  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      validator: (value) => value?.validatePassword,
      decoration: commonImputdecoration(
        labletext: "${StaticString.password}*",
      ),
      onSaved: (password) {
        _authModel.password = password ?? "";
      },
    );
  }

// Forgot password button
  Widget _buildForgotPasswordButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomText(
          btnTextAlignment: Alignment.centerRight,
          onPressed: () => forgotPasswordButtonAction(context),
          txtTitle: StaticString.forgotPassword,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: ColorConstants.custBlue1BC4F4,
          ),
        ),
      ],
    );
  }

  // Sign in Elaveted button
  Widget _buildSignInButton(BuildContext context) {
    return CommonElevatedButton(
      bttnText: StaticString.signIn,
      onPressed: () => signInButtonAction(context),
    );
  }

  // Don`t have an account? Sign up
  Widget _buildDontHaveAccountText(BuildContext context) {
    return Align(
      child: CustomRichText(
        title: StaticString.dontHaveAnAccount,
        normalTextStyle: Theme.of(context).textTheme.headline1?.copyWith(
              color: ColorConstants.custDarkPurple160935,
              fontWeight: FontWeight.w600,
            ),
        fancyTextStyle: Theme.of(context).textTheme.headline1?.copyWith(
              color: ColorConstants.custBlue1BC4F4,
              fontWeight: FontWeight.w600,
            ),
        onTap: (val) {
          gotoSignupButton(context);
        },
      ),
    );
  }

  // ---------------------- Helper widgets ----------------------

  InputDecoration commonImputdecoration({required String labletext}) {
    return InputDecoration(
      counterText: "",
      labelText: labletext,
    );
  }

  //------------------------- Button action -------------------------

  // Key Board  Hide On tap
  void keyBoardHieOntap(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  // Sign In Button action
  Future<void> signInButtonAction(BuildContext context) async {
    try {
      _indicatorNotifier.show();
      if (!(_formKey.currentState?.validate() ?? true)) {
        _autovalidateMode = AutovalidateMode.always;

        _signInNotifier.notifyListeners();
        return;
      }
      _formKey.currentState?.save();
      keyBoardHieOntap(context);
      await Provider.of<AuthProvider>(context, listen: false).login(_authModel);
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _indicatorNotifier.hide();
    }
  }

  //Forgot PAssword Ontap
  void forgotPasswordButtonAction(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordScreen(),
      ),
    );
  }

  // Sign Up Button Action
  void gotoSignupButton(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  }
}
