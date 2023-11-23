import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/screens/landlord/tenant/create%20lease/create_new_lease_screen.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';
import 'package:zungu_mobile/widgets/image_upload_outlined_widget.dart';

import '../../../../cards/custom_tenancy_select_card.dart';
import '../../../../cards/property_card.dart';
import '../../../../constant/decoration.dart';
import '../../../../constant/img_font_color_string.dart';
import '../../../../models/landloard/property_detail_model.dart';
import '../../../../providers/auth/auth_provider.dart';
import '../../../../providers/landlord/tenant/fetch_property_provider.dart';
import '../../../../services/img_upload_service.dart';
import '../../../../utils/custom_extension.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_title_with_line.dart';
import '../../../../widgets/date_selector.dart';
import '../../../../widgets/loading_indicator.dart';

class TenantRenewLeaseScreen extends StatefulWidget {
  final Tenancy? tenancyModel;
  final PropertiesDetailModel? propertiesDetailModel;
  const TenantRenewLeaseScreen({
    super.key,
    this.tenancyModel,
    this.propertiesDetailModel,
  });

  @override
  State<TenantRenewLeaseScreen> createState() => _TenantRenewLeaseScreenState();
}

class _TenantRenewLeaseScreenState extends State<TenantRenewLeaseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final ValueNotifier _valueNotifier = ValueNotifier(true);
  final TextEditingController _agreementDateController =
      TextEditingController();
  final TextEditingController _rentAmountController = TextEditingController();
  final TextEditingController _tenantStartDateController =
      TextEditingController();
  final TextEditingController _tenantEndDateController =
      TextEditingController();

  List<String> uploadImage = [];

  //landlord tenant Property Provider getter method

  AuthProvider get getAuthProvider =>
      Provider.of<AuthProvider>(context, listen: false);

  LandlordTenantPropertyProvider get landlordTenantPropertyProvider =>
      Provider.of<LandlordTenantPropertyProvider>(
        context,
        listen: false,
      );

  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  // variables
  DateTime? _agreementDate;
  DateTime? _leaseStartDate;
  DateTime? _leaseEndDate;

  @override
  Widget build(BuildContext context) {
    print(
      widget.propertiesDetailModel?.type,
    );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Scaffold(
        appBar: AppBar(
          title: const CustomText(
            txtTitle: StaticString.renewLease,
          ),
          backgroundColor: ColorConstants.custDarkPurple500472,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    _buildPropertyTile(),
                    const SizedBox(height: 30),
                    _buildTenantDetails(context),
                    // _buildBottomTitle(),
                    // const SizedBox(height: 30),
                    // _buildTenancyCard(),
                    const SizedBox(height: 30),
                    _buildPropertyDetails(context),
                    // _buildForm(),
                    const SizedBox(height: 30),
                    _buildRentAmountDate(),
                    const SizedBox(height: 30),
                    _buildTenantStartDate(),
                    const SizedBox(height: 30),
                    _buildTennatEndDate(),
                    const SizedBox(height: 30),
                    _builduploadImage(),

                    const SizedBox(height: 30),
                    _buildGenerateRenewalButton(),
                    const SizedBox(height: 30),
                    CustomText(
                      txtTitle: StaticString.oryouCan,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: ColorConstants.custGrey707070,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const CreateNewLeaseScreen(),
                          ),
                        );
                      },
                      child: CustomText(
                        txtTitle: StaticString.createaNewLease,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: ColorConstants.custskyblue22CBFE,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
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

//
  Widget _builduploadImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: UploadMediaOutlinedWidget(
        title: StaticString.uploadlease,
        image: ImgName.landlordCamera,
        userRole: UserRole.LANDLORD,
        prefillImages: uploadImage,
        maxImages: 1,
        onSelectImg: (newSelectedImages) async {
          uploadImage = newSelectedImages;
        },
      ),
    );
  }

//   ProprtyTile...
  Widget _buildPropertyTile() {
    return PropertyCard(
      imageUrl: (widget.propertiesDetailModel?.photos.isNotEmpty ?? false)
          ? widget.propertiesDetailModel?.photos.first ?? ""
          : "",
      propertyTitle: widget.propertiesDetailModel?.address?.addreesTitle ?? "",
      propertySubtitle:
          widget.propertiesDetailModel?.address?.fullAddress ?? "",
      color: ColorConstants.custDarkPurple500472,
    );
  }

