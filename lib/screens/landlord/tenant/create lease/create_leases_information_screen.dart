import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/main.dart';
import 'package:zungu_mobile/models/landloard/create_lease_model.dart';
import 'package:zungu_mobile/models/landloard/fetch_lease_type.dart';
import 'package:zungu_mobile/providers/auth/personal_profile_provider/personal_provider.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/custom_title_with_line.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';

import '../../../../models/landloard/my_property_list_model.dart';
import '../../../../providers/landlord/tenant/create_leases_provider.dart';
import '../../../../providers/landlord/tenant/fetch_property_provider.dart';
import '../../../../services/pdf_viewer_service.dart';
import '../../../../utils/custom_extension.dart';
import '../e_signed_leases/signature_pad_popup.dart';

class CreateLeasesInformationScreen extends StatefulWidget {
  final CreateLeaseModel? createLeasesInformation;
  final SelectLeaseType? selectedTypedata;
  final PropertiesList? propertyInformation;
  const CreateLeasesInformationScreen({
    super.key,
    this.createLeasesInformation,
    this.selectedTypedata,
    this.propertyInformation,
  });

  @override
  State<CreateLeasesInformationScreen> createState() =>
      _CreateLeasesInformationScreenState();
}

class _CreateLeasesInformationScreenState
    extends State<CreateLeasesInformationScreen> {
  // Loadingindicator...
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  //  --------------------Providers--------------//
  PersonalProfileProvider get getPersonalProfileProvider =>
      Provider.of<PersonalProfileProvider>(context, listen: false);

  CreateLeasesProvider get getCreateLeasesProvider =>
      Provider.of<CreateLeasesProvider>(context, listen: false);

  LandlordTenantPropertyProvider get landlordTenantPropertyProvider =>
      Provider.of<LandlordTenantPropertyProvider>(
        context,
        listen: false,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(context),
    );
  }

  // Appbar...
  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: ColorConstants.custDarkPurple500472,
      title: const CustomText(
        txtTitle: StaticString.createLeaseInformation,
      ),
    );
  }

  //  Body...
  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: LoadingIndicator(
        loadingStatusNotifier: _loadingIndicatorNotifier,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              const CustomTitleWithLine(
                title: StaticString.reviewInformation,
                primaryColor: ColorConstants.custDarkPurple160935,
                secondaryColor: ColorConstants.custskyblue22CBFE,
              ),
              const SizedBox(height: 30),
              buildCreateLeaseInfo(
                StaticString.countryy,
                widget.createLeasesInformation?.selectCountry ?? "",
              ),
              const SizedBox(height: 15),
              commonDevider(),
              const SizedBox(height: 15),
              buildCreateLeaseInfo(
                StaticString.leaseType,
                widget.createLeasesInformation?.selectedDisplayType ?? "",
              ),
              const SizedBox(height: 15),
              commonDevider(),
              const SizedBox(height: 15),
              buildCreateLeaseInfo(
                StaticString.agreementDate,
                widget.createLeasesInformation?.agreementDate?.createLeaseDate,
              ),
              const SizedBox(height: 30),
              _buildLandlordDetails(),
              const SizedBox(height: 30),
              // Property info...
              _buildPropertyinfo(context),
              const SizedBox(height: 30),

              // TenantsDetails -----
              _buildTenantDetails(context),
              const SizedBox(height: 30),

              // Gaurantor details.....
              _buildGaurantorDetail(context),
              const SizedBox(height: 30),

              // Bills Included && Excluded...
              _buildBillsInclusionandExclusion(context),
              const SizedBox(height: 30),
              commonCreateLeaseinformationCard(
                StaticString.benerateLeaseDescription,
              ),

              const SizedBox(height: 20),
              commonCreateLeaseinformationCard(StaticString.signingScreenPad),

              commonCreateLeaseinformationCard(
                StaticString.gaurantorInformation,
              ),
              const SizedBox(height: 30),
              CommonElevatedButton(
                bttnText: StaticString.generateLease,
                color: ColorConstants.custskyblue22CBFE,
                onPressed: createLease,
              )
            ],
          ),
        ),
      ),
    );
  }

