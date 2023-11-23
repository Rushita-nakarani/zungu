// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../cards/custom_lease_select_card_copy.dart';
import '../../../../constant/decoration.dart';
import '../../../../constant/img_font_color_string.dart';
import '../../../../models/landloard/attribute_info_model.dart';
import '../../../../models/landloard/create_lease_model.dart';
import '../../../../models/landloard/fetch_country_model.dart';
import '../../../../models/landloard/fetch_lease_type.dart';
import '../../../../models/landloard/my_property_list_model.dart';
import '../../../../models/settings/business_profile/fetch_profile_model.dart';
import '../../../../providers/auth/auth_provider.dart';
import '../../../../providers/auth/personal_profile_provider/personal_provider.dart';
import '../../../../providers/landlord/tenant/add_tenant_property_detail_provider.dart';
import '../../../../providers/landlord/tenant/create_leases_provider.dart';
import '../../../../providers/landlord/tenant/fetch_property_provider.dart';
import '../../../../providers/landlord_provider.dart';
import '../../../../screens/landlord/tenant/create%20lease/create_leases_information_screen.dart';
import '../../../../screens/landlord/tenant/create%20lease/property_address_sheet.dart';
import '../../../../utils/cust_eums.dart';
import '../../../../utils/custom_extension.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_title_with_line.dart';
import '../../../../widgets/date_selector.dart';
import '../../../../widgets/guarantor_form.dart';
import '../../../../widgets/loading_indicator.dart';
import '../../../../widgets/no_content_label.dart';
import '../../../landlord/tenant/create%20lease/create_property_rent_cycle.dart';
import '../../../landlord/tenant/create%20lease/create_select_country.dart';
import '../../../settings/business%20profile/landLoard_bussiness_profile/edit_landlord_business_profile.dart';
import '../add tenants/deposit_scheme_selector.dart';

class CreateNewLeaseScreen extends StatefulWidget {
  const CreateNewLeaseScreen({super.key});

  @override
  State<CreateNewLeaseScreen> createState() => _CreateNewLeaseScreenState();
}

class _CreateNewLeaseScreenState extends State<CreateNewLeaseScreen> {
  // form keys
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // controllers
  final TextEditingController selectCountryController = TextEditingController();
  final TextEditingController agreementDateInput = TextEditingController();
  final TextEditingController _propertyAddressController =
      TextEditingController();
  final TextEditingController _petController = TextEditingController();
  final TextEditingController _propertyStartDateController =
      TextEditingController();
  final TextEditingController _propertyEndDateController =
      TextEditingController();
  final TextEditingController _propertyRentAmountController =
      TextEditingController();
  final TextEditingController _propertyRentCycleController =
      TextEditingController();
  final TextEditingController _propertyDepositPaidController =
      TextEditingController();
  final TextEditingController _propertyDepositSchemeNameController =
      TextEditingController();
  final TextEditingController _paylateController = TextEditingController();
  final TextEditingController _rentDueDateController = TextEditingController();

  //---------Landlord bank details form controller--------
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _sortCodeController = TextEditingController();

  TextEditingController tenantNameController = TextEditingController();
  TextEditingController tenantMobileController = TextEditingController();
  TextEditingController tenantaddressController = TextEditingController();

  TextEditingController guarantorNameController = TextEditingController();
  TextEditingController guarantorMobileController = TextEditingController();
  TextEditingController guarantoraddressController = TextEditingController();

  // notifiers
  final ValueNotifier _valueNotifier = ValueNotifier(true);
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  // providers
  LandlordProvider get getPropertiesListProvider =>
      Provider.of<LandlordProvider>(context, listen: false);

  CreateLeasesProvider get getCreateLeasesProvider =>
      Provider.of<CreateLeasesProvider>(context, listen: false);

  PersonalProfileProvider get personalProfileProvider =>
      Provider.of<PersonalProfileProvider>(context, listen: false);

  LandlordTenantPropertyProvider get landlordTenantPropertyProvider =>
      Provider.of<LandlordTenantPropertyProvider>(
        context,
        listen: false,
      );

  AddTenantPropertyDetailProvider get addTenantPropertyDetailProvider =>
      Provider.of<AddTenantPropertyDetailProvider>(
        context,
        listen: false,
      );

  LandlordProvider get getLandlordProvider =>
      Provider.of<LandlordProvider>(context, listen: false);

  // getters
  List<GuarantorForm> get guarantorUsers => _guarantorUsers;

  // variables
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? aggrementDate;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  int numberOfForm = 1;
  int selectedRoom = -1;
  String selectedRoomId = "";

  bool isAllowPet = false;
  bool ispetFeesRefundable = false;
  String selectedDisplayType = "";

  final List<GuarantorForm> _guarantorUsers = [];

  SelectLeaseType? _selectLeaseType;
  FetchCountryModel? _selectedCountry;

  bool tenantExpansion = false;
  bool guarantorExpansion = false;
  bool propertyExpansion = false;
  bool landlordBankExpansion = false;
  bool billButtonExpansion = false;

  List<String> tenantName = [];
  List<String> tenantMobileNumber = [];
  List<String> tenantCurrentAddress = [];

