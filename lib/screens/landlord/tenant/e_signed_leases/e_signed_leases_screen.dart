import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/screens/landlord/tenant/e_signed_leases/e_signed_leases.dart';
import 'package:zungu_mobile/screens/landlord/tenant/e_signed_leases/pending_e_sign.dart';

import '../../../../constant/img_font_color_string.dart';
import '../../../../models/landloard/e_signed_lease_list_model.dart';
import '../../../../providers/dashboard_provider/landlord_dashboard_provider.dart';
import '../../../../providers/landlord/tenant/e_signed_lease_provider.dart';
import '../../../../screens/landlord/tenant/e_signed_leases/e_signed_leases_filter_bottomsheet.dart';
import '../../../../screens/landlord/tenant/e_signed_leases/signature_pad_popup.dart';
import '../../../../services/image_picker_service.dart';
import '../../../../services/pdf_viewer_service.dart';
import '../../../../services/uri_launch_service.dart';
import '../../../../utils/cust_eums.dart';
import '../../../../utils/custom_extension.dart';
import '../../../../widgets/bookmark_widget.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/loading_indicator.dart';
import '../../../../widgets/no_content_label.dart';

class ESignedLeasesScreen extends StatefulWidget {
  const ESignedLeasesScreen({super.key});

  @override
  State<ESignedLeasesScreen> createState() => _ESignedLeasesScreenState();
}

