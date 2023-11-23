import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/settings/business%20profile/landLoard_bussiness_profile/landlord_business_profile_screen.dart';
import 'package:zungu_mobile/screens/settings/business%20profile/tradesman_business_profile/tradesman_bussiness_profile.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';

import '../../../providers/auth/personal_profile_provider/personal_provider.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/rounded_lg_shape_widget.dart';

class BusinessProfileScreen extends StatefulWidget {
  const BusinessProfileScreen({Key? key}) : super(key: key);

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();
  List<Color> businessCardColor = [];
  Color? primaryColor;
  Color? secColor;
  PersonalProfileProvider get personalProfileProvider =>
      Provider.of<PersonalProfileProvider>(context, listen: false);

  @override
  void initState() {
    userProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.custDarkPurple500472,
          title: const CustomText(
            txtTitle: StaticString.businessProfile,
          ),
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Consumer<PersonalProfileProvider>(
        builder: (context, bussinessProfile, child) => Column(
          children: [
            Container(
              height: 20,
              color: ColorConstants.custDarkPurple500472,
            ),
            const SizedBox(
              width: double.infinity,
              child: RoundedLgShapeWidget(
                color: ColorConstants.custDarkPurple500472,
                title: StaticString.myBusinesses,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: bussinessProfile.bussinessUserList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _buildBusinessInfoCard(
                    bussinessProfile.bussinessUserList[index].roleName.name,
                    bussinessProfile.bussinessUserList[index].tradingName,
                    bussinessProfile.bussinessUserList[index].profileImg,
                    () {
                      switch (
                          bussinessProfile.bussinessUserList[index].roleName) {
                        case UserRole.LANDLORD:
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => LandlordBusinessProfileScreen(
                                roleId: bussinessProfile
                                    .bussinessUserList[index].roleId,
                              ),
                            ),
                          );
                          break;
                        case UserRole.TENANT:
                          break;
                        case UserRole.TRADESPERSON:
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => TradesmanBussinessProfileScreen(
                                roleId: bussinessProfile
                                    .bussinessUserList[index].roleId,
                              ),
                            ),
                          );
                          break;
                        case UserRole.None:
                          // TODO: Handle this case.
                          break;
                      }
                      //
                    },
                    bussinessProfile.bussinessUserList[index].roleName,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getRolePrimaryColor(UserRole role) {
    switch (role) {
      case UserRole.LANDLORD:
        return primaryColor = ColorConstants.custDarkPurple500472;
      case UserRole.TENANT:
        return primaryColor = ColorConstants.custDarkGreen838500;
      case UserRole.TRADESPERSON:
        return primaryColor = ColorConstants.custDarkPurple662851;
      case UserRole.None:
        return primaryColor = ColorConstants.custDarkPurple500472;
    }
  }

  Color getRoleSecondaryColor(UserRole role) {
    switch (role) {
      case UserRole.LANDLORD:
        return secColor = ColorConstants.custLightPupurle;
      case UserRole.TENANT:
        return secColor = ColorConstants.custGreenA9AC14;
      case UserRole.TRADESPERSON:
        return secColor = ColorConstants.custLight823969;
      case UserRole.None:
        return secColor = ColorConstants.custDarkPurple500472;
    }
  }

  Widget _buildBusinessInfoCard(
    String title,
    String businessName,
    String profileUrl,
    void Function()? onPressed,
    UserRole role,
  ) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: getRolePrimaryColor(role),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: ClipOval(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: CustImage(
                  imgURL: profileUrl,
                  boxfit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                color: getRoleSecondaryColor(role),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CustomText(
                    txtTitle: title,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 20),
                  CustomText(
                    txtTitle: StaticString.businessName,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  CustomText(
                    txtTitle: businessName.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 20),
                  if (role == UserRole.TENANT)
                    Container(
                      padding: const EdgeInsets.all(20),
                    )
                  else
                    ElevatedButton(
                      onPressed: onPressed,
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(const StadiumBorder()),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        fixedSize: MaterialStateProperty.all(
                          const Size(double.infinity, 25),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: CustomText(
                          txtTitle: StaticString.viewEdit,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: getRoleSecondaryColor(role),
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> userProfile() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );

      await personalProfileProvider.businessUserDetail();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