//  Property info...
  Widget _buildPropertyinfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: _commonCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
          const SizedBox(height: 20),
          buildCreateLeaseInfo(
            StaticString.propertyAddress,
            widget.createLeasesInformation?.propertyAddress,
          ),
          if (widget.propertyInformation?.propertyType?.name.isNotEmpty ??
              false)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: buildCreateLeaseInfo(
                StaticString.propertyType,
                widget.propertyInformation?.propertyType?.name,
              ),
            ),
          if (widget.propertyInformation?.furnishing != null)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: buildCreateLeaseInfo(
                StaticString.furnishing,
                widget.propertyInformation?.furnishing,
              ),
            ),
          // const SizedBox(height: 20),
          if (widget.selectedTypedata?.startDate?.isEnabled ?? false)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: buildCreateLeaseInfo(
                StaticString.leaseStartDate,
                widget.createLeasesInformation?.startDate?.createLeaseDate,
              ),
            ),
          if (widget.selectedTypedata?.endDate?.isEnabled ?? false)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: buildCreateLeaseInfo(
                StaticString.leaseEndDate,
                widget.createLeasesInformation?.endDate?.createLeaseDate,
              ),
            ),
          const SizedBox(height: 20),
          buildCreateLeaseInfo(
            StaticString.rentAmout,
            widget.createLeasesInformation?.rentAmount,
          ),
          const SizedBox(height: 20),
          buildCreateLeaseInfo(
            StaticString.rentCycle,
            widget.createLeasesInformation?.rentCycle,
          ),
          const SizedBox(height: 20),
          buildCreateLeaseInfo(
            StaticString.rentDueDate,
            (widget.createLeasesInformation?.rentDueDate).toString(),
          ),
          const SizedBox(height: 20),
          buildCreateLeaseInfo(
            StaticString.latePaymentFee,
            (widget.createLeasesInformation?.latePaymentFee).toString(),
          ),
          const SizedBox(height: 20),
          buildCreateLeaseInfo(
            StaticString.deposit,
            (widget.createLeasesInformation?.deposit).toString(),
          ),
          const SizedBox(height: 20),
          buildCreateLeaseInfo(
            StaticString.depositScheme,
            widget.createLeasesInformation?.depositeSchemeName,
          ),
          const SizedBox(height: 20),
          buildCreateLeaseInfo(
            StaticString.petsAllowed,
            (widget.createLeasesInformation?.pets?.allowed ?? false)
                ? StaticString.yes
                : StaticString.no,
          ),
          SizedBox(
            height: (widget.createLeasesInformation?.pets?.allowed ?? false)
                ? 20
                : 0,
          ),
          if (widget.createLeasesInformation?.pets?.allowed ?? false)
            buildCreateLeaseInfo(
              StaticString.petDeposite,
              (widget.createLeasesInformation?.pets?.deposit).toString(),
            )
          else
            Container(),
          const SizedBox(height: 20),
          buildCreateLeaseInfo(
            StaticString.petsAllowed,
            widget.createLeasesInformation?.pets?.refundable ?? false
                ? StaticString.yes
                : StaticString.no,
          ),
        ],
      ),
    );
  }

  // Tenant Details...
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
          ListView.builder(
            itemCount: widget.createLeasesInformation?.tenants.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    txtTitle: "${StaticString.tenant} ${index + 1}",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstants.custGrey707070,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 10),
                  buildCreateLeaseInfo(
                    StaticString.tenantName,
                    widget.createLeasesInformation?.tenants[index].name,
                  ),
                  const SizedBox(height: 10),
                  buildCreateLeaseInfo(
                    StaticString.tenantMobileNumber,
                    widget.createLeasesInformation?.tenants[index].mobile,
                  ),
                  const SizedBox(height: 10),
                  buildCreateLeaseInfo(
                    StaticString.tenantCurrentAddress,
                    widget.createLeasesInformation?.tenants[index].address,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  //  GaurantorDetails...
  Widget _buildGaurantorDetail(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: _commonCardDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            txtTitle: StaticString.guarantorDetails,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const Divider(
            color: ColorConstants.custskyblue22CBFE,
            thickness: 1,
          ),
          ListView.builder(
            itemCount: widget.createLeasesInformation?.guarantors.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    txtTitle: "${StaticString.guarantor} ${index + 1}",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstants.custGrey707070,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 10),
                  buildCreateLeaseInfo(
                    StaticString.guarantorName,
                    widget.createLeasesInformation?.guarantors[index].name,
                  ),
                  const SizedBox(height: 10),
                  buildCreateLeaseInfo(
                    StaticString.guarantorMobileNumber,
                    widget.createLeasesInformation?.guarantors[index].mobile,
                  ),
                  const SizedBox(height: 10),
                  buildCreateLeaseInfo(
                    StaticString.guarantorCurrentAddress,
                    widget.createLeasesInformation?.guarantors[index].address,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

//  Bills inclusion& exclusion...
  Widget _buildBillsInclusionandExclusion(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: _commonCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            txtTitle: StaticString.billsIncludedExcluded,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const Divider(
            color: ColorConstants.custskyblue22CBFE,
            thickness: 1,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.createLeasesInformation?.inclusion.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  buildCreateLeaseInfo(
                    widget.createLeasesInformation?.inclusion[index]
                            .displayValue ??
                        "",
                    (widget.createLeasesInformation?.inclusion[index]
                                .isEnabled ??
                            false)
                        ? StaticString.included
                        : StaticString.excluded,
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          )
        ],
      ),
    );
  }

  // Common createLease information text...
  Widget commonCreateLeaseinformationCard(
    String userInfo,
  ) {
    return Center(
      child: CustomText(
        txtTitle: userInfo,
        align: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: ColorConstants.custGrey707070,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  // Landloard details...
  Widget _buildLandlordDetails() {
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
          children: [
            _buildLandlordDetailTextRow(),
            const SizedBox(height: 20),
            _buildLandlordDetailAvatarAddressRow(),
          ],
        ),
      ),
    );
  }

  // landloard userInformation...
  Widget _buildLandlordDetailAvatarAddressRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CustImage(
              imgURL:
                  getPersonalProfileProvider.getFetchProfileModel?.profileImg ??
                      "",
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  txtTitle: getPersonalProfileProvider
                          .getFetchProfileModel?.fullName ??
                      "",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
                CustomText(
                  txtTitle: getPersonalProfileProvider
                          .getFetchProfileModel?.addresid?.fullAddress ??
                      "",
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
                      txtTitle: getPersonalProfileProvider
                          .getFetchProfileModel?.registrationNumber,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstants.custGrey707070,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
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

  // User Information ...
  Widget _buildLandlordDetailTextRow() {
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
      ],
    );
  }

// Common divider...
  Widget commonDevider() {
    return const Divider(
      color: ColorConstants.custGreyEBEAEA,
      thickness: 1,
    );
  }

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

  // Create lease api function...
  Future<void> createLease() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      // createlease api call...
      if (widget.createLeasesInformation != null) {
        final CreateLeaseModel? _leaseModel = await getCreateLeasesProvider
            .createLeasesData(widget.createLeasesInformation!);

        // Navigate to pdfviewer Screen...
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => PDFViewerService(
              pdfUrl: _leaseModel?.leaseUrl ?? "",
              nextBtnAction: () async {
                await showAlert(
                  context: getContext,
                  hideButton: true,
                  showCustomContent: true,
                  showIcon: false,
                  title: StaticString.signaturePad,
                  content: SignaturePadPopup(
                    leaseID: _leaseModel?.id ?? "",
                    eSignType: ESignType.landlord,
                    onSubmit: () {
                      Navigator.of(getContext).pop();
                      Navigator.of(getContext).pop();
                      Navigator.of(getContext).pop();
                    },
                  ),
                );
              },
              userRole: UserRole.LANDLORD,
            ),
          ),
        );
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