  List<String> gaurantorName = [];
  List<String> gaurantorMobileNumber = [];
  List<String> gaurantorCurrentAddress = [];

  String countryCode = "";
  Color? colors;

  List<String> houseAndFlatsCategoryId = [];
  PropertiesList? _selectedProperty;

  AttributeInfoModel? selectedDepositScheme;

  List<AttributeInfoModel> rentCycles = [
    AttributeInfoModel(
      attributeValue: StaticString.weekly,
    ),
    AttributeInfoModel(
      attributeValue: StaticString.fortnightly,
    ),
    AttributeInfoModel(
      attributeValue: StaticString.monthly,
    ),
  ];

  AttributeInfoModel? selectedRentCycle;
  bool selectedCountry = false;

  final Random _rng = Random();

  @override
  void initState() {
    fetchCountry();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }

  Widget _buildScaffold() {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  //  Appbar view...
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorConstants.custDarkPurple500472,
      title: const CustomText(
        txtTitle: StaticString.createLease,
      ),
    );
  }

  //  Build body view...
  Widget _buildBody() {
    return SafeArea(
      child: LoadingIndicator(
        loadingStatusNotifier: _loadingIndicatorNotifier,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: ValueListenableBuilder(
            valueListenable: _valueNotifier,
            builder: (context, val, child) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),

                    // select country
                    _buildSelectCountry(),

                    const SizedBox(height: 45),

                    // landlord detail
                    if (_selectedCountry != null)
                      Column(
                        key: Key("${_rng.nextInt(100)}"),
                        children: [
                          _buildSelectLeaseType(),
                          const SizedBox(height: 35),
                          _buildAgreementDate(),
                          const SizedBox(height: 40),
                          _buildLandlordDetails(),
                          const SizedBox(height: 30),
                          _buildPropertyDetails(),
                          const SizedBox(height: 30),
                          _buildTenantDetails(),
                          const SizedBox(height: 30),
                          _buildGuarantorDetails(),
                          const SizedBox(height: 30),
                          _buildBillIncludedExcluded(),
                          const SizedBox(height: 30),
                          _buildLandlordBankDetails(),
                          const SizedBox(height: 45),
                          _buildSendCodeButton(),
                          const SizedBox(height: 30),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

//----------subTitle Name---------------------
  Widget _buildSubTitle({required String title}) {
    return CustomText(
      txtTitle: title,
      style: Theme.of(context).textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }

  InputDecoration commonInputdecoration({required String labletext}) {
    return InputDecoration(
      counterText: "",
      labelText: labletext,
    );
  }

//-----------Select Country---------

  Widget _buildSelectCountry() {
    return Container(
      decoration: _commonCardDecoration,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 20,
          top: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTitleWithLine(
              title: StaticString.selectCountry,
              primaryColor: ColorConstants.custDarkPurple500472,
              secondaryColor: ColorConstants.custBlue1EC0EF,
            ),
            const SizedBox(
              height: 27,
            ),
            TextFormField(
              autovalidateMode: _autovalidateMode,
              onTap: () async {
                await _showSchemeModel(selectCountryController);
                if (mounted) {
                  setState(() {});
                }
              },
              readOnly: true,
              validator: (value) => value?.emptySelectCountry,
              controller: selectCountryController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration: CommonInputdecoration.copyWith(
                labelText: StaticString.selectCountry.addStarAfter,
                suffixIcon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 30,
                  color: ColorConstants.custGrey707070,
                ),
              ),
              cursorColor: ColorConstants.custDarkPurple500472,
            ),
          ],
        ),
      ),
    );
  }

  // select  Lease type...
  Widget _buildSelectLeaseType() {
    return Column(
      children: [
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CustomTitleWithLine(
                  title: StaticString.selectLeaseType,
                  primaryColor: ColorConstants.custDarkPurple500472,
                  secondaryColor: ColorConstants.custBlue1EC0EF,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 35),
        Consumer<CreateLeasesProvider>(
          builder: (context, selectLeaseType, child) {
            return selectLeaseType.fetchTenanttypeList.isEmpty
                ? NoContentLabel(
                    title: StaticString.nodataFound,
                    onPress: () {
                      fetchLeaseTypeData(countryCode);
                    },
                  )
                : GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: selectLeaseType.fetchTenanttypeList.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          colors = ColorConstants.custDarkYellowFFBF00
                              .withOpacity(0.3);

                          break;
                        case 1:
                          colors =
                              ColorConstants.custredFA1111.withOpacity(0.2);
                          break;
                        default:
                      }
                      return _buildCardLeaseType(
                        selectLeaseType.fetchTenanttypeList[index],
                      );
                    },
                  );
          },
        )
      ],
    );
  }

