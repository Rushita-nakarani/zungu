import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/api/api_middleware.dart';
import 'package:zungu_mobile/models/auth/auth_model.dart';
import 'package:zungu_mobile/providers/auth/auth_provider.dart';
import 'package:zungu_mobile/providers/auth/personal_profile_provider/personal_provider.dart';
import 'package:zungu_mobile/providers/dashboard_provider/landlord_dashboard_provider.dart';
import 'package:zungu_mobile/providers/dashboard_provider/tenant_dashboard_provider.dart';
import 'package:zungu_mobile/providers/dashboard_provider/tradesman_dashboard_provider.dart';
import 'package:zungu_mobile/providers/landlord/active_leaese_provider.dart';
import 'package:zungu_mobile/providers/landlord/tenant/create_leases_provider.dart';
import 'package:zungu_mobile/providers/landlord/tenant/e_signed_lease_provider.dart';
import 'package:zungu_mobile/providers/settings/privacy_and_help_provider.dart';
import 'package:zungu_mobile/providers/tenantProvider/tenancy_provider.dart';
import 'package:zungu_mobile/screens/auth/login_screen.dart';
import 'package:zungu_mobile/screens/auth/on_boarding_screen.dart';
import 'package:zungu_mobile/screens/auth/tell_us_who_are_you_screen.dart';
import 'package:zungu_mobile/screens/settings/business%20profile/landLoard_bussiness_profile/edit_landlord_business_profile.dart';
import 'package:zungu_mobile/screens/settings/business%20profile/tradesman_business_profile/edit_tradesman_bussiness_profile.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';

import 'constant/app_constant.dart';
import 'constant/string_constants.dart';
import 'providers/auth/notification_provider.dart';
import 'providers/landlord/tenant/add_tenant_property_detail_provider.dart';
import 'providers/landlord/tenant/add_tenant_provider.dart';
import 'providers/landlord/tenant/fetch_property_provider.dart';
import 'providers/landlord/tenant/lease_detail_provider.dart';
import 'providers/landlord/tenant/view_tenant_provider.dart';
import 'providers/landlord_provider.dart';
import 'screens/bottom_navigation_bar_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

BuildContext get getContext => navigatorKey.currentState!.context;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ApiMiddleware.instance.getDefaultParams();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const ZunguApp());
}

class ZunguApp extends StatelessWidget {
  const ZunguApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Auth provider...
        ChangeNotifierProvider<AuthProvider>.value(value: AuthProvider()),
        // Property search
        // Form Expansion provider
        ChangeNotifierProvider<CreateLeasesProvider>.value(
          value: CreateLeasesProvider(),
        ),
        ChangeNotifierProvider<LandlordProvider>.value(
          value: LandlordProvider(),
        ),
        ChangeNotifierProvider<PrivacyAndPolicyProvider>.value(
          value: PrivacyAndPolicyProvider(),
        ),
        ChangeNotifierProvider<LandlordTenantPropertyProvider>.value(
          value: LandlordTenantPropertyProvider(),
        ),
        ChangeNotifierProvider<LandlordTenantProvider>.value(
          value: LandlordTenantProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, PersonalProfileProvider>(
          create: (context) => PersonalProfileProvider(),
          update: (context, auth, profile) {
            if (auth.authModel != null) {
              profile?.authModel = auth.authModel;
            } else {
              profile?.logout();
            }
            return profile!;
          },
        ),
        // ChangeNotifierProvider<EditTradeServiceProvider>.value(
        //   value: EditTradeServiceProvider(),
        // ),
        ChangeNotifierProvider<LandlordDashboradProvider>.value(
          value: LandlordDashboradProvider(),
        ),

        ChangeNotifierProvider<TenantDashboradProvider>.value(
          value: TenantDashboradProvider(),
        ),

        ChangeNotifierProvider<TradesmanDashboradProvider>.value(
          value: TradesmanDashboradProvider(),
        ),
        ChangeNotifierProvider<AddTenantPropertyDetailProvider>.value(
          value: AddTenantPropertyDetailProvider(),
        ),
        ChangeNotifierProvider<TenanciesProvider>.value(
          value: TenanciesProvider(),
        ),
        ChangeNotifierProvider<LandlordTenantViewTenantProvider>.value(
          value: LandlordTenantViewTenantProvider(),
        ),
        ChangeNotifierProvider<NotificationProvider>.value(
          value: NotificationProvider(),
        ),
        ChangeNotifierProvider<ActiveLeasesProvider>.value(
          value: ActiveLeasesProvider(),
        ),
        ChangeNotifierProvider<ESignedLeaseProvider>.value(
          value: ESignedLeaseProvider(),
        ),
        ChangeNotifierProvider<LeaseDetailProvider>.value(
          value: LeaseDetailProvider(),
        ),
      ],
      child: MaterialApp(
        builder: (BuildContext context, Widget? child) {
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(
              textScaleFactor: 1,
            ),
            child: child ?? Container(),
          );
        },
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
        navigatorKey: navigatorKey,
        title: StaticString.appName,
        theme: CustomAppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: Consumer<AuthProvider>(
          builder: (context, auth, child) => !auth.isShowedOnBoarding
              ? const OnBoardingScreen()
              : auth.authModel == null
                  ? LoginScreen()
                  : auth.authModel?.profile == null
                      ? TellUsWhoAreyouScreen()
                      : _profileScreenRoute(auth.authModel),
        ),
      ),
    );
  }
}

Widget _profileScreenRoute(AuthModel? authModel) {
  Widget _screen = const BottomNavigationBarScreen();
  if (authModel != null &&
      authModel.profile?.userRole != null &&
      (authModel.profile?.profileCompleted == false)) {
    switch (authModel.profile!.userRole) {
      case UserRole.LANDLORD:
        _screen = EditLandloardBussinessProfileScreen(
          roleId: authModel.profile!.roleId,
        );
        break;
      case UserRole.TENANT:
        break;
      case UserRole.TRADESPERSON:
        _screen = EditTradesmanBussinessProfileScreen(
          roleId: authModel.profile!.roleId,
        );
        break;
      case UserRole.None:
        break;
    }
  }
  return _screen;
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}
