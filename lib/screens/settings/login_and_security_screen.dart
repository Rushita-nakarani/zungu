// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../utils/custom_extension.dart';
import '../../constant/img_font_color_string.dart';
import '../../models/auth/auth_model.dart';
import '../../providers/auth/auth_provider.dart';
import '../../providers/auth/personal_profile_provider/personal_provider.dart';
import '../../screens/settings/personal_profile/edit_register_number_screen.dart';
import '../../widgets/common_elevated_button.dart';
import '../../widgets/custom_alert.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_title_with_line.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/scrollable_widget.dart';

class LoginAndSecurityScreen extends StatefulWidget {
  const LoginAndSecurityScreen({
    super.key,
  });

  @override
  State<LoginAndSecurityScreen> createState() => _LoginAndSecurityScreenState();
}

class _LoginAndSecurityScreenState extends State<LoginAndSecurityScreen> {
  //----------------------------Variables-----------------------------//

  //Edit Register Number Controller
  TextEditingController editRegisterNumberController = TextEditingController();
  //Pssword Controller
  final TextEditingController _passController = TextEditingController();
  // Form Key
  final formKey = GlobalKey<FormState>();
  // Auto validate Mode
  AutovalidateMode autovalidationMode = AutovalidateMode.disabled;
  // Auth model
  final AuthModel _authModel = AuthModel();
  // Loading Indicator Notifier
  final LoadingIndicatorNotifier _indicatorNotifier =
      LoadingIndicatorNotifier();

  //----------------------------UI-----------------------------//

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: keyboardhideOnTapAction,
      child: LoadingIndicator(
        loadingStatusNotifier: _indicatorNotifier,
        child: Scaffold(
          appBar: _appBar(),
          body: _buildBody(),
        ),
      ),
    );
  }
  //----------------------------Widget-----------------------------//

  //  appBar...
  AppBar _appBar() {
    return AppBar(
      title: const Text(
        StaticString.loginAndSecurity,
      ),
    );
  }

  // body...
  Widget _buildBody() {
    return GestureDetector(
      onTap: keyboardhideOnTapAction,
      child: SafeArea(
        child: BuildScrollableWidget(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              // Registered Number CardInfo...
              _registerNumberCardInfo(),
              const SizedBox(height: 40),

              // newNumber card Details...
              _newNumberCardDetail(),
              const SizedBox(height: 40),
              const Spacer(),

              // Change Password Elevated Button
              CommonElevatedButton(
                onPressed: sendVerificationBtnOnTap,
                bttnText: StaticString.changePassword,
                color: ColorConstants.custskyblue22CBFE,
              )
            ],
          ),
        ),
      ),
    );
  }

  // Registered Number CardInfo...
  Widget _registerNumberCardInfo() {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.backgroundColorFFFFFF,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.3),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          // Call Ring Icon Card
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(ImgName.callImage),
          ),
          const SizedBox(width: 10),

          // Registered Mobile Numbers text and number
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  txtTitle: StaticString.registerNumber,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 1),
                Consumer2<AuthProvider, PersonalProfileProvider>(
                  builder: (context, auth, profile, child) => CustomText(
                    txtTitle: profile.fetchUser?.mobile,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstants.custGrey7A7A7A,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                )
              ],
            ),
          ),

          // Edit Register Number Icon
          CustomText(
            onPressed: editRegisterNumberOntapButton,
            txtTitle: StaticString.edit,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custgreen19B445,
                  fontWeight: FontWeight.w500,
                ),
          )
        ],
      ),
    );
  }

  // newNumber card Details...
  Container _newNumberCardDetail() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.backgroundColorFFFFFF,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidationMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTitleWithLine(
                title: StaticString.changePassword,
                primaryColor: ColorConstants.custDarkBlue160935,
                secondaryColor: ColorConstants.custskyblue22CBFE,
              ),
              const SizedBox(height: 25),
              TextFormField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                validator: (value) => value?.validatePassword,
                decoration: const InputDecoration(
                  labelText: "${StaticString.oldPassword}*",
                ),
                onSaved: (pass) {
                  _authModel.oldPassword = pass ?? "";
                },
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                obscureText: true,
                controller: _passController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                validator: (value) => value?.validatePassword,
                decoration: const InputDecoration(
                  labelText: "${StaticString.newPassword}*",
                ),
                onSaved: (pass) {
                  _authModel.password = pass ?? "";
                },
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
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
                  _authModel.newPassword = pass ?? "";
                },
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  // Move to register ontap action...
  void editRegisterNumberOntapButton() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const EditRegisterNumberScreen(isFromSecurity: true),
      ),
    );
  }

  // keyboardHide onTapAction...
  void keyboardhideOnTapAction() {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  //----------------------------Button Action-----------------------------//

  // Send Verification Button Ontap
  Future<void> sendVerificationBtnOnTap() async {
    try {
      _indicatorNotifier.show();
      if (!formKey.currentState!.validate()) {
        autovalidationMode = AutovalidateMode.always;
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        return;
      }
      formKey.currentState!.save();
      await Provider.of<AuthProvider>(context, listen: false)
          .changePassword(_authModel);
      Navigator.of(context).pop();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _indicatorNotifier.hide();
    }
  }
}
