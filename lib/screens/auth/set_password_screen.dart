// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/color_constants.dart';
import '../../constant/img_constants.dart';
import '../../constant/string_constants.dart';
import '../../models/auth/auth_model.dart';
import '../../providers/auth/auth_provider.dart';
import '../../utils/custom_extension.dart';
import '../../widgets/common_elevated_button.dart';
import '../../widgets/cust_image.dart';
import '../../widgets/custom_alert.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/loading_indicator.dart';

class SetPasswordScreen extends StatefulWidget {
  final AuthModel authModel;
  const SetPasswordScreen({Key? key, required this.authModel})
      : super(key: key);

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  //--------------------------Variables----------------------------//

  //Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Auto validate mode
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  // Sign in Notifier
  final ValueNotifier _signInNotifier = ValueNotifier(true);
  // Pass word Controller
  final TextEditingController _passController = TextEditingController();
  // Loading Indicator
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  //-----------------------------UI------------------------------//

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: keyBoardHieOntap,
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

  //-----------------------------UI------------------------------//

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
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 5.8,
                        ),

                        // Reset PAssword Text
                        _buildresetPasswordText(),
                        const SizedBox(height: 20),

                        // SubTitle Text
                        _buildSubtitle(),
                        const SizedBox(height: 50),

                        // Pass Word Textfield
                        _passwordTextfield(),
                        const SizedBox(height: 24),

                        // Confirmed Password Textfield
                        _confirmedPasswordTextfield(),
                        const SizedBox(height: 50),

                        // Sign up Button
                        _buildSignUpButton(),
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

  // Background Image
  Widget _buildBackgroundImage() {
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

  // Reset PAssword Text
  Widget _buildresetPasswordText() {
    return const CustomText(
      txtTitle: StaticString.setPassword,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: ColorConstants.custBlue1BC4F4,
      ),
    );
  }

  // SubTitle Text
  Widget _buildSubtitle() {
    return const CustomText(
      txtTitle: StaticString.setPasswordDec,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  // Password Textfield
  Widget _passwordTextfield() {
    return TextFormField(
      obscureText: true,
      controller: _passController,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      validator: (value) => value?.validatePassword,
      decoration: const InputDecoration(
        labelText: "${StaticString.password}*",
      ),
      onSaved: (pass) {
        widget.authModel.password = pass ?? "";
      },
    );
  }

  // Confirmed Password Textfield
  Widget _confirmedPasswordTextfield() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      validator: (value) => value?.validateConfrimPassword(
        confrimPasswordVal: _passController.text,
      ),
      decoration: const InputDecoration(
        labelText: "${StaticString.confrimPassword}*",
      ),
      onSaved: (pass) {
        widget.authModel.newPassword = pass ?? "";
      },
    );
  }

  // Sign up Button
  Widget _buildSignUpButton() {
    return CommonElevatedButton(
      bttnText: (widget.authModel.fullName.isEmpty)
          ? StaticString.forgotpassword
          : StaticString.signUp,
      onPressed: signUpButtonAction,
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

  // Sign up Button Action
  Future<void> signUpButtonAction() async {
    try {
      _loadingIndicatorNotifier.show();
      if (!(_formKey.currentState?.validate() ?? true)) {
        _autovalidateMode = AutovalidateMode.always;

        _signInNotifier.notifyListeners();
        return;
      }
      _formKey.currentState?.save();
      if (widget.authModel.fullName.isEmpty) {
        await Provider.of<AuthProvider>(context, listen: false)
            .forgotPassword(widget.authModel);
      } else {
        await Provider.of<AuthProvider>(context, listen: false)
            .signUp(widget.authModel);
      }
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
