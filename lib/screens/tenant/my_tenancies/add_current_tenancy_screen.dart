import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/models/tenant/fetch_current_tenancy_model.dart';
import 'package:zungu_mobile/providers/tenantProvider/tenancy_provider.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';

import '../../../../utils/custom_extension.dart';
import '../../../constant/img_font_color_string.dart';
import '../../../providers/auth/auth_provider.dart';
import '../../../providers/dashboard_provider/tenant_dashboard_provider.dart';
import '../../../services/address_detail_service.dart';
import '../../../utils/cust_eums.dart';
import '../../../widgets/common_auto_textformfield.dart';
import '../../../widgets/common_elevated_button.dart';
import '../../../widgets/cust_image.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/date_selector.dart';
import '../../../widgets/image_upload_widget.dart';
import '../../../widgets/rounded_lg_shape_widget.dart';

class AddCurrentTenancyScreen extends StatefulWidget {
  const AddCurrentTenancyScreen({super.key});

  @override
  State<AddCurrentTenancyScreen> createState() =>
      AddCurrentTenancyScreenState();
}

class AddCurrentTenancyScreenState extends State<AddCurrentTenancyScreen> {
  final GlobalKey<FormState> _currentTenancyFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _previousTenancyFormKey = GlobalKey<FormState>();

  final TextEditingController _landlordNameController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController _landlordMobileController =
      TextEditingController();
  final TextEditingController _rentalAmountController = TextEditingController();
  // final TextEditingController _rentPaymentDayController =
  // TextEditingController();
  // final TextEditingController _leaseStartController = TextEditingController();
  // final TextEditingController _leaseEndController = TextEditingController();
  final TextEditingController _movedInController = TextEditingController();
  final TextEditingController _movedOutController = TextEditingController();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  // ignore: prefer_final_fields
  String _currentSelection = StaticString.currentTenancy;

