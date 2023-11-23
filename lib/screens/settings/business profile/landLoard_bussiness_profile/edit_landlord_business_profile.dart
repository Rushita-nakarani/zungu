import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/auth/auth_model.dart';
import 'package:zungu_mobile/models/settings/business_profile/bussiness_type_model.dart';
import 'package:zungu_mobile/models/settings/business_profile/fetch_profile_model.dart';
import 'package:zungu_mobile/providers/auth/auth_provider.dart';
import 'package:zungu_mobile/providers/auth/personal_profile_provider/personal_provider.dart';
import 'package:zungu_mobile/utils/common_funcations.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';
import 'package:zungu_mobile/widgets/common_auto_textformfield.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/custom_title_with_line.dart';
import 'package:zungu_mobile/widgets/image_upload_outlined_widget.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';

import '../../../../api/api_end_points.dart';
import '../../../../models/address_model.dart';
import '../../../../services/img_upload_service.dart';
import '../../../../utils/custom_extension.dart';
import '../../../../widgets/common_elevated_button.dart';

class EditLandloardBussinessProfileScreen extends StatefulWidget {
  final FetchProfileModel? profileModel;
  final String roleId;
  const EditLandloardBussinessProfileScreen({
    super.key,
    this.profileModel,
    required this.roleId,
  });

  @override
  State<EditLandloardBussinessProfileScreen> createState() =>
      _EditLandloardBussinessProfileScreenState();
}

