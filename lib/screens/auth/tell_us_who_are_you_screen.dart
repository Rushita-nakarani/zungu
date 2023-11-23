// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/img_font_color_string.dart';
import '../../models/auth/role_model.dart';
import '../../providers/auth/auth_provider.dart';
import '../../screens/auth/add_subscription_screen.dart';
import '../../widgets/common_elevated_button.dart';
import '../../widgets/cust_image.dart';
import '../../widgets/custom_alert.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/no_content_label.dart';

class TellUsWhoAreyouScreen extends StatefulWidget {
  @override
  State<TellUsWhoAreyouScreen> createState() => _TellUsWhoAreyouScreenState();
}

class _TellUsWhoAreyouScreenState extends State<TellUsWhoAreyouScreen> {
  //-------------------------------Variables-------------------------------//

  //Value Notifier
  final ValueNotifier _valueNotifier = ValueNotifier(true);
  // Selected Role Model
  RoleData? _selectedRole;
  // Loading Indicator
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  @override
  void initState() {
    super.initState();
    fetchRoles();
  }

  //-------------------------------UI-------------------------------//

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height -
            kToolbarHeight +
            MediaQuery.of(context).padding.top -
            24) /
        4;
    final double itemWidth = size.width / 2;

    return Scaffold(
      body: _buildBody(itemWidth, itemHeight, size, context),
    );
  }
  //-------------------------------Widgets-------------------------------//

  // Body
  Widget _buildBody(
    double itemWidth,
    double itemHeight,
    Size size,
    BuildContext context,
  ) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Stack(
        children: [
          //Top Background circle
          const Padding(
            padding: EdgeInsets.only(
              left: 80,
            ),
            child: CustImage(
              height: 80,
              width: double.infinity,
              imgURL: ImgName.tellUs1,
              boxfit: BoxFit.contain,
            ),
          ),

          // Bottom Background Circle
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustImage(
              height: 80,
              width: double.infinity,
              imgURL: ImgName.tellUs2,
              boxfit: BoxFit.contain,
            ),
          ),
          // User Role Card List And Continue Button
          _userRoleCardListAndContinueButtonView(itemWidth, itemHeight, size),
        ],
      ),
    );
  }

  // User Role Card List And Continue Button
  Widget _userRoleCardListAndContinueButtonView(
    double itemWidth,
    double itemHeight,
    Size size,
  ) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Tell Us Who Are you text
              _tellUsWhoAreYouText(),
              const SizedBox(height: 20),

              // User Role Card List
              _userRoleCardList(itemWidth, itemHeight, size),
              const SizedBox(height: 20),

              // Continue button
              CommonElevatedButton(
                bttnText: StaticString.continu,
                color: ColorConstants.custDarkPurple500472,
                onPressed: onContinueTapAction,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Tell Us Who Are you text
  Widget _tellUsWhoAreYouText() {
    return const CustomText(
      txtTitle: StaticString.tellUsWhoAreYou,
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: ColorConstants.custBlue1BC4F4,
      ),
    );
  }

  // User Role Card List
  Widget _userRoleCardList(
    double itemWidth,
    double itemHeight,
    Size size,
  ) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) => auth.roleList.isEmpty
          ? NoContentLabel(
              title: AlertMessageString.noDataFound,
              onPress: () {
                fetchRoles();
              },
            )
          : GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: itemWidth / itemHeight,
              ),
              itemCount: auth.roleList.length,
              itemBuilder: (BuildContext context, int index) {
                return ValueListenableBuilder(
                  valueListenable: _valueNotifier,
                  builder: (context, val, child) {
                    return InkWell(
                      onTap: () => userRoleCardOntap(auth.roleList[index]),
                      child: _userRoleCard(auth.roleList[index], size),
                    );
                  },
                );
              },
            ),
    );
  }

  // User Role Card
  Widget _userRoleCard(
    RoleData roleData,
    Size size,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: _selectedRole?.id == roleData.id
            ? ColorConstants.custDarkPurple500472
            : Colors.white,
        borderRadius: BorderRadius.circular(
          10,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: ColorConstants.custGrey707070.withOpacity(0.2),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // User Role Icon Image
              CustImage(
                imgURL: roleData.images,
                height: size.height / 11,
                width: size.height / 11,
              ),
              const SizedBox(height: 6),

              // User Role Name Text
              CustomText(
                txtTitle: roleData.displayName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: _selectedRole?.id == roleData.id
                      ? Colors.white
                      : ColorConstants.custDarkPurple160935,
                ),
              )
            ],
          ),

          // Coming Soon Label Image
          if (roleData.isActive)
            const SizedBox.shrink()
          else
            const Align(
              alignment: Alignment.topLeft,
              child: CustImage(
                imgURL: ImgName.comingSoonLabel,
                height: 60,
                width: 60,
              ),
            )
        ],
      ),
    );
  }

  //---------------------------------Button Action-----------------------------//

  // On Continue Ontap
  Future<void> onContinueTapAction() async {
    try {
      if (_selectedRole != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => AddSubScriptionScreen(_selectedRole),
          ),
        );
      }
    } catch (e) {
      showAlert(context: context, message: e);
    }
  }

  void userRoleCardOntap(RoleData roleData) {
    if (roleData.isActive) {
      _valueNotifier.notifyListeners();
      _selectedRole = roleData;
    }
  }
  //---------------------------------Helper Function-----------------------------//

  // Fetch Roles
  Future<void> fetchRoles() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      await Provider.of<AuthProvider>(context, listen: false).fetchRoleList();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
