import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/settings/business_profile/fetch_profile_model.dart';
import 'package:zungu_mobile/models/settings/business_profile/trades_service_model.dart';
import 'package:zungu_mobile/models/settings/business_profile/view_edit_trades_document_model.dart';
import 'package:zungu_mobile/screens/settings/business%20profile/tradesman_business_profile/edit_location_screen.dart';
import 'package:zungu_mobile/screens/settings/business%20profile/tradesman_business_profile/edit_trades_service_offered_screen.dart';
import 'package:zungu_mobile/screens/settings/business%20profile/tradesman_business_profile/edit_tradesman_bussiness_profile.dart';
import 'package:zungu_mobile/screens/settings/business%20profile/tradesman_business_profile/view_and_edit_trade_screen.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/lenear_container.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';

import '../../../../cards/buisness_info_card.dart';
import '../../../../providers/auth/personal_profile_provider/personal_provider.dart';
import '../../../../services/img_upload_service.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/image_picker_button.dart';
import '../../../../widgets/no_content_label.dart';

class TradesmanBussinessProfileScreen extends StatefulWidget {
  final String? roleId;
  const TradesmanBussinessProfileScreen({
    super.key,
    this.roleId,
  });

  @override
  State<TradesmanBussinessProfileScreen> createState() =>
      _TradesmanBussinessProfileScreenState();
}