//-------------Select Lease Type-----------

  Widget _buildCardLeaseType(
    SelectLeaseType fetchCountry,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomLeaseCard(
          colors: ColorConstants.custDarkYellowFFBF00,
          title: fetchCountry.displayType,
          color: colors ?? ColorConstants.custyellowFDEAB2,
          image: ImgName.tenantCurrentTenancy,
          isSelected: _selectLeaseType?.id == fetchCountry.id,
          previewUrl: fetchCountry.previewUrl,
          onTap: () async {
            customLeasesCardOnTap(fetchCountry);
          },
        ),
      ],
    );
  }

  // selectLease typeCard ontap action...

  // agreement date textformfield...
  Widget _buildAgreementDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextFormField(
        autovalidateMode: _autovalidateMode,
        onTap: agreementDateOnTapaction,
        validator: (value) => value?.validateDate,
        readOnly: true,
        controller: agreementDateInput,
        keyboardType: TextInputType.datetime,
        textInputAction: TextInputAction.next,
        decoration: CommonInputdecoration.copyWith(
          labelText: "${StaticString.agreementDate}*",
          suffixIcon: const CustImage(
            imgURL: ImgName.commonCalendar,
            imgColor: ColorConstants.custDarkPurple500472,
            width: 24,
          ),
        ),
        cursorColor: ColorConstants.custDarkPurple500472,
      ),
    );
  }

  Widget _buildLandlordDetails() {
    return Consumer<PersonalProfileProvider>(
      builder: (context, fetchProfileDatails, child) {
        return fetchProfileDatails.fetchProfileModel == null
            ? const NoContentLabel(title: StaticString.nodataFound)
            : Container(
                decoration: _commonCardDecoration,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    bottom: 20,
                    top: 12,
                  ),
                  child: Column(
                    children: [
                      _buildLandlordDetailTextRow(
                        fetchProfileDatails.fetchProfileModel!,
                      ),
                      const SizedBox(height: 20),
                      _buildLandlordDetailAvatarAddressRow(
                        fetchProfileDatails.fetchProfileModel!,
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  Widget _buildLandlordDetailTextRow(
    FetchProfileModel fetchProfileModel,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // landlord title
        CustomTitleWithLine(
          title: StaticString.landlordDetails,
          primaryColor: ColorConstants.custDarkPurple500472,
          secondaryColor: ColorConstants.custBlue1EC0EF,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),

        // landlord detail edit button
        InkWell(
          onTap: () {
            editLandloardDetailsontap(fetchProfile: fetchProfileModel);
          },
          child: CustomText(
            txtTitle: StaticString.edit1,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custBlue1EC0EF,
                ),
          ),
        ),
      ],
    );
  }

  //  landloard user info card...
  Widget _buildLandlordDetailAvatarAddressRow(
    FetchProfileModel fetchProfileModel,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CustImage(
            imgURL: fetchProfileModel.profileImg.isEmpty
                ? ImgName.defaultProfile1
                : fetchProfileModel.profileImg,
            height: 40,
            width: 40,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                txtTitle: fetchProfileModel.tradingName,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.custGrey707070,
                    ),
              ),
              CustomText(
                txtTitle: fetchProfileModel.addresid?.fullAddress,
                align: TextAlign.left,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstants.custGrey8F8F8F,
                    ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  CustomText(
                    txtTitle: StaticString.lrn,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstants.custBlue1EC0EF,
                        ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  CustomText(
                    txtTitle: fetchProfileModel.registrationNumber,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstants.custGrey707070,
                        ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  //Property Details view...
  Widget _buildPropertyDetails() {
    return Container(
      decoration: _commonCardDecoration,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    colorScheme: ColorScheme.fromSwatch().copyWith(
                      secondary: Colors.black,
                    ),
                  ),
                  child: ExpansionTile(
                    initiallyExpanded: propertyExpansion,
                    title: _buildSubTitle(
                      title: StaticString.propertyDetails,
                    ),
                    trailing: SvgPicture.asset(
                      propertyExpansion == true
                          ? ImgName.upArrow
                          : ImgName.arrowDown,
                    ),
                    onExpansionChanged: (value) {
                      if (_selectLeaseType == null) {
                        return;
                      }
                      if (mounted) {
                        setState(() {
                          propertyExpansion = value;
                        });
                      }
                    },
                    children: [
                      _buildCommonDivider(),
                      const SizedBox(height: 20),
                      _buildPropertyDetailsForm(),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // common divider...
  Widget _buildCommonDivider() {
    return const Divider(
      color: ColorConstants.custBlue1EC0EF,
      thickness: 1.5,
    );
  }

  // property details form
  Widget _buildPropertyDetailsForm() {
    return Column(
      children: [
        _buildPropertyAddress(),
        const SizedBox(height: 20),
        if (_selectedProperty?.propertyType?.name.isNotEmpty ?? false)
          _buildCreateLeaseInfo(
            StaticString.propertyType,
            _selectedProperty!.propertyType?.name ?? "",
          ),
        if (_selectedProperty?.furnishing.isNotEmpty ?? false)
          _buildCreateLeaseInfo(
            StaticString.furnishing,
            _selectedProperty?.furnishing ?? "",
          ),
        if (_selectedProperty?.category?.name == "HMO")
          _buildRoomPortion()
        else
          Container(),
        const SizedBox(height: 5),
        if (_selectLeaseType?.startDate?.isEnabled ?? false)
          _buildPropertyLeaseStartDate(),
        if (_selectLeaseType?.endDate?.isEnabled ?? false)
          _buildPropertyLeaseEndDate(),
        _buildPropertyRentAmount(),
        const SizedBox(height: 20),
        _buildPropertyRentCycle(),
        const SizedBox(height: 20),
        _buildRentDueDate(),
        const SizedBox(height: 20),
        _buildLatePaymentFee(),
        const SizedBox(height: 20),
        _buildPropertyDeposit(),
        const SizedBox(height: 20),
        _buildPropertyDepositScheme(),
        const SizedBox(height: 20),
        _buildPetAllowedText(),
        const SizedBox(height: 20),
        _buildPetAllowToPropertyChip(),
        SizedBox(height: !isAllowPet ? 0 : 20),
        if (isAllowPet) _buildPetDeposit() else Container(),
        const SizedBox(height: 20),
        _buildPetDepositRefundable(),
      ],
    );
  }

  // Room Portion
  Widget _buildRoomPortion() {
    return _selectedProperty?.propertyDetail.isEmpty ?? true
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              left: 5,
            ),
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
                  padding: const EdgeInsets.only(right: 5, bottom: 10),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _selectedProperty?.propertyDetail.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        roomtileOntap(
                          index,
                          _selectedProperty!.propertyDetail[index],
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
                              txtTitle: _selectedProperty
                                  ?.propertyDetail[index].roomName,
                              textOverflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    color: selectedRoom == index
                                        ? ColorConstants.backgroundColorFFFFFF
                                        : ColorConstants.custDarkPurple160935,
                                  ),
                            ),

                            // room type
                            CustomText(
                              txtTitle: _selectedProperty
                                  ?.propertyDetail[index].propertyTypeValue,
                              textOverflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(
                                    color: selectedRoom == index
                                        ? ColorConstants.backgroundColorFFFFFF
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

                // // room not selected error
                // if (showRoomError)
                //   Column(
                //     children: const [
                //       SizedBox(
                //         height: 20,
                //       ),
                //       Align(
                //         alignment: Alignment.centerLeft,
                //         child: CustomText(
                //           txtTitle: AlertMessageString.roomErrorMsg,
                //           style: TextStyle(
                //             color: ColorConstants.custRedF50B31,
                //             fontSize: 14,
                //           ),
                //         ),
                //       ),
                //     ],
                //   )
                // else
                //   Container(),
              ],
            ),
          );
  }

  // Create leases info...
  Widget _buildCreateLeaseInfo(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txtTitle: title,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey707070,
                ),
          ),
          CustomText(
            txtTitle: value,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custskyblue22CBFE,
                ),
          ),
        ],
      ),
    );
  }

