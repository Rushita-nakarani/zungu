import 'package:flutter/material.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';

import '../../../../cards/property_card.dart';
import '../../../../models/landloard/property_list_model.dart';
import '../../../../providers/landlord/tenant/fetch_property_provider.dart';
import '../../../../widgets/common_searchbar.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/loading_indicator.dart';
import '../../../../widgets/no_content_label.dart';
import '../../../../widgets/rounded_lg_shape_widget.dart';
import 'add_tenant_rent_details_form.dart';

class LandlordAddTenant extends StatefulWidget {
  const LandlordAddTenant({super.key});

  @override
  State<LandlordAddTenant> createState() => _LandlordAddTenantState();
}

class _LandlordAddTenantState extends State<LandlordAddTenant> {
  // form keys
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // controllers
  final TextEditingController _searchController = TextEditingController();

  // notifiers
  final LoadingIndicatorNotifier _indicatorNotifier =
      LoadingIndicatorNotifier();

  // providers
  LandlordTenantPropertyProvider get landlordTenantPropertyProvider =>
      Provider.of<LandlordTenantPropertyProvider>(
        context,
        listen: false,
      );

  @override
  void initState() {
    // fetching property list while initilizing screen
    fetchPropertyList(indicatorType: LoadingIndicatorType.spinner);
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
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

//  Appbar...
  AppBar _buildAppBar() {
    return AppBar(
      title: const CustomText(
        txtTitle: StaticString.addTenant,
      ),
      backgroundColor: ColorConstants.custDarkPurple500472,
    );
  }

// Body...
  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        await landlordTenantPropertyProvider.fetchProperties();
      },
      child: SingleChildScrollView(
        // physics: const ClampingScrollPhysics(),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // Custom shape and title
              _buildShapeTitle(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 110,
                    ),

                    // Search bar
                    buildCommonSearchBar(
                      context: context,
                      color: ColorConstants.custDarkPurple500472,
                      image: ImgName.landlordSearch,
                      title: StaticString.searchByProperty,
                      controller: _searchController,
                      searchFunc: _searchFunc,
                    ),

                    // Properties
                    _buildProperties(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom shape and title
  Widget _buildShapeTitle() {
    return const SizedBox(
      width: double.infinity,
      child: RoundedLgShapeWidget(
        color: ColorConstants.custDarkPurple500472,
        title: StaticString.selectProperty,
      ),
    );
  }

  // Property card by listview builder
  Widget _buildProperties() {
    return Consumer<LandlordTenantPropertyProvider>(
      builder: (context, provider, child) {
        return provider.property.propertyList.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: NoContentLabel(
                  title: AlertMessageString.noDataFound,
                  onPress: () async {
                    await fetchPropertyList(
                      indicatorType: LoadingIndicatorType.overlay,
                    );
                  },
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 15),
                itemCount: provider.property.propertyList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return LazyLoadingList(
                    index: index,
                    initialSizeOfItems: provider.property.size,
                    hasMore: provider.property.count >=
                        provider.property.propertyList.length,
                    loadMore: () async {
                      await landlordTenantPropertyProvider.fetchProperties(
                        page: ++provider.property.page,
                      );
                    },
                    child: _buildPropertyCard(
                      property: provider.property.propertyList[index],
                    ),
                  );
                },
              );
      },
    );
  }

  // Single property card
  Widget _buildPropertyCard({
    required LandlordAddTenantPropertyListModel property,
  }) {
    return InkWell(
      onTap: () => propertyCardontapAction(property),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: PropertyCard(
          imageUrl: (property.propertyResource?.photos.isNotEmpty ?? false)
              ? property.propertyResource!.photos[0]
              : "",
          propertyTitle: property.createFullAddress,
          propertySubtitle: property.address?.fullAddress ?? "",
          color: ColorConstants.custDarkPurple500472,
        ),
      ),
    );
  }

  void propertyCardontapAction(
    LandlordAddTenantPropertyListModel propertymodel,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => LandlordAddEditTenantRentDetailForm(
          property: propertymodel,
        ),
      ),
    );
  }

  // Fetch property function
  Future<void> fetchPropertyList({
    required LoadingIndicatorType indicatorType,
  }) async {
    try {
      _indicatorNotifier.show(
        loadingIndicatorType: indicatorType,
      );
      await landlordTenantPropertyProvider.fetchProperties();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _indicatorNotifier.hide();
    }
  }

  // Search button action
  Future<void> _searchFunc() async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      _indicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      if (_formKey.currentState?.validate() ?? true) {
        await landlordTenantPropertyProvider.fetchProperties(
          query: _searchController.text,
        );
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _indicatorNotifier.hide();
    }
  }
}
