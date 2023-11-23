import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/models/landloard/attribute_info_model.dart';
import 'package:zungu_mobile/models/landloard/property_detail_model.dart';
import 'package:zungu_mobile/services/uri_launch_service.dart';
import 'package:zungu_mobile/widgets/bookmark_widget.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../../../../constant/img_font_color_string.dart';
import '../../../../constant/text_style_decoration.dart';
import '../../../../models/landloard/property_list_model.dart';
import '../../../../models/landloard/view_tenant_tenancy_list_model.dart';
import '../../../../models/settings/personal_profile/user_profile_model.dart';
import '../../../../providers/dashboard_provider/landlord_dashboard_provider.dart';
import '../../../../providers/landlord/tenant/view_tenant_provider.dart';
import '../../../../providers/landlord_provider.dart';
import '../../../../services/pdf_viewer_service.dart';
import '../../../../utils/cust_eums.dart';
import '../../../../utils/custom_extension.dart';
import '../../../../widgets/common_searchbar.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/loading_indicator.dart';
import '../../../../widgets/no_content_label.dart';
import '../../../../widgets/rounded_lg_shape_widget.dart';
import '../add tenants/add_tenant_rent_details_form.dart';
import 'property_filter.dart';
import 'renew_lease_screen.dart';

class LandlordTenantViewEndTenants extends StatefulWidget {
  const LandlordTenantViewEndTenants({super.key});

  @override
  State<LandlordTenantViewEndTenants> createState() =>
      _LandlordTenantViewEndTenantsState();
}