//  custom title
  Widget _buildBottomTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: CustomTitleWithLine(
        title: StaticString.selectLeaseType,
        primaryColor: ColorConstants.custDarkPurple500472,
        secondaryColor: ColorConstants.custBlue1EC0EF,
      ),
    );
  }

  Widget _buildTenancyCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          CustomTenancyCard(
            title: StaticString.currentTenancy,
            color: ColorConstants.custLimeEAFDB2,
            image: ImgName.tenantCurrentTenancy,
            isSelected: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTenantDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: _commonCardDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            txtTitle: StaticString.tenantDetails,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const Divider(
            color: ColorConstants.custskyblue22CBFE,
            thickness: 1,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              buildCreateLeaseInfo(
                StaticString.tenantName,
                widget.tenancyModel?.profile?.fullName ?? "",
              ),
              const SizedBox(height: 10),
              buildCreateLeaseInfo(
                StaticString.tenantMobileNumber,
                widget.tenancyModel?.profile?.mobile ?? "",
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // PrpertyDetailsCard...
  Widget _buildPropertyDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: _commonCardDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            txtTitle: StaticString.propertyDetails,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const Divider(
            color: ColorConstants.custskyblue22CBFE,
            thickness: 1,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: (widget.propertiesDetailModel?.type.isNotEmpty ?? false)
                    ? 10
                    : 0,
              ),
              if (widget.propertiesDetailModel?.type.isNotEmpty ?? false)
                buildCreateLeaseInfo(
                  StaticString.propertyType,
                  widget.propertiesDetailModel?.type,
                )
              else
                Container(),
              const SizedBox(height: 10),
              buildCreateLeaseInfo(
                StaticString.rentDueDate,
                widget.tenancyModel?.rentDueDate?.activeLeaseDay,
              ),
              const SizedBox(height: 10),
              buildCreateLeaseInfo(
                StaticString.deposit,
                "${StaticString.currency}${widget.tenancyModel?.depositAmount.toString()}",
              ),
              const SizedBox(height: 10),
              buildCreateLeaseInfo(
                StaticString.depositScheme,
                widget.tenancyModel?.depositScheme?.attributeValue,
              ),
              SizedBox(
                height: (widget.tenancyModel?.depositId.isNotEmpty ?? false)
                    ? 10
                    : 0,
              ),
              if (widget.tenancyModel?.depositId.isNotEmpty ?? false)
                buildCreateLeaseInfo(
                  StaticString.depositId,
                  widget.tenancyModel?.depositId ?? "",
                )
              else
                Container(),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  //  Common container boxDecoration...
  final BoxDecoration _commonCardDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: ColorConstants.backgroundColorFFFFFF,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        blurRadius: 8,
        offset: const Offset(0, 5),
      ),
    ],
  );

  // CreateInformation view ...
  Widget buildCreateLeaseInfo(
    String title,
    String? value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CustomText(
            txtTitle: title,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey707070,
                ),
          ),
        ),
        Expanded(
          child: CustomText(
            txtTitle: value,
            align: TextAlign.end,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custskyblue22CBFE,
                ),
          ),
        )
      ],
    );
  }

  Widget _buildRentAmountDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        autovalidateMode: _autovalidateMode,
        validator: (value) => value?.validateEmpty,
        controller: _rentAmountController,
        keyboardType: TextInputType.number,
        maxLength: 9,
        textInputAction: TextInputAction.next,
        decoration: CommonInputdecoration.copyWith(
          prefixText: StaticString.currency.addSpaceAfter,
          labelText: StaticString.rentalAmount.addStarAfter,
        ),
        cursorColor: ColorConstants.custDarkPurple500472,
      ),
    );
  }

  Widget _buildTenantStartDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        autovalidateMode: _autovalidateMode,
        onTap: () => selectDate(
          controller: _tenantStartDateController,
          color: ColorConstants.custDarkPurple500472,
          initialDate: _leaseStartDate,
        ).then(
          (value) => {
            if (value != null) {_leaseStartDate = value}
          },
        ),
        validator: (value) => value?.validateDate,
        readOnly: true,
        controller: _tenantStartDateController,
        keyboardType: TextInputType.datetime,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: StaticString.tenancyStartDate.addStarAfter,
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

  Widget _buildTennatEndDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        autovalidateMode: _autovalidateMode,
        onTap: () => selectDate(
          controller: _tenantEndDateController,
          color: ColorConstants.custDarkPurple500472,
          initialDate: _leaseEndDate,
        ).then(
          (value) => {
            if (value != null) {_leaseEndDate = value}
          },
        ),
        validator: (value) => value?.validateEndDate(
          startDate: _leaseStartDate,
          endDate: _leaseEndDate,
        ),
        readOnly: true,
        controller: _tenantEndDateController,
        keyboardType: TextInputType.datetime,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: StaticString.tenancyEndDate.addStarAfter,
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

  Widget _buildGenerateRenewalButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CommonElevatedButton(
        bttnText: StaticString.renewLease,
        color: ColorConstants.custBlue1EC0EF,
        fontSize: 18,
        onPressed: leaseRenewProperty,
      ),
    );
  }

  // Lease Renew Property function
  Future<void> leaseRenewProperty() async {
    try {
      if (!(_formKey.currentState?.validate() ?? true)) {
        _autovalidateMode = AutovalidateMode.always;

        return;
      }

      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      // final String? userId = getAuthProvider.authModel?.userId;
      final List<String> uploadedbleImage = [];

      if (uploadImage.isNotEmpty) {
        for (final element in uploadImage) {
          if (!element.isNetworkImage) {
            uploadedbleImage.add(element);
          }
        }

        // upload lease
        final List<String> uploadedLeaseUrl =
            await ImgUploadService.instance.uploadPropertyPictures(
          id: widget.tenancyModel?.id ?? "",
          images: uploadedbleImage,
          uploadType: UploadType.PROPERTY_LEASAES,
        );
        print("tenantcyID:${widget.tenancyModel?.id}");
        // set leaseUrl
        if (uploadedLeaseUrl.isNotEmpty) {
          widget.tenancyModel?.leaseUrl = uploadedLeaseUrl.first;
        } else {
          widget.tenancyModel?.leaseUrl = uploadImage.first;
        }
      }
      // final List<String> urls =
      //     await ImgUploadService.instance.uploadPropertyPictures(
      //   id: userId,
      //   images: [uploadImage.first],
      // );
      // print("******${urls.first}");

      await landlordTenantPropertyProvider.tenantRenewLeaseProperty(
        widget.tenancyModel?.id ?? "",
        _rentAmountController.text,
        _leaseStartDate?.toFilterDate ?? "",
        _leaseEndDate?.toFilterDate ?? "",
        widget.tenancyModel?.leaseUrl,
      );
      Navigator.of(context).pop();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
