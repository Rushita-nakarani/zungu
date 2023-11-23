import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constant/img_font_color_string.dart';
import '../../../../models/landloard/landlord_my_lease_model.dart';
import '../../../../providers/landlord/tenant/lease_detail_provider.dart';
import '../../../../services/image_picker_service.dart';
import '../../../../services/pdf_viewer_service.dart';
import '../../../../utils/cust_eums.dart';
import '../../../../utils/custom_extension.dart';
import '../../../../widgets/bookmark_widget.dart';
import '../../../../widgets/calender_card.dart';
import '../../../../widgets/common_container_with_value_container.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/loading_indicator.dart';
import '../../../../widgets/no_content_label.dart';

class ActiveLeasesDetailScreen extends StatefulWidget {
  final String propertyDetailId;
  const ActiveLeasesDetailScreen({super.key, required this.propertyDetailId});

  @override
  State<ActiveLeasesDetailScreen> createState() =>
      _ActiveLeasesDetailScreenState();
}

class _ActiveLeasesDetailScreenState extends State<ActiveLeasesDetailScreen> {
  //---------------------------Variables----------------------//
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();
//  Providers
  LeaseDetailProvider get getFetchLease => Provider.of<LeaseDetailProvider>(
        context,
        listen: false,
      );

  @override
  void initState() {
    super.initState();
    fetchLeaseDetail();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

// Appbar...
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorConstants.custPurple500472,
      title: const Text(
        StaticString.activeLeasesDetail,
      ),
    );
  }

//  Body...
  Widget _buildBody() {
    return SafeArea(
      child: Consumer<LeaseDetailProvider>(
        builder: (context, leaseProvider, child) {
          return _tenancyList(
            landlordMyLeaseModel: leaseProvider.landlordCurrentlease,
            tenantList: leaseProvider.currentLeaseTeants,
          );
        },
      ),
    );
  }

