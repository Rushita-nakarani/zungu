import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/providers/landlord/tenant/e_signed_lease_provider.dart';
import 'package:zungu_mobile/screens/landlord/tenant/e_signed_leases/signature_pad_popup.dart';
import 'package:zungu_mobile/utils/custom_extension.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../models/landloard/e_signed_lease_list_model.dart';
import '../../../../providers/auth/personal_profile_provider/personal_provider.dart';
import '../../../../services/pdf_viewer_service.dart';
import '../../../../services/uri_launch_service.dart';
import '../../../../utils/cust_eums.dart';
import '../../../../widgets/bookmark_widget.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/loading_indicator.dart';
import '../../../../widgets/no_content_label.dart';

class PendingESign extends StatefulWidget {
  const PendingESign({
    super.key,
  });

  @override
  State<PendingESign> createState() => _PendingESignState();
}

class _PendingESignState extends State<PendingESign> {
  //---------------------Variables------------------------//
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

//  Provider...
  ESignedLeaseProvider get eSignedLeaseProvider =>
      Provider.of<ESignedLeaseProvider>(
        context,
        listen: false,
      );

  PersonalProfileProvider get personalProfileProvider =>
      Provider.of<PersonalProfileProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();

    fetchPendingESignedLeaseList();
  }

  //---------------------UI------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  //---------------------Widgets------------------------//

  Widget _buildBody() {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Consumer<ESignedLeaseProvider>(
        builder: (context, pendingESignedLeaseData, child) {
          return pendingESignedLeaseData.pendingESignList.isEmpty
              ? NoContentLabel(
                  title: StaticString.nodataFound,
                  onPress: () async {
                    await eSignedLeaseProvider.fetchESignedLeaseListData();
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
                      return _custESignCard(
                        eSignedLeaseListModel:
                            pendingESignedLeaseData.pendingESignList[index],
                      );
                    },
                  ),
                );
        },
      ),
    );
  }

  //  eSignCard...
  Widget _custESignCard({
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

  //-----------------------------Helper Function------------------------//

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

  // fetch property function
  Future<void> fetchPendingESignedLeaseList() async {
    try {
      if (eSignedLeaseProvider.pendingESignList.isEmpty) {
        _loadingIndicatorNotifier.show(
          loadingIndicatorType: LoadingIndicatorType.spinner,
        );
      }
      await eSignedLeaseProvider.fetchESignedLeaseListData();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

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
}
