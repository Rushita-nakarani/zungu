import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/models/settings/business_profile/fetch_profile_model.dart';
import 'package:zungu_mobile/providers/auth/personal_profile_provider/personal_provider.dart';
import 'package:zungu_mobile/screens/settings/business%20profile/landLoard_bussiness_profile/edit_landlord_business_profile.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/image_picker_button.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';
import 'package:zungu_mobile/widgets/no_content_label.dart';

import '../../../../cards/buisness_info_card.dart';
import '../../../../constant/img_font_color_string.dart';
import '../../../../services/img_upload_service.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/lenear_container.dart';

class LandlordBusinessProfileScreen extends StatefulWidget {
  final String roleId;
  const LandlordBusinessProfileScreen({
    Key? key,
    required this.roleId,
  }) : super(key: key);

  @override
  State<LandlordBusinessProfileScreen> createState() =>
      _LandlordBusinessProfileScreenState();
}

class _LandlordBusinessProfileScreenState
    extends State<LandlordBusinessProfileScreen> {
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  PersonalProfileProvider get profileProvider =>
      Provider.of<PersonalProfileProvider>(
        context,
        listen: false,
      );

  @override
  void initState() {
    fetchLandloardProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            StaticString.landlordBusinessProfile,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            // physics: const ClampingScrollPhysics(),
            child: SafeArea(
              child: Consumer<PersonalProfileProvider>(
                builder: (context, landloardPersonalProfile, child) {
                  return landloardPersonalProfile.fetchProfileModel == null
                      ? const NoContentLabel(title: StaticString.nodataFound)
                      : Column(
                          children: [
                            _buildProfileView(
                              landloardPersonalProfile.fetchProfileModel!,
                            ),
                            _buildBody(
                              landloardPersonalProfile.fetchProfileModel!,
                            ),
                          ],
                        );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(FetchProfileModel landloardUser) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Column(
        children: [
          const SizedBox(height: 5),
          _buildBusinessTitle(context, landloardUser),
          LinearContainer(
            width: MediaQuery.of(context).size.width / 8,
            color: ColorConstants.custDarkPurple160935,
          ),
          const SizedBox(height: 3),
          LinearContainer(
            width: MediaQuery.of(context).size.width / 10,
            color: ColorConstants.custgreen19B445,
          ),
          const SizedBox(height: 25),
          BuisnessInfoCard(
            title: StaticString.companyRegistrationNumber,
            subTitle: landloardUser.companyReg.toString(),
            leading: ImgName.company,
          ),
          const SizedBox(height: 25),
          BuisnessInfoCard(
            title: StaticString.landloardregistrationNumber,
            subTitle: landloardUser.registrationNumber.toString(),
            leading: ImgName.registerNumberImage,
          ),
          const SizedBox(height: 25),
          BuisnessInfoCard(
            title: StaticString.vatNumber,
            subTitle: landloardUser.vatNumber.toString(),
            leading: ImgName.vatNumber,
          ),
          const SizedBox(height: 25),
          BuisnessInfoCard(
            title: StaticString.phoneNumber,
            subTitle: landloardUser.mobile,
            leading: ImgName.phone,
          ),
          const SizedBox(height: 25),
          BuisnessInfoCard(
            title: StaticString.email,
            subTitle: landloardUser.email,
            leading: ImgName.landlordEmailCircle,
          ),
          const SizedBox(height: 25),
          BuisnessInfoCard(
            title: StaticString.website,
            subTitle: landloardUser.orgWebUrl,
            leading: ImgName.landlordWebCircle,
          ),
          const SizedBox(height: 25),
          BuisnessInfoCard(
            title: StaticString.address,
            subTitle: landloardUser.addresid?.fullAddress,
            leading: ImgName.landlordAddressCircle,
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _buildBusinessTitle(
    BuildContext context,
    FetchProfileModel landloardUser,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txtTitle: StaticString.businessInformation,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: ColorConstants.custgreen19B445,
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => EditLandloardBussinessProfileScreen(
                      profileModel: landloardUser,
                      roleId: widget.roleId,
                    ),
                  ),
                );
              },
              child: CustomText(
                txtTitle: StaticString.edit,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildProfileView(FetchProfileModel landloardUser) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        color: ColorConstants.custDarkPurple160935,
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
                      imgURL: landloardUser.profileImg,
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
            txtTitle: landloardUser.tradingName,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: ColorConstants.custBlue1EC0EF,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 5),
          CustomText(
            txtTitle: landloardUser.addresid?.country,
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
        final FetchProfileModel? fetchUser = profileProvider.fetchProfileModel;
        fetchUser?.profileImg = urls.first;
        await profileProvider.updatelandLoardProfile(
          fetchUser,
          widget.roleId,
          isFromLandlord: true,
        );
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  Future<void> fetchLandloardProfile() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      await profileProvider.fetchUserProfile(
        widget.roleId,
        isFromLandlord: true,
      );
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