// tenancy List...
  Widget _tenancyList({
    LandlordMyLeaseModel? landlordMyLeaseModel,
    required List<Tenant> tenantList,
  }) {
    return landlordMyLeaseModel == null
        ? NoContentLabel(
            title: StaticString.nodataFound,
            onPress: () {
              fetchLeaseDetail();
            },
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonContainerWithImageValue(
                    imgurl: landlordMyLeaseModel.photos.isNotEmpty
                        ? landlordMyLeaseModel.photos.first
                        : "",
                    secondContainer: false,
                    valueContainerColor:
                        ColorConstants.custDarkBlue150934.withOpacity(0.6),
                    imgValue: "£${landlordMyLeaseModel.rent}/month",
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomText(
                      txtTitle: landlordMyLeaseModel.name,
                      style: Theme.of(context).textTheme.headline1?.copyWith(
                            color: ColorConstants.custDarkBlue150934,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomText(
                      txtTitle: landlordMyLeaseModel.address?.fullAddress,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: ColorConstants.custGrey707070),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // fetch lease data through listview...
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: tenantList.length,
                    itemBuilder: (context, index) {
                      return _leasesPersonCard(
                        category: landlordMyLeaseModel.category,
                        tenantData: tenantList[index],
                        leaseList: tenantList[index].leases,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
  }

  // Leases Person Card
  Widget _leasesPersonCard({
    required String category,
    required Tenant tenantData,
    required List<Lease> leaseList,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
            blurRadius: 7,
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          // Leases person details and room book mark card row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const SizedBox(height: 12),
                  ClipOval(
                    child: CustImage(
                      height: 50,
                      width: 50,
                      imgURL: tenantData.profileImg.isEmpty
                          ? ImgName.defaultProfile1
                          : tenantData.profileImg,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      txtTitle: tenantData.fullName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    CustomText(
                      txtTitle:
                          "${StaticString.rentGem} ${StaticString.currency}${tenantData.rentAmount}",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.custGrey707070,
                          ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (tenantData.roomName.isNotEmpty)
                buildBookmark(
                  text: tenantData.roomName.replaceAll(" ", "\n"),
                  color: ColorConstants
                      .custDarkBlue160935, // (widget.id * 25).getExpiresColor,
                  size: const Size(40, 50),
                )
              else
                Container(),
            ],
          ),
          const SizedBox(height: 15),

          // Leases start and end calender and pdf card row
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: leaseList.length,
            itemBuilder: (context, index) {
              return _leasesStartEndCalenderAndPdfCameraCardRow(
                leaseData: leaseList[index],
              );
            },
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  // Lease start and end date ,pdf icon row
  Widget _leasesStartEndCalenderAndPdfCameraCardRow({
    required Lease leaseData,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CommonCalenderCard(
              bgColor: leaseData.isExpired
                  ? ColorConstants.custLightRedFFE6E6
                  : ColorConstants.custLightGreenE4FEE2,
              calenderUrl: ImgName.commonCalendar,
              date: leaseData.startDate?.activeLeaseDay,
              dateMonth: leaseData.startDate?.monthYearLeaseDay ?? "",
              title: StaticString.leasesStart,
              imgColor: ColorConstants.custDarkPurple500472,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 2,
            child: CommonCalenderCard(
              bgColor: leaseData.isExpired
                  ? ColorConstants.custLightRedFFE6E6
                  : ColorConstants.custLightGreenE4FEE2,
              calenderUrl: ImgName.commonCalendar,
              date: leaseData.endDate?.activeLeaseDay,
              dateMonth: leaseData.endDate?.monthYearLeaseDay ?? "",
              title: StaticString.leasesEnd,
              imgColor: ColorConstants.custDarkPurple500472,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: ColorConstants.custGreyF7F7F7,
              ),
              child: leaseData.leaseUrl.isEmpty
                  ? InkWell(
                      onTap: () => cameraIconOntap(leaseData.id),
                      child: const CustImage(
                        imgURL: ImgName.landlordCamera,
                        height: 30,
                        boxfit: BoxFit.contain,
                      ),
                    )
                  : InkWell(
                      onTap: () => pdfIconOnTapAction(leaseData),
                      child: const CustImage(
                        imgURL: ImgName.landlordPdf,
                        height: 30,
                        boxfit: BoxFit.contain,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // Camera Icon Card Ontap
  void cameraIconOntap(String leaesId) {
    if (leaesId.isEmpty) {
      return;
    }
    ImagePickerService(
      isDocumentsFile: true,
      pickedImg: (imgPath) async {
        if (imgPath?.isNotEmpty ?? false) {
          updateLeaseUrl(
            imgPath?.first ?? "",
            leaesId,
          );
        }
      },
    ).openImagePikcer(
      multipicker: false,
      context: context,
      iosImagePicker: Platform.isIOS,
    );
  }

  // Pdf OnTap Action...
  void pdfIconOnTapAction(Lease activeLeaseData) {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      if (activeLeaseData.leaseUrl.isNetworkImage) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => PDFViewerService(
              userRole: UserRole.LANDLORD,
              pdfUrl: activeLeaseData.leaseUrl,
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

  //-------------------------------Helper Function-------------------------//
  // Fetch leases detail function...
  Future<void> fetchLeaseDetail() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );

      if (widget.propertyDetailId.isNotEmpty) {
        await getFetchLease.leaseFetchByStatus(
          propertyDetailId: widget.propertyDetailId,
          status: StaticString.statusCURRENT,
        );
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  Future<void> updateLeaseUrl(
    String leaseUrl,
    String leaseId,
  ) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );

      await getFetchLease.leaesUpdateUrl(
        leaesId: leaseId,
        leaesUrl: leaseUrl,
      );
      if (widget.propertyDetailId.isNotEmpty) {
        getFetchLease.leaseFetchByStatus(
          propertyDetailId: widget.propertyDetailId,
          status: StaticString.statusCURRENT,
        );
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