class _LandlordTenantViewEndTenantsState
    extends State<LandlordTenantViewEndTenants> {
  // controllers
  final TextEditingController _propertyFilterController =
      TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  // notifiers
  final LoadingIndicatorNotifier _indicatorNotifier =
      LoadingIndicatorNotifier();

  // providers
  LandlordTenantViewTenantProvider get landlordTenantViewTenantProvider =>
      Provider.of<LandlordTenantViewTenantProvider>(
        context,
        listen: false,
      );

  LandlordProvider get landloardProvider => Provider.of<LandlordProvider>(
        context,
        listen: false,
      );
  LandlordDashboradProvider get getLandlordDashboardProvider =>
      Provider.of<LandlordDashboradProvider>(
        context,
        listen: false,
      );

  // variables
  CurrentTenantsFilter? filterType;
  AttributeInfoModel? selectedFilterModel;

  @override
  void initState() {
    // fetching tenancy list while initilizing screen
    fetchCurrentTenantList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: _buildScaffold(),
    );
  }

  Widget _buildScaffold() {
    return LoadingIndicator(
      loadingStatusNotifier: _indicatorNotifier,
      child: Scaffold(
        appBar: _buildAppBar(filterController: _propertyFilterController),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar({required TextEditingController filterController}) {
    return AppBar(
      title: const CustomText(
        txtTitle: StaticString.viewTenants,
      ),
      backgroundColor: ColorConstants.custDarkPurple500472,
      actions: [
        // filter icon button
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              barrierColor: Colors.black.withOpacity(0.5),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              isScrollControlled: true,
              backgroundColor: ColorConstants.backgroundColorFFFFFF,
              builder: (context) {
                return PropertyFilter(
                  // controller: filterController,
                  filterType: filterType,
                  onSelected: (filter) {
                    selectedFilterModel = filter;
                    filterController.text =
                        selectedFilterModel?.attributeValue ?? "";
                    switch (filterController.text) {
                      case StaticString.residentialProperties:
                        filterType = CurrentTenantsFilter.RESIDENTIAL;
                        break;
                      case StaticString.commercialProperties:
                        filterType = CurrentTenantsFilter.COMMERCIAL;
                        break;
                      case StaticString.hMOProperties:
                        filterType = CurrentTenantsFilter.HMO;
                        break;
                      default:
                    }
                    fetchCurrentTenantList(
                      query: _searchController.text,
                    );
                  },
                );
              },
            );
          },
          icon: const CustImage(
            imgURL: ImgName.filterIcon,
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await landlordTenantViewTenantProvider.fetchCurrentTenants(
            filterType: filterType,
            query: _searchController.text,
          );
        },
        child: SingleChildScrollView(
          // physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              // build custom shape and title
              _buildShapeTitle(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // search bar
                    buildCommonSearchBar(
                      context: context,
                      title: StaticString.searchByNameOrAddress,
                      color: ColorConstants.custDarkPurple500472,
                      image: ImgName.landlordSearch,
                      controller: _searchController,
                      searchFunc: () => fetchCurrentTenantList(
                        // indicatorType: LoadingIndicatorType.overlay,
                        query: _searchController.text,
                      ),
                      hintStyle:
                          TextStyleDecoration.lableStyle.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 15),

                    // build tenancies
                    Consumer<LandlordTenantViewTenantProvider>(
                      builder: (context, provider, child) {
                        return _buildTenantCards(
                          tenancies: provider.getTenancy,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // build custom shape and title
  Widget _buildShapeTitle() {
    return Column(
      children: const [
        SizedBox(
          width: double.infinity,
          child: RoundedLgShapeWidget(
            color: ColorConstants.custDarkPurple500472,
            title: StaticString.currentTenants,
          ),
        ),
      ],
    );
  }

  // build tenant cards
  Widget _buildTenantCards({
    required List<ViewTenantTenancyListModel> tenancies,
  }) {
    return tenancies.isEmpty
        ? NoContentLabel(
            title: AlertMessageString.noDataFound,
            onPress: () async {
              await fetchCurrentTenantList(
                // indicatorType: LoadingIndicatorType.overlay,
                query: _searchController.text,
              );
            },
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tenancies.length,
            itemBuilder: (context, index) {
              return _buildTenantCard(tenancy: tenancies[index]);
            },
          );
  }

  // tenant card
  Widget _buildTenantCard({
    required ViewTenantTenancyListModel tenancy,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25),
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
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _buildNameRow(tenancy: tenancy),
                const SizedBox(height: 20),
                _buildAddressRow(tenancy: tenancy),
                const SizedBox(height: 10),
                _buildRentRow(tenancy: tenancy),
                const SizedBox(height: 5),
                _buildDepositPaidRow(tenancy: tenancy),
                const SizedBox(height: 5),
                _buildTenancyDepositSchemeRow(tenancy: tenancy),
                const SizedBox(height: 5),
                _buildButtonsRow(tenancy: tenancy),
              ],
            ),
          ),

          // bookmark if HMO
          if (tenancy.roomName.isNotEmpty)
            Positioned(
              right: 15,
              child: buildBookmark(
                text: tenancy.roomName,
                color: ColorConstants.custDarkPurple150934,
              ),
            ),
        ],
      ),
    );
  }

//  userInfo view...
  Widget _buildNameRow({required ViewTenantTenancyListModel tenancy}) {
    return Row(
      children: [
        CircleAvatar(
          child: CustImage(
            imgURL: tenancy.profileImg,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              txtTitle: tenancy.fullName,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    color: ColorConstants.custDarkPurple150934,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Row(
              children: [
                // quick mobile button
                _quickActionButton(
                  image: ImgName.landlordCall,
                  onTap: () => launchMobile(tenancy.mobile),
                ),

                const SizedBox(width: 5),

                // quick email button
                _quickActionButton(
                  image: ImgName.landlordEmailCircle,
                  onTap: () => launchEmail(tenancy.email),
                ),

                const SizedBox(width: 5),

                // quick lease button
                if (tenancy.leaseUrl.isNotEmpty)
                  _quickActionButton(
                    image: ImgName.landlordPdfCircle,
                    onTap: () async {
                      try {
                        _indicatorNotifier.show(
                          loadingIndicatorType: LoadingIndicatorType.overlay,
                        );
                        if (tenancy.leaseUrl.isNetworkImage) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => PDFViewerService(
                                userRole: UserRole.LANDLORD,
                                pdfUrl: tenancy.leaseUrl,
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        showAlert(context: context, message: e);
                      } finally {
                        _indicatorNotifier.hide();
                      }
                    },
                  )
                else
                  Container(),

                SizedBox(width: tenancy.leaseUrl.isNotEmpty ? 5 : 0),

                // edit button
                _quickActionButton(
                  image: ImgName.landlordEdit,
                  onTap: () => {
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (ctx) =>
                                LandlordAddEditTenantRentDetailForm(
                              property: LandlordAddTenantPropertyListModel(
                                id: tenancy.propertyDetailId,
                                address: tenancy.address,
                                propertyResource: PropertyResourceModel(),
                              ),
                              tenancyId: tenancy.tenancyId,
                            ),
                          ),
                        )
                        .then(
                          // after editing complete refresh list again
                          (value) => fetchCurrentTenantList(
                              // indicatorType: LoadingIndicatorType.overlay,
                              ),
                        ),
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _quickActionButton({
    required String image,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: CustImage(
        imgURL: image,
        width: 24,
      ),
    );
  }

  Widget _buildAddressRow({required ViewTenantTenancyListModel tenancy}) {
    return Column(
      children: [
        CustomText(
          txtTitle: tenancy.createFullAddress,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorConstants.custDarkPurple150934,
              ),
        ),
        const SizedBox(height: 5),
        CustomText(
          txtTitle: tenancy.address?.fullAddress,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: ColorConstants.custGrey707070,
              ),
        ),
      ],
    );
  }

  Widget _buildRentRow({required ViewTenantTenancyListModel tenancy}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomText(
            txtTitle: StaticString.rent,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.custGrey707070,
                ),
          ),
        ),
        CustomText(
          txtTitle: tenancy.createRentAmount,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorConstants.custBlue1EC0EF,
              ),
        ),
      ],
    );
  }

  Widget _buildDepositPaidRow({required ViewTenantTenancyListModel tenancy}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomText(
            txtTitle: StaticString.depositPaid,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.custGrey707070,
                ),
          ),
        ),
        CustomText(
          txtTitle: tenancy.createDepositPaid,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorConstants.custBlue1EC0EF,
              ),
        ),
      ],
    );
  }

  Widget _buildTenancyDepositSchemeRow({
    required ViewTenantTenancyListModel tenancy,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomText(
            txtTitle: StaticString.tenancyDepositScheme,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.custGrey707070,
                ),
          ),
        ),
        CustomText(
          txtTitle: tenancy.depositScheme?.attributeValue,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorConstants.custBlue1EC0EF,
              ),
        ),
      ],
    );
  }

  Widget _buildButtonsRow({
    required ViewTenantTenancyListModel tenancy,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // date box
          _buildDateBox(tenancy: tenancy),

          // renew lease button
          _buildRenewEndLeaseButton(
            text: StaticString.renewLease,
            color: ColorConstants.custDarkGreen09B500,
            onTap: () {
              _renewLeaseFunction(
                viewTenantTenancyListModel: tenancy,
              );
            },
          ),
          // end lease button
          _buildRenewEndLeaseButton(
            text: StaticString.endLease,
            color: ColorConstants.custChartRed,
            onTap: () => _endLeaseFunction(tenancy: tenancy),
          ),
        ],
      ),
    );
  }

  // buildDate...
  Widget _buildDateBox({required ViewTenantTenancyListModel tenancy}) {
    return Container(
      padding: const EdgeInsets.all(8),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustImage(
              imgURL: ImgName.commonCalendar,
              imgColor: ColorConstants.custDarkPurple500472,
              width: 15,
              height: 15,
            ),
            const SizedBox(height: 5),
            CustomText(
              txtTitle: tenancy.renewalDate?.toMobileString,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.custDarkPurple150934,
                  ),
            ),
            CustomText(
              txtTitle: StaticString.renewalDate,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custGrey707070,
                  ),
            )
          ],
        ),
      ),
    );
  }

  // build renewLeases btnOnTap...
  Widget _buildRenewEndLeaseButton({
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 25,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: CustomText(
            align: TextAlign.center,
            txtTitle: text.toUpperCase().replaceAll(" ", "\n"),
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.backgroundColorFFFFFF,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }

  // fetching tenancies list
  Future<void> fetchCurrentTenantList({
    String query = "",
  }) async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      _indicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      await landlordTenantViewTenantProvider.fetchCurrentTenants(
        filterType: filterType,
        query: query,
      );
    } catch (e) {
      showAlert(context: context, message: e);
      // rethrow;
    } finally {
      _indicatorNotifier.hide();
    }
  }

  // renew lease function
  Future<void> _renewLeaseFunction({
    required ViewTenantTenancyListModel viewTenantTenancyListModel,
  }) async {
    final PropertiesDetailModel _propertiesDetailModel = PropertiesDetailModel(
      type: viewTenantTenancyListModel.category?.name ?? "",
      address: viewTenantTenancyListModel.address,
    );
    final Tenancy _tenancy = Tenancy(
      id: viewTenantTenancyListModel.tenancyId,
      depositAmount: viewTenantTenancyListModel.depositAmount,
      depositScheme: viewTenantTenancyListModel.depositScheme,
      rentAmount: viewTenantTenancyListModel.rentAmount,
      rentDueDate: viewTenantTenancyListModel.renewalDate,
      profile: UserProfileModel(
        fullName: viewTenantTenancyListModel.fullName,
        mobile: viewTenantTenancyListModel.mobile,
      ),
    );
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => TenantRenewLeaseScreen(
          tenancyModel: _tenancy,
          propertiesDetailModel: _propertiesDetailModel,
        ),
      ),
    );
    landlordTenantViewTenantProvider.fetchCurrentTenants(
      filterType: filterType,
      query: _searchController.text,
    );
  }

  // end lease function
  void _endLeaseFunction({required ViewTenantTenancyListModel tenancy}) {
    showAlert(
      context: context,
      title: StaticString.endTenancy,
      singleBtnTitle: AlertMessageString.yesEndTenancy.toUpperCase(),
      showIcon: false,
      singleBtnColor: ColorConstants.custChartRed,
      message: AlertMessageString.endTenancyConf,
      onRightAction: () async {
        _indicatorNotifier.show(
          loadingIndicatorType: LoadingIndicatorType.overlay,
        );
        // remove tenancy API call
        await landlordTenantViewTenantProvider.removeTenancy(
          tenancyId: tenancy.tenancyId,
        );

        // fetch tenancy list API call
        await fetchCurrentTenantList(
          // indicatorType: LoadingIndicatorType.overlay,
          query: _searchController.text,
        );
        getLandlordDashboardProvider.fetchLandlordDashboardList();
        _indicatorNotifier.hide();
      },
    );
  }
}
