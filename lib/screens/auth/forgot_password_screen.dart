// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/img_font_color_string.dart';
import '../../models/auth/auth_model.dart';
import '../../providers/auth/auth_provider.dart';
import '../../screens/auth/reset_password_screen.dart';
import '../../utils/custom_extension.dart';
import '../../widgets/common_elevated_button.dart';
import '../../widgets/cust_image.dart';
import '../../widgets/custom_alert.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/loading_indicator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  //--------------------------Variables-----------------------//

  // Auth Model
  final AuthModel _authModel = AuthModel();
  //Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //Sign In Notifier
  final ValueNotifier _signInNotifier = ValueNotifier(true);
  //Auto validation mode
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  // Loading Indicator
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  //--------------------------UI-----------------------//
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: keyBoardHieOntap,
      child: LoadingIndicator(
        loadingStatusNotifier: _loadingIndicatorNotifier,
        child: Scaffold(
          appBar: _buildAppbar(),
          body: _buildBody(),
        ),
      ),
    );
  }
  //--------------------------Widgets-----------------------//

  // App bar
  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  // Body
  Widget _buildBody() {
    return SingleChildScrollView(
      child: SafeArea(
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
                        const SizedBox(
                          height: 160,
                        ),

                        // Forget Password text
                        _buildForgetPasswordText(),
                        const SizedBox(height: 20),

                        //Forget Password sub title text
                        _buildSubtitle(context),
                        const SizedBox(height: 40),

                        // Mobile number
                        _buildMobileNumber(),
                        const SizedBox(height: 60),

                        // Send Code button
                        _buildSendCodeButton(context),
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
  Positioned _buildBackgroundImage() {
    return const Positioned(
      top: 0,
      right: 0,
      child: SafeArea(
        child: CustImage(
          imgURL: ImgName.authBgCircle,
          height: 196,
        ),
      ),
    );
  }

  // Forget Password text
  CustomText _buildForgetPasswordText() {
    return const CustomText(
      txtTitle: StaticString.forgotPasswordSplit,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: ColorConstants.custBlue1BC4F4,
      ),
    );
  }

  //Forget Password sub title text
  CustomText _buildSubtitle(BuildContext context) {
    return CustomText(
      txtTitle: StaticString.enterTheMobileNumber,
      style: Theme.of(context).textTheme.headline2?.copyWith(
            fontWeight: FontWeight.w400,
            color: ColorConstants.custDarkPurple160935,
          ),
    );
  }

  // Mobile Number RextField
  TextFormField _buildMobileNumber() {
    return TextFormField(
      validator: (value) => value?.validatePhoneNumber,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        counterText: "",
        labelText: StaticString.mobileNumber,
      ),
      onSaved: (mobile) {
        _authModel.mobile = mobile ?? "";
      },
    );
  }

  // Send Code button
  Widget _buildSendCodeButton(BuildContext context) {
    return CommonElevatedButton(
      bttnText: StaticString.sendCode,
      onPressed: () => sendCodeButtonAction(context),
    );
  }

  //------------------------- Button action ------------------------//

  // Key Board  Hide On tap
  void keyBoardHieOntap() {
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

        _signInNotifier.notifyListeners();
        return;
      }
      _formKey.currentState?.save();
      _authModel.type = 2;
      final String token =
          await Provider.of<AuthProvider>(context, listen: false)
              .generateOTP(_authModel);
      _authModel.token = token;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResetPasswordScreen(auth: _authModel),
        ),
      );
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
