import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/providers/dashboard_provider/tenant_dashboard_provider.dart';
import 'package:zungu_mobile/widgets/calender_card.dart';
import 'package:zungu_mobile/widgets/common_container_with_value_container.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/image_upload_outlined_widget.dart';

import '../../../providers/landlord/tenant/create_leases_provider.dart';
import '../../../providers/landlord/tenant/lease_detail_provider.dart';
import '../../../services/pdf_viewer_service.dart';
import '../../../utils/cust_eums.dart';
import '../../../utils/custom_extension.dart';
import '../../../widgets/loading_indicator.dart';
import '../../../widgets/no_content_label.dart';
import '../../landlord/tenant/e_signed_leases/signature_pad_popup.dart';

class MyLeasesSignRenewScreen extends StatefulWidget {
  const MyLeasesSignRenewScreen({super.key});

  @override
  State<MyLeasesSignRenewScreen> createState() => _MyLeseasReState();
}

class _MyLeseasReState extends State<MyLeasesSignRenewScreen> {
  String? pdfDoc;

  // notifiers
  final LoadingIndicatorNotifier _indicatorNotifier =
      LoadingIndicatorNotifier();

  // providers
  LeaseDetailProvider get leaseDetailProvider =>
      Provider.of<LeaseDetailProvider>(
        context,
        listen: false,
      );
  TenantDashboradProvider get tenantDashboardProvider =>
      Provider.of<TenantDashboradProvider>(
        context,
        listen: false,
      );

  CreateLeasesProvider get createLeasesProvider =>
      Provider.of<CreateLeasesProvider>(
        context,
        listen: false,
      );

  @override
  void initState() {
    super.initState();
    fetchLeaseData(indicatorType: LoadingIndicatorType.spinner);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _indicatorNotifier,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorConstants.custDarkPurple662851,
      title: const CustomText(
        txtTitle: StaticString.signRenewLease,
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Consumer<LeaseDetailProvider>(
        builder: (context, provider, child) {
          return provider.leaseDetail.isEmpty
              ? NoContentLabel(
                  title: AlertMessageString.noDataFound,
                  onPress: () => fetchLeaseData(
                    indicatorType: LoadingIndicatorType.overlay,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await leaseDetailProvider.fetchLeaseData();
                  },
                  child: ListView.builder(
                    itemCount: provider.leaseDetail.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 25,
                          horizontal: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonContainerWithImageValue(
                              imgurl:
                                  provider.leaseDetail[index].photos.isNotEmpty
                                      ? provider.leaseDetail[index].photos.first
                                      : "",
                              valueContainerColor: ColorConstants
                                  .custDarkBlue150934
                                  .withOpacity(0.6),
                              imgValue:
                                  "£ ${provider.leaseDetail[index].rentAmount}/month",
                              secondContainer: true,
                              midContainerColor: provider
                                          .leaseDetail[index].flowType
                                          .toLowerCase() ==
                                      StaticString.newStatus.toLowerCase()
                                  ? ColorConstants.custgreen00B604
                                      .withOpacity(0.5)
                                  : ColorConstants.custPureRedFF0000
                                      .withOpacity(0.5),
                              midContainertxt: provider
                                          .leaseDetail[index].flowType
                                          .toLowerCase() ==
                                      StaticString.newStatus.toLowerCase()
                                  ? StaticString.newLease.toUpperCase()
                                  : StaticString.renewLease.toUpperCase(),
                            ),
                            const SizedBox(height: 25),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: CustomText(
                                txtTitle: provider.leaseDetail[index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: CustomText(
                                txtTitle: provider
                                    .leaseDetail[index].address?.fullAddress,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                      color: ColorConstants.custGrey707070,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CommonCalenderCard(
                                      bgColor:
                                          ColorConstants.custLightGreenE4FEE2,
                                      calenderUrl: ImgName.commonCalendar,
                                      imgColor:
                                          ColorConstants.custDarkPurple662851,
                                      date: provider
                                          .leaseDetail[index].startDate?.day
                                          .toString(),
                                      dateMonth: provider.leaseDetail[index]
                                              .startDate?.toMonthYear ??
                                          "",
                                      title: StaticString.startLease,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: CommonCalenderCard(
                                      bgColor:
                                          ColorConstants.custLightGreenE4FEE2,
                                      calenderUrl: ImgName.commonCalendar,
                                      imgColor:
                                          ColorConstants.custDarkPurple662851,
                                      date: provider
                                          .leaseDetail[index].endDate?.day
                                          .toString(),
                                      dateMonth: provider.leaseDetail[index]
                                              .endDate?.toMonthYear ??
                                          "",
                                      title: StaticString.endLease,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 25),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: UploadMediaOutlinedWidget(
                                title: StaticString.viewAndEsignLease,
                                userRole: UserRole.LANDLORD,
                                image: ImgName.landlordPdf,
                                showOptional: false,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => PDFViewerService(
                                        userRole: UserRole.TENANT,
                                        pdfUrl: provider
                                            .leaseDetail[index].leaseUrl,
                                        nextBtnAction: () async {
                                          if (provider
                                                  .leaseDetail[index].flowType
                                                  .toLowerCase() ==
                                              StaticString.newStatus
                                                  .toLowerCase()) {
                                            await showAlert(
                                              context: context,
                                              hideButton: true,
                                              showCustomContent: true,
                                              showIcon: false,
                                              title: StaticString.signaturePad,
                                              content: SignaturePadPopup(
                                                leaseID: provider
                                                    .leaseDetail[index]
                                                    .leaseDetailId,
                                                eSignType: ESignType.tenant,
                                                onSubmit: () {
                                                  Navigator.of(context).pop();
                                                  fetchLeaseData(
                                                    indicatorType:
                                                        LoadingIndicatorType
                                                            .spinner,
                                                  );
                                                },
                                              ),
                                            );
                                          } else {
                                            await renewEsignedLease(
                                              leaseDetailId: provider
                                                  .leaseDetail[index]
                                                  .leaseDetailId,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }

  Future<void> fetchLeaseData({
    required LoadingIndicatorType indicatorType,
  }) async {
    try {
      _indicatorNotifier.show(loadingIndicatorType: indicatorType);

      await leaseDetailProvider.fetchLeaseData();
      tenantDashboardProvider.fetchTenantDashboardList();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _indicatorNotifier.hide();
    }
  }

  Future<void> renewEsignedLease({
    required String leaseDetailId,
  }) async {
    try {
      _indicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      await leaseDetailProvider.renewESignLease(leaseDetailId: leaseDetailId);
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _indicatorNotifier.hide();
    }
  }
}