//property address textFormField...
  Widget _buildPropertyAddress() {
    return TextFormField(
      onTap: () {
        _showPropertyModel(_propertyAddressController);
      },
      readOnly: true,
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.validateAddress,
      controller: _propertyAddressController,
      keyboardType: TextInputType.streetAddress,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: StaticString.propertyAddress.addStarAfter,
        suffixIcon: const CustImage(
          imgURL: ImgName.downArrow,
          imgColor: ColorConstants.custDarkPurple500472,
          width: 15,
        ),
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

//property leaese start Date textFormField...
  Widget _buildPropertyLeaseStartDate() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        autovalidateMode: _autovalidateMode,
        onTap: startDateOnTapaction,
        validator: (value) => value?.validateDate,
        readOnly: true,
        controller: _propertyStartDateController,
        keyboardType: TextInputType.datetime,
        textInputAction: TextInputAction.next,
        decoration: CommonInputdecoration.copyWith(
          labelText: StaticString.leaseStartDate.addStarAfter,
          suffixIcon: const CustImage(
            imgURL: ImgName.commonCalendar,
            imgColor: ColorConstants.custDarkPurple500472,
            width: 24,
          ),
        ),
        cursorColor: ColorConstants.custDarkPurple500472,
      ),
    );
  }

  // property leaese endDate textFormField...
  Widget _buildPropertyLeaseEndDate() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        autovalidateMode: _autovalidateMode,
        onTap: endDateOnTapaction,
        // validator: (value) => value?.validateDate,
        validator: (value) => value?.validateEndDate(
          startDate: _startDate,
          endDate: _endDate,
        ),
        readOnly: true,
        controller: _propertyEndDateController,
        keyboardType: TextInputType.datetime,
        textInputAction: TextInputAction.next,
        decoration: CommonInputdecoration.copyWith(
          labelText: StaticString.leaseEndDate.addStarAfter,
          suffixIcon: const CustImage(
            imgURL: ImgName.commonCalendar,
            imgColor: ColorConstants.custDarkPurple500472,
            width: 24,
          ),
        ),
        cursorColor: ColorConstants.custDarkPurple500472,
      ),
    );
  }

  // peoperty rentmount textFormField...
  Widget _buildPropertyRentAmount() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.validateEmpty,
      controller: _propertyRentAmountController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: StaticString.rentAmount.addStarAfter,
        prefixText: StaticString.currency.addSpaceAfter,
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

  // property rentcycle textformField...
  Widget _buildPropertyRentCycle() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      onTap: () {
        _showRentCycle(_propertyRentCycleController);
      },
      readOnly: true,
      validator: (value) => value?.emptyRentCycle,
      controller: _propertyRentCycleController,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: StaticString.rentCycle.addStarAfter,
        suffixIcon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 30,
          color: ColorConstants.custGrey707070,
        ),
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

  //  rent due date TextFormField...
  Widget _buildRentDueDate() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.validateDueDate,
      controller: _rentDueDateController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: StaticString.rentDueDate.addStarAfter,
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

  // late payment fee textformfield...
  Widget _buildLatePaymentFee() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.validateEmpty,
      controller: _paylateController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: StaticString.latePaymentFee.addStarAfter,
        prefixText: StaticString.currency.addSpaceAfter,
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

  //  property deposite textformField...
  Widget _buildPropertyDeposit() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.validateEmpty,
      controller: _propertyDepositPaidController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: StaticString.deposit.addStarAfter,
        prefixText: StaticString.currency.addSpaceAfter,
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

  // property allow scheme...
  Widget _buildPropertyDepositScheme() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      onTap: () {
        _showDepositScheme(_propertyDepositSchemeNameController);
      },
      readOnly: true,
      validator: (value) => value?.emptyDepositSchemeName,
      controller: _propertyDepositSchemeNameController,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: "${StaticString.depositSchemeName}*",
        suffixIcon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 30,
          color: ColorConstants.custGrey707070,
        ),
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

