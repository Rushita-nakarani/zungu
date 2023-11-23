import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/providers/auth/notification_provider.dart';

import '../../models/auth/notification_model.dart';
import '../../models/dashboard/subscribe_role_model.dart';
import '../../providers/auth/personal_profile_provider/personal_provider.dart';
import '../../providers/dashboard_provider/landlord_dashboard_provider.dart';
import '../../utils/cust_eums.dart';
import '../../utils/custom_extension.dart';
import '../../widgets/cust_image.dart';
import '../../widgets/custom_alert.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/no_content_label.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  //------------------------Variables------------------------//

  // Notification Provider
  NotificationProvider get notificationProvider =>
      Provider.of<NotificationProvider>(context, listen: false);

  // Muted Provider
  LandlordDashboradProvider get mutedProvider =>
      Provider.of<LandlordDashboradProvider>(context, listen: false);

  PersonalProfileProvider get personalProfile =>
      Provider.of<PersonalProfileProvider>(context, listen: false);

  // Loading Incdicator
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  // Selecetd User Role
  Role? _selectedUserRole;

  // Active Role List
  List<Role> _activeRoleList = [];

  //------------------------UI------------------------//

  @override
  void initState() {
    super.initState();
    _activeRoleList = mutedProvider.subscribeRoleModel?.active.toList() ?? [];
    if (_activeRoleList.isNotEmpty) {
      _selectedUserRole = _activeRoleList.first;
      fetchNotificationList(
        indicatorType: LoadingIndicatorType.spinner,
        userRole: _selectedUserRole!.roleName,
      );
    }
  }

  //-------------------------UI----------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          txtTitle: StaticString.notification,
        ),
      ),
      body: _buildBody(),
    );
  }

  //-------------------------Widget----------------------------//

  Widget _buildBody() {
    return Consumer<NotificationProvider>(
      builder: (context, notificationData, child) {
        return LoadingIndicator(
          loadingStatusNotifier: _loadingIndicatorNotifier,
          child: _selectedUserRole == null
              ? const NoContentLabel(title: StaticString.nodataFound)
              : Column(
                  children: [
                    // Notification header by user role...
                    _buildNotificationHeaderByRole(),

                    //Tenant Notification View
                    _buildNotificationView(
                      userRole: _selectedUserRole!.roleName,
                      context: context,
                      color: ColorConstants.custDarkPurple662851,
                      notificationData: _getNotificationData(
                        _selectedUserRole!.roleName,
                        notificationData,
                      ),
                      count: _getNotificationCount(
                        _selectedUserRole!.roleName,
                        notificationData,
                      ),
                      loadMoreData: () async {
                        _selectedUserRole!.page++;
                        switch (_selectedUserRole!.roleName) {
                          case UserRole.LANDLORD:
                            await notificationProvider
                                .fetchNotificationLandlordData(
                              page: _selectedUserRole!.page,
                              profileId: _selectedUserRole!.profileId,
                            );
                            break;
                          case UserRole.TENANT:
                            await notificationProvider
                                .fetchNotificationTenantData(
                              page: _selectedUserRole!.page,
                              profileId: _selectedUserRole!.profileId,
                            );

                            break;
                          case UserRole.TRADESPERSON:
                            await notificationProvider
                                .fetchNotificationTradesmanData(
                              page: _selectedUserRole!.page,
                              profileId: _selectedUserRole!.profileId,
                            );
                            break;
                          case UserRole.None:
                            // TODO: Handle this case.
                            break;
                        }
                      },
                      notificationModel: _getNotificationModel(
                        _selectedUserRole!.roleName,
                        notificationData,
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }

  // Notification Viee by User Role
  Widget _buildNotificationView({
    required UserRole userRole,
    required BuildContext context,
    required Color color,
    required int count,
    required List<NotificationDatum> notificationData,
    required NotificationScreenModel? notificationModel,
    required Function() loadMoreData,
  }) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (notificationData.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      onPressed: () => clearAllBtnAction(userRole: userRole),
                      txtTitle: StaticString.clearAll,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: ColorConstants.custBlue1EC0EF,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              )
            else
              Container(),
            if (notificationData.isEmpty)
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                ),
                child: NoContentLabel(
                  title: AlertMessageString.noDataFound,
                  onPress: () async {
                    await fetchNotificationList(
                      indicatorType: LoadingIndicatorType.overlay,
                      userRole: userRole,
                    );
                  },
                ),
              )
            else
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: notificationData.length,
                itemBuilder: (context, index) {
                  return notificationModel != null
                      ? LazyLoadingList(
                          index: index,
                          hasMore: count >= notificationData.length,
                          loadMore: loadMoreData,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: _buildNotificationCard(
                              color: color,
                              notificationData: notificationData[index],
                            ),
                          ),
                        )
                      : Container();
                },
              ),
          ],
        ),
      ),
    );
  }

  // Notification header by user role...
  Widget _buildNotificationHeaderByRole() {
    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          Container(
            color: ColorConstants.custDarkPurple160935,
            height: 90,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 110,
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  scrollDirection: Axis.horizontal,
                  itemCount: _activeRoleList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      onTap: () =>
                          userRoleCardOntap(userRole: _activeRoleList[index]),
                      child: _customCard(
                        role: _activeRoleList[index],
                        count: _getNotificationUnReadCount(
                          _activeRoleList[index],
                        ).toString(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //custom User Role card
  Widget _customCard({
    required Role role,
    required String count,
  }) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          height: 90,
          width: 95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: (_selectedUserRole!.roleName == role.roleName &&
                    role.roleName == UserRole.LANDLORD)
                ? ColorConstants.custBlue1EC0EF
                : (_selectedUserRole!.roleName == role.roleName &&
                        role.roleName == UserRole.TRADESPERSON)
                    ? ColorConstants.custGreenAFCB1F
                    : (_selectedUserRole!.roleName == role.roleName &&
                            role.roleName == UserRole.TENANT)
                        ? ColorConstants.custDarkPurple662851
                        : Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                color: ColorConstants.custGrey7A7A7A.withOpacity(.20),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustImage(
                imgURL: _getImgOfButton(role.roleName),
                height: 36,
                width: 36,
              ),
              const SizedBox(height: 5),
              CustomText(
                txtTitle: role.displayName,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: _selectedUserRole!.roleName == role.roleName
                          ? Colors.white
                          : ColorConstants.custGrey707070,
                    ),
              )
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0,
          right: MediaQuery.of(context).size.width * 0.011,
          child: Container(
            height: 30,
            width: 30,
            padding: const EdgeInsets.only(top: 3),
            decoration: BoxDecoration(
              color: _getColorOfButton(role.roleName),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
            ),
            child: Center(
              child: CustomText(
                txtTitle: count,
                align: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildNotificationCard({
    required Color color,
    required NotificationDatum notificationData,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: ColorConstants.custGrey7A7A7A.withOpacity(.20),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Color Line card
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 10,
            height: 110,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ),

          //Profile Image
          Container(
            margin: const EdgeInsets.only(top: 10, right: 5),
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CustImage(
                imgURL: notificationData.recordId?.profileImg.isEmpty ?? false
                    ? ""
                    : notificationData.recordId?.profileImg ?? "",
              ),
            ),
          ),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                CustomText(
                  txtTitle: notificationData.headLine,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: ColorConstants.custGrey707070,
                      ),
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomText(
                        txtTitle: notificationData.recordId?.fullName ?? "",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 3),
                          child: CircleAvatar(
                            radius: 2.5,
                            backgroundColor: ColorConstants.custPurple500472,
                          ),
                        ),
                        CustomText(
                          txtTitle: DateFormat("dd MMM yyyy").format(
                            notificationData.createdAt ?? DateTime.now(),
                          ),
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: ColorConstants.custGrey707070,
                              ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 3),
                CustomText(
                  txtTitle: notificationData.label,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: color,
                        fontSize: 13,
                      ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomText(
                        txtTitle: notificationData.title,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: ColorConstants.custGrey707070,
                              fontSize: 13,
                            ),
                      ),
                    ),
                    // const SizedBox(width: 30),
                    Expanded(
                      child: CustomText(
                        txtTitle:
                            notificationData.createdAt?.toLocal().timeAgo(),
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: ColorConstants.custGrey707070,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          )
        ],
      ),
    );
  }

  //-----------------------------------getter methods----------------------------//

  //Button Color getter
  Color _getColorOfButton(UserRole selected) {
    switch (selected) {
      case UserRole.LANDLORD:
        return ColorConstants.custDarkPurple500472;
      case UserRole.TENANT:
        return ColorConstants.custDarkPurple662851;
      case UserRole.TRADESPERSON:
        return ColorConstants.custCyan017781;
      default:
        return ColorConstants.custBlack000000;
    }
  }

  // Notification Main role Card Image getter
  String _getImgOfButton(UserRole selected) {
    switch (selected) {
      case UserRole.LANDLORD:
        return ImgName.landlordRole;
      case UserRole.TENANT:
        return ImgName.tenantRole;
      case UserRole.TRADESPERSON:
        return ImgName.tradesmanRole;
      default:
        return '';
    }
  }

  // Notification Count getter
  int _getNotificationCount(
    UserRole selected,
    NotificationProvider notificationProvider,
  ) {
    switch (selected) {
      case UserRole.LANDLORD:
        return notificationProvider.notificationLandlordModel?.count ?? 0;
      case UserRole.TENANT:
        return notificationProvider.notificationTenantModel?.count ?? 0;
      case UserRole.TRADESPERSON:
        return notificationProvider.notificationTradesmanModel?.count ?? 0;
      default:
        return 0;
    }
  }

  // Notification Unread Count getter
  int _getNotificationUnReadCount(
    Role selected,
  ) {
    switch (selected.roleName) {
      case UserRole.LANDLORD:
        final String _profileId = selected.profileId;
        final Map<String, dynamic>? _unreadCount =
            notificationProvider.notificationLandlordModel?.unreadCount;
        int unreadCount = 0;
        _unreadCount?.forEach((key, value) {
          if (key.contains(_profileId)) {
            unreadCount = int.tryParse(value.toString()) ?? 0;
          }
        });
        return unreadCount;
      case UserRole.TENANT:
        final String _profileId = selected.profileId;
        final Map<String, dynamic>? _unreadCount =
            notificationProvider.notificationTenantModel?.unreadCount;
        int unreadCount = 0;
        _unreadCount?.forEach((key, value) {
          if (key.contains(_profileId)) {
            unreadCount = int.tryParse(value.toString()) ?? 0;
          }
        });
        return unreadCount;
      case UserRole.TRADESPERSON:
        final String _profileId = selected.profileId;
        final Map<String, dynamic>? _unreadCount =
            notificationProvider.notificationTradesmanModel?.unreadCount;
        int unreadCount = 0;
        _unreadCount?.forEach((key, value) {
          if (key.contains(_profileId)) {
            unreadCount = int.tryParse(value.toString()) ?? 0;
          }
        });
        return unreadCount;
      default:
        return 0;
    }
  }

  //Notification Data Getter
  List<NotificationDatum> _getNotificationData(
    UserRole selected,
    NotificationProvider notificationProvider,
  ) {
    switch (selected) {
      case UserRole.LANDLORD:
        return notificationProvider.notificationListLandlordData ?? [];
      case UserRole.TENANT:
        return notificationProvider.notificationListTenantData ?? [];
      case UserRole.TRADESPERSON:
        return notificationProvider.notificationListTradesmanData ?? [];
      default:
        return [];
    }
  }

  // Notification Model getter
  NotificationScreenModel? _getNotificationModel(
    UserRole selected,
    NotificationProvider notificationProvider,
  ) {
    switch (selected) {
      case UserRole.LANDLORD:
        return notificationProvider.notificationLandlordModel;
      case UserRole.TENANT:
        return notificationProvider.notificationTenantModel;
      case UserRole.TRADESPERSON:
        return notificationProvider.notificationTradesmanModel;
      default:
        return null;
    }
  }

  //---------------------------Button Action-------------------//

  Future<void> userRoleCardOntap({required Role userRole}) async {
    if (_selectedUserRole?.roleId == userRole.roleId) {
      return;
    }
    _selectedUserRole = userRole;
    await fetchNotificationList(
      indicatorType: LoadingIndicatorType.overlay,
      userRole: userRole.roleName,
    );
  }

  //Ctear All Button Action
  void clearAllBtnAction({required UserRole userRole}) {
    showAlert(
      context: context,
      showIcon: false,
      singleBtnTitle: StaticString.clearAll.toUpperCase(),
      singleBtnColor: ColorConstants.custRedE03816,
      message: userRole == UserRole.LANDLORD
          ? StaticString.clearNotificationMsgLandlord
          : userRole == UserRole.TRADESPERSON
              ? StaticString.clearNotificationMsgTradesman
              : StaticString.clearNotificationMsgTenant,
      title: StaticString.clearNotification,
      onRightAction: () async {
        try {
          _loadingIndicatorNotifier.show(
            loadingIndicatorType: LoadingIndicatorType.spinner,
          );

          await Future.wait([
            notificationProvider.clearAllNotification(
              profileId: _selectedUserRole!.profileId,
              userRole: userRole,
            ),
          ]);
        } catch (e) {
          showAlert(context: context, message: e);
        } finally {
          _loadingIndicatorNotifier.hide();
        }
      },
    );
  }

  // Fetch Notification List
  Future<void> fetchNotificationList({
    required LoadingIndicatorType indicatorType,
    required UserRole userRole,
  }) async {
    try {
      _loadingIndicatorNotifier.show(loadingIndicatorType: indicatorType);

      await notificationProvider.fetchNotification(
        page: _selectedUserRole!.page,
        userRole: userRole,
        profileId: _selectedUserRole!.profileId,
      );
      await notificationProvider.readNotification(
        profileId: _selectedUserRole!.profileId,
      );
      personalProfile.fetchUserDetails();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