  final CurrentTenancyModel _tenancyModel = CurrentTenancyModel(
    photos: [],
  );
  TenantDashboradProvider get getTenantDashboardProvider =>
      Provider.of<TenantDashboradProvider>(context, listen: false);
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  @override
  Widget build(BuildContext context) {
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
            txtTitle: StaticString.myTenancies,
          ),
          backgroundColor: ColorConstants.custDarkPurple662851,
        ),
        body: SafeArea(
          child: Column(
            children: [
              _buildTitle(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SearchLocationautocomplete(
                          streetController: searchController,
                          onAddressSelect: serchAddress,
                          onTap: () {},
                          icon: ImgName.searchTenant,
                        ),
                        // const SizedBox(height: 28),
                        // _buildBottomTitle(),
                        // const SizedBox(height: 40),
                        // _buildTenancyCards(),
                        // const SizedBox(height: 150),
                        const SizedBox(height: 40),
                        _buildAddressCard(),
                        const SizedBox(height: 30),
                        if (_currentSelection == StaticString.currentTenancy)
                          _buildCurrentTenancyForm(),
                        if (_currentSelection == StaticString.previousTenancy)
                          _buildPreviousTenancyForm(),
                        if (_currentSelection ==
                            StaticString.currentTenancy) ...[
                          const SizedBox(height: 30),
                          _uploadPhotosVideos(),
                        ],
                        const SizedBox(height: 50),
                        // _uploadPreviousLease(),
                        // const SizedBox(height: 50),
                        _buildSubmitBtn(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: const [
        SizedBox(
          width: double.infinity,
          child: RoundedLgShapeWidget(
            color: ColorConstants.custDarkPurple662851,
            title: StaticString.currentAddress,
          ),
        ),
      ],
    );
  }

  Widget _buildAddressCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: ColorConstants.backgroundColorFFFFFF,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custBlack000000.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 0.2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            txtTitle: StaticString.myaddress,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.custDarkPurple662851,
                ),
          ),
          const SizedBox(height: 6),
          CustomText(
            txtTitle: searchController.text,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.custGrey707070,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentTenancyForm() {
    return Form(
      key: _currentTenancyFormKey,
      autovalidateMode: _autovalidateMode,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: TextFormField(
              validator: (value) => value?.validateName,
              controller: _landlordNameController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: "${StaticString.landlordName}*",
              ),
              onSaved: (name) {
                _tenancyModel.name = name ?? "";
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: TextFormField(
              validator: (value) => value?.validatePhoneNumber,
              controller: _landlordMobileController,
              maxLength: 10,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: "${StaticString.landlordMobileNumber}*",
                counterText: "",
              ),
              onSaved: (mobileNumber) {
                _tenancyModel.mobileNumber = mobileNumber ?? "";
              },
            ),
          ),
          TextFormField(
            validator: (value) => value?.validateEmpty,
            controller: _rentalAmountController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              prefixText: StaticString.currency.addSpaceAfter,
              labelText: StaticString.rentalAmount.addStarAfter,
            ),
            onSaved: (rentAmount) {
              _tenancyModel.rentAmount = int.parse(rentAmount ?? "0");
            },
          ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 30),
          //   child: TextFormField(
          //     validator: (value) => value?.validateEmpty,
          //     controller: _rentPaymentDayController,
          //     keyboardType: TextInputType.number,
          //     textInputAction: TextInputAction.next,
          //     decoration: const InputDecoration(
          //       labelText: "${StaticString.rentPaymentDay}*",
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 30),
          //   child: TextFormField(
          //     onTap: () => selectDate(
          //       controller: _leaseStartController,
          //       color: ColorConstants.custDarkPurple662851,
          //     ),
          //     validator: (value) => value?.validateDate,
          //     readOnly: true,
          //     controller: _leaseStartController,
          //     keyboardType: TextInputType.datetime,
          //     textInputAction: TextInputAction.next,
          //     decoration: const InputDecoration(
          //       labelText: "${StaticString.leaseStartDate}*",
          //       suffixIcon: CustImage(
          //         width: 24,
          //         imgURL: ImgName.calenderPurpleTenant,
          //       ),
          //     ),
          //   ),
          // ),
          // TextFormField(
          //   onTap: () => selectDate(
          //     controller: _leaseEndController,
          //     color: ColorConstants.custDarkPurple662851,
          //   ),
          //   validator: (value) => value?.validateDate,
          //   readOnly: true,
          //   controller: _leaseEndController,
          //   keyboardType: TextInputType.datetime,
          //   textInputAction: TextInputAction.next,
          //   decoration: const InputDecoration(
          //     labelText: "${StaticString.leaseEndDate}*",
          //     suffixIcon: CustImage(
          //       width: 24,
          //       imgURL: ImgName.calenderPurpleTenant,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildPreviousTenancyForm() {
    return Form(
      key: _previousTenancyFormKey,
      autovalidateMode: _autovalidateMode,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: TextFormField(
              validator: (value) => value?.validateEmpty,
              controller: _rentalAmountController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixText: StaticString.currency.addSpaceAfter,
                labelText: StaticString.rentalAmount.addStarAfter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: TextFormField(
              onTap: () => selectDate(
                controller: _movedInController,
                color: ColorConstants.custDarkPurple662851,
              ),
              validator: (value) => value?.validateDate,
              readOnly: true,
              controller: _movedInController,
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: "${StaticString.movedIn}*",
                suffixIcon: CustImage(
                  imgURL: ImgName.commonCalendar,
                  imgColor: ColorConstants.custDarkPurple662851,
                  width: 24,
                ),
              ),
            ),
          ),
          TextFormField(
            onTap: () => selectDate(
              controller: _movedOutController,
              color: ColorConstants.custDarkPurple662851,
            ),
            validator: (value) => value?.validateDate,
            readOnly: true,
            controller: _movedOutController,
            keyboardType: TextInputType.datetime,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: "${StaticString.movedOut}*",
              suffixIcon: CustImage(
                imgURL: ImgName.commonCalendar,
                imgColor: ColorConstants.custDarkPurple662851,
                width: 24,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _uploadPhotosVideos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          txtTitle: StaticString.uploadPhotos,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(height: 20),
        UploadMediaWidget(
          images: _tenancyModel.photos,
          image: ImgName.tenantCamera,
          userRole: UserRole.TENANT,
          multipicker: true,
          maxUpload: 20,
          imageList: (images) {
            _tenancyModel.photos = images;
          },
        ),
      ],
    );
  }

  // autocomplete address...
  Future<void> serchAddress(
    String address,
  ) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );

      _tenancyModel.address = await AddressDetailService.instance
          .getAddressDetailFromAddress(address);
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  Widget _buildSubmitBtn() {
    return CommonElevatedButton(
      onPressed: () async {
        try {
          _loadingIndicatorNotifier.show();
          if (_currentSelection == StaticString.currentTenancy) {
            if (!(_currentTenancyFormKey.currentState?.validate() ?? true)) {
              _autovalidateMode = AutovalidateMode.always;
              return;
            }

            if (searchController.text.isEmpty) {
              Fluttertoast.showToast(msg: "please select address");
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(content: Text("please select address ")),
              // );
            } else {
              _currentTenancyFormKey.currentState?.save();
              final String? userId =
                  Provider.of<AuthProvider>(context, listen: false)
                      .authModel
                      ?.userId;
              await Provider.of<TenanciesProvider>(context, listen: false)
                  .createTenancy(_tenancyModel, userId);
              getTenantDashboardProvider.fetchTenantDashboardList();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
          } else {
            if (!(_previousTenancyFormKey.currentState?.validate() ?? true)) {
              _autovalidateMode = AutovalidateMode.always;

              return;
            }
            _previousTenancyFormKey.currentState?.save();

            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        } catch (e) {
          showAlert(context: context, message: e);
        } finally {
          _loadingIndicatorNotifier.hide();
        }
      },
      bttnText: _currentSelection == StaticString.currentTenancy
          ? StaticString.addTenancy.toUpperCase()
          : StaticString.addPreviousTenancy.toUpperCase(),
      color: ColorConstants.custDarkYellow838500,
      fontSize: 16,
    );
  }
}