// PetAllow commonText...
  Widget _buildPetAllowedText() {
    return const CustomTitleWithLine(
      title: StaticString.petAllowes,
      primaryColor: ColorConstants.custPurple500472,
      secondaryColor: ColorConstants.custskyblue22CBFE,
    );
  }

  // pet allow property chip...
  Widget _buildPetAllowToPropertyChip() {
    return Row(
      children: [
        Expanded(
          child: CustomText(
            txtTitle: StaticString.doYouAllowPets,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Switch.adaptive(
          value: isAllowPet,
          activeColor: ColorConstants.custPurple500472,
          activeTrackColor: ColorConstants.custPurple500472,
          thumbColor: MaterialStateProperty.all(ColorConstants.custGreyECECEC),
          onChanged: (value) {
            if (mounted) {
              setState(() {
                isAllowPet = value;
              });
            }
          },
        )
      ],
    );
  }

  // pet deposite textformfield...
  Widget _buildPetDeposit() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.validateAddress,
      controller: _petController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: StaticString.petDeposite.addStarAfter,
        prefixText: StaticString.currency.addSpaceAfter,
      ),
      cursorColor: ColorConstants.custPurple500472,
    );
  }

  // pet deposite refundable view...
  Widget _buildPetDepositRefundable() {
    return Row(
      children: [
        Expanded(
          child: CustomText(
            txtTitle: StaticString.petDepositeRefundable,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Switch.adaptive(
          value: ispetFeesRefundable,
          activeColor: ColorConstants.custPurple500472,
          activeTrackColor: ColorConstants.custPurple500472,
          thumbColor: MaterialStateProperty.all(ColorConstants.custGreyECECEC),
          onChanged: (value) {
            if (mounted) {
              setState(() {
                ispetFeesRefundable = value;
              });
            }
          },
        )
      ],
    );
  }

  //  tenant Details view....
  Widget _buildTenantDetails() {
    return Container(
      decoration: _commonCardDecoration,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    colorScheme: ColorScheme.fromSwatch().copyWith(
                      secondary: Colors.black,
                    ),
                  ),
                  child: ExpansionTile(
                    initiallyExpanded: tenantExpansion,
                    title: _buildSubTitle(
                      title: StaticString.tenantDetails,
                    ),
                    trailing: SvgPicture.asset(
                      tenantExpansion == true
                          ? ImgName.upArrow
                          : ImgName.arrowDown,
                    ),
                    onExpansionChanged: (value) {
                      if (mounted) {
                        setState(() {
                          tenantExpansion = value;
                        });
                      }
                    },
                    children: [
                      const Divider(
                        color: ColorConstants.custBlue1EC0EF,
                        thickness: 1.5,
                      ),
                      const SizedBox(height: 10),
                      _buildTenantNameField(),
                      const SizedBox(height: 20),
                      _buildTenantMobileField(),
                      const SizedBox(height: 20),
                      _buildTenantAddressField(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // -------tanant form TextformField-----------//
  Widget _buildTenantNameField() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      controller: tenantNameController,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateYourName,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: commonInputdecoration(
        labletext: StaticString.tenantName.addStarAfter,
      ),
    );
  }

  Widget _buildTenantMobileField() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      controller: tenantMobileController,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validatePhoneNumber,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      textInputAction: TextInputAction.next,
      decoration: commonInputdecoration(
        labletext: StaticString.tenantMobileNumber.addStarAfter,
      ),
    );
  }

  Widget _buildTenantAddressField() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      controller: tenantaddressController,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateAddress,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: commonInputdecoration(
        labletext: StaticString.tenantCurrentAddress.addStarAfter,
      ),
    );
  }

  //  gauarantor details view...
  Widget _buildGuarantorDetails() {
    return Container(
      decoration: _commonCardDecoration,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    colorScheme: ColorScheme.fromSwatch().copyWith(
                      secondary: Colors.black,
                    ),
                  ),
                  child: ExpansionTile(
                    initiallyExpanded: guarantorExpansion,
                    title: _buildSubTitle(
                      title: StaticString.guarantorDetails,
                    ),
                    trailing: SvgPicture.asset(
                      guarantorExpansion == true
                          ? ImgName.upArrow
                          : ImgName.arrowDown,
                    ),
                    onExpansionChanged: (value) {
                      if (mounted) {
                        setState(() {
                          guarantorExpansion = value;
                        });
                      }
                      // provider.isguarantorExpand(value);
                    },
                    children: [
                      const Divider(
                        color: ColorConstants.custBlue1EC0EF,
                        thickness: 1.5,
                      ),
                      const SizedBox(height: 20),
                      _buildGuarantorNameField(),
                      const SizedBox(height: 20),
                      _buildGuarantorMobileField(),
                      const SizedBox(height: 20),
                      _buildGuarantorAddressField(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // -----------gaurantor form textfield---------//
  Widget _buildGuarantorNameField() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      controller: guarantorNameController,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateYourName,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: commonInputdecoration(
        labletext: StaticString.guarantorName.addStarAfter,
      ),
    );
  }

  Widget _buildGuarantorMobileField() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      controller: guarantorMobileController,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validatePhoneNumber,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      textInputAction: TextInputAction.next,
      decoration: commonInputdecoration(
        labletext: StaticString.guarantorMobileNumber.addStarAfter,
      ),
    );
  }

  Widget _buildGuarantorAddressField() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      controller: guarantoraddressController,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateYourName,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: commonInputdecoration(
        labletext: StaticString.guarantorCurrentAddress.addStarAfter,
      ),
    );
  }

  // inclusion and exclusion view...
  Widget _buildBillIncludedExcluded() {
    return Container(
      decoration: _commonCardDecoration,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    colorScheme: ColorScheme.fromSwatch().copyWith(
                      secondary: Colors.black,
                    ),
                  ),
                  child: ExpansionTile(
                    initiallyExpanded: billButtonExpansion,
                    title: _buildSubTitle(
                      title: StaticString.billsIncludedExcluded,
                    ),
                    trailing: SvgPicture.asset(
                      billButtonExpansion ? ImgName.upArrow : ImgName.arrowDown,
                    ),
                    onExpansionChanged: (value) {
                      if (_selectLeaseType == null) {
                        return;
                      }
                      if (mounted) {
                        setState(() {
                          billButtonExpansion = value;
                        });
                      }
                    },
                    children: [
                      _buildCommonDivider(),
                      const SizedBox(height: 20),
                      Consumer<CreateLeasesProvider>(
                        builder: (
                          context,
                          createlease,
                          child,
                        ) =>
                            ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _selectLeaseType?.inclusion.length ?? 0,
                          itemBuilder: (
                            BuildContext context,
                            int index,
                          ) {
                            return _billSwitchButton(
                              _selectLeaseType?.inclusion[index],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // inclusion and exclusion switch btn ui...
  Widget _billSwitchButton(Inclusion? inclusion) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txtTitle: inclusion?.displayValue,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                color: ColorConstants.custGrey7A7A7A,
                fontWeight: FontWeight.w400,
              ),
        ),
        Switch.adaptive(
          activeTrackColor: ColorConstants.custPurple500472,
          activeColor: ColorConstants.custPurple500472,
          thumbColor: MaterialStateProperty.all(
            ColorConstants.custGreyECECEC,
          ),
          value: inclusion?.isEnabled ?? false,
          onChanged: (value) {
            if (mounted) {
              setState(() {
                inclusion?.isEnabled = value;
              });
            }
          },
        ),
      ],
    );
  }

  // bank Details view ...
  Widget _buildLandlordBankDetails() {
    return Container(
      decoration: _commonCardDecoration,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    colorScheme: ColorScheme.fromSwatch().copyWith(
                      secondary: Colors.black,
                    ),
                  ),
                  child: ExpansionTile(
                    initiallyExpanded: landlordBankExpansion,
                    title: _buildSubTitle(
                      title: StaticString.landlordBankDetails,
                    ),
                    trailing: SvgPicture.asset(
                      landlordBankExpansion == true
                          ? ImgName.upArrow
                          : ImgName.arrowDown,
                    ),
                    onExpansionChanged: (value) {
                      if (mounted) {
                        setState(() {
                          landlordBankExpansion = value;
                        });
                      }
                    },
                    children: [
                      _buildCommonDivider(),
                      const SizedBox(height: 30),
                      _buildLandlordBankDetailsForm(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // BankDetail form...
  Widget _buildLandlordBankDetailsForm() {
    return Column(
      children: [
        _buildLandlordBankName(),
        const SizedBox(height: 20),
        _buildLandlordAccountName(),
        const SizedBox(height: 20),
        _buildLandlordAccountNumber(),
        const SizedBox(height: 20),
        _buildLandlordSortCode()
      ],
    );
  }

  //-----------Landlord Bank Details Form TextFromField---------------

  Widget _buildLandlordBankName() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.emptyBankName,
      controller: _bankNameController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: StaticString.bankName.addStarAfter,
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

  Widget _buildLandlordAccountName() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.emptyAccountName,
      controller: _accountNameController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: StaticString.accountName.addStarAfter,
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

  Widget _buildLandlordAccountNumber() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.validateAccountNumber,
      controller: _accountNumberController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: StaticString.accountNumber.addStarAfter,
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

  Widget _buildLandlordSortCode() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      validator: (value) => value?.emptySortCode,
      controller: _sortCodeController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: CommonInputdecoration.copyWith(
        labelText: StaticString.sortCode.addStarAfter,
      ),
      cursorColor: ColorConstants.custDarkPurple500472,
    );
  }

// Generate Lease button...
  Widget _buildSendCodeButton() {
    return CommonElevatedButton(
      color: ColorConstants.custBlue1EC0EF,
      bttnText: StaticString.next,
      onPressed: () {
        sendCodeButtonAction();
      },
    );
  }

  // Select Country BottomSheet...
  Future _showSchemeModel(TextEditingController controller) {
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
        return CreateCountrySelector(
          selectedCountry: _selectedCountry,
          onSubmit: (fetchCountryModel) async {
            selectCountryOnTapAction(fetchCountryModel, controller);
          },
        );
      },
    );
  }

  // PropertyAddress bottomSheet---------
  Future _showPropertyModel(TextEditingController controller) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      // isScrollControlled: true,
      backgroundColor: ColorConstants.backgroundColorFFFFFF,
      builder: (context) {
        return PropertyAddressSheet(
          categoryList: houseAndFlatsCategoryId,
          cardOntap: (property) {
            propertyAddressOnTapAction(property, controller);
          },
        );
      },
    );
  }

  Future _showDepositScheme(TextEditingController controller) {
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
            if (depsoit != null) {
              depositeSchemeOnTapAction(depsoit);
            }
          },
        );
      },
    );
  }

  // -------Button Action------//

  // roomTile ontap action...
  void roomtileOntap(
    int index,
    PropertyDetail property,
  ) {
    if (mounted) {
      setState(() {
        selectedRoom = index;
        selectedRoomId = property.id;
      });
    }
  }

