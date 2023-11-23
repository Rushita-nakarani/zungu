import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/auth/auth_model.dart';
import 'package:zungu_mobile/providers/auth/personal_profile_provider/personal_provider.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/custom_title_with_line.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';
import 'package:zungu_mobile/widgets/scrollable_widget.dart';

import '../../../models/settings/personal_profile/user_profile_model.dart';
import '../../../providers/auth/auth_provider.dart';
import '../../../utils/custom_extension.dart';
import '../../auth/reset_password_screen.dart';

class EditRegisterNumberScreen extends StatefulWidget {
  final UserProfileModel? userData;
  final bool isFromSecurity;
  const EditRegisterNumberScreen({
    super.key,
    this.isFromSecurity = false,
    this.userData,
  });

  @override
  State<EditRegisterNumberScreen> createState() =>
      _EditRegisterNumberScreenState();
}

class _EditRegisterNumberScreenState extends State<EditRegisterNumberScreen> {
  // Variables--------//
  TextEditingController editRegisterNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidationMode = AutovalidateMode.disabled;
  final AuthModel _authModel = AuthModel();
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: GestureDetector(
        onTap: keyboardHideOntap,
        child: Scaffold(
          appBar: _appBar(),
          body: _buildBody(context),
        ),
      ),
    );
  }

  // Appbar...
  AppBar _appBar() {
    return AppBar(
      title: Text(
        widget.isFromSecurity
            ? StaticString.loginAndSecurity
            : StaticString.editRegisterNumber,
      ),
    );
  }

// body...
  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: BuildScrollableWidget(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            _registerNumberCardInfo(),
            const SizedBox(height: 40),
            _newNumberCardDetail(context),
            const SizedBox(height: 40),
            const Spacer(),
            CommonElevatedButton(
              onPressed: () {
                sendVerificationBtnOnTap();
              },
              bttnText: StaticString.sendVerificationCode,
              color: ColorConstants.custskyblue22CBFE,
            )
          ],
        ),
      ),
    );
  }

  // Register card info....
  Widget _registerNumberCardInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorConstants.backgroundColorFFFFFF,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(ImgName.callImage),
          ),
          const SizedBox(
            width: 10,
          ),
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
          )
        ],
      ),
    );
  }

  // newNumber card Details...
  Widget _newNumberCardDetail(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
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
                title: StaticString.changeMobileNumber,
                primaryColor: ColorConstants.custDarkBlue160935,
                secondaryColor: ColorConstants.custskyblue22CBFE,
              ),
              const SizedBox(height: 15),
              CustomText(
                txtTitle: StaticString.editPhoneInfo,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(color: ColorConstants.custGrey707070),
              ),
              const SizedBox(height: 25),
              TextFormField(
                autovalidateMode: autovalidationMode,
                controller: editRegisterNumberController,
                cursorColor: ColorConstants.custDarkBlue160935,
                validator: (value) => value?.validatePhoneNumber,
                maxLength: 10,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                decoration: commonImputdecoration(
                  labletext: "${StaticString.enterNewMobileNumber}*",
                ),
                onSaved: (mobile) {
                  _authModel.mobile = mobile ?? "";
                },
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration commonImputdecoration({required String labletext}) {
    return InputDecoration(
      counterText: "",
      labelText: labletext,
    );
  }

  //Keyboard Hide Ontap
  void keyboardHideOntap() {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Future<void> sendVerificationBtnOnTap() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      if (!formKey.currentState!.validate()) {
        autovalidationMode = AutovalidateMode.always;
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        return;
      }
      formKey.currentState?.save();
      _authModel.type = 3;
      final String token =
          await Provider.of<AuthProvider>(context, listen: false)
              .generateOTP(_authModel);
      _authModel.token = token;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => ResetPasswordScreen(
            isFromSecurity: widget.isFromSecurity,
            auth: _authModel,
          ),
        ),
      );
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
