import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/providers/auth/personal_profile_provider/personal_provider.dart';
import 'package:zungu_mobile/screens/settings/personal_profile/edit_personal_profile.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/image_picker_button.dart';
import 'package:zungu_mobile/widgets/lenear_container.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';
import 'package:zungu_mobile/widgets/no_content_label.dart';

import '../../../cards/buisness_info_card.dart';
import '../../../models/settings/personal_profile/user_profile_model.dart';
import '../../../providers/auth/auth_provider.dart';
import '../../../services/img_upload_service.dart';

class PersonalProfileScreen extends StatefulWidget {
  const PersonalProfileScreen({super.key});

  @override
  State<PersonalProfileScreen> createState() => _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends State<PersonalProfileScreen> {
  // --------Variables---------//
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  // provider
  PersonalProfileProvider get personalProfileProvider =>
      Provider.of<PersonalProfileProvider>(context, listen: false);

  AuthProvider get getAuthProvider =>
      Provider.of<AuthProvider>(context, listen: false);

  @override
  void initState() {
    fetchUserDataProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Scaffold(
        appBar: _buildAppbar(),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      // physics: const ClampingScrollPhysics(),
      child: Center(
        child: Consumer<PersonalProfileProvider>(
          builder: (context, auth, child) => auth.fetchUser == null
              ? const NoContentLabel(title: StaticString.nodataFound)
              : Column(
                  children: [
                    _cardContainer(auth.fetchUser!),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 30,
                      ),
                      child: _bodyContent(auth.fetchUser!),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

//  appbar...
  AppBar _buildAppbar() {
    return AppBar(
      title: const Text(
        StaticString.personalProfile,
      ),
    );
  }

//  body...
  Widget _bodyContent(UserProfileModel user) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              txtTitle: StaticString.personalInformation,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            InkWell(
              onTap: () {
                editOnTapAction(user);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: ColorConstants.custgreen19B445,
                ),
                child: CustomText(
                  txtTitle: StaticString.edit,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        LinearContainer(
          width: MediaQuery.of(context).size.width / 8,
          color: ColorConstants.custDarkPurple160935,
        ),
        const SizedBox(height: 3),
        LinearContainer(
          width: MediaQuery.of(context).size.width / 10,
          color: ColorConstants.custgreen19B445,
        ),
        const SizedBox(
          height: 25,
        ),
        BuisnessInfoCard(
          title: StaticString.regMobileNumber,
          subTitle: user.mobile,
          leading: ImgName.callImage,
        ),
        const SizedBox(
          height: 25,
        ),
        BuisnessInfoCard(
          title: StaticString.email,
          subTitle: user.email,
          leading: ImgName.landlordEmailCircle,
        ),
        const SizedBox(
          height: 25,
        ),
        BuisnessInfoCard(
          title: StaticString.address,
          subTitle: user.address?.fullAddress,
          leading: ImgName.landlordAddressCircle,
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }

  // User profile info card...
  Widget _cardContainer(UserProfileModel user) {
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
            onImageSelected: (images) async {
              if (images.isNotEmpty) {
                // update profile...
                updateProfile(images.first);
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
                      imgURL: user.profileImg,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: SvgPicture.asset(
                    ImgName.landlordCamera,
                    height: 25,
                    width: 25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 35),
          CustomText(
            txtTitle: user.fullName,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: ColorConstants.custBlue1EC0EF,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 5),
          CustomText(
            txtTitle: user.address?.country,
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

// fetch User Profile...
  Future<void> fetchUserDataProfile() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );

      await personalProfileProvider.fetchUserDetails();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  // user info editOnTap Action...
  void editOnTapAction(UserProfileModel userData) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => EditPersonalProfile(userData: userData),
      ),
    );
  }

  // update profile...
  Future<void> updateProfile(String profileImage) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      final String? userId = getAuthProvider.authModel?.userId;

      final List<String> urls =
          await ImgUploadService.instance.uploadProfilePicture(
        id: userId,
        images: [profileImage],
      );
      if (urls.isNotEmpty) {
        final UserProfileModel? fetchUser = personalProfileProvider.fetchUser;
        fetchUser?.profileImg = urls.first;
        await personalProfileProvider.userUpdate(fetchUser);
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
