// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/screens/search/search_screen.dart';

import '../../constant/img_font_color_string.dart';
import '../../models/settings/business_profile/business_profile_model.dart';
import '../../providers/auth/auth_provider.dart';
import '../../providers/auth/personal_profile_provider/personal_provider.dart';
import '../../providers/dashboard_provider/landlord_dashboard_provider.dart';
import '../../screens/Navigation%20Bar/curved_navigation_bar.dart';
import '../../screens/auth/add_subscription_screen.dart';
import '../../screens/auth/notification_screen.dart';
import '../../screens/landlord/landlord_dashboard_screen.dart';
import '../../screens/landlord/landlord_favourites_screen.dart';
import '../../screens/settings/business%20profile/tradesman_business_profile/start_free_trial_account_activated_and_inactive_screen.dart';
import '../../screens/settings/setting_screen.dart';
import '../../screens/tenant/tenant_deshboard/tenant_dashboard_screen.dart';
import '../../screens/trades_person/trades_person_dashboard_screen.dart';
import '../../utils/cust_eums.dart';
import '../../utils/push_notification.dart';
import '../../widgets/custom_alert.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/statusbar_content_style.dart';
import '../../widgets/user_role_menu_screen.dart';
import '../models/auth/auth_model.dart';
import '../models/auth/role_model.dart';
import '../utils/common_funcations.dart';
import '../widgets/cust_image.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  //---------------------------------Variables--------------------------------//

  // Selected Page int
  int page = 2;
  // PersistentTabController? _controller;

  PersistentTabController controller = PersistentTabController(
    initialIndex: 2,
  );

  // Bottom Navigationn Key
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  //---------------List-------------//
  bool isAppbarshow = false;
  // Active Button Image List
  // List<Widget> _buildScreens() {
  //   return [
  //     const Scaffold(
  //       backgroundColor: Colors.red,
  //     ),
  //     const Scaffold(
  //       backgroundColor: Colors.yellow,
  //     )
  //   ];
  // }

  final List<String> _activeButton = [
    ImgName.selectedSearch,
    ImgName.selectedChat,
    ImgName.selectedLogo,
    ImgName.landlordCalender,
    ImgName.selectedSetting,
  ];
  // Deactive Button Image List
  final List<String> _deActiveButton = [
    ImgName.searchProperties,
    ImgName.newMessage,
    ImgName.logo,
    ImgName.calendar,
    ImgName.businessServices,
  ];
  // Bottom Item Text
  final List<String> _bottomItems = [
    StaticString.search,
    StaticString.messages,
    StaticString.dashboard,
    StaticString.calender,
    StaticString.setting,
  ];
  // Loading Indicator Notifier
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  // Muted Provider getter
  AuthProvider get mutedProvider =>
      Provider.of<AuthProvider>(context, listen: false);

  LandlordDashboradProvider get landloarddashboard =>
      Provider.of<LandlordDashboradProvider>(context, listen: false);

  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    // Push notification setup...
    PushNotification.instance.pushNotificationsMethodsSetup();
    fetchData();
  }

  //---------------------------------UI--------------------------------//

  @override
  Widget build(BuildContext context) {
    return StatusbarContentStyle(
      statusbarContentColor: StatusbarContentColor.Black,
      child: LoadingIndicator(
        loadingStatusNotifier: _loadingIndicatorNotifier,
        child: Scaffold(
          body: Consumer<LandlordDashboradProvider>(
            builder: (context, value, child) => Column(
              children: [
                if (controller.index != 2)
                  Container()
                else if (!value.getIsAppbarremove)
                  _buildAppBar()
                else
                  Container(),
                _buildBottomNavigationBar(),
              ],
            ),
          ),
          // bottomNavigationBar: ,
        ),
      ),
    );
  }

  //---------------------------------Widget--------------------------------//

  // Curved Bottom Navigation Bar
  Widget _buildBottomNavigationBar() {
    return Expanded(
      child: PersistentTabView.custom(
        onWillPop: (p0) async {
          return false;
        },
        itemCount: _bottomItems.length,
        context,
        controller: controller,
        screens: [
          // Search Screen
          const SearchScreen(),

          const Scaffold(),

          // Dash board screen
          Consumer2<AuthProvider, PersonalProfileProvider>(
            builder: (ctx, btp, prf, child) {
              Widget screen = const LandlordDashboardScreen();
              switch (btp.userRole) {
                case UserRole.LANDLORD:
                  screen = const LandlordDashboardScreen();
                  break;
                case UserRole.TENANT:
                  screen = const TenantDashboardScreen();
                  break;
                case UserRole.TRADESPERSON:
                  screen = (!(prf.fetchProfileModel?.isActive ?? true) ||
                          !(prf.fetchProfileModel?.isSubscribed ?? true))
                      ? StartFreeTrialAccountInactive(
                          profileModel: prf.fetchProfileModel!,
                        )
                      : const TradesPersonDashboardScreen();
                  break;
                case UserRole.None:
                  break;
              }
              return screen;
            },
          ),
          const Scaffold(),

          // Setting Screen
          const SettingScreen(),
        ],
        customWidget: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: controller.index,
          items: List.generate(_bottomItems.length, (index) {
            return _custBottomBarIcon(
              image: controller.index == index
                  ? _activeButton[index]
                  : _deActiveButton[index],
              title: _bottomItems[index],
              isSelected: controller.index == index,
            );
          }),
          buttonBackgroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          onTap: (index) {
            if (mounted) {
              setState(() {
                controller.index = index;
              });
            }
          },
          letIndexChange: (index) => true,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
        ),
      ),
    );
  }

  // Custom Dash Board Icon
  Widget _custBottomBarIcon({
    required String image,
    required String title,
    required bool isSelected,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Dash Board Item Image
        SvgPicture.asset(
          image,
          height: image == ImgName.selectedLogo ? 50 : 30,
        ),
        const SizedBox(height: 2),

        // Dash Board Item Text
        if (isSelected)
          Container()
        else
          CustomText(
            txtTitle: title,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: ColorConstants.custGrey707070),
          )
      ],
    );
  }

  // Body
  Widget _buildBody() {
    return Column(
      children: const [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 40),
            // child:
            // [
            //   // Search Screen
            //   const SearchScreen(),

            //   const Scaffold(),

            //   // Dash board screen
            //   Consumer2<AuthProvider, PersonalProfileProvider>(
            //     builder: (context, btp, prf, child) {
            //       Widget screen = const LandlordDashboardScreen();
            //       switch (btp.userRole) {
            //         case UserRole.LANDLORD:
            //           screen = const LandlordDashboardScreen();
            //           break;
            //         case UserRole.TENANT:
            //           screen = const TenantDashboardScreen();
            //           break;
            //         case UserRole.TRADESPERSON:
            //           screen = (!(prf.fetchProfileModel?.isActive ?? true) ||
            //                   !(prf.fetchProfileModel?.isSubscribed ?? true))
            //               ? StartFreeTrialAccountInactive(
            //                   profileModel: prf.fetchProfileModel!,
            //                 )
            //               : const TradesPersonDashboardScreen();
            //           break;
            //         case UserRole.None:
            //           break;
            //       }
            //       return screen;
            //     },
            //   ),
            //   const Scaffold(),

            //   // Setting Screen
            //   const SettingScreen(),
            // ][_page],
          ),
        ),
      ],
    );
  }

  // AppBar ...
  Widget _buildAppBar() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Consumer3<AuthProvider, PersonalProfileProvider,
            LandlordDashboradProvider>(
          builder: (context, auth, profile, dash, child) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    // Profile Image Card
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CustImage(
                          imgURL: auth.userRole == UserRole.TENANT
                              ? (profile.authModel?.profileImg ?? "")
                              : (profile.bussinessUserList.isNotEmpty
                                  ? profile.bussinessUserList
                                      .firstWhere(
                                        (element) =>
                                            element.roleName == auth.userRole,
                                        orElse: () => BussinessProfileModel(),
                                      )
                                      .profileImg
                                  : ""),
                          height: 53,
                          width: 53,
                        ),
                      ),
                    ),

                    // User Role Title and User Name text roe
                    Flexible(
                      flex: 2,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              txtTitle: getRoleTitle(auth.userRole),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                    color: getRoleColor(auth.userRole),
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            CustomText(
                              txtTitle: auth.userRole == UserRole.TENANT
                                  ? (profile.authModel?.fullName ?? "")
                                  : (profile.bussinessUserList.isNotEmpty
                                      ? profile.bussinessUserList
                                          .firstWhere(
                                            (element) =>
                                                element.roleName ==
                                                auth.userRole,
                                            orElse: () =>
                                                BussinessProfileModel(),
                                          )
                                          .tradingName
                                      : ""),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  Stack(
                    children: [
                      // Notification Icon Button
                      _buildAppBarButton(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => const NotificationScreen(),
                            ),
                          );
                        },
                      ),

                      // Count Notification Circle
                      Positioned(
                        right: MediaQuery.of(context).size.width * 0.015,
                        top: MediaQuery.of(context).size.height * 0.005,
                        child: Container(
                          height: 13,
                          width: 13,
                          padding: const EdgeInsets.only(left: 1),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: mutedProvider.userRole == UserRole.LANDLORD
                                ? ColorConstants.custBlue1EC0EF
                                : mutedProvider.userRole == UserRole.TENANT
                                    ? ColorConstants.custDarkYellow838500
                                    : mutedProvider.userRole ==
                                            UserRole.TRADESPERSON
                                        ? ColorConstants.custDarkTeal017781
                                        : ColorConstants.custDarkPurple150934,
                          ),
                          child: CustomText(
                            txtTitle:
                                (profile.fetchUser?.notificationCount ?? 0)
                                    .toString(),
                            align: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.overline?.copyWith(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),

                  // Favourite Icon Button
                  _buildAppBarButton(
                    imgUrl: ImgName.fillHeart,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const LandlordMyFavouritesScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),

                  // Select User Role Icon Button
                  UserRoleMenuScreen(
                    onSelected: (value) async {
                      if (value.isActive) {
                        await auth.switchProfile(value.roleId);
                        auth.userRole = value.roleName;
                      } else {
                        await auth.fetchRoleList();
                        final RoleData _roleData = auth.roleList.firstWhere(
                          (element) => element.roleName == value.roleName,
                        );
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) =>
                                AddSubScriptionScreen(_roleData, ispop: true),
                          ),
                        );
                        await auth.switchProfile(value.roleId);
                        value.isActive = true;
                        auth.userRole = value.roleName;
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Custo Appbar button
  Widget _buildAppBarButton({
    String imgUrl = ImgName.bell,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
              blurRadius: 12,
            ),
          ],
        ),
        child: CustImage(
          imgURL: imgUrl,
          height: 18,
          width: 18,
        ),
      ),
    );
  }

  //------------------------------Helper Function----------------------------//

  // Fetch Data
  Future<void> fetchData() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      await Future.wait([
        mutedProvider.reloadSession(),
        Provider.of<LandlordDashboradProvider>(context, listen: false)
            .fetchRoleList(),
        Provider.of<PersonalProfileProvider>(context, listen: false)
            .businessUserDetail()
      ]);
      final ProfileModel? profile =
          Provider.of<AuthProvider>(context, listen: false).authModel?.profile;
      if (profile != null) {
        await Provider.of<PersonalProfileProvider>(context, listen: false)
            .fetchUserProfile(
          profile.roleId,
          isFromLandlord: profile.userRole != UserRole.TRADESPERSON,
        );
        await Provider.of<PersonalProfileProvider>(context, listen: false)
            .fetchUserDetails();
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
