// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/main.dart';
import 'package:zungu_mobile/models/landloard/attribute_info_model.dart';
import 'package:zungu_mobile/models/settings/business_profile/fetch_profile_model.dart';

import '../../../../cards/property_card.dart';
import '../../../../constant/decoration.dart';
import '../../../../constant/img_font_color_string.dart';
import '../../../../models/landloard/add_tenant_property_detail_model.dart';
import '../../../../models/landloard/landlord_tenant_add_tenant_to_property.dart';
import '../../../../models/landloard/property_list_model.dart';
import '../../../../models/landloard/view_tenant_tenancy_model.dart';
import '../../../../providers/dashboard_provider/landlord_dashboard_provider.dart';
import '../../../../providers/landlord/tenant/add_tenant_property_detail_provider.dart';
import '../../../../providers/landlord/tenant/add_tenant_provider.dart';
import '../../../../providers/landlord/tenant/fetch_property_provider.dart';
import '../../../../providers/landlord/tenant/view_tenant_provider.dart';
import '../../../../providers/landlord_provider.dart';
import '../../../../services/img_upload_service.dart';
import '../../../../utils/cust_eums.dart';
import '../../../../utils/custom_extension.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_title_with_line.dart';
import '../../../../widgets/date_selector.dart';
import '../../../../widgets/image_upload_outlined_widget.dart';
import '../../../../widgets/loading_indicator.dart';
import '../../my properties/landlord_my_properties_details/landlord_my_properties_details_screen.dart';
import 'deposit_scheme_selector.dart';

class LandlordAddEditTenantRentDetailForm extends StatefulWidget {
  const LandlordAddEditTenantRentDetailForm({
    super.key,
    required this.property,
    this.tenancyId,
    this.doPop = false,
  });

  final LandlordAddTenantPropertyListModel property;
  final String? tenancyId;
  final bool doPop;

  @override
  State<LandlordAddEditTenantRentDetailForm> createState() =>
      _LandlordAddEditTenantRentDetailFormState();
}

