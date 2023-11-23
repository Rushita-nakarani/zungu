import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/settings/business_profile/fetch_profile_model.dart';
import 'package:zungu_mobile/providers/auth/personal_profile_provider/personal_provider.dart';
import 'package:zungu_mobile/screens/settings/business%20profile/tradesman_business_profile/view_and_edit_trade_screen.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';
import 'package:zungu_mobile/widgets/no_content_label.dart';
import 'package:zungu_mobile/widgets/rich_text.dart';

import '../../../../models/auth/auth_model.dart';
import '../../../../models/settings/business_profile/view_edit_trades_document_model.dart';
import '../../../../providers/auth/auth_provider.dart';
import '../../../../services/in_app_purchase_service.dart';
import '../../../../utils/cust_eums.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_title_with_line.dart';
import '../../../../widgets/html_view.dart';

class StartFreeTrialAccountInactive extends StatefulWidget {
  final FetchProfileModel profileModel;
  const StartFreeTrialAccountInactive({super.key, required this.profileModel});

  @override
  State<StartFreeTrialAccountInactive> createState() =>
      _StartFreeTrialAccountInactiveState();
}

class _StartFreeTrialAccountInactiveState
    extends State<StartFreeTrialAccountInactive> {
  //-----------------------Variables-----------------------//

  bool isCheck = false;
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();
  //-----------------------UI-----------------------//
  PersonalProfileProvider get profileProvider =>
      Provider.of<PersonalProfileProvider>(
        context,
        listen: false,
      );

  @override
  void initState() {
    fetchTrdaesDocuments();
    super.initState();
  }

  @override
  void dispose() {
    PaymentService.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: PaymentService.instance.loadingIndicator,
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text(
        //     StaticString.startFreeTrialAccountInactive,
        //   ),
        // ),
        body: LoadingIndicator(
          loadingStatusNotifier: _loadingIndicatorNotifier,
          child: RefreshIndicator(
            onRefresh: () async {
              await profileProvider.fetchTradesDocuments(
                widget.profileModel.id,
                widget.profileModel.roleId,
              );
              await fetchProfileInfo();
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Column(
                          children: [
                            //Active Subscription Image
                            const CustImage(
                              imgURL: ImgName.activesubscriptionImage,
                              height: 105,
                              width: 105,
                            ),
                            const SizedBox(height: 20),

                            //Account activation text
                            CustomText(
                              txtTitle: StaticString.accountactivation,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: 15),

                            //Pending Text
                            CustomText(
                              txtTitle: (!widget.profileModel.isActive)
                                  ? StaticString.pending
                                  : StaticString.approved.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(
                                    color: !widget.profileModel.isActive
                                        ? ColorConstants.custRedFF0000
                                        : ColorConstants.custgreen19B445,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: 15),

                            //Account Activation Detail Msg Text
                            CustomText(
                              align: TextAlign.center,
                              txtTitle: !widget.profileModel.isActive
                                  ? StaticString.pendingMsg
                                  : StaticString.approvedMsg,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    color: ColorConstants.custGreyA4A4A4,
                                  ),
                            ),
                            const SizedBox(height: 35),
                          ],
                        ),
                      ),
                    ),
                    // Trades Documents Header Text
                    const CustomTitleWithLine(
                      title: StaticString.tradeDocuments,
                      primaryColor: ColorConstants.custDarkPurple160935,
                      secondaryColor: ColorConstants.custGreen3DAE74,
                    ),
                    const SizedBox(height: 20),
                    Consumer<PersonalProfileProvider>(
                      builder: (context, documentData, child) {
                        return documentData.viewEditTradesDocumentList.isEmpty
                            ? NoContentLabel(
                                title: StaticString.nodataFound,
                                onPress: () {
                                  fetchTrdaesDocuments();
                                },
                              )
                            : ListView.builder(
                                itemCount: documentData
                                    .viewEditTradesDocumentList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return _buildTradeDocumentDetail(
                                    documentData
                                        .viewEditTradesDocumentList[index]
                                        .tradeDocumentTypeId
                                        ?.name,
                                    documentData
                                        .viewEditTradesDocumentList[index]
                                        .finalApprovalStatus,
                                    documentData
                                            .viewEditTradesDocumentList[index]
                                            .tradeDocumentTypeId
                                            ?.isRequired ??
                                        false,
                                    // StatusType.approved,
                                  );
                                },
                              );
                      },
                    ),

                    const SizedBox(height: 35),

                    // Your # month Free Trial Msg
                    if (!widget.profileModel.isActive)
                      const SizedBox(height: 0)
                    else
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: CustomText(
                          txtTitle: StaticString.your3MonthFreeTrialMsg,
                          align: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: ColorConstants.custGrey707070,
                                  ),
                        ),
                      ),

                    // accept Subscription terms and Continue text and checkbox
                    if (!widget.profileModel.isActive)
                      const SizedBox(height: 0)
                    else
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Row(
                          children: [
                            //Check box
                            InkWell(
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    isCheck = !isCheck;
                                  });
                                }
                              },
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  const Icon(
                                    Icons.square_outlined,
                                    color: ColorConstants.custGrey707070,
                                    size: 30,
                                  ),
                                  if (isCheck)
                                    const CustImage(
                                      imgURL: ImgName.greenCheck,
                                      height: 27,
                                      width: 27,
                                    )
                                  else
                                    Container()
                                ],
                              ),
                            ),
                            const SizedBox(width: 5),

                            //Accept Subscription Terms & Continue Text
                            CustomRichText(
                              title:
                                  StaticString.acceptSubscriptionTermsContinue,
                              onTap: (text) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => const HtmlCommonView(
                                      title: StaticString.termsAndConditons,
                                      viewType: HtmlViewType.TC,
                                    ),
                                  ),
                                );
                              },
                              fancyTextStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    color: ColorConstants.custBlue1EC0EF,
                                  ),
                              normalTextStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    color: ColorConstants.custGrey707070,
                                  ),
                            )
                          ],
                        ),
                      ),

                    CommonElevatedButton(
                      bttnText: StaticString.startFreeTrial,
                      color: !isCheck || (!widget.profileModel.isActive)
                          ? ColorConstants.custBlue1EC0EF.withOpacity(.30)
                          : ColorConstants.custBlue1EC0EF,
                      onPressed: !isCheck || (!widget.profileModel.isActive)
                          ? null
                          : startFreeTrialBtnAction,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //-------------------------Widget--------------------//

  //Custom Trades Document Row
  Widget _buildTradeDocumentDetail(
    String? subType,
    String? status,
    bool isRequired,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.arrow_right_alt_sharp,
          size: 20,
          color: ColorConstants.custGrey707070,
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: RichText(
            text: TextSpan(
              text: subType,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    color: ColorConstants.custDarkBlue160935,
                  ),
              children: <TextSpan>[
                TextSpan(
                  text: isRequired ? StaticString.required : "",
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: ColorConstants.custDarkBlue160935,
                      ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: () {
              if (status?.toUpperCase() ==
                  StaticString.uploadDoc.toUpperCase()) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => ViewEditTradeDocumentscreen(
                      getProfileData: profileProvider.fetchProfileModel!,
                      viewEditTradesDocumentsList: viewEditDocfromRef(
                        profileProvider.viewEditTradesDocumentList,
                      ),
                      isFromUpdate: true,
                    ),
                  ),
                );
              }
            },
            child: CustomText(
              txtTitle: status,
              align: TextAlign.right,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: status?.toUpperCase() ==
                            StaticString.approved.toUpperCase()
                        ? ColorConstants.custgreen19B445
                        : status?.toUpperCase() ==
                                StaticString.rejected.toUpperCase()
                            ? Colors.red
                            : status?.toUpperCase() ==
                                    StaticString.underReview.toUpperCase()
                                ? Colors.amber
                                : status?.toUpperCase() ==
                                        StaticString.uploadDoc.toUpperCase()
                                    ? ColorConstants.custskyblue22CBFE
                                    : ColorConstants.custDarkBlue160935,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> fetchTrdaesDocuments() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      await profileProvider.fetchTradesDocuments(
        widget.profileModel.id,
        widget.profileModel.roleId,
      );
      await PaymentService.instance.initConnection();
      await fetchProfileInfo();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  //---------------------------Button Action----------------------//
  Future<void> startFreeTrialBtnAction() async {
    try {
      PaymentService.instance.loadingIndicator.show();
      final String profileId =
          Provider.of<PersonalProfileProvider>(context, listen: false)
                  .fetchProfileModel
                  ?.userId ??
              "";

      await PaymentService.instance.buyTradespersonProduct(
        profileId,
        () async {
          await fetchProfileInfo();
        },
      );
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      PaymentService.instance.loadingIndicator.hide();
    }
  }

  Future<void> fetchProfileInfo() async {
    final ProfileModel? profile =
        Provider.of<AuthProvider>(context, listen: false).authModel?.profile;
    if (profile != null) {
      await Future.wait([
        Provider.of<PersonalProfileProvider>(
          context,
          listen: false,
        ).fetchUserProfile(
          profile.roleId,
          isFromLandlord: profile.userRole != UserRole.TRADESPERSON,
        ),
        Provider.of<PersonalProfileProvider>(
          context,
          listen: false,
        ).fetchUserDetails()
      ]);
    }
  }
}