//  deposite bottomsheet btnOntap...
  Future<void> depositeSchemeOnTapAction(
    AttributeInfoModel deposite,
  ) async {
    if (mounted) {
      setState(() {
        selectedDepositScheme = deposite;
      });
    }
  }

  // edit landloard details on tap action...
  void editLandloardDetailsontap({
    required FetchProfileModel fetchProfile,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => EditLandloardBussinessProfileScreen(
          profileModel: fetchProfile,
          roleId: Provider.of<AuthProvider>(context, listen: false)
                  .authModel
                  ?.profile
                  ?.roleId ??
              "",
        ),
      ),
    );
  }

  // Select CountrybottomSheet onTapAction...
  Future<void> selectCountryOnTapAction(
    FetchCountryModel selectCountry,
    TextEditingController controller,
  ) async {
    selectCountryController.text = selectCountry.country ?? "";
    countryCode = selectCountry.countryCode ?? "";
    _selectedCountry = selectCountry;
    resetProperty();
    await fetchLeaseTypeData(countryCode);
  }

  // propertyAddressbottomsheet onTap btn...
  Future<void> propertyAddressOnTapAction(
    PropertiesList propertyList,
    TextEditingController controller,
  ) async {
    controller.text = propertyList.addressDetail?.fullAddress ?? "";
    _selectedProperty = propertyList;
    // showRoomError = _selectedProperty?.propertyDetail.isEmpty ?? true;
    if (mounted) {
      setState(() {});
    }

    Navigator.of(context).pop();
  }

  // satrtDate ontap textFormField...
  Future<void> startDateOnTapaction() async {
    await selectDate(
      initialDate: _startDate,
      controller: _propertyStartDateController,
      color: ColorConstants.custDarkPurple500472,
    ).then(
      (value) => {if (value != null) _startDate = value},
    );
  }

