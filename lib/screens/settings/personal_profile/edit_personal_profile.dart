// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

import '../../../api/api_end_points.dart';
import '../../../constant/img_font_color_string.dart';
import '../../../models/address_model.dart';
import '../../../models/settings/personal_profile/user_profile_model.dart';
import '../../../providers/auth/personal_profile_provider/personal_provider.dart';
import '../../../screens/settings/personal_profile/edit_register_number_screen.dart';
import '../../../utils/common_funcations.dart';
import '../../../utils/custom_extension.dart';
import '../../../widgets/common_auto_textformfield.dart';
import '../../../widgets/common_elevated_button.dart';
import '../../../widgets/custom_alert.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_title_with_line.dart';
import '../../../widgets/loading_indicator.dart';

class EditPersonalProfile extends StatefulWidget {
  final UserProfileModel? userData;
  const EditPersonalProfile({super.key, this.userData});

  @override
  State<EditPersonalProfile> createState() => _EditPersonalProfileState();
}

class _EditPersonalProfileState extends State<EditPersonalProfile> {
  //---------------------------Variables-------------------------//

  // TextEditing Controller
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController address3Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController registernumberController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  //Form key
  final formKey = GlobalKey<FormState>();
  // Auto Validation Mode
  AutovalidateMode autovalidationMode = AutovalidateMode.disabled;
  // Loading Indicator
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  // Personal Profile Provider getter
  PersonalProfileProvider get personalProfileProvider =>
      Provider.of<PersonalProfileProvider>(context, listen: false);

