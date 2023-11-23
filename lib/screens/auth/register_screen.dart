// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/img_font_color_string.dart';
import '../../models/auth/auth_model.dart';
import '../../providers/auth/auth_provider.dart';
import '../../screens/auth/verfiy_mobile_number_screen.dart';
import '../../utils/custom_extension.dart';
import '../../widgets/common_elevated_button.dart';
import '../../widgets/cust_image.dart';
import '../../widgets/custom_alert.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/rich_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //---------------------------Variables------------------------//

  // Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Auto validate mode
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  // Signin Notifier
  final ValueNotifier _signInNotifier = ValueNotifier(true);
  // Auth Model
  final AuthModel _authModel = AuthModel();
  // Loading Indicator
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  //-----------------------------UI------------------------------//

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => keyBoardHieOntap(),
      child: LoadingIndicator(
        loadingStatusNotifier: _loadingIndicatorNotifier,
        child: Scaffold(
          body: _buildBody(),
        ),
      ),
    );
  }

  //-----------------------------Widget-----------------------------//

  //Body
  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            // Backgroung circle Image
            _buildBackgroundImage(),

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

                        // Create New Account Text
                        _buildCreateNewAccount(),
                        const SizedBox(height: 20),

                        // Sub title Text
                        _buildSubtitle(),
                        const SizedBox(height: 40),

                        // Full name TextField
                        _buildFullnameTextField(),
                        const SizedBox(height: 20),

                        // Mobile number
                        _buildMobileNumberTextField(),
                        const SizedBox(height: 60),

                        // Sign in button
                        _buildSignUpButton(),

                        const SizedBox(
                          height: 24,
                        ),

                        // Don`t have an account? Sign up
                        _buildAlreadyHaveAnAccount(),
                        const SizedBox(
                          height: 24,
                        ),
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
  Positioned _buildBackgroundImage() {
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

  // Create New Account Text
  CustomText _buildCreateNewAccount() {
    return const CustomText(
      txtTitle: StaticString.createNewAccount,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: ColorConstants.custBlue1BC4F4,
      ),
    );
  }

  // Sub Title Text
  CustomText _buildSubtitle() {
    return const CustomText(
      txtTitle: StaticString.pleaseenterFollowingDetail,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: ColorConstants.custDarkPurple160935,
      ),
    );
  }

  // Full Name TextField
  TextFormField _buildFullnameTextField() {
    return TextFormField(
      validator: (value) => value?.validateYourName,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: "${StaticString.fullName}*",
      ),
      onSaved: (name) {
        _authModel.fullName = name ?? "";
      },
    );
  }

  // Mobile Number TextField
  TextFormField _buildMobileNumberTextField() {
    return TextFormField(
      validator: (value) => value?.validatePhoneNumber,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      textInputAction: TextInputAction.done,
      decoration: commonImputdecoration(
        labletext: StaticString.mobileNumber,
      ),
      onSaved: (mobile) {
        _authModel.mobile = mobile ?? "";
      },
    );
  }

  // SignUp Elaveted button
  Widget _buildSignUpButton() {
    return CommonElevatedButton(
      bttnText: StaticString.continu,
      onPressed: () => signUpButtonAction(),
    );
  }

  // Already have an account? Sign In
  Widget _buildAlreadyHaveAnAccount() {
    return Align(
      child: CustomRichText(
        title: StaticString.alreadyHaveAnAccount,
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
        onTap: (val) => gotoSigninButton(),
      ),
    );
  }

  // ---------------------- Helper widgets ----------------------//

  // common Input Decoration
  InputDecoration commonImputdecoration({required String labletext}) {
    return InputDecoration(
      counterText: "",
      labelText: labletext,
    );
  }

  //------------------------- Button action -------------------------//

  // Key Board  Hide On tap
  void keyBoardHieOntap() {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  // Sign Up Btn Action
  Future<void> signUpButtonAction() async {
    try {
      _loadingIndicatorNotifier.show();
      if (!(_formKey.currentState?.validate() ?? true)) {
        _autovalidateMode = AutovalidateMode.always;

        _signInNotifier.notifyListeners();
        return;
      }
      _formKey.currentState?.save();
      keyBoardHieOntap();
      final String token =
          await Provider.of<AuthProvider>(context, listen: false)
              .generateOTP(_authModel);
      _authModel.token = token;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => VerfiyMobileNumberScreen(auth: _authModel),
        ),
      );
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  // Go to Sign in Button Ontap
  void gotoSigninButton() {
    Navigator.of(context).pop();
  }
}