//  endDate textFormField ontap...
  Future<void> endDateOnTapaction() async {
    await selectDate(
      initialDate: _endDate,
      controller: _propertyEndDateController,
      color: ColorConstants.custDarkPurple500472,
    ).then(
      (value) => {if (value != null) _endDate = value},
    );
  }

  // agrrement textFormField ontap...
  Future<void> agreementDateOnTapaction() async {
    aggrementDate = await selectDate(
      initialDate: aggrementDate,
      controller: agreementDateInput,
      color: ColorConstants.custDarkPurple500472,
    );
  }

  //  SendCode btn action...
  Future<void> sendCodeButtonAction() async {
    try {
      if (!(_formKey.currentState?.validate() ?? true)) {
        _autovalidateMode = AutovalidateMode.always;

        tenantExpansion = true;
        guarantorExpansion = true;
        propertyExpansion = true;
        landlordBankExpansion = true;
        billButtonExpansion = true;
        _valueNotifier.notifyListeners();
        return;
      }
      _formKey.currentState?.save();

      final CreateLeaseModel createLeaseModel = CreateLeaseModel(
        selectCountry: selectCountryController.text,
        leaseTypeId: _selectLeaseType?.id ?? "",
        agreementDate: aggrementDate,
        propertyAddress: _propertyAddressController.text,
        startDate: _startDate,
        selectedDisplayType: selectedDisplayType,
        endDate: _endDate,
        propertyId: selectedRoomId.isEmpty
            ? (_selectedProperty?.propertyDetail.isNotEmpty ?? false)
                ? _selectedProperty!.propertyDetail.first.id
                : ""
            : selectedRoomId,
        rentCycle: _propertyRentCycleController.text,
        rentAmount: _propertyRentAmountController.text,
        rentDueDate: int.tryParse(_rentDueDateController.text) ?? 0,
        latePaymentFee: int.tryParse(_paylateController.text) ?? 0,
        deposit: int.tryParse(_propertyDepositPaidController.text) ?? 0,
        depositScheme: selectedDepositScheme?.id ?? "",
        depositeSchemeName: _propertyDepositSchemeNameController.text,
        tenants: [
          Tenanator(
            name: tenantNameController.text,
            address: tenantaddressController.text,
            mobile: tenantMobileController.text,
          )
        ],
        guarantors: [
          Guarantor(
            name: guarantorNameController.text,
            mobile: guarantorMobileController.text,
            address: guarantoraddressController.text,
          ),
        ],
        pets: isAllowPet
            ? Pets(
                allowed: isAllowPet,
                deposit: int.parse(_petController.text),
                refundable: ispetFeesRefundable,
              )
            : null,
        inclusion: _selectLeaseType?.inclusion ?? [],
        bankName: _bankNameController.text,
        accountName: _accountNameController.text,
        accountNumber: _accountNumberController.text,
        sortCode: _sortCodeController.text,
      );
      if (_selectedProperty?.category?.name.toUpperCase() == "HMO") {
        if (selectedRoomId.isEmpty) {
          Fluttertoast.showToast(msg: AlertMessageString.roomErrorMsg);
          return;
        }
      }
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => CreateLeasesInformationScreen(
            createLeasesInformation: createLeaseModel,
            propertyInformation: _selectedProperty,
            selectedTypedata: _selectLeaseType,
          ),
        ),
      );
    } catch (e) {
      showAlert(context: context, message: e);
    }
  }

  //----------------  Property Rent Cycle BottomSheet---------
  Future _showRentCycle(TextEditingController controller) {
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
        return CreatePropertyRentCycle(
          controller: controller,
          rentCycles: rentCycles,
          selectedOption: selectedRentCycle,
          onSelect: (val) {
            selectedRentCycle = val;
          },
        );
      },
    );
  }

  //----------------  Property Deposit Scheme BottomSheet---------

  // commom box decoration of container...
  final BoxDecoration _commonCardDecoration = BoxDecoration(
    color: ColorConstants.backgroundColorFFFFFF,
    borderRadius: BorderRadius.circular(3),
    boxShadow: [
      BoxShadow(
        color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
        blurRadius: 12,
      ),
    ],
  );

  // Fetch country api call...
  Future<void> fetchCountry() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      await Future.wait([
        getCreateLeasesProvider.fetchCountryData(),
        getLandlordProvider.fetchCategoryList(),
        landlordTenantPropertyProvider.fetchAttributeList(),
        getPropertiesListProvider.fetchPropertiesListData(
          1,
          categoryIdList: houseAndFlatsCategoryId,
        ),
      ]);
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  // Custom lease Card onTap action...
  Future<void> customLeasesCardOnTap(SelectLeaseType selectleasetype) async {
    try {
      if (mounted) {
        setState(() {
          _selectLeaseType = selectleasetype;
          resetProperty();
        });
      }
      selectedDisplayType = selectleasetype.displayType;
      if (_selectLeaseType?.displayType.toLowerCase().contains("hmo") ??
          false) {
        await Future.wait([
          fetchCategoryId(isSelected: false),
          getPropertiesListProvider.fetchPropertiesListData(
            categoryIdList: houseAndFlatsCategoryId,
            1,
          ),
        ]);
      } else {
        await Future.wait([
          fetchCategoryId(isSelected: true),
          getPropertiesListProvider.fetchPropertiesListData(
            categoryIdList: houseAndFlatsCategoryId,
            1,
          ),
        ]);
      }
    } catch (e) {
      showAlert(context: context, message: e);
    }
  }

  //  Fetch Leasestype data api call...
  Future<void> fetchLeaseTypeData(String countryCode) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      await getCreateLeasesProvider.fetchLeaseTypeData(countryCode);
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  // Fetch Category Id List...
  Future<void> fetchCategoryId({required bool isSelected}) async {
    houseAndFlatsCategoryId = getLandlordProvider.getCategoryList
        .where((element) {
          return isSelected
              ? (element.propertyTypeEnum == PropertyType.House ||
                  element.propertyTypeEnum == PropertyType.Flats)
              : element.propertyTypeEnum == PropertyType.HMO;
        })
        .map((e) => e.id)
        .toList();
  }

  void resetProperty() {
    _propertyAddressController.text = "";
    _selectedProperty = null;
    _propertyStartDateController.text = "";
    _endDate = null;
    _propertyEndDateController.text = "";
    _startDate = null;
    _propertyRentAmountController.text = "";
    _propertyRentCycleController.text = "";
    selectedRentCycle = null;
    _rentDueDateController.text = "";
    _paylateController.text = "";
    _propertyDepositPaidController.text = "";
    _propertyDepositSchemeNameController.text = "";
    selectedDepositScheme = null;
    isAllowPet = false;
    _petController.text = "";
    ispetFeesRefundable = false;
  }
}
