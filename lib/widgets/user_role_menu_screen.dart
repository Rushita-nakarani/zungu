import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/main.dart';
import 'package:zungu_mobile/models/auth/role_model.dart';
import 'package:zungu_mobile/models/dashboard/subscribe_role_model.dart';
import 'package:zungu_mobile/providers/auth/auth_provider.dart';
import 'package:zungu_mobile/providers/dashboard_provider/landlord_dashboard_provider.dart';
import 'package:zungu_mobile/screens/auth/add_subscription_screen.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/helper_widgets.dart';

import '../constant/img_font_color_string.dart';
import '../utils/common_funcations.dart';
import 'custom_text.dart';

class UserRoleMenuScreen extends StatelessWidget {
  final void Function(Role) onSelected;
  UserRoleMenuScreen({Key? key, required this.onSelected}) : super(key: key) {
    fetchRole();
  }

  final List<PopupMenuEntry<Role>> _items = [];

  LandlordDashboradProvider get mutedProvider =>
      Provider.of<LandlordDashboradProvider>(getContext, listen: false);

  AuthProvider get authProvider =>
      Provider.of<AuthProvider>(getContext, listen: false);

  final ValueNotifier _signInNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _signInNotifier,
      builder: (context, value, child) =>
          Consumer2<LandlordDashboradProvider, AuthProvider>(
        builder: (context, dash, auth, child) => PopupMenuButton<Role>(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          itemBuilder: (context) {
            return _items;
          },
          onSelected: (value) async {
            if (value.isActive) {
              await auth.switchProfile(value.roleId);
              auth.userRole = value.roleName;
            } else {
              await auth.fetchRoleList();
              final RoleData _roleData = auth.roleList
                  .firstWhere((element) => element.roleName == value.roleName);
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
            fetchRole();
            _signInNotifier.notifyListeners();
          },
          child: Container(
            height: 36,
            width: 36,
            decoration: appBarMenuIconDecoration(),
            child: Icon(
              Icons.more_vert_rounded,
              color: _getColorOfButton(auth.userRole),
            ),
          ),
        ),
      ),
    );
  }

  Color _getColorOfButton(UserRole selected) {
    switch (selected) {
      case UserRole.LANDLORD:
        return ColorConstants.custBlue1BC4F4;
      case UserRole.TENANT:
        return ColorConstants.custDarkYellow838500;
      case UserRole.TRADESPERSON:
        return ColorConstants.custDarkTeal017781;
      default:
        return ColorConstants.custBlack000000;
    }
  }

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

  void fetchRole() {
    final List<Role> _activeRoleList =
        mutedProvider.subscribeRoleModel?.active.toList() ?? [];
    for (final element in _activeRoleList) {
      element.isActive = true;
    }
    final List<Role> _inActiveRoleList =
        mutedProvider.subscribeRoleModel?.inActive.toList() ?? [];
    for (final element in _inActiveRoleList) {
      element.isActive = false;
    }
    _activeRoleList
        .removeWhere((element) => element.roleName == authProvider.userRole);
    if (_activeRoleList.isNotEmpty) {
      _items.insert(
        0,
        PopupMenuItem(
          child: Container(
            height: 30,
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorConstants.custLightGreyF1F1F1,
              borderRadius: BorderRadius.circular(5),
            ),
            child: CustomText(
              txtTitle: StaticString.activeSubscribtions,
              style: Theme.of(getContext).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custGrey707070,
                  ),
            ),
          ),
        ),
      );

      _items.insertAll(
        1,
        _activeRoleList
            .map(
              (e) => PopupMenuItem(
                value: e,
                child: Row(
                  children: [
                    CustImage(
                      imgURL: _getImgOfButton(e.roleName),
                      height: 20,
                    ),
                    const SizedBox(width: 10),
                    CustomText(
                      txtTitle: getRoleTitle(e.roleName),
                      style: Theme.of(getContext).textTheme.bodyText2,
                    )
                  ],
                ),
              ),
            )
            .toList(),
      );
    }
    if (_inActiveRoleList.isNotEmpty) {
      _items.add(
        PopupMenuItem(
          child: Container(
            height: 30,
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorConstants.custLightGreyF1F1F1,
              borderRadius: BorderRadius.circular(5),
            ),
            child: CustomText(
              txtTitle: StaticString.addSubscribtions,
              style: Theme.of(getContext).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custGrey707070,
                  ),
            ),
          ),
        ),
      );
    }
    _items.addAll(
      _inActiveRoleList
          .map(
            (e) => PopupMenuItem(
              value: e,
              child: Row(
                children: [
                  CustImage(
                    imgURL: _getImgOfButton(e.roleName),
                    height: 20,
                  ),
                  const SizedBox(width: 10),
                  CustomText(
                    txtTitle: getRoleTitle(e.roleName),
                    style: Theme.of(getContext).textTheme.bodyText2,
                  )
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