class _ESignedLeasesScreenState extends State<ESignedLeasesScreen>
    with TickerProviderStateMixin {
  //--------------------------------Variables----------------------------//

  // Tab Controller
  TabController? _tabController;

  //Is Filter Icon Hide and Show
  bool isFilterIcon = false;

  // Loading Indicator
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  // E-Signed Lease Provider getter
  ESignedLeaseProvider get eSignedLeaseProvider =>
      Provider.of<ESignedLeaseProvider>(context, listen: false);

  // Landlord Dashboard Provider getter
  LandlordDashboradProvider get landlordDashboardProvider =>
      Provider.of<LandlordDashboradProvider>(
        context,
        listen: false,
      );

  // From Date and to date
  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
    // fetchPendingESignedLeaseList();
  }

  //--------------------------------UI----------------------------//
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

  //--------------------------------Widgets----------------------------//
  // Appbar...
  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: ColorConstants.custDarkPurple500472,
      title: const CustomText(txtTitle: StaticString.eSignedLeases),
      actions: [
        if (isFilterIcon == true)
          IconButton(
            onPressed: filterBtnAction,
            icon: const CustImage(
              imgURL: ImgName.filter,
            ),
          )
        else
          Container()
      ],
    );
  }

  // Body...
  Widget _buildBody() {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Tabbar
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TabBar(
              onTap: (value) {
                tabBarOntapaction(value);
              },
              labelColor: ColorConstants.custBlue1EC0EF,
              unselectedLabelColor: ColorConstants.custGrey707070,
              indicatorColor: ColorConstants.custBlue1EC0EF,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
              controller: _tabController,
              tabs: const [
                Tab(
                  text: StaticString.pendingeSign,
                ),
                Tab(text: StaticString.eSignedLeases1),
              ],
              labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(),
            ),
          ),
          // Tabbar view
          Expanded(
            child: TabBarView(
              // physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: const [
                PendingESign(),
                ESignedLeases()
                // _pendingEsignView(),
                // _eSignLeaseView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Pending E-sign View
  Widget _pendingEsignView() {
    return Consumer<ESignedLeaseProvider>(
      builder: (context, pendingESignedLeaseData, child) {
        return pendingESignedLeaseData.pendingESignList.isEmpty
            ? NoContentLabel(
                title: StaticString.nodataFound,
                onPress: () {
                  fetchPendingESignedLeaseList();
                },
              )
            : RefreshIndicator(
                onRefresh: () async {
                  await eSignedLeaseProvider.fetchESignedLeaseListData();
                },
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  itemCount: pendingESignedLeaseData.pendingESignList.length,
                  itemBuilder: (context, index) {
                    return _pendingEsignCard(
                      eSignedLeaseListModel:
                          pendingESignedLeaseData.pendingESignList[index],
                    );
                  },
                ),
              );
      },
    );
  }

  //  eSignCard...
  Widget _pendingEsignCard({
    required ESignedLeaseListModel eSignedLeaseListModel,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20, bottom: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: _userInfoCard(eSignedLeaseListModel),
      ),
    );
  }

  //--------Person image,name ,call pdf icon image and book mark card -------//
  Widget _userInfoCard(ESignedLeaseListModel eSignedLeaseListModel) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: CustomText(
                    txtTitle: eSignedLeaseListModel.fullName,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 6),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          launchMobile(
                            eSignedLeaseListModel.mobile,
                          );
                        },
                        child: const CustImage(
                          imgURL: ImgName.tenantCall,
                          height: 24,
                          width: 24,
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          pdfOntapAction(eSignedLeaseListModel);
                        },
                        child: const CustImage(
                          imgURL: ImgName.landlordPdfCircle,
                          height: 24,
                          width: 24,
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          deleteOntapAction(eSignedLeaseListModel);
                        },
                        child: const CustImage(
                          imgURL: ImgName.deleteIcon,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Spacer(),
            // Book mark card

            if (eSignedLeaseListModel.roomName.isEmpty)
              Container()
            else
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: buildBookmark(
                  text: eSignedLeaseListModel.roomName,
                  color: ColorConstants.custDarkPurple160935,
                ),
              )
          ],
        ),

        const SizedBox(height: 25),

        //-----------------Address text----------------//
        Column(
          children: [
            CustomText(
              align: TextAlign.center,
              txtTitle:
                  " ${eSignedLeaseListModel.address?.addressLine1} ${eSignedLeaseListModel.address?.addressLine2}",
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custDarkPurple150934,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            CustomText(
              align: TextAlign.center,
              txtTitle: eSignedLeaseListModel.address?.fullAddress,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custGrey707070,
                    fontWeight: FontWeight.w400,
                  ),
            )
          ],
        ),
        const SizedBox(height: 10),

        _custTitleAndAmountRow(
          title: StaticString.rent,
          amount: eSignedLeaseListModel.rentAmount.toString(),
        ),
        const SizedBox(height: 9),
        _custTitleAndAmountRow(
          title: StaticString.depositPaid,
          amount: eSignedLeaseListModel.deposit.toString(),
        ),
        const SizedBox(height: 7),

        _custTitleAndAmountRow(
          title: StaticString.status,
          isCurrency: false,
          amount: eSignedLeaseListModel.status == "PENDING"
              ? StaticString.landlordSignaturePending
              : StaticString.tenantSignaturePending,
          amountColor: ColorConstants.custPureRedFF0000,
        ),
        const SizedBox(height: 20),

        // send to tenant to e-sign button
        if (eSignedLeaseListModel.status == "PENDING")
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: 30,
            ),
            child: CommonElevatedButton(
              height: 40,
              bttnText: StaticString.signAndSendTenant,
              color: ColorConstants.custBlue1EC0EF,
              onPressed: () => signAndSendToTenantBtnAction(
                leaseUrl: eSignedLeaseListModel.leaseUrl,
                leaseId: eSignedLeaseListModel.leaseDetailId,
              ),
            ),
          )
        else
          Container()
      ],
    );
  }

  // E-Sign Lease View
  Widget _eSignLeaseView() {
    return Consumer<ESignedLeaseProvider>(
      builder: (context, eSignedLeaseData, child) {
        return eSignedLeaseData.eSignedLeaseList.isEmpty
            ? NoContentLabel(
                title: StaticString.nodataFound,
                onPress: () {
                  fetchPendingESignedLeaseList(
                    status: StaticString.statusESIGNED,
                  );
                },
              )
            : RefreshIndicator(
                onRefresh: () async {
                  await eSignedLeaseProvider.fetchESignedLeaseListData(
                    status: StaticString.statusESIGNED,
                  );
                },
                child: ListView.builder(
                  itemCount: eSignedLeaseData.eSignedLeaseList.length,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  itemBuilder: (context, index) {
                    return _custESignCard(
                      eSignedLeaseListModel:
                          eSignedLeaseData.eSignedLeaseList[index],
                    );
                  },
                ),
              );
      },
    );
  }

  //E-signed Lease Card
  Widget _custESignCard({
    required ESignedLeaseListModel eSignedLeaseListModel,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              //--------Person image,name ,call pdf icon image and book mark card -------//
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      CustomText(
                        txtTitle: eSignedLeaseListModel.fullName,
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          // Launch Mobile Card
                          InkWell(
                            onTap: () => launchMobile(
                              eSignedLeaseListModel.mobile,
                            ),
                            child: const CustImage(
                              imgURL: ImgName.tenantCall,
                              height: 24,
                              width: 24,
                            ),
                          ),
                          const SizedBox(width: 10),

                          // upload Pdf card
                          InkWell(
                            onTap: () => pdfOntapAction(eSignedLeaseListModel),
                            child: const CustImage(
                              imgURL: ImgName.landlordPdfCircle,
                              height: 24,
                              width: 24,
                            ),
                          ),
                          const SizedBox(width: 10),

                          // Upload Document Card
                          InkWell(
                            onTap: () => uploadDocsOntap(
                              leaseDetailId:
                                  eSignedLeaseListModel.leaseDetailId,
                            ),
                            child: Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorConstants.custskyblue22CBFE,
                                ),
                              ),
                              child: Icon(
                                Icons.upload_sharp,
                                size: 20,
                                color: ColorConstants.custPurple500472
                                    .withOpacity(0.8),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const Spacer(),

                  // Book mark card
                  if (eSignedLeaseListModel.roomName.isEmpty)
                    Container()
                  else
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: buildBookmark(
                        text: eSignedLeaseListModel.roomName,
                        color: ColorConstants.custDarkPurple160935,
                      ),
                    )
                ],
              ),

              const SizedBox(height: 25),

              //-----------------Address text----------------//
              Column(
                children: [
                  CustomText(
                    txtTitle: eSignedLeaseListModel.address?.fullAddress,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstants.custDarkPurple150934,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  CustomText(
                    txtTitle:
                        "${eSignedLeaseListModel.address?.addressLine1} ${eSignedLeaseListModel.address?.addressLine2}",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ColorConstants.custGrey707070,
                          fontWeight: FontWeight.w400,
                        ),
                  )
                ],
              ),
              const SizedBox(height: 30),

              _custTitleAndAmountRow(
                title: StaticString.sentDate,
                amount: eSignedLeaseListModel.signedDate?.toMobileString ?? "",
              ),
              const SizedBox(height: 7),

              _custTitleAndAmountRow(
                title: StaticString.status,
                amount: StaticString.esigned,
                isCurrency: false,
                amountColor:
                    eSignedLeaseListModel.status == StaticString.pending
                        ? ColorConstants.custRedFF0004
                        : ColorConstants.custGreen47BF0D,
              ),

              if (eSignedLeaseListModel.action ==
                  EsignLeasesAction.DIFF_TENANT_EXIST)
                _propertyAddInfo(eSignedLeaseListModel)
              else
                Container(),

              // send to tenant to e-sign button
              if (eSignedLeaseListModel.action != EsignLeasesAction.NONE)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CommonElevatedButton(
                    bttnText: esignBtnText(eSignedLeaseListModel.action),
                    onPressed: () {
                      esignOnTap(
                        eSignedLeaseListModel.action,
                        eSignedLeaseListModel,
                      );
                    },
                    color: eSignedLeaseListModel.action ==
                            EsignLeasesAction.DIFF_TENANT_EXIST
                        ? ColorConstants.greyColor
                        : ColorConstants.custBlue1EC0EF,
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Property add info...
  Widget _propertyAddInfo(ESignedLeaseListModel eSignedLeaseListModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, top: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorConstants.custPureRedFF0000.withOpacity(0.1),
      ),
      child: Column(
        children: [
          Center(
            child: CustomText(
              txtTitle: StaticString.propertyAdd,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custGrey707070,
                    fontWeight: FontWeight.w500,
                  ),
              align: TextAlign.center,
            ),
          ),
          const SizedBox(height: 15),
          CustomText(
            txtTitle: eSignedLeaseListModel.tenantName,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custGrey707070,
                  fontWeight: FontWeight.w500,
                ),
            align: TextAlign.center,
          )
        ],
      ),
    );
  }

  //-------------------------------Helper Widget--------------------------------//

  //  PropertyDetailInfo view...
  Widget _custTitleAndAmountRow({
    required String title,
    required String amount,
    bool isCurrency = true,
    Color amountColor = ColorConstants.custBlue1EC0EF,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txtTitle: title,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custGrey707070,
                  fontWeight: FontWeight.w600,
                ),
          ),
          // rent amount text
          CustomText(
            txtTitle: isCurrency ? "${StaticString.currency} $amount" : amount,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: amountColor,
                  fontWeight: FontWeight.w600,
                ),
          )
        ],
      ),
    );
  }

  // btnText method...
  String esignBtnText(EsignLeasesAction action) {
    switch (action) {
      case EsignLeasesAction.UPDATE_LEASE_DETAILS:
        return StaticString.updateLeaseDetails;

      case EsignLeasesAction.DIFF_TENANT_EXIST:
        return StaticString.addNewTenant;

      case EsignLeasesAction.ADD_NEW_TENANT:
        return StaticString.addNewTenant;

      case EsignLeasesAction.NONE:
        break;
    }
    return "";
  }

  //--------------------------------Button Action-------------------------------//

  // Filter btnAction on tap...
  void filterBtnAction() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ESignedLeasesFilterBottomsheet(
          applyFilterOnTap: applyFilterOntap,
          fromDate: _fromDate,
          toDate: _toDate,
        );
      },
    );
  }

  // Tabbar on tap action...
  Future<void> tabBarOntapaction(int value) async {
    if (value == 0) {
      if (mounted) {
        setState(() {
          isFilterIcon = false;
        });
      }
    } else if (value == 1) {
      if (mounted) {
        setState(() {
          isFilterIcon = true;
        });
        // await eSignedLeaseProvider.fetchESignedLeaseListData(
        //   status: StaticString.statusESIGNED,
        // );
      }
    }
  }

  // PdfIcon ontap action...
  void pdfOntapAction(ESignedLeaseListModel esignLeaesModel) {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      if (esignLeaesModel.leaseUrl.isNetworkImage) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => PDFViewerService(
              userRole: UserRole.LANDLORD,
              pdfUrl: esignLeaesModel.leaseUrl,
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

  // Delete ontap Action...
  Future<void> deleteOntapAction(ESignedLeaseListModel esignModel) async {
    showAlert(
      context: context,
      showIcon: false,
      singleBtnTitle: StaticString.deleteLease.toUpperCase(),
      singleBtnColor: ColorConstants.custRedE03816,
      message: StaticString.areYouSureYouWantToDeleteThisLease,
      title: StaticString.deleteLease,
      onRightAction: () async {
        await deleteESignedLease(
          esignModel.leaseDetailId,
        );
      },
    );
  }

  Future<void> uploadDocsOntap({required String leaseDetailId}) async {
    ImagePickerService(
      isDocumentsFile: true,
      pickedImg: (imgPath) async {
        if (imgPath?.isNotEmpty ?? false) {
          await uploadLeaseSign(
            imgPath?.first ?? "",
            leaseDetailId,
          );
        }
      },
    ).openImagePikcer(
      multipicker: false,
      context: context,
      iosImagePicker: Platform.isIOS,
    );
  }

  //  Esign Button ontap method...
  void esignOnTap(
    EsignLeasesAction action,
    ESignedLeaseListModel eSignedLeaseListModel,
  ) {
    switch (action) {
      case EsignLeasesAction.UPDATE_LEASE_DETAILS:
        showAlert(
          context: context,
          showIcon: false,
          showCustomContent: true,
          content: CustomText(
            align: TextAlign.center,
            txtTitle: eSignedLeaseListModel.updateLeasesinfo,
            // "${StaticString.updateLeases}\n ${eSignedLeaseListModel.tenantName}\n TO \n ${eSignedLeaseListModel.address?.fullAddress} ",
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey707070,
                  fontWeight: FontWeight.w600,
                ),
          ),
          title: StaticString.updateLeaseDetails,
          singleBtnTitle: StaticString.updateLeaseDetails,
          singleBtnColor: ColorConstants.custskyblue22CBFE,
          onRightAction: () async {
            await updateEsignedLeases(eSignedLeaseListModel);
            eSignedLeaseProvider.fetchESignedLeaseListData(
              status: StaticString.statusESIGNED,
            );
          },
        );

        break;
      case EsignLeasesAction.DIFF_TENANT_EXIST:
        break;
      case EsignLeasesAction.ADD_NEW_TENANT:
        showAlert(
          context: context,
          showIcon: false,
          showCustomContent: true,
          content: CustomText(
            align: TextAlign.center,
            txtTitle: eSignedLeaseListModel.addLeasesinfo,
            // "${StaticString.addLeases} \n ${eSignedLeaseListModel.fullName}\n TO \n ${eSignedLeaseListModel.address?.fullAddress} ",
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey707070,
                  fontWeight: FontWeight.w600,
                ),
          ),
          title: StaticString.addNewTenant,
          singleBtnTitle: StaticString.addNewTenant,
          singleBtnColor: ColorConstants.custskyblue22CBFE,
          onRightAction: () async {
            await addEsignedLeases(eSignedLeaseListModel);
            await eSignedLeaseProvider.fetchESignedLeaseListData(
              status: StaticString.statusESIGNED,
            );
            await landlordDashboardProvider.fetchLandlordDashboardList();
          },
        );

        break;

      default:
    }
  }

  Future<void> signAndSendToTenantBtnAction({
    required String leaseUrl,
    required String leaseId,
  }) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      if (leaseUrl.isNetworkImage) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => PDFViewerService(
              userRole: UserRole.LANDLORD,
              pdfUrl: leaseUrl,
              nextBtnAction: () => signaturePadPopup(leaseId: leaseId),
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

  // Signature pad popupview...
  Future<void> signaturePadPopup({required String leaseId}) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );

      await showAlert(
        context: context,
        hideButton: true,
        showCustomContent: true,
        showIcon: false,
        title: StaticString.signaturePad,
        content: SignaturePadPopup(
          leaseID: leaseId,
          eSignType: ESignType.landlord,
          onSubmit: () => Navigator.of(context).pop(),
        ),
      );

      eSignedLeaseProvider.fetchESignedLeaseListData();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  //--------------------------------Helper Function-----------------------------//
  // Delete E-Signed Lease function
  Future<void> deleteESignedLease(String leaseDetailId) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      await eSignedLeaseProvider.deleteESignedLease(leaseDetailId);
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

