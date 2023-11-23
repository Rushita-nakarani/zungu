import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/models/settings/business_profile/trades_service_model.dart';
import 'package:zungu_mobile/providers/auth/auth_provider.dart';
import 'package:zungu_mobile/providers/auth/personal_profile_provider/personal_provider.dart';
import 'package:zungu_mobile/screens/settings/business%20profile/tradesman_business_profile/edit_location_screen.dart';
import 'package:zungu_mobile/widgets/no_content_label.dart';

import '../../../../constant/img_font_color_string.dart';
import '../../../../models/auth/auth_model.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/expand_child.dart';
import '../../../../widgets/loading_indicator.dart';

class EditTradeServiceOfferedScreen extends StatefulWidget {
  List<TradesService> tradesService;
  final String roleId;
  final bool isFromUpdate;
  EditTradeServiceOfferedScreen({
    super.key,
    this.tradesService = const [],
    required this.roleId,
    this.isFromUpdate = false,
  });

  @override
  State<EditTradeServiceOfferedScreen> createState() =>
      _EditTradeServiceOfferedScreenState();
}

class _EditTradeServiceOfferedScreenState
    extends State<EditTradeServiceOfferedScreen> {
  //----------------------------Variable-------------------------//
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();
  TextEditingController searchControlller = TextEditingController();
  List<TradesService> tradesServiceList = [];

  PersonalProfileProvider get personalProfileProvider =>
      Provider.of<PersonalProfileProvider>(context, listen: false);

  AuthProvider get authProvider =>
      Provider.of<AuthProvider>(context, listen: false);
  @override
  void initState() {
    tradesServiceList = widget.tradesService;
    super.initState();
  }

  //----------------------------Ui-------------------------//
  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Scaffold(
        bottomNavigationBar: widget.tradesService.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                  bottom: 20,
                ),
                child: CommonElevatedButton(
                  bttnText: Provider.of<PersonalProfileProvider>(
                            context,
                            listen: false,
                          ).fetchProfileModel?.profileCompleted ==
                          false
                      ? StaticString.next
                      : StaticString.uPDATE,
                  color: Provider.of<PersonalProfileProvider>(
                            context,
                            listen: false,
                          ).fetchProfileModel?.profileCompleted ==
                          false
                      ? ColorConstants.custDarkBlue150934
                      : ColorConstants.custskyblue22CBFE,
                  onPressed: () {
                    updateTradesServices(
                      widget.tradesService,
                    );
                  },
                ),
              )
            : Container(),
        appBar: AppBar(
          title: Text(
            Provider.of<PersonalProfileProvider>(
                      context,
                      listen: false,
                    ).fetchProfileModel?.profileCompleted ==
                    false
                ? StaticString.tradeServicesOffered
                : StaticString.tradeServicesOfferedtitle,
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 30,
                top: 25,
                right: 30,
                bottom: 25,
              ),
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: ColorConstants.custskyblue22CBFE,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    txtTitle: StaticString.addTradesServices,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: ColorConstants.backgroundColorFFFFFF,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 14),
                  CustomText(
                    txtTitle: StaticString.multiTradesServices,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _buildSearchField(),
            const SizedBox(height: 40),
            if (widget.tradesService.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                ),
                child: NoContentLabel(
                  title: StaticString.nodataFound,
                  onPress: () {},
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: tradesServiceList.length,
                itemBuilder: (BuildContext context, int i) {
                  return _buildTradeService(
                    // widget.tradesService[i],
                    tradesServiceList[i],
                  );
                },
              ),

            // if (widget.tradesService.isNotEmpty)
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 20),
            //     child: CommonElevatedButton(
            //       bttnText: Provider.of<PersonalProfileProvider>(
            //                 context,
            //                 listen: false,
            //               ).fetchProfileModel?.profileCompleted ==
            //               false
            //           ? StaticString.next
            //           : StaticString.uPDATE,
            //       color: Provider.of<PersonalProfileProvider>(
            //                 context,
            //                 listen: false,
            //               ).fetchProfileModel?.profileCompleted ==
            //               false
            //           ? ColorConstants.custDarkBlue150934
            //           : ColorConstants.custskyblue22CBFE,
            //       onPressed: () {
            //         updateTradesServices(
            //           widget.tradesService,
            //         );
            //       },
            //     ),
            //   ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTradeService(
    TradesService tradeserviceProfessionData,
  ) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (mounted) {
              setState(() {
                tradeserviceProfessionData.isExpaned =
                    !tradeserviceProfessionData.isExpaned;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: ColorConstants.custGrey707070.withOpacity(.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomText(
                    txtTitle: tradeserviceProfessionData.name,
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          color: ColorConstants.custDarkBlue150934,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                RotatedBox(
                  quarterTurns: tradeserviceProfessionData.isExpaned ? 90 : 0,
                  child: SvgPicture.asset(
                    ImgName.arrowDown,
                    height: 18,
                    width: 10,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        ExpandChild(
          expand: tradeserviceProfessionData.isExpaned,
          child: Column(
            children: tradeserviceProfessionData.child
                .map(
                  (tradeServiceList) => Column(
                    children: [
                      cupertinoSwitch(
                        tradeServiceProfessionChildData: tradeServiceList,
                      ),
                      Divider(
                        indent: 10,
                        endIndent: 10,
                        thickness: 0.5,
                        color: ColorConstants.custGrey707070.withOpacity(0.7),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget cupertinoSwitch({
    required Child tradeServiceProfessionChildData,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: CustomText(
              txtTitle: tradeServiceProfessionChildData.name,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    color: ColorConstants.custGrey7A7A7A,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Expanded(
            child: Switch.adaptive(
              activeColor: ColorConstants.custDarkBlue150934,
              activeTrackColor: ColorConstants.custDarkBlue150934,
              thumbColor:
                  MaterialStateProperty.all(ColorConstants.custGreyECECEC),
              value: tradeServiceProfessionChildData.isToggle,
              onChanged: (value) {
                if (mounted) {
                  setState(() {
                    tradeServiceProfessionChildData.isToggle = value;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Search field
  Widget _buildSearchField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
            blurRadius: 10,
          ),
        ],
      ),
      height: 46,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: searchControlller,
              cursorColor: ColorConstants.custBlue1BC4F4,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, right: 10, bottom: 5),
                hintText: "Search",
                hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstants.custGreyAEAEAE,
                    ),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              trdaesServiceSearch(searchControlller.text);
            },
            child: const CustImage(
              imgURL: ImgName.landlordSearch,
              width: 24,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  //--------------------------Helper function------------------------//

  Future<void> updateTradesServices(
    List<TradesService> tradesServiceModel,
  ) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );

      await personalProfileProvider.updateTradesOfferedService(
        widget.tradesService,
        widget.roleId,
      );
      await personalProfileProvider.fetchUserProfile(
        widget.roleId,
        isFromLandlord: true,
      );

      if (!(personalProfileProvider.fetchProfileModel?.profileCompleted ??
          true)) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => EditMyLocationscreen(
              roleId: widget.roleId,
              myLocation: personalProfileProvider.getMyLocation,
              isFromUpdate: widget.isFromUpdate,
            ),
          ),
        );
      } else if (personalProfileProvider.fetchProfileModel?.profileCompleted ??
          false) {
        final AuthModel? _auth = authProvider.authModel;

        _auth?.profile?.profileCompleted =
            personalProfileProvider.fetchProfileModel?.profileCompleted ??
                false;
        authProvider.authModel = _auth;
        if (widget.isFromUpdate) {
          Navigator.of(context).pop();
        }
      } else {
        Navigator.of(context).pop();
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  Future<void> trdaesServiceSearch(String name) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      tradesServiceList =
          await personalProfileProvider.tradesServiceSearch(name);
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