class _LandlordAddEditTenantRentDetailFormState
    extends State<LandlordAddEditTenantRentDetailForm> {
  // form keys
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formSearchKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _tenantDetailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LandlordProvider get getPropertiesProvider =>
      Provider.of<LandlordProvider>(context, listen: false);

  // controllers
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _tenantNameController = TextEditingController();
  final TextEditingController _tenantEmailController = TextEditingController();
  final TextEditingController _rentalAmountController = TextEditingController();
  final TextEditingController _rentDueDateController = TextEditingController();
  final TextEditingController _depositController = TextEditingController();
  final TextEditingController _depositSchemeController =
      TextEditingController();
  final TextEditingController _depositIdController = TextEditingController();
  final TextEditingController _tenancyStartDateController =
      TextEditingController();
  final TextEditingController _tenancyEndDateController =
      TextEditingController();

  // notifiers
  final ValueNotifier _valueNotifier = ValueNotifier(true);
  final ValueNotifier _roomNotifier = ValueNotifier(true);
  final LoadingIndicatorNotifier _indicatorNotifier =
      LoadingIndicatorNotifier();

  // Providers
  LandlordTenantAddTenantToPropertyModel tenantModel =
      LandlordTenantAddTenantToPropertyModel();

  LandlordTenantProvider get landlordTenantProvider =>
      Provider.of<LandlordTenantProvider>(
        context,
        listen: false,
      );
  AddTenantPropertyDetailProvider get addTenantPropertyDetailProvider =>
      Provider.of<AddTenantPropertyDetailProvider>(
        context,
        listen: false,
      );

  LandlordTenantPropertyProvider get landlordTenantPropertyProvider =>
      Provider.of<LandlordTenantPropertyProvider>(
        context,
        listen: false,
      );

  LandlordTenantViewTenantProvider get landlordTenantViewTenantProvider =>
      Provider.of<LandlordTenantViewTenantProvider>(
        context,
        listen: false,
      );

  //--------------------Variables---------------//
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  FetchProfileModel? profile;
  AttributeInfoModel? selectedDepositScheme;
  int selectedRoom = -1;
  bool showRoomError = false;
  bool isSearched = false;
  List<String> prefillImages = [];

  @override
  void initState() {
    // Fetching initial property data
    _loadPropertyData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Provider.of<LandlordTenantProvider>(
        getContext,
        listen: false,
      ).removeProfile(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _indicatorNotifier,
      child: GestureDetector(
        onTap: keyboardHideOnTaPaction,
        child: _buildScafflod(),
      ),
    );
  }

  Widget _buildScafflod() {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorConstants.backgroundColorFFFFFF,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

//  Appbar...
  AppBar _buildAppBar() {
    return AppBar(
      title: CustomText(
        txtTitle: widget.tenancyId != null
            ? StaticString.editTenant
            : StaticString.addTenant,
      ),
      backgroundColor: ColorConstants.custDarkPurple500472,
    );
  }

  // Body view...
  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  _buildPropertyCard(),
                  const SizedBox(height: 10),
                  _buildSearchText(),
                  const SizedBox(height: 10),
                  _buildSearchBar(),
                  _buildTenantProfileCard(),
                  _buildTenantDetailForm(),
                  _buildRoomSection(),
                  _buildTenantLeaseDetailForm(),
                  const SizedBox(height: 50),
                  _buildUploadMedia(),
                  const SizedBox(height: 50),
                  _buildAddEditTenantButton(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  PropertyCard...
  Widget _buildPropertyCard() {
    return Consumer<AddTenantPropertyDetailProvider>(
      builder: (context, provider, child) {
        return PropertyCard(
          imageUrl: provider
                  .getPropertiesDetailModel.propertyDetail.photos.isNotEmpty
              ? provider.getPropertiesDetailModel.propertyDetail.photos.first
              : "",
          propertyTitle: provider.createFullAddress,
          propertySubtitle: provider.getPropertiesDetailModel.propertyDetail
                  .addressDetail?.fullAddress ??
              "",
          color: ColorConstants.custDarkPurple500472,
        );
      },
    );
  }

  // Tenant profileCard...
  Widget _buildTenantProfileCard() {
    return Consumer<LandlordTenantProvider>(
      builder: (context, provider, child) {
        if (isSearched && provider.profile != null) {
          return Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              _tenantProfileCard(profile: provider.profile),
            ],
          );
        } else if (isSearched &&
            landlordTenantViewTenantProvider.getTenant.userId.isNotEmpty) {
          return Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              _tenantProfileCard(
                tenant: landlordTenantViewTenantProvider.getTenant,
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

//  Tenant profile card...
  Widget _tenantProfileCard({
    FetchProfileModel? profile,
    ViewTenantTenancyModel? tenant,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: ColorConstants.backgroundColorFFFFFF,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custBlack000000.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 0.2,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // tenant circle avatar
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CustImage(
              height: 35,
              imgURL: profile?.profileImg.getValidProfileImage ??
                  tenant?.profileImg ??
                  "",
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // tenant full name
                    CustomText(
                      txtTitle: profile?.fullName ?? tenant?.fullName,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 5),

                    // tenant mobile
                    CustomText(
                      txtTitle: profile?.mobile ?? tenant?.mobile,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstants.custGrey707070,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 5),

                    // tenant email
                    CustomText(
                      txtTitle:
                          "${StaticString.email}: ${profile?.email ?? tenant?.email}",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstants.custGrey707070,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // tenant existance message
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomText(
                    txtTitle: StaticString.hoorayTenantExist,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstants.custDarkGreen09B500,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Tenant detail form...
  Widget _buildTenantDetailForm() {
    return Consumer<LandlordTenantProvider>(
      builder: (context, provider, child) {
        if (isSearched &&
            provider.profile == null &&
            landlordTenantViewTenantProvider.getTenant.userId.isEmpty) {
          return Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _tenantDetailFormKey,
                autovalidateMode: _autovalidateMode,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // tenant name form field
                      _buildTenantName(),
                      const SizedBox(height: 40),
                      // tenant email form field
                      _buildTenantEmail(),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        // return blank if tenant exist
        return Container();
      },
    );
  }

  // Tenant name textformfield...
  Widget _buildTenantName() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.validateEmptyName,
      controller: _tenantNameController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        tenantModel.fullName = value ?? "";
      },
      decoration: CommonInputdecoration.copyWith(
        labelText: StaticString.tenantName.addStarAfter,
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

  //  Tenant email textformfield...
  Widget _buildTenantEmail() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.validateOptionalEmail,
      controller: _tenantEmailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        tenantModel.email = value ?? "";
      },
      decoration: CommonInputdecoration.copyWith(
        labelText: StaticString.emailOptional,
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

  // Room selection view...
  Widget _buildRoomSection() {
    return Consumer<AddTenantPropertyDetailProvider>(
      builder: (context, provider, child) {
        return ValueListenableBuilder(
          valueListenable: _roomNotifier,
          builder: (context, val, child) {
            if (isSearched &&
                provider.getPropertiesDetailModel.property.isNotEmpty &&
                widget.tenancyId == null) {
              return Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        // room section headline
                        const CustomTitleWithLine(
                          title: StaticString.selectRoom,
                          primaryColor: ColorConstants.custDarkPurple500472,
                          secondaryColor: ColorConstants.custBlue1EC0EF,
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        // room tiles builder
                        GridView.builder(
                         
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              provider.getPropertiesDetailModel.property.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 20,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                roomtileOntap(
                                  index,
                                  provider
                                      .getPropertiesDetailModel.property[index],
                                );
                              },
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: selectedRoom == index
                                      ? ColorConstants.custBlue1EC0EF
                                      : ColorConstants.backgroundColorFFFFFF,
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorConstants.custGrey7A7A7A
                                          .withOpacity(0.2),
                                      blurRadius: 12,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // room name
                                    CustomText(
                                      txtTitle: provider
                                          .getPropertiesDetailModel
                                          .property[index]
                                          .roomName,
                                      textOverflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                            color: selectedRoom == index
                                                ? ColorConstants
                                                    .backgroundColorFFFFFF
                                                : ColorConstants
                                                    .custDarkPurple160935,
                                          ),
                                    ),

                                    // room type
                                    CustomText(
                                      txtTitle: provider
                                          .getPropertiesDetailModel
                                          .property[index]
                                          .propertyType,
                                      textOverflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(
                                            color: selectedRoom == index
                                                ? ColorConstants
                                                    .backgroundColorFFFFFF
                                                : ColorConstants.custGrey707070,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                        // room not selected error
                        if (showRoomError)
                          Column(
                            children: const [
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                  txtTitle: AlertMessageString.roomErrorMsg,
                                  style: TextStyle(
                                    color: ColorConstants.custRedF50B31,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              // return blank container if not HMO
              return Container();
            }
          },
        );
      },
    );
  }

  // roomTile ontap action...
  void roomtileOntap(
    int index,
    Property property,
  ) {
    selectedRoom = index;
    tenantModel.propertyId = property.id;
    _roomNotifier.notifyListeners();
  }

//  keyboard hide onTapaction...
  void keyboardHideOnTaPaction() {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

// tenant lease Details form...
  Widget _buildTenantLeaseDetailForm() {
    return Consumer<LandlordTenantProvider>(
      builder: (context, provider, child) {
        if (isSearched) {
          return Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildRentalAmount(),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildRentDueDate(),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildDeposit(),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildDepositScheme(),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildDepositId(),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildTenancyStartDate(),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildTenancyEndDate(),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  // build rental amount textformField...
  Widget _buildRentalAmount() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.validateEmpty,
      controller: _rentalAmountController,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        tenantModel.rentAmount = value?.toInt ?? 0;
      },
      maxLength: 9,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        prefixText: StaticString.currency.addSpaceAfter,
        labelText: StaticString.rentalAmount.addStarAfter,
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

  // build renatl Due date textformfield...
  Widget _buildRentDueDate() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      // readOnly: true,
      // onTap: () {
      //   selectDate(
      //     controller: _rentDueDateController,
      //     color: ColorConstants.custDarkPurple500472,
      //   ).then((value) => tenantModel.rentDueDate = value?.day ?? 1);
      // },
      // validator: (value) => value?.validateDueDate,
      validator: (value) => value?.validateDueDate,
      controller: _rentDueDateController,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        tenantModel.rentDueDate = value?.toInt ?? 0;
      },
      maxLength: 2,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: StaticString.rentDueDate.addStarAfter,
        // suffixIcon: const CustImage(
        //   imgURL: ImgName.commonCalendar,
        //   imgColor: ColorConstants.custDarkPurple500472,
        //   width: 24,
        // ),
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

  //  buildDeposite textformfield...
  Widget _buildDeposit() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.validateEmpty,
      controller: _depositController,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        tenantModel.depositAmount = value?.toInt ?? 0;
      },
      maxLength: 9,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        prefixText: StaticString.currency.addSpaceAfter,
        labelText: StaticString.depositPaid,
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

//  buildDepositescheme textformfield...
  Widget _buildDepositScheme() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.emptyDepositSchemeName,
      onTap: () {
        _showDepositSchemeModel(_depositSchemeController);
      },
      readOnly: true,
      controller: _depositSchemeController,
      keyboardType: TextInputType.phone,
      onSaved: (value) {
        tenantModel.depositScheme = selectedDepositScheme?.id ?? "";
      },
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: StaticString.depositScheme.addStarAfter,
        suffixIcon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 30,
          color: ColorConstants.custGrey707070,
        ),
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

//   build depositeId textformfield...
  Widget _buildDepositId() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.validateDepositId,
      controller: _depositIdController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        tenantModel.depositId = value ?? "";
      },
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: StaticString.depositId.addStarAfter,
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

  //  buildDeposite textformfield...
  Widget _buildTenancyStartDate() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      onTap: () {
        selectDate(
          controller: _tenancyStartDateController,
          color: ColorConstants.custDarkPurple500472,
          initialDate: tenantModel.startDate,
        ).then(
          (value) => {
            if (value != null) {tenantModel.startDate = value}
          },
        );
      },
      validator: (value) => value?.validateDate,
      readOnly: true,
      controller: _tenancyStartDateController,
      keyboardType: TextInputType.datetime,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: StaticString.tenancyStartDate.addStarAfter,
        suffixIcon: const CustImage(
          imgURL: ImgName.commonCalendar,
          imgColor: ColorConstants.custDarkPurple500472,
          width: 24,
        ),
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

  // build Tenancy endDate textformfield...
  Widget _buildTenancyEndDate() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      onTap: () {
        selectDate(
          controller: _tenancyEndDateController,
          color: ColorConstants.custDarkPurple500472,
          initialDate: tenantModel.endDate,
        ).then(
          (value) => {
            if (value != null) {tenantModel.endDate = value}
          },
        );
      },
      validator: (value) => value?.validateEndDate(
        startDate: tenantModel.startDate,
        endDate: tenantModel.endDate,
      ),
      readOnly: true,
      controller: _tenancyEndDateController,
      keyboardType: TextInputType.datetime,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: StaticString.tenancyEndDate.addStarAfter,
        suffixIcon: const CustImage(
          imgURL: ImgName.commonCalendar,
          imgColor: ColorConstants.custDarkPurple500472,
          width: 24,
        ),
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

  // upload media
  Widget _buildUploadMedia() {
    return Consumer<LandlordTenantProvider>(
      builder: (context, provider, child) {
        if (isSearched) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: UploadMediaOutlinedWidget(
              title: StaticString.uploadLease,
              userRole: UserRole.LANDLORD,
              image: ImgName.landlordCamera,
              prefillImages: prefillImages,
              maxImages: 1,
              onSelectImg: (newSelectedImages) async {
                prefillImages = newSelectedImages;
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  // deposit scheme bottom sheet
  Future _showDepositSchemeModel(TextEditingController controller) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: ColorConstants.backgroundColorFFFFFF,
      builder: (context) {
        return DepositSchemeSelector(
          controller: controller,
          selectedOption: selectedDepositScheme,
          onSelect: (depsoit) {
            if (mounted) {
              setState(() {
                selectedDepositScheme = depsoit;
              });
            }
          },
        );
        // return const InvoiceFilterPopupScreen();
      },
    );
  }

  Widget _buildAddEditTenantButton() {
    return Consumer<LandlordTenantProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CommonElevatedButton(
            bttnText: widget.tenancyId != null
                ? StaticString.editTenant.toUpperCase()
                : isSearched
                    ? StaticString.addTenant.toUpperCase()
                    : StaticString.next.toUpperCase(),
            color: widget.tenancyId != null
                ? ColorConstants.custDarkPurple500472
                : ColorConstants.custBlue1EC0EF,
            onPressed: _addEditFunc,
          ),
        );
      },
    );
  }

  // build serchbar List...
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Form(
        key: _formSearchKey,
        autovalidateMode: _autovalidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              enabled: !isSearched,
              controller: _searchController,
              cursorHeight: 20,
              onEditingComplete: _searchFunc,
              cursorColor: ColorConstants.custDarkPurple500472,
              validator: (value) => value?.validatePhoneNumber,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              textInputAction: TextInputAction.search,
              decoration: addTenantSearchInputdecoration(
                onTap: _searchFunc,
                enable: !isSearched,
              ),
            ),
          ],
        ),
      ),
    );
  }

//  build search text...
  Widget _buildSearchText() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CustImage(
                  imgURL: ImgName.mobileImg1,
                ),
                const SizedBox(
                  width: 8,
                ),
                CustomText(
                  txtTitle: StaticString.tenantsMobileNumber,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w600,
                      ),
                )
              ],
            ),
            if (isSearched)
              InkWell(
                onTap: changeNumberFunc,
                child: CustomText(
                  txtTitle: StaticString.change,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custBlue1EC0EF,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // search bar decoration
  InputDecoration addTenantSearchInputdecoration({
    void Function()? onTap,
    required bool enable,
  }) {
    return InputDecoration(
      fillColor: enable ? null : ColorConstants.custWhiteF5F5F5,
      counterText: "",
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      border: commonBorder(),
      enabledBorder: commonBorder(),
      disabledBorder: commonBorder(),
      focusedBorder: commonBorder(),
      focusedErrorBorder: commonBorder(),
      errorBorder: commonBorder(),
      labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
            color: ColorConstants.custDarkPurple160935,
          ),
      suffixIcon: IconButton(
        padding: const EdgeInsets.only(right: 10),
        onPressed: onTap,
        icon: const CustImage(
          imgURL: ImgName.landlordSearch,
          width: 24,
        ),
      ),
    );
  }

//  common Border of textformfield...
  OutlineInputBorder commonBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorConstants.borderColorACB4B0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
    );
  }

  // load propertyData...
  Future<void> _loadPropertyData() async {
    try {
      _indicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      await addTenantPropertyDetailProvider.fetchPropertiesDetailsData(
        propertyDetailId: widget.property.id,
      );

      tenantModel.propertyId =
          addTenantPropertyDetailProvider.getPropertiesDetailModel.propertyId;
      await landlordTenantPropertyProvider.fetchAttributeList();

      if (widget.tenancyId != null) {
        await makeEditForm();
      }
    } catch (e) {
      showAlert(context: context, message: e);
      // rethrow;
    } finally {
      _indicatorNotifier.hide();
    }
  }

  // search function...
  Future<void> _searchFunc() async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      _indicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      if (_formSearchKey.currentState!.validate()) {
        await landlordTenantProvider.checkProfileExists(
          mobile: _searchController.text,
        );
        landlordTenantViewTenantProvider
            .removeTenantDetail(); // remove edit profile
        tenantModel.mobile = _searchController.text;
        tenantModel.fullName =
            landlordTenantProvider.getProfile?.fullName ?? "";
        tenantModel.email = landlordTenantProvider.getProfile?.email ?? "";
        tenantModel.userId = landlordTenantProvider.getProfile?.userId ?? "";
        isSearched = true;
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      showAlert(context: context, message: e);
      // rethrow;
    } finally {
      _indicatorNotifier.hide();
    }
  }

  // when form in in edit mode it prefill the data
  Future<void> makeEditForm() async {
    try {
      await landlordTenantViewTenantProvider.fetchTenancyById(
        tenancyId: widget.tenancyId ?? "",
      );

      final ViewTenantTenancyModel tenant =
          landlordTenantViewTenantProvider.getTenant;

      // tenant search and tenant profile card
      if (tenant.isExistingUser) {
        // await landlordTenantProvider.checkProfileExists(
        //   mobile: tenant.mobile,
        // );

        tenantModel.mobile = tenant.mobile;
        tenantModel.fullName = tenant.fullName;
        tenantModel.email = tenant.email;
        tenantModel.userId = tenant.userId;
      } else {
        tenantModel.mobile = tenant.mobile;
        _tenantNameController.text =
            tenant.fullName.isEmpty ? "" : tenant.fullName;
        _tenantEmailController.text = tenant.email.isEmpty ? "" : tenant.email;
      }

      // change in controller
      isSearched = true;
      _searchController.text = tenant.mobile;
      // selectedRoom = profile;
      tenantModel.propertyId = tenant.propertyId;
      tenantModel.startDate = tenant.startDate;
      tenantModel.endDate = tenant.endDate;

      _rentalAmountController.text = tenant.rentAmount.toString();
      _rentDueDateController.text = tenant.rentDueDate?.day.toString() ?? "";
      _depositController.text = tenant.depositAmount.toString();
      _depositIdController.text = tenant.depositId;
      _tenancyStartDateController.text = tenant.startDate?.toMobileString ?? "";
      _tenancyEndDateController.text = tenant.endDate?.toMobileString ?? "";
      if (tenant.leaseUrl.isNotEmpty) {
        prefillImages.add(tenant.leaseUrl);
      }

      // set deposit scheme
      final fetchedDepositSchemeIndex = landlordTenantPropertyProvider
          .getAttributeList
          .indexWhere((element) => element.id == tenant.depositScheme);
      if (fetchedDepositSchemeIndex != -1) {
        _depositSchemeController.text = landlordTenantPropertyProvider
            .getAttributeList[fetchedDepositSchemeIndex].attributeValue;
        selectedDepositScheme = landlordTenantPropertyProvider
            .getAttributeList[fetchedDepositSchemeIndex];
      }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      showAlert(context: context, message: e);
      // rethrow;
    }
  }

  // search bar change number function
  void changeNumberFunc() {
    // empty field
    isSearched = false;
    if (widget.tenancyId == null) {
      landlordTenantProvider.removeProfile();
      // selectedDepositScheme = null;
      // selectedRoom = -1;
      // showRoomError = false;
      // prefillImages = [];
      // selectedImages = [];

      // _tenantNameController.text = "";
      // _tenantEmailController.text = "";
      // _rentalAmountController.text = "";
      // _rentDueDateController.text = "";
      // _depositController.text = "";
      // _depositSchemeController.text = "";
      // _depositIdController.text = "";
      // _tenancyStartDateController.text = "";
      // _tenancyEndDateController.text = "";
      // tenantModel = LandlordTenantAddTenantToPropertyModel();
      // tenantModel.propertyId =
      //     addTenantPropertyDetailProvider.getPropertiesDetailModel.propertyId;
    }
    if (mounted) {
      setState(() {});
    }
  }

  // add or edit tennat function
  Future<void> _addEditFunc() async {
    try {
      _indicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      if (isSearched) {
        if (_formKey.currentState!.validate()) {
          // tenantModel
          _tenantDetailFormKey.currentState?.save();
          _formKey.currentState?.save();

          if (addTenantPropertyDetailProvider
                  .getPropertiesDetailModel.property.isEmpty ||
              selectedRoom != -1 ||
              widget.tenancyId != null) {
            showRoomError = false;
            _roomNotifier.notifyListeners();

            // TODO: temporary fix as data issue at backend
            if (tenantModel.fullName.isEmpty) {
              tenantModel.fullName = "Name Issue";
            }

            final List<String> uploadedbleImage = [];

            if (prefillImages.isNotEmpty) {
              for (final element in prefillImages) {
                if (!element.isNetworkImage) {
                  uploadedbleImage.add(element);
                }
              }

              // upload lease
              final List<String> uploadedLeaseUrl =
                  await ImgUploadService.instance.uploadPropertyPictures(
                id: tenantModel.propertyId,
                images: uploadedbleImage,
                uploadType: UploadType.PROPERTY_LEASAES,
              );

              // set leaseUrl
              if (uploadedLeaseUrl.isNotEmpty) {
                tenantModel.leaseUrl = uploadedLeaseUrl.first;
              } else {
                tenantModel.leaseUrl = prefillImages.first;
              }
            }

            if (widget.tenancyId == null) {
              // add API call
              await landlordTenantProvider.addTenantToProperty(
                tenantModel: tenantModel,
              );
              Provider.of<LandlordDashboradProvider>(context, listen: false)
                  .fetchLandlordDashboardList();
              Provider.of<LandlordTenantPropertyProvider>(
                context,
                listen: false,
              ).fetchProperties();
              Provider.of<LandlordDashboradProvider>(
                context,
                listen: false,
              ).fetchLandlordDashboardList();
              Provider.of<LandlordProvider>(
                context,
                listen: false,
              ).fetchPropertiesListData(1);
            } else {
              // edit API call
              tenantModel.tenancyId = widget.tenancyId!;
              await landlordTenantProvider.editTenantToProperty(
                tenantModel: tenantModel,
              );
            }
            if (widget.doPop) {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => LandlordMyPropertiesDetailsScreen(
                    initialIndex: 2,
                    propertyId: widget.property.id,
                  ),
                ),
              );
            }
          } else {
            showRoomError = true;
            _roomNotifier.notifyListeners();
          }
        } else {
          _autovalidateMode = AutovalidateMode.always;

          _valueNotifier.notifyListeners();
        }
      }
    } catch (e) {
      showAlert(context: context, message: e);
      // rethrow;
    } finally {
      _indicatorNotifier.hide();
    }
  }
}