//  fetch EsignedLeases api...
  Future<void> applyFilterOntap({
    required DateTime? fromDate,
    required DateTime? toDate,
  }) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      await eSignedLeaseProvider.fetchESignedLeaseListData(
        status: StaticString.statusESIGNED,
        fromDate:
            fromDate != null ? DateFormat("yyyy-MM-dd").format(fromDate) : null,
        toDate: toDate != null ? DateFormat("yyyy-MM-dd").format(toDate) : null,
      );
      _fromDate = fromDate;
      _toDate = toDate;
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  // fetch property function
  Future<void> fetchPendingESignedLeaseList({
    String status = StaticString.statusPENDING,
  }) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      await eSignedLeaseProvider.fetchESignedLeaseListData(status: status);
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  // Update leases api...
  Future<void> uploadLeaseSign(
    String _sign,
    String leaseDetailId,
  ) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      await eSignedLeaseProvider.leaseSignGuarantor(
        _sign,
        leaseDetailId,
      );
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  // Update leases api...
  Future<void> updateEsignedLeases(
    ESignedLeaseListModel eSignedLeaseListModel,
  ) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      await eSignedLeaseProvider.updateEsignedTenantLeases(
        eSignedLeaseListModel.leaseDetailId,
      );
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  // add new Leases api...
  Future<void> addEsignedLeases(
    ESignedLeaseListModel eSignedLeaseListModel,
  ) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      await eSignedLeaseProvider.addEsignedTenantLeases(
        eSignedLeaseListModel.propertyId,
        eSignedLeaseListModel.leaseDetailId,
      );
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
