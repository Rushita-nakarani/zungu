import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/providers/dashboard_provider/landlord_dashboard_provider.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../models/landloard/e_signed_lease_list_model.dart';
import '../../../../providers/landlord/tenant/e_signed_lease_provider.dart';
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

class ESignedLeases extends StatefulWidget {
  const ESignedLeases({super.key});

  @override
  State<ESignedLeases> createState() => _ESignedLeasesState();
}

class _ESignedLeasesState extends State<ESignedLeases> {
  //------------------------Variables------------------------//

  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  // providers
  ESignedLeaseProvider get eSignedLeaseProvider =>
      Provider.of<ESignedLeaseProvider>(
        context,
        listen: false,
      );
  LandlordDashboradProvider get landlordDashboardProvider =>
      Provider.of<LandlordDashboradProvider>(
        context,
        listen: false,
      );

  @override
  void initState() {
    super.initState();

    fetchESignedLeaseList();
  }

  //---------------------UI------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  //---------------------Widgets------------------------//
//   build body...
  Widget _buildBody() {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Consumer<ESignedLeaseProvider>(
        builder: (context, eSignedLeaseData, child) {
          return eSignedLeaseData.eSignedLeaseList.isEmpty
              ? NoContentLabel(
                  title: StaticString.nodataFound,
                  onPress: () {
                    eSignedLeaseProvider.fetchESignedLeaseListData(
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
      ),
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
                            onTap: () => pdfonTapAction(eSignedLeaseListModel),
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

  // pdficon onTap action...
  void pdfonTapAction(ESignedLeaseListModel esignleaseModel) {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      if (esignleaseModel.leaseUrl.isNetworkImage) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => PDFViewerService(
              userRole: UserRole.LANDLORD,
              pdfUrl: esignleaseModel.leaseUrl,
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

//  btn ontap method...
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

  // btnText method...
  String esignBtnText(EsignLeasesAction action) {
    String? esignBtnText;
    switch (action) {
      case EsignLeasesAction.UPDATE_LEASE_DETAILS:
        esignBtnText = StaticString.updateLeaseDetails;
        break;
      case EsignLeasesAction.DIFF_TENANT_EXIST:
        esignBtnText = StaticString.addNewTenant;
        break;

      case EsignLeasesAction.ADD_NEW_TENANT:
        esignBtnText = StaticString.addNewTenant;
        break;
      case EsignLeasesAction.NONE:
        break;
    }
    return esignBtnText ?? "";
  }

  // custom title with value of esignLeases...
  Widget _custTitleAndAmountRow({
    required String title,
    required String amount,
    bool isCurrency = true,
    Color amountColor = ColorConstants.custBlue1EC0EF,
  }) {
    return Row(
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
          txtTitle: isCurrency ? amount : amount,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: amountColor,
                fontWeight: FontWeight.w600,
              ),
        )
      ],
    );
  }

  //----------------------------Button Action---------------------------//

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

  //-----------------------------Helper Function------------------------//

  // fetch property function
  Future<void> fetchESignedLeaseList() async {
    try {
      if (eSignedLeaseProvider.eSignedLeaseList.isEmpty) {
        _loadingIndicatorNotifier.show(
          loadingIndicatorType: LoadingIndicatorType.spinner,
        );
      }
      await eSignedLeaseProvider.fetchESignedLeaseListData(
        status: StaticString.statusESIGNED,
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
        loadingIndicatorType: LoadingIndicatorType.spinner,
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
}
