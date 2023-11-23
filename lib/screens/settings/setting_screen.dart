import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';

import '../../constant/img_font_color_string.dart';
import '../../providers/auth/auth_provider.dart';
import '../../screens/settings/contact_us.dart';
import '../../screens/settings/delete_account_screen.dart';
import '../../screens/settings/faq_screen.dart';
import '../../screens/settings/login_and_security_screen.dart';
import '../../screens/settings/personal_profile/personal_profile.dart';
import '../../screens/settings/subscription/my_subscription_screen.dart';
import '../../screens/settings/video_tutorials.dart';
import '../../utils/cust_eums.dart';
import '../../widgets/common_outline_elevated_button.dart';
import '../../widgets/custom_alert.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/html_view.dart';
import 'business profile/business_profile_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  //----------------------------Variables-----------------------------//

  // Rate My app model
  RateMyApp rateMyApp = RateMyApp(
    minDays: 7,
    minLaunches: 10,
    remindDays: 7,
    remindLaunches: 10,
    googlePlayIdentifier: 'fr.skyost.example',
    appStoreIdentifier: '1491556149',
  );
  //----------------------------UI-----------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          txtTitle: StaticString.setting,
        ),
      ),
      body: _buildBody(context),
    );
  }
  //----------------------------Widgets-----------------------------//

  // body...
  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // My profile...
            ..._buildListTileCard(
              StaticString.myProfile,
              [
                SettingModel(
                  title: StaticString.personalProfile,
                  onTap: personalProfileOnTapAction,
                ),
                SettingModel(
                  title: StaticString.businessProfile,
                  onTap: businessProfileOnTapAction,
                ),
              ],
            ),
            // Account & Security...
            ..._buildListTileCard(
              StaticString.accountAndSecurity,
              [
                SettingModel(
                  title: StaticString.loginAndSecurity,
                  onTap: loginSecurityOnTapAction,
                ),
                SettingModel(
                  title: StaticString.mySubscriptions,
                  onTap: mySubscriptionOnTapAction,
                ),
                SettingModel(
                  title: StaticString.deleteAccount,
                  onTap: deleteAccountOnTapAction,
                ),
              ],
            ),

            // Privacy & Help...
            ..._buildListTileCard(
              StaticString.privacyAndHelp,
              [
                SettingModel(
                  title: StaticString.contactUs,
                  onTap: contactOnTapAction,
                ),
                SettingModel(
                  title: StaticString.FAQs,
                  onTap: faqOnTapAction,
                ),
                SettingModel(
                  title: StaticString.videoTutorials,
                  onTap: videoTutorialTapAction,
                ),
                SettingModel(
                  title: StaticString.termsAndConditons,
                  onTap: termsandConditionTapAction,
                ),
                SettingModel(
                  title: StaticString.privacyPolicy,
                  onTap: privacyPolicyTapAction,
                ),
                SettingModel(
                  title: StaticString.cookiesPolicy,
                  onTap: cookiesPolicyTapAction,
                ),
                SettingModel(
                  title: StaticString.disclaimer,
                  onTap: desclaimerTapAction,
                ),
                SettingModel(
                  title: StaticString.rateUs,
                  onTap: rateUsOntap,
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Logout...
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: CommonOutlineElevatedButton(
                onPressed: logOutOnTapAction,
                borderColor: Colors.red,
                bttnText: StaticString.logOut.toUpperCase(),
                textColor: Colors.red,
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  // custom ListTile Card
  List<Widget> _buildListTileCard(String title, List<SettingModel> values) {
    return [
      // Title...
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomText(
          txtTitle: title,
          style: Theme.of(context).textTheme.headline2!.copyWith(),
        ),
      ),
      // Values...
      ...values
          .map(
            (e) => Column(
              children: [
                // Title...
                ListTile(
                  onTap: e.onTap,
                  title: CustomText(
                    txtTitle: e.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: ColorConstants.custGrey707070),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(),
              ],
            ),
          )
          .toList()
    ];
  }

//----------------------------Button Action-----------------------------//

// Move to personalProfile screen...
  void personalProfileOnTapAction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const PersonalProfileScreen(),
      ),
    );
  }

// Move to businessProfile screen...
  void businessProfileOnTapAction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const BusinessProfileScreen(),
      ),
    );
  }

// Move to loginSecurity screen...
  void loginSecurityOnTapAction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const LoginAndSecurityScreen(),
      ),
    );
  }

// Move to MySubscription screen...
  void mySubscriptionOnTapAction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const MySubScriptionScreen(),
      ),
    );
  }

// Move to delete screen...
  void deleteAccountOnTapAction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const DeleteAccountscreen(),
      ),
    );
  }

// Move to contact screen...
  void contactOnTapAction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const ContactUsScreen(),
      ),
    );
  }

// Move to faq screen...
  void faqOnTapAction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const FaqScreen(),
      ),
    );
  }

// Move to video Tutorial screen...
  void videoTutorialTapAction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const VideoTutorialScreen(),
      ),
    );
  }

// Move to terms and Condition  screen...
  void termsandConditionTapAction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const HtmlCommonView(
          title: StaticString.termsAndConditons,
          viewType: HtmlViewType.TC,
        ),
      ),
    );
  }

// Move to privacy policy  screen...
  void privacyPolicyTapAction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const HtmlCommonView(
          title: StaticString.privacyPolicy,
          viewType: HtmlViewType.PP,
        ),
      ),
    );
  }

// Move to cookies Policies  screen...
  void cookiesPolicyTapAction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const HtmlCommonView(
          title: StaticString.cookiesPolicy,
          viewType: HtmlViewType.CP,
        ),
      ),
    );
  }

// Move to desclaimer  screen...
  void desclaimerTapAction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const HtmlCommonView(
          title: StaticString.disclaimer,
          viewType: HtmlViewType.DC,
        ),
      ),
    );
  }

//  logout ontap action...
  void logOutOnTapAction() {
    showAlert(
      context: context,
      title: StaticString.logOut,
      message: StaticString.logoutConfirmationMsg,
      onRightAction: () {
        Provider.of<AuthProvider>(context, listen: false).logout();
      },
    );
  }

  // Rate Us Ontap
  void rateUsOntap() {
    rateMyApp.showStarRateDialog(
      context,
      title: StaticString.rateUs,
      message: StaticString.rateUsAppMessage,
      actionsBuilder: (context, stars) {
        return [
          MaterialButton(
            child: const Text('OK'),
            onPressed: () {
              // debugPrint(
              //   'Thanks for the ${stars == null ? '0' : stars.round().toString()} star(s) !',
              // );

              rateMyApp.callEvent(
                RateMyAppEventType.rateButtonPressed,
              );
              Navigator.of(context).pop();
            },
          ),
        ];
      },
      ignoreNativeDialog: Platform.isAndroid,
      dialogStyle: const DialogStyle(
        titleAlign: TextAlign.center,
        messageAlign: TextAlign.center,
        messagePadding: EdgeInsets.only(bottom: 20),
      ),
      starRatingOptions: const StarRatingOptions(),
      onDismissed: () =>
          rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
    );
  }
}

class SettingModel {
  final String title;
  final void Function() onTap;
  SettingModel({required this.title, required this.onTap});
}