class _EditLandloardBussinessProfileScreenState
    extends State<EditLandloardBussinessProfileScreen> {
  TextEditingController address2Controller = TextEditingController();
  TextEditingController address3Controller = TextEditingController();
  TextEditingController tradingNameController = TextEditingController();
  TextEditingController companyRegisteredController = TextEditingController();
  TextEditingController landLordRegisteredController = TextEditingController();
  TextEditingController vatNumberController = TextEditingController();
  TextEditingController telephoneNumberController = TextEditingController();
  TextEditingController emailAddresController = TextEditingController();
  TextEditingController websiteAddressController = TextEditingController();
  TextEditingController addressline1Controller = TextEditingController();
  TextEditingController zippostalController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidationMode = AutovalidateMode.disabled;
  BussinessType bussinessType = BussinessType.soleTrader;
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  BussinessData? _selectedBusinessType;

  FetchProfileModel? profileModel;

  PersonalProfileProvider get profileProvider =>
      Provider.of<PersonalProfileProvider>(
        context,
        listen: false,
      );
  AuthProvider get authProvider => Provider.of<AuthProvider>(
        context,
        listen: false,
      );

  @override
  void initState() {
    profileModel = widget.profileModel;
    fetchBussinessType();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: LoadingIndicator(
        loadingStatusNotifier: _loadingIndicatorNotifier,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              profileModel?.profileCompleted == false
                  ? StaticString.landlordBusinessProfile
                  : StaticString.editLandloardBussinessProfile,
            ),
          ),
          body: _buildBody(context),
        ),
      ),
    );
  }

  SafeArea _buildBody(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        autovalidateMode: autovalidationMode,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTitleWithLine(
                title: StaticString.bussinessType,
                primaryColor: ColorConstants.custDarkBlue160935,
                secondaryColor: ColorConstants.custgreen19B445,
              ),
              const SizedBox(height: 33),
              Consumer<PersonalProfileProvider>(
                builder: (context, businessType, child) => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: businessType.businessTypeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        if (mounted) {
                          setState(() {
                            _selectedBusinessType =
                                businessType.businessTypeList[index];
                          });
                        }
                      },
                      child: bussinessTypeCard(
                        businessType.businessTypeList[index],
                      ),
                    );
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 36),
                  _tradingNametxFeld(),
                  const SizedBox(height: 25),
                  _companyRegisterNumertxField(),
                  const SizedBox(height: 25),
                  _landLoardNumbertxfield(),
                  const SizedBox(height: 25),
                  _vatNumbertxField(),
                  const SizedBox(height: 25),
                  _telephoneNumbertxField(),
                  const SizedBox(height: 25),
                  _emailTxField(),
                  const SizedBox(height: 25),
                  _webAddresstxField(),
                  const SizedBox(height: 26),
                  CustomText(
                    txtTitle: StaticString.businessAddress,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 5),
                  SearchLocationautocomplete(
                    streetController: streetController,
                    onAddressSelect: (address) async {
                      landloardSerchAddress(address);
                    },
                    onTap: () {},
                  ),
                  const SizedBox(height: 25),
                  _add1txField(),
                  const SizedBox(height: 25),
                  _add2txField(),
                  const SizedBox(height: 25),
                  _add3txField(),
                  const SizedBox(height: 25),
                  _zipPostaltxfiels(),
                  const SizedBox(height: 25),
                  _citytxField(),
                  const SizedBox(height: 25),
                  _statetxField(),
                  const SizedBox(height: 25),
                  _countrytxField(),
                  const SizedBox(height: 30),
                  UploadMediaOutlinedWidget(
                    title: StaticString.uploadCompanyLogo,
                    userRole: UserRole.LANDLORD,
                    image: ImgName.landlordCamera,
                    showOptional: false,
                    maxImages: 1,
                    prefillImages: (profileModel?.profileImg.isEmpty ?? true)
                        ? []
                        : [profileModel?.profileImg ?? ""],
                    onSelectImg: (selectedImages) async {
                      if (selectedImages.isNotEmpty) {
                        if (mounted) {
                          setState(() {
                            profileModel?.profileImg = selectedImages.first;
                          });
                        }
                      }
                    },
                    onRemove: (img) {
                      profileModel?.profileImg = "";
                    },
                  ),
                  const SizedBox(height: 50),
                  CommonElevatedButton(
                    onPressed: () {
                      userUpdateProfile();
                    },
                    fontSize: 16,
                    bttnText: profileModel?.profileCompleted == false
                        ? StaticString.submit
                        : StaticString.uPDATE,
                    color: profileModel?.profileCompleted == false
                        ? ColorConstants.custDarkBlue150934
                        : ColorConstants.custskyblue22CBFE,
                  ),
                  const SizedBox(height: 20),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _countrytxField() {
    return TextFormField(
      controller: countryController,
      autovalidateMode: autovalidationMode,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateCountry,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.country,
      ),
    );
  }

  TextFormField _statetxField() {
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

  TextFormField _citytxField() {
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

  TextFormField _zipPostaltxfiels() {
    return TextFormField(
      controller: zippostalController,
      autovalidateMode: autovalidationMode,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateZipcode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.zipPostalcord,
      ),
    );
  }

  TextFormField _add3txField() {
    return TextFormField(
      controller: address3Controller,
      autovalidateMode: autovalidationMode,
      cursorColor: ColorConstants.custDarkBlue160935,
      // validator: (value) => value?.validateName,
      keyboardType: TextInputType.text,

      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.addressline3,
      ),
    );
  }

  TextFormField _add2txField() {
    return TextFormField(
      controller: address2Controller,
      autovalidateMode: autovalidationMode,
      cursorColor: ColorConstants.custDarkBlue160935,
      // validator: (value) => value?.validateName,
      keyboardType: TextInputType.text,

      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.addressline2,
      ),
    );
  }

  TextFormField _add1txField() {
    return TextFormField(
      controller: addressline1Controller,
      autovalidateMode: autovalidationMode,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateAddress,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.addressline1,
      ),
    );
  }

  TextFormField _webAddresstxField() {
    return TextFormField(
      controller: websiteAddressController,
      autovalidateMode: autovalidationMode,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateWebsiteAddress,
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.websiteAddress,
      ),
    );
  }

  TextFormField _emailTxField() {
    return TextFormField(
      controller: emailAddresController,
      autovalidateMode: autovalidationMode,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateEmail,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.emailAddress,
      ),
    );
  }

  TextFormField _telephoneNumbertxField() {
    return TextFormField(
      controller: telephoneNumberController,
      autovalidateMode: autovalidationMode,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateTelephone,
      keyboardType: TextInputType.number,
      maxLength: 10,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.telephoneNumber,
      ),
    );
  }

  TextFormField _vatNumbertxField() {
    return TextFormField(
      controller: vatNumberController,
      autovalidateMode: autovalidationMode,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateVAT,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.vatNumber,
      ),
    );
  }

  TextFormField _landLoardNumbertxfield() {
    return TextFormField(
      controller: landLordRegisteredController,
      autovalidateMode: autovalidationMode,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateLandloardRegisterNumber,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.landloardregisterNumber,
      ),
    );
  }

  TextFormField _companyRegisterNumertxField() {
    return TextFormField(
      controller: companyRegisteredController,
      autovalidateMode: autovalidationMode,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateCompanyRegister,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.companyRegistrationNumber,
      ),
    );
  }

  TextFormField _tradingNametxFeld() {
    return TextFormField(
      controller: tradingNameController,
      autovalidateMode: autovalidationMode,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validatetrandingName,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: commonImputdecoration(
        labletext: StaticString.tradingName,
      ),
    );
  }

  // void updateOnTap() {
  //   if (!formKey.currentState!.validate()) {
  //     autovalidationMode = AutovalidateMode.always;
  //     final FocusScopeNode currentFocus = FocusScope.of(context);

  //     if (!currentFocus.hasPrimaryFocus) {
  //       currentFocus.unfocus();
  //     }
  //   }
  // }

  InputDecoration commonImputdecoration({required String labletext}) {
    return InputDecoration(
      counterText: "",
      labelText: labletext,
    );
  }

  Widget bussinessTypeCard(
    BussinessData bussinessData,
  ) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _selectedBusinessType?.id == bussinessData.id
                  ? ColorConstants.custDarkBlue150934
                  : ColorConstants.backgroundColorFFFFFF,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 8,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child: CustImage(
              imgURL: bussinessData.businessIcon,
              height: MediaQuery.of(context).size.width / 6,
            ),
          ),
          const SizedBox(height: 8),
          CustomText(
            txtTitle: bussinessData.businessName,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchBussinessType() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );

      await profileProvider.businessTypeApi();
      await assignedInitialValue();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  Future<void> landloardSerchAddress(
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
            profileModel?.addresid = AddressModel(
              fullAddress: address,
              addressLine1: addressLine1,
              addressLine2: addressLine2,
              addressLine3: addressLine3,
              city: _placeMark.subAdministrativeArea ?? "",
              state: _placeMark.administrativeArea ?? "",
              country: _placeMark.country ?? "",
              zipCode: _placeMark.postalCode ?? "",
            );

            assignedInitialValue(onlyProfile: true);
          }
        }
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  Future<void> userUpdateProfile() async {
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
        addressLine1: addressline1Controller.text,
        addressLine2: address2Controller.text,
        addressLine3: address3Controller.text,
        city: cityController.text,
        country: countryController.text,
        fullAddress: streetController.text,
        state: stateController.text,
        zipCode: zippostalController.text,
      );

      // ignore: prefer_final_locals
      FetchProfileModel fetchProfileModel = FetchProfileModel(
        email: emailAddresController.text,
        mobile: telephoneNumberController.text,
        companyReg: companyRegisteredController.text,
        orgWebUrl: websiteAddressController.text,
        tradingName: tradingNameController.text,
        registrationNumber: landLordRegisteredController.text,
        vatNumber: companyRegisteredController.text,
        addresid: _address,
      );
      fetchProfileModel.addresid?.fullAddress = getFullAddress(_address);
      if (_selectedBusinessType == null) {
        throw StaticString.selectBusinessType;
      } else {
        if ((profileModel?.profileImg.isNotEmpty ?? false) &&
            (!(profileModel?.profileImg.isNetworkImage ?? false))) {
          final List<String> urls =
              await ImgUploadService.instance.uploadProfilePicture(
            id: widget.roleId,
            images: [profileModel!.profileImg],
          );
          profileModel?.profileImg = urls.first;
          fetchProfileModel.profileImg = urls.first;
        } else {
          fetchProfileModel.profileImg = profileModel?.profileImg ?? "";
        }
        fetchProfileModel.businessId = _selectedBusinessType?.id ?? "";
        await profileProvider.updatelandLoardProfile(
          fetchProfileModel,
          widget.roleId,
          isFromLandlord: true,
        );
        if ((profileProvider.fetchProfileModel?.profileCompleted ?? false) &&
            widget.profileModel == null) {
          print("*******");
          final AuthModel? _auth = authProvider.authModel;
          _auth?.profile?.profileCompleted =
              profileProvider.fetchProfileModel?.profileCompleted ?? false;
          authProvider.authModel = _auth;
         
        } else {
          print("#######");
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  Future<void> assignedInitialValue({bool onlyProfile = false}) async {
    if (profileModel == null) {
      await fetchLandloardProfile();
    }
    if (profileModel != null) {
      if (mounted) {
        setState(() {
          final List<BussinessData> _businessData =
              profileProvider.businessTypeList
                  .where(
                    (element) => element.id == profileModel?.businessId,
                  )
                  .toList();
          if (_businessData.isNotEmpty) {
            if (mounted) {
              setState(() {
                _selectedBusinessType = _businessData.first;
              });
            }
          }
        });
      }
      if (onlyProfile) {
        addressline1Controller.text =
            profileModel!.addresid?.addressLine1 ?? "";
        address2Controller.text = profileModel!.addresid?.addressLine2 ?? "";
        address3Controller.text = profileModel!.addresid?.addressLine3 ?? "";
        streetController.text = profileModel!.addresid?.fullAddress ?? "";
        zippostalController.text = profileModel!.addresid?.zipCode ?? "";
        cityController.text = profileModel!.addresid?.city ?? "";
        stateController.text = profileModel!.addresid?.state ?? "";
        countryController.text = profileModel!.addresid?.country ?? "";
      } else {
        emailAddresController.text = profileModel!.email;

        vatNumberController.text = profileModel!.vatNumber ?? "";
        companyRegisteredController.text = profileModel!.companyReg ?? "";
        websiteAddressController.text = profileModel!.orgWebUrl;
        telephoneNumberController.text = profileModel!.mobile;
        landLordRegisteredController.text =
            profileModel!.registrationNumber ?? "";
        addressline1Controller.text =
            profileModel!.addresid?.addressLine1 ?? "";
        address2Controller.text = profileModel!.addresid?.addressLine2 ?? "";
        address3Controller.text = profileModel!.addresid?.addressLine3 ?? "";
        streetController.text = profileModel!.addresid?.fullAddress ?? "";
        zippostalController.text = profileModel!.addresid?.zipCode ?? "";
        cityController.text = profileModel!.addresid?.city ?? "";
        stateController.text = profileModel!.addresid?.state ?? "";
        countryController.text = profileModel!.addresid?.country ?? "";
        tradingNameController.text = profileModel!.tradingName;
      }
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

      profileModel = profileProvider.fetchProfileModel;
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
