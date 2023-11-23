import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/providers/dashboard_provider/tenant_dashboard_provider.dart';
import 'package:zungu_mobile/widgets/no_content_label.dart';

import '../../../cards/dashboard_card.dart';
import '../../../cards/new_task_card.dart';
import '../../../constant/img_font_color_string.dart';
import '../../../providers/dashboard_provider/landlord_dashboard_provider.dart';
import '../../../widgets/cust_image.dart';
import '../../../widgets/custom_alert.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/loading_indicator.dart';

class TenantDashboardScreen extends StatefulWidget {
  const TenantDashboardScreen({Key? key}) : super(key: key);

  @override
  State<TenantDashboardScreen> createState() => _TenantDashboardScreenState();
}

class _TenantDashboardScreenState extends State<TenantDashboardScreen> {
  final int selectedIndex = 2;

  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  TenantDashboradProvider get getTenantDashboardProvider =>
      Provider.of<TenantDashboradProvider>(context, listen: false);
  // List<DashboardModel> _dashboardData = [];

  @override
  void initState() {
    super.initState();

    fetchDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.backgroundColorFFFFFF,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: _buildBody(context),
      ),
    );
  }

  SafeArea _buildBody(BuildContext context) {
    return SafeArea(
      top: false,
      child: LoadingIndicator(
        loadingStatusNotifier: _loadingIndicatorNotifier,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 20,
                    //     vertical: 10,
                    //   ),
                    //   child: _buildSearchField(),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomText(
                        txtTitle: StaticString.newTaskLeft,
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    _buildNewTaskCard(),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomText(
                        txtTitle: StaticString.myDashboard,
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildDashboardCard(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard() {
    return Consumer<TenantDashboradProvider>(
      builder: (context, dashboardData, child) {
        return GridView.builder(
          itemCount: dashboardData.tenantDashboardData.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 35),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (context, index) {
            return DashboardCard(
              iconImage: dashboardData.tenantDashboardData[index].iconImage,
              title: dashboardData.tenantDashboardData[index].title,
              subtitleValue:
                  dashboardData.tenantDashboardData[index].subtitleValue,
              subtitle: dashboardData.tenantDashboardData[index].subtitle,
              primaryColor: ColorConstants.custDarkPurple662851,
              bgColor: index == 0 || index == 3 || index == 4
                  ? ColorConstants.custDarkPurple662851
                  : ColorConstants.custDarkYellow838500,
              isLeft: index % 2 == 0,
              onTap: dashboardData.tenantDashboardData[index].onTap,
            );
          },
        );
      },
    );
  }

  Widget _buildNewTaskCard() {
    return Consumer<TenantDashboradProvider>(
      builder: (context, provider, child) {
        return provider.newTaskData.isEmpty
            ? NoContentLabel(
                title: StaticString.nodataFound,
                onPress: () {
                  fetchDashboardData();
                },
              )
            : SizedBox(
                height: 100,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 12,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.newTaskData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return NewTaskCard(
                      iconImage: provider.newTaskData[index].iconImage,
                      title: provider.newTaskData[index].title,
                      itemCount: provider.newTaskData[index].itemCount,
                      primaryColor: provider.newTaskData[index].primaryColor,
                      secondaryColor:
                          provider.newTaskData[index].secondaryColor,
                      onTap: provider.newTaskData[index].onTap,
                    );
                  },
                ),
              );
      },
    );
  }

  // Search field
  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
            blurRadius: 10,
          ),
        ],
      ),
      height: 46,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              cursorColor: ColorConstants.custDarkPurple500472,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20, right: 10),
                hintText: "Search",
                hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: ColorConstants.custGreyAEAEAE,
                    ),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
          const CustImage(
            imgURL: ImgName.searchTenant,
            width: 30,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  //-----------------------------Helper Function--------------------------//
  Future<void> fetchDashboardData() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      if (Provider.of<LandlordDashboradProvider>(context, listen: false)
              .subscribeRoleModel ==
          null) {
        return;
      }

      await Future.wait([
        getTenantDashboardProvider.fetchTenantDashboardList(),
        Provider.of<LandlordDashboradProvider>(context, listen: false)
            .fetchRoleList(),
      ]);
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