class _TradesmanBussinessProfileScreenState
    extends State<TradesmanBussinessProfileScreen> {
  // StatusType statusType = StatusType.approved;
  int page = 1;
  String? _profileImage;
  String? statusColor;
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();
  PersonalProfileProvider get personalProfileProvider =>
      Provider.of<PersonalProfileProvider>(context, listen: false);

  @override
  void initState() {
    fetchtradesPersonProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StaticString.tradesmanBussinessProfile),
        ),
        body: SingleChildScrollView(
          // physics: const ClampingScrollPhysics(),
          child: Consumer<PersonalProfileProvider>(
            builder: (context, tradesBusinessProfile, child) {
              return tradesBusinessProfile.fetchProfileModel == null ||
                      tradesBusinessProfile.tradesServiceModel == null ||
                      tradesBusinessProfile.viewEditTradesDocumentList.isEmpty
                  ? const NoContentLabel(title: StaticString.nodataFound)
                  : Column(
                      children: [
                        _buildProfileView(
                          tradesBusinessProfile.fetchProfileModel!,
                        ),
                        _buildBody(
                          tradesBusinessProfile.fetchProfileModel!,
                          tradesBusinessProfile.tradesServiceNameList,
                          tradesBusinessProfile.tradesServiceModel!,
                          tradesBusinessProfile.viewEditTradesDocumentList,
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    FetchProfileModel trdaesPersonUser,
    List<TradesService> tradesServiceNameList,
    TradesServiceModel tradesServiceModel,
    List<ViewEditTradesDocumentModel> viewEditTradesDocumentList,
  ) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          children: [
            const SizedBox(height: 5),
            _buildBusinessTitle(context, StaticString.businessInformation, true,
                () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => EditTradesmanBussinessProfileScreen(
                    tradesprofileModel: trdaesPersonUser,
                    roleId: widget.roleId ?? "",
                    isFromUpdate: true,
                  ),
                ),
              );
            }),
            LinearContainer(
              width: MediaQuery.of(context).size.width / 8,
              color: ColorConstants.custDarkBlue160935,
            ),
            const SizedBox(height: 3),
            LinearContainer(
              width: MediaQuery.of(context).size.width / 10,
              color: ColorConstants.custgreen19B445,
            ),
            const SizedBox(height: 25),
            BuisnessInfoCard(
              title: StaticString.companyRegistrationNumber,
              subTitle: trdaesPersonUser.companyReg.toString(),
              leading: ImgName.company,
            ),
            const SizedBox(height: 25),
            BuisnessInfoCard(
              title: StaticString.tradesmanBussinessProfile,
              subTitle: trdaesPersonUser.registrationNumber.toString(),
              leading: ImgName.registerNumberImage,
            ),
            const SizedBox(height: 25),
            BuisnessInfoCard(
              title: StaticString.vatNumber,
              subTitle: trdaesPersonUser.vatNumber.toString(),
              leading: ImgName.vatNumber,
            ),
            const SizedBox(height: 25),
            BuisnessInfoCard(
              title: StaticString.phoneNumber,
              subTitle: trdaesPersonUser.mobile,
              leading: ImgName.phone,
            ),
            const SizedBox(height: 25),
            BuisnessInfoCard(
              title: StaticString.email,
              subTitle: trdaesPersonUser.email,
              leading: ImgName.landlordEmailCircle,
            ),
            const SizedBox(height: 25),
            BuisnessInfoCard(
              title: StaticString.website,
              subTitle: trdaesPersonUser.orgWebUrl,
              leading: ImgName.landlordWebCircle,
            ),
            const SizedBox(height: 25),
            BuisnessInfoCard(
              title: StaticString.address,
              subTitle: trdaesPersonUser.addresid?.fullAddress,
              leading: ImgName.landlordAddressCircle,
            ),
            const SizedBox(height: 45),
            _buildBusinessTitle(
                context, StaticString.tradeServicesOffered, true, () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => EditTradeServiceOfferedScreen(
                    tradesService: TradesServiceModel.fromJson(
                      tradesServiceModel.toJson(),
                    ).services,
                    roleId: trdaesPersonUser.roleId,
                    isFromUpdate: true,
                  ),
                ),
              );

              if (mounted) {
                setState(() {});
              }
            }),
            LinearContainer(
              width: MediaQuery.of(context).size.width / 8,
              color: ColorConstants.custDarkBlue160935,
            ),
            const SizedBox(height: 3),
            LinearContainer(
              width: MediaQuery.of(context).size.width / 10,
              color: ColorConstants.custgreen19B445,
            ),
            const SizedBox(height: 18),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: tradesServiceNameList.length,
              itemBuilder: (context, servicesIndex) {
                final List<Child> _childList =
                    tradesServiceNameList[servicesIndex]
                        .child
                        .where((element) => element.isToggle)
                        .toList();

                // tradesServiceModel.services.where(

                //   },
                // );
                return Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.arrow_right_alt_sharp,
                          size: 30,
                          color: ColorConstants.custGrey707070,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          txtTitle: tradesServiceNameList[servicesIndex].name,
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstants.custDarkBlue160935,
                                  ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _childList.length,
                      itemBuilder: (context, childIndex) {
                        return _buildSublist(
                          _childList[childIndex].name,
                        );
                      },
                    )
                  ],
                );
              },
            ),
            const SizedBox(height: 30),
            _buildBusinessTitle(context, StaticString.myLocation, true, () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => EditMyLocationscreen(
                    roleId: trdaesPersonUser.roleId,
                    myLocation: trdaesPersonUser.myLocation,
                    isFromUpdate: true,
                  ),
                ),
              );
            }),
            LinearContainer(
              width: MediaQuery.of(context).size.width / 8,
              color: ColorConstants.custDarkBlue160935,
            ),
            const SizedBox(height: 3),
            LinearContainer(
              width: MediaQuery.of(context).size.width / 10,
              color: ColorConstants.custgreen19B445,
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorConstants.backgroundColorFFFFFF,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomText(
                  txtTitle:
                      "Within ${trdaesPersonUser.myLocation?.coverage.round().toString()} miles of ${trdaesPersonUser.myLocation?.postCode ?? 0}",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildBusinessTitle(context, StaticString.tradeDocuments, false,
                () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ViewEditTradeDocumentscreen(
                    getProfileData: trdaesPersonUser,
                    viewEditTradesDocumentsList:
                        viewEditDocfromRef(viewEditTradesDocumentList),
                    isFromUpdate: true,
                  ),
                ),
              );
            }),
            LinearContainer(
              width: MediaQuery.of(context).size.width / 8,
              color: ColorConstants.custDarkBlue160935,
            ),
            const SizedBox(height: 3),
            LinearContainer(
              width: MediaQuery.of(context).size.width / 10,
              color: ColorConstants.custgreen19B445,
            ),
            const SizedBox(height: 15),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewEditTradesDocumentList.length,
              // trdaesmanUpdate
              //     .viewEditTradesDocumentList.length,
              itemBuilder: (context, index) {
                return _buildTradeDocumentDetail(
                  viewEditTradesDocumentList[index].tradeDocumentTypeId?.name ??
                      "",
                  viewEditTradesDocumentList[index].finalApprovalStatus,
                  "",
                  viewEditTradesDocumentList[index]
                          .tradeDocumentTypeId
                          ?.isRequired ??
                      false,
                );
              },
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _buildTradeDocumentDetail(
    String? subType,
    String? status,
    String errorMsg,
    bool isRequired,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 5, left: 5),
              child: Icon(
                Icons.arrow_right_alt_sharp,
                size: 25,
                color: ColorConstants.custGrey707070,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: RichText(
                      text: TextSpan(
                        text: subType,
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                              color: ColorConstants.custDarkBlue160935,
                            ),
                        children: <TextSpan>[
                          TextSpan(
                            text: isRequired ? StaticString.required : "",
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: ColorConstants.custDarkBlue160935,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              flex: 2,
              child: CustomText(
                txtTitle: status,
                align: TextAlign.right,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: status == StaticString.approved.toUpperCase()
                          ? ColorConstants.custgreen19B445
                          : status == StaticString.rejected.toUpperCase()
                              ? Colors.red
                              : status == StaticString.underReview.toUpperCase()
                                  ? Colors.amber
                                  : status ==
                                          StaticString.uploadDoc.toUpperCase()
                                      ? ColorConstants.custskyblue22CBFE
                                      : status ==
                                              StaticString.reUploadDoc
                                                  .toUpperCase()
                                          ? ColorConstants.custskyblue22CBFE
                                          : ColorConstants.custDarkBlue160935,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _tradeInsuranceCard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 5, left: 5),
          child: Icon(
            Icons.arrow_right_alt_sharp,
            size: 25,
            color: ColorConstants.custGrey707070,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: CustomText(
                      txtTitle: StaticString.tradeInsurance,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstants.custDarkBlue160935,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    flex: 2,
                    child: CustomText(
                      txtTitle: StaticString.approved,
                      align: TextAlign.right,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstants.custgreen19B445,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: CustomText(
                      txtTitle: "(Expires on: 25 May 2023)",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: ColorConstants.custRedFF0000,
                          ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    flex: 2,
                    child: CustomText(
                      txtTitle: StaticString.reUploadDoc,
                      align: TextAlign.right,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstants.custBlue1EC0EF,
                          ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSublist(String? subType) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 40,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 5),
          child: CircleAvatar(
            radius: 5,
            backgroundColor: ColorConstants.custGrey707070,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: CustomText(
            txtTitle: subType ?? "",
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey707070,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessTitle(
    BuildContext context,
    String? headlineName,
    bool? edit,
    void Function()? onPressed,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txtTitle: headlineName ?? "",
          style: Theme.of(context).textTheme.headline1?.copyWith(
                color: ColorConstants.custDarkBlue160935,
                fontWeight: FontWeight.w500,
              ),
        ),
        InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: ColorConstants.custgreen19B445,
            ),
            child: CustomText(
              txtTitle:
                  edit == true ? StaticString.edit : StaticString.viewEditt,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildProfileView(FetchProfileModel trdaesPersonUser) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        color: ColorConstants.custDarkBlue160935,
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          ImagePickerButton(
            onImageSelected: (images) {
              if (images.isNotEmpty && mounted) {
                if (mounted) {
                  setState(() {
                    updateProfile(images.first);
                    // _profileImage = images[0];
                  });
                }
              }
            },
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  child: ClipOval(
                    child: CustImage(
                      imgURL: trdaesPersonUser.profileImg,
                    ),
                  ),
                ),
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: CustImage(
                    imgURL: ImgName.landlordCamera,
                    boxfit: BoxFit.contain,
                    height: 25,
                    width: 25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 35),
          CustomText(
            txtTitle: trdaesPersonUser.tradingName,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: ColorConstants.custBlue1EC0EF,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 5),
          CustomText(
            txtTitle: trdaesPersonUser.addresid?.country,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  //  FetchTradesPerson profile...
  Future<void> fetchtradesPersonProfile() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      await personalProfileProvider.fetchUserProfile(
        widget.roleId ?? "",
      );
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  Future<void> updateProfile(String profileImage) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );

      final List<String> urls =
          await ImgUploadService.instance.uploadProfilePicture(
        id: widget.roleId,
        images: [profileImage],
      );
      if (urls.isNotEmpty) {
        final FetchProfileModel? fetchUser =
            personalProfileProvider.fetchProfileModel;
        fetchUser?.profileImg = urls.first;

        await personalProfileProvider.updatelandLoardProfile(
          fetchUser,
          widget.roleId ?? "",
        );
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
