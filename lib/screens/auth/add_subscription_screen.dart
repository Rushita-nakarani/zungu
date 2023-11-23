// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/img_font_color_string.dart';
import '../../models/auth/role_model.dart';
import '../../providers/auth/auth_provider.dart';
import '../../utils/cust_eums.dart';
import '../../widgets/common_elevated_button.dart';
import '../../widgets/cust_image.dart';
import '../../widgets/custom_alert.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/rich_text.dart';

class AddSubScriptionScreen extends StatelessWidget {
  final RoleData? selectedRole;
  final bool ispop;
  AddSubScriptionScreen(this.selectedRole, {this.ispop = false});

  //--------------------------Variables---------------------------//

  // Loading Indicator
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  //--------------------------UI---------------------------//

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Scaffold(
        body: _buildBody(context: context),
      ),
    );
  }

  //-------------------------Widget---------------------//

  // Body
  Widget _buildBody({required BuildContext context}) {
    return Stack(
      children: [
        // Back Ground Image
        const CustImage(
          imgURL: ImgName.modernVilaImg,
          height: double.infinity,
          width: double.infinity,
        ),

        // Blur Container Image
        Container(
          height: double.infinity,
          width: double.infinity,
          color: ColorConstants.custblue6E7BB0.withOpacity(.85),
        ),
        _buildContent(context: context)
      ],
    );
  }

  // Subscription content
  Widget _buildContent({required BuildContext context}) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 5),
          //back arrow icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const CustImage(
                  width: 20,
                  imgURL: ImgName.backArrow,
                  imgColor: Colors.white,
                ),
              ),
            ),
          ),

          // Subscription content
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Price text
                    CustomText(
                      txtTitle:
                          "${selectedRole?.currency}${selectedRole?.price.toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.headline1?.copyWith(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    SizedBox(
                      height: selectedRole?.roleName == UserRole.TENANT ? 0 : 9,
                    ),

                    // Frre trial text
                    if (selectedRole?.roleName == UserRole.TENANT)
                      const SizedBox.shrink()
                    else
                      CustomText(
                        txtTitle:
                            "${selectedRole?.freeTrial.toString()} ${selectedRole?.freeTrialType} ${StaticString.freeTrial}",
                        style: Theme.of(context).textTheme.headline3?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                        align: TextAlign.center,
                      ),
                    const SizedBox(height: 12),

                    //for type text
                    CustomText(
                      txtTitle: "For ${selectedRole?.displayName}",
                      align: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 34),

                    //Description text
                    CustomText(
                      txtTitle: _getDescriptionText(selectedRole?.roleName),
                      align: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(height: 35),

                    // Features text Row
                    ..._propertiesFeaturesList(context),
                    const SizedBox(height: 45),

                    // Continue Elaveted Button
                    _continueBtn(context),
                    const SizedBox(height: 20),

                    // Property Per Month Text
                    CustomText(
                      txtTitle:
                          _getPropertyPerMonthData(selectedRole?.roleName),
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.white,
                            decoration:
                                selectedRole?.roleName == UserRole.TRADESPERSON
                                    ? TextDecoration.lineThrough
                                    : null,
                            decorationColor: ColorConstants.custRedFF0000,
                          ),
                    ),
                    const SizedBox(height: 10),

                    // Property Per Month Sub Data
                    CustomText(
                      txtTitle: _getPropertySubData(selectedRole?.roleName),
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Properties FEatures List
  List<Widget> _propertiesFeaturesList(BuildContext context) {
    return List.generate(
      _getManagePropertyData(selectedRole?.roleName).length,
      (index) => Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Check Icon Image
            const CustImage(
              imgURL: ImgName.greyCheckImage,
              height: 30,
              width: 30,
              imgColor: ColorConstants.custgreen19B445,
            ),
            const SizedBox(width: 5),

            //Properties Description Text
            Expanded(
              child: CustomRichText(
                maxLines: 5,
                title: _getManagePropertyData(selectedRole?.roleName)[index],
                normalTextStyle:
                    Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.white,
                        ),
                fancyTextStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // continue Elaveted Button
  Widget _continueBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CommonElevatedButton(
        onPressed: () => onContinueTapAction(context),
        color: Colors.white,
        textColor: ColorConstants.custDarkBlue150934,
        bttnText: selectedRole?.roleName == UserRole.TENANT
            ? StaticString.continu
            : "${StaticString.start} ${selectedRole?.freeTrial.toString()} ${selectedRole?.freeTrialType} ${StaticString.freeTrial}",
      ),
    );
  }

  //----------------------------getter Methods------------------------//

  String _getDescriptionText(UserRole? selecetd) {
    //Description Data
    switch (selecetd) {
      case UserRole.LANDLORD:
        return StaticString.landlordDescription;
      case UserRole.TENANT:
        return StaticString.tenant1Description;
      case UserRole.TRADESPERSON:
        return StaticString.tradesPersonDescription;
      default:
        return "";
    }
  }

  // Get Property Sub Data
  String _getPropertySubData(UserRole? selecetd) {
    switch (selecetd) {
      case UserRole.LANDLORD:
        return StaticString.afterWeekFreeTrial;
      case UserRole.TENANT:
        return "";
      case UserRole.TRADESPERSON:
        return StaticString.perMonthForTheYear;
      default:
        return "";
    }
  }

  //Propertt Per Month Data
  String _getPropertyPerMonthData(UserRole? selecetd) {
    switch (selecetd) {
      case UserRole.LANDLORD:
        return StaticString.perPropertyPerMoth;
      case UserRole.TENANT:
        return "";
      case UserRole.TRADESPERSON:
        return StaticString.perMonth;
      default:
        return "";
    }
  }

//manage Properties Data
  List<String> _getManagePropertyData(UserRole? selecetd) {
    switch (selecetd) {
      case UserRole.LANDLORD:
        return [
          StaticString.landlordManageProperties,
          StaticString.landlordmanageMaintenance,
          StaticString.landlordManageTenants,
        ];
      case UserRole.TENANT:
        return [
          StaticString.tenantManageTenancies,
          StaticString.tenantMaintenance,
          StaticString.tenantFindProperties,
        ];
      case UserRole.TRADESPERSON:
        return [
          StaticString.tradesPersonManageJobs,
          StaticString.tradesPersonInvoiceClients,
          StaticString.tradesPersonTrackFinancials,
        ];
      default:
        return [];
    }
  }

  //--------------------------Button Action -----------------------//

  // On Continue Button Ontap
  Future<void> onContinueTapAction(BuildContext context) async {
    try {
      _loadingIndicatorNotifier.show();
      await Provider.of<AuthProvider>(context, listen: false)
          .startFreeTrail(selectedRole?.id);
      if (ispop) {
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