  @override
  void initState() {
    assignedInitialValue(userProfileModel: widget.userData);
    super.initState();
  }
  //---------------------------UI-------------------------//

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            StaticString.editPersonalProfile,
          ),
        ),
        body: _buildBody(),
      ),
    );
  }
  //---------------------------Widgets-------------------------//

  // Body
  Widget _buildBody() {
    return GestureDetector(
      onTap: keyboardHideOntap,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Form(
            key: formKey,
            autovalidateMode: autovalidationMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card Info
                _buildCardInfo(),
                const SizedBox(height: 30),

                // Profile Header text with line
                const CustomTitleWithLine(
                  title: StaticString.profile,
                  primaryColor: ColorConstants.custDarkBlue160935,
                  secondaryColor: ColorConstants.custskyblue22CBFE,
                ),
                const SizedBox(height: 20),

                // Full name textfield
                _fullNameTextField(),
                const SizedBox(height: 20),

                //Email textfield
                _emailTextfield(),
                const SizedBox(height: 20),

                // My address text
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  child: CustomText(
                    txtTitle: StaticString.myaddress,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),

                // Serach Location field
                SearchLocationautocomplete(
                  streetController: streetController,
                  onAddressSelect: (address) async {
                    serchAddress(address);
                  },
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                // _landloardRegisterNumberTextField(),
                const SizedBox(height: 20),

                // Address 1 textfield
                _address1TextField(),
                const SizedBox(height: 20),
                // Address 2 textfield
                _address2Textfield(),
                const SizedBox(height: 20),
                // Address 3 textfield
                _address3Textfield(),
                const SizedBox(height: 20),
                // Address 4 textfield
                _zipcodeTextfield(),
                const SizedBox(height: 20),
                // Address 5 textfield
                _buildcityTextfield(),
                const SizedBox(height: 20),
                // State textfield
                _stateTextField(),
                const SizedBox(height: 20),
                //Country Textfield
                _countryTextField(),
                const SizedBox(height: 40),

                // Update Button
                CommonElevatedButton(
                  onPressed: () {
                    userUpdateDate();
                  },
                  fontSize: 16,
                  bttnText: StaticString.update,
                  color: ColorConstants.custskyblue22CBFE,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _countryTextField() {
    return TextFormField(
      controller: countryController,
      autovalidateMode: autovalidationMode,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateCountry,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.country,
      ),
    );
  }

  TextFormField _stateTextField() {
    return TextFormField(
      controller: stateController,
      autovalidateMode: autovalidationMode,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateState,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.state,
      ),
    );
  }

  TextFormField _buildcityTextfield() {
    return TextFormField(
      controller: cityController,
      autovalidateMode: autovalidationMode,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateCity,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.city,
      ),
    );
  }

  TextFormField _zipcodeTextfield() {
    return TextFormField(
      controller: zipcodeController,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateZipcode,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.zipPostalcord,
      ),
    );
  }

  TextFormField _address3Textfield() {
    return TextFormField(
      controller: address3Controller,
      cursorColor: ColorConstants.custDarkBlue160935,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.addressline3,
      ),
    );
  }

  TextFormField _address2Textfield() {
    return TextFormField(
      controller: address2Controller,
      cursorColor: ColorConstants.custDarkBlue160935,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.addressline2,
      ),
    );
  }

  TextFormField _address1TextField() {
    return TextFormField(
      controller: address1Controller,
      autovalidateMode: autovalidationMode,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateAddress,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.addressline1,
      ),
    );
  }

  // TextFormField _landloardRegisterNumberTextField() {
  //   return TextFormField(
  //     autovalidateMode: autovalidationMode,
  //     controller: registernumberController,
  //     cursorColor: ColorConstants.custDarkBlue160935,
  //     validator: (value) => value?.validatePhoneNumber,
  //     keyboardType: TextInputType.number,
  //     textInputAction: TextInputAction.next,
  //     decoration: commonImputdecoration(
  //       labletext: StaticString.landloardregisterNumber,
  //     ),
  //   );
  // }

  TextFormField _emailTextfield() {
    return TextFormField(
      controller: emailController,
      autovalidateMode: autovalidationMode,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateEmail,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.email,
      ),
    );
  }

  TextFormField _fullNameTextField() {
    return TextFormField(
      controller: fullnameController,
      autovalidateMode: autovalidationMode,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateYourName,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.fullName,
      ),
    );
  }

  InputDecoration commonImputdecoration({required String labletext}) {
    return InputDecoration(
      counterText: "",
      labelText: labletext,
    );
  }

  Container _buildCardInfo() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorConstants.backgroundColorFFFFFF,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(ImgName.callImage),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  txtTitle: StaticString.regMobileNumber,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<PersonalProfileProvider>(
                      builder: (context, profile, child) => CustomText(
                        txtTitle: profile.fetchUser?.mobile,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: ColorConstants.custGrey7A7A7A,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => EditRegisterNumberScreen(
                              userData: widget.userData,
                              isFromSecurity: true,
                            ),
                          ),
                        );
                      },
                      child: CustomText(
                        txtTitle: StaticString.edit,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: ColorConstants.custgreen19B445,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  //-----------------------------Button Action-----------------------//

  //Keyboard Hide Ontap
  void keyboardHideOntap() {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Future<void> serchAddress(
    String address,
  ) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );

      final GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: APISetup.kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      final PlacesSearchResponse result = await places.searchByText(
        "address=$address",
      );

      if (result.results.isNotEmpty) {
        if (result.results.first.geometry?.location != null) {
          final Location location = result.results.first.geometry!.location;

          final List<geo.Placemark> placemarks =
              await geo.placemarkFromCoordinates(location.lat, location.lng);
          if (placemarks.isNotEmpty) {
            final geo.Placemark _placeMark = placemarks.first;

            String addressLine1 = _placeMark.subThoroughfare ?? "";
            String addressLine2 = _placeMark.thoroughfare ?? "";
            String addressLine3 = _placeMark.street ?? "";
            if (addressLine1.isEmpty) {
              addressLine1 = addressLine2;
              addressLine2 = addressLine3;
              addressLine3 = "";
            }
            widget.userData?.address = AddressModel(
              fullAddress: address,
              addressLine1: addressLine1,
              addressLine2: addressLine2,
              addressLine3: addressLine3,
              city: _placeMark.subAdministrativeArea ?? "",
              state: _placeMark.administrativeArea ?? "",
              country: _placeMark.country ?? "",
              zipCode: _placeMark.postalCode ?? "",
            );

            assignedInitialValue(
              userProfileModel: widget.userData,
              onlyProfile: true,
            );
          }
        }
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  Future<void> userUpdateDate() async {
    try {
      if (!formKey.currentState!.validate()) {
        autovalidationMode = AutovalidateMode.always;
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        return;
      }
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );

      final AddressModel _address = AddressModel(
        addressLine1: address1Controller.text,
        addressLine2: address2Controller.text,
        addressLine3: address3Controller.text,
        city: cityController.text,
        country: countryController.text,
        fullAddress: streetController.text,
        state: stateController.text,
        zipCode: zipcodeController.text,
      );
      final UserProfileModel _userProfile = UserProfileModel(
        fullName: fullnameController.text,
        email: emailController.text,
        mobile: widget.userData?.mobile ?? "",
        userId: widget.userData?.userId ?? "",
        profileImg: widget.userData?.profileImg ?? "",
        address: _address,
      );
      _userProfile.address?.fullAddress = getFullAddress(_address);
      await personalProfileProvider.userUpdate(
        _userProfile,
      );
      Navigator.of(context).pop();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  void assignedInitialValue({
    UserProfileModel? userProfileModel,
    bool onlyProfile = false,
  }) {
    if (userProfileModel != null) {
      if (onlyProfile) {
        address1Controller.text = userProfileModel.address?.addressLine1 ?? "";
        address2Controller.text = userProfileModel.address?.addressLine2 ?? "";
        address3Controller.text = userProfileModel.address?.addressLine3 ?? "";
        streetController.text = userProfileModel.address?.fullAddress ?? "";
        zipcodeController.text = userProfileModel.address?.zipCode ?? "";
        cityController.text = userProfileModel.address?.city ?? "";
        stateController.text = userProfileModel.address?.state ?? "";
        countryController.text = userProfileModel.address?.country ?? "";
      } else {
        address1Controller.text = userProfileModel.address?.addressLine1 ?? "";
        address2Controller.text = userProfileModel.address?.addressLine2 ?? "";
        address3Controller.text = userProfileModel.address?.addressLine3 ?? "";
        fullnameController.text = userProfileModel.fullName;

        emailController.text = userProfileModel.email;
        streetController.text = userProfileModel.address?.fullAddress ?? "";
        zipcodeController.text = userProfileModel.address?.zipCode ?? "";
        cityController.text = userProfileModel.address?.city ?? "";
        stateController.text = userProfileModel.address?.state ?? "";
        countryController.text = userProfileModel.address?.country ?? "";
      }
      if (mounted) {
        setState(() {});
      }
    }
  }
}
