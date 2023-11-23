import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/settings/business_profile/fetch_profile_model.dart';
import 'package:zungu_mobile/providers/auth/auth_provider.dart';
import 'package:zungu_mobile/providers/auth/personal_profile_provider/personal_provider.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/image_upload_widget.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';

import '../../../../models/auth/auth_model.dart';
import '../../../../models/settings/business_profile/view_edit_trades_document_model.dart';
import '../../../../services/img_upload_service.dart';
import '../../../../utils/custom_extension.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/date_selector.dart';
import '../../../../widgets/lenear_container.dart';

class ViewEditTradeDocumentscreen extends StatefulWidget {
  final FetchProfileModel getProfileData;
  final List<ViewEditTradesDocumentModel> viewEditTradesDocumentsList;
  final bool isFromUpdate;

  const ViewEditTradeDocumentscreen({
    super.key,
    required this.getProfileData,
    required this.viewEditTradesDocumentsList,
    this.isFromUpdate = false,
  });

  @override
  State<ViewEditTradeDocumentscreen> createState() =>
      _ViewEditTradeDocumentscreenState();
}

class _ViewEditTradeDocumentscreenState
    extends State<ViewEditTradeDocumentscreen> {
  TextEditingController startController = TextEditingController();
  TextEditingController expiryController = TextEditingController();

  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  PersonalProfileProvider get personalProfileProvider =>
      Provider.of<PersonalProfileProvider>(context, listen: false);

  AuthProvider get authProvider =>
      Provider.of<AuthProvider>(context, listen: false);

  final ValueNotifier _dateNotifier = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    if (widget.viewEditTradesDocumentsList.isNotEmpty) {
      startController.text =
          widget.viewEditTradesDocumentsList.first.startDate?.toMobileString ??
              "";
      expiryController.text =
          widget.viewEditTradesDocumentsList.first.endDate?.toMobileString ??
              "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StaticString.viewEditTradeDocuments),
        ),
        body: _buildBody(context),
      ),
    );
  }

  SafeArea _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(context),
            const SizedBox(height: 30),
            _buildUploadPhotoCardView(
              context,
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildUploadPhotoCardView(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Consumer<PersonalProfileProvider>(
        builder: (context, tradesDocumentData, child) {
          return Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.viewEditTradesDocumentsList.length,
                  separatorBuilder: (context, index) {
                    return Column(
                      children: const [
                        SizedBox(height: 25),
                        Divider(
                          color: ColorConstants.custLightBlueF5F9FA,
                          thickness: 2,
                        ),
                        SizedBox(height: 25),
                      ],
                    );
                  },
                  itemBuilder: (context, index) {
                    return commonView(
                      context: context,
                      imgName1: ImgName.shape1Container,
                      imgName2: ImgName.shape2Container,
                      imgName3: ImgName.shape3Container,
                      index: index,
                    );
                  },
                ),
                const SizedBox(height: 50),
                CommonElevatedButton(
                  bttnText:
                      personalProfileProvider.fetchProfileModel?.isActive ==
                              false
                          ? StaticString.submit
                          : StaticString.uPDATE,
                  color: personalProfileProvider.fetchProfileModel?.isActive ==
                          false
                      ? ColorConstants.custDarkBlue150934
                      : ColorConstants.custskyblue22CBFE,
                  fontSize: 16,
                  onPressed: () {
                    updateTradesDocumentsData();
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Container _buildInfoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 30,
        top: 25,
        right: 10,
        bottom: 25,
      ),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        color: ColorConstants.custskyblue22CBFE,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            txtTitle: StaticString.verificationDocumentsRequired,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: ColorConstants.backgroundColorFFFFFF,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 14),
          CustomText(
            txtTitle: StaticString.viewEditTradeDocumentsDescription,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.white),
          ),
          // const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget commonCameraContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorConstants.custlightwhitee,
        border: Border.all(
          color: ColorConstants.custGreyEBEAEA,
          width: 0.2,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: CustImage(
          imgURL: ImgName.landlordCamera,
        ),
      ),
    );
  }

  Widget commonView({
    required int index,
    required BuildContext context,
    required String imgName1,
    required String imgName2,
    required String imgName3,
  }) {
    return ValueListenableBuilder(
      valueListenable: _dateNotifier,
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: widget
                  .viewEditTradesDocumentsList[index].tradeDocumentTypeId?.name,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    color: ColorConstants.custDarkBlue160935,
                  ),
              children: <TextSpan>[
                TextSpan(
                  text: widget.viewEditTradesDocumentsList[index]
                              .tradeDocumentTypeId?.isRequired ??
                          false
                      ? StaticString.required
                      : "",
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: ColorConstants.custDarkBlue160935,
                      ),
                ),
              ],
            ),
          ),
          LinearContainer(
            width: MediaQuery.of(context).size.width / 8,
            color: ColorConstants.custDarkBlue160935,
          ),
          const SizedBox(height: 3),
          LinearContainer(
            width: MediaQuery.of(context).size.width / 10,
            color: ColorConstants.custskyblue22CBFE,
          ),
          const SizedBox(height: 30),
          UploadMediaWidget(
            images: widget.viewEditTradesDocumentsList[index].documentList,
            image: ImgName.landlordCamera,
            userRole: UserRole.LANDLORD,
            imageList: (images) async {
              widget.viewEditTradesDocumentsList[index].documents =
                  images.map((e) => Document(url: e)).toList();
            },
            removeFunc: (images) async {
              if (images.isNetworkImage) {
                widget.viewEditTradesDocumentsList[index].deletedDocuments.add(
                  Document(url: images),
                );
              }
              widget.viewEditTradesDocumentsList[index].documents
                  .removeWhere((element) => element.url == images);
            },
          ),
          if (widget.viewEditTradesDocumentsList[index].tradeDocumentTypeId
                  ?.startDateRequired ??
              false) ...[
            const SizedBox(height: 22),
            TextFormField(
              onTap: () async {
                await selectDate(
                  initialDate: widget
                              .viewEditTradesDocumentsList[index].startDate ==
                          null
                      ? null
                      : widget.viewEditTradesDocumentsList[index].startDate!,
                  controller: startController,
                  color: ColorConstants.custDarkPurple160935,
                ).then(
                  (value) {
                    if (value != null) {
                      startController.text = value.toMobileString;
                      widget.viewEditTradesDocumentsList[index].startDate =
                          value;
                    }
                  },
                );
              },
              controller: startController,
              validator: (value) => value?.validateDate,
              readOnly: true,
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: StaticString.startDate,
                suffixIcon: CustImage(
                  width: 20,
                  height: 20,
                  imgURL: ImgName.calendar,
                  imgColor: ColorConstants.custDarkBlue150934,
                ),
              ),
            ),
          ],
          if (widget.viewEditTradesDocumentsList[index].tradeDocumentTypeId
                  ?.endDateRequired ??
              false) ...[
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              onTap: () async {
                await selectDate(
                  initialDate:
                      widget.viewEditTradesDocumentsList[index].endDate == null
                          ? DateTime.now()
                          : widget.viewEditTradesDocumentsList[index].endDate!,
                  controller: expiryController,
                  color: ColorConstants.custDarkPurple160935,
                ).then(
                  (value) {
                    if (value != null) {
                      expiryController.text = value.toMobileString;
                      widget.viewEditTradesDocumentsList[index].endDate = value;
                    }
                  },
                );
              },
              validator: (value) => value?.validateEndDate(
                startDate: widget.viewEditTradesDocumentsList[index].startDate,
                endDate: widget.viewEditTradesDocumentsList[index].endDate,
              ),
              readOnly: true,
              keyboardType: TextInputType.datetime,
              controller: expiryController,
              decoration: const InputDecoration(
                labelText: StaticString.expiryDate,
                suffixIcon: CustImage(
                  width: 20,
                  height: 20,
                  imgURL: ImgName.calendar,
                  imgColor: ColorConstants.custDarkBlue150934,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> updateTradesDocumentsData() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      _formKey.currentState?.save();
      if (_formKey.currentState?.validate() ?? false) {
        if (widget.viewEditTradesDocumentsList.any(
          (element) =>
              (element.tradeDocumentTypeId?.isRequired ?? false) &&
              (element.documentList.isEmpty),
        )) {
          throw AlertMessageString.emptyDocument;
        }
        for (final element in widget.viewEditTradesDocumentsList) {
          final List<String> _imgs = element.documentList
              .where((element) => !element.isNetworkImage)
              .toList();
          if (_imgs.isNotEmpty) {
            final List<String> urls =
                await ImgUploadService.instance.uploadProfilePicture(
              id: widget.getProfileData.roleId,
              profileUploadType: ProfileUploadType.TRADESMAN_DOCUMENT,
              images: _imgs,
            );
            for (final local in _imgs) {
              element.documents.removeWhere((all) => local == all.url);
            }
            element.documents
                .addAll(urls.map((e) => Document(url: e)).toList());
          }
        }
        await personalProfileProvider.updateTradesDocument(
          trdaesdocument: widget.viewEditTradesDocumentsList,
          profileId: widget.getProfileData.id,
          roleId: widget.getProfileData.roleId,
        );

        final FetchProfileModel? profile =
            personalProfileProvider.fetchProfileModel;

        if (profile?.profileCompleted ?? false) {
          final AuthModel? _auth = authProvider.authModel;
          _auth?.profile?.profileCompleted = profile?.profileCompleted ?? false;
          authProvider.authModel = _auth;
          if (widget.isFromUpdate) {
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).popUntil(
              (route) => route.isFirst,
            );
          }
        } else {
          Navigator.of(context).pop();
        }
      } else {
        setState(() {
          _autovalidateMode = AutovalidateMode.always;
        });
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
