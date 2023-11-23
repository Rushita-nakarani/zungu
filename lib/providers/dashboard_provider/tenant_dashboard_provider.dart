// ignore_for_file: avoid_setters_without_getters

import 'package:flutter/material.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:zungu_mobile/main.dart';
import 'package:zungu_mobile/models/dashboard/tenant_dashboard_model.dart';
import 'package:zungu_mobile/models/dashboard/tenant_task_model.dart';

import '../../api/api_end_points.dart';
import '../../api/api_middleware.dart';
import '../../constant/color_constants.dart';
import '../../constant/img_constants.dart';
import '../../constant/string_constants.dart';
import '../../models/dashboard/dashboard_model.dart';
import '../../models/new_task_model.dart';
import '../../models/tenant/previous_tenancy_fetch_model.dart';
import '../../screens/tenant/my_tenancies/my_tenancies_home.dart';
import '../../screens/tenant/tenant_deshboard/my_leases_sign_renew_screen.dart';

class TenantDashboradProvider extends ChangeNotifier {
  //-------------------------------Variables-----------------------------------//
  TenantDashboardModel? tenantDashboardModel;
  TenantTaskModel? tenantTaskModel;
  List<FetchTenanciesModel> _fetchPreviousTenantList = [];
  List<NewTaskModel> newTaskData = [];
  List<DashboardDetailModel> _tenantDashboardData = [];

  List<DashboardDetailModel> get tenantDashboardData => _tenantDashboardData;

  set dashboardData(List<DashboardDetailModel> value) {
    _tenantDashboardData = value;
  }

  set fetchPreviousTenantList(List<FetchTenanciesModel> value) {
    _fetchPreviousTenantList = value;
    notifyListeners();
  }

  //---------------------------getter/setter methods------------------------//

  //Tenant dashboard getter/setter method
  TenantDashboardModel? get getTenantDashboardModel => tenantDashboardModel;

  set setTenantDashboardModel(
    TenantDashboardModel? _tenantDashboardModel,
  ) {
    tenantDashboardModel = _tenantDashboardModel;
  }

  //Tenant task getter/setter method
  TenantTaskModel? get getTenantTaskModel => tenantTaskModel;

  set setTenantTaskModel(TenantTaskModel? _tenantTaskModel) {
    tenantTaskModel = _tenantTaskModel;
  }

  //--------------------------------Function---------------------------//

  // Fetch Tenant Dashboard data List
  Future<void> fetchTenantDashboardList() async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: DashboardEndPoints.tenantDashboard,
          requestType: HTTPRequestType.GET,
        ),
      );

      setTenantTaskModel = tenantTaskModelFromJson(response);

      newTaskData = [
        NewTaskModel(
          iconImage: ImgName.newQuotesTenant,
          title: StaticString.bookedJob,
          itemCount: getTenantTaskModel?.bookedJobsCount ?? 0,
          primaryColor: ColorConstants.custDarkPurple662851,
          secondaryColor: ColorConstants.custDarkYellow838500,
          onTap: () {},
        ),
        NewTaskModel(
          iconImage: ImgName.newQuotesTenant,
          title: StaticString.newQuotes,
          primaryColor: ColorConstants.custDarkPurple662851,
          secondaryColor: ColorConstants.custDarkYellow838500,
          onTap: () {},
          itemCount: getTenantTaskModel?.newQuote ?? 0,
        ),
        NewTaskModel(
          iconImage: ImgName.propertyViewingsTenant,
          title: StaticString.propertyViewings,
          itemCount: getTenantTaskModel?.propertyViewing ?? 0,
          primaryColor: ColorConstants.custDarkPurple662851,
          secondaryColor: ColorConstants.custDarkYellow838500,
          onTap: () {},
        ),
        NewTaskModel(
          iconImage: ImgName.tenantSignRenew,
          title: StaticString.signRenewLease,
          itemCount: getTenantTaskModel?.signRenewLeaseCount ?? 0,
          primaryColor: ColorConstants.custDarkPurple662851,
          secondaryColor: ColorConstants.custDarkYellow838500,
          onTap: () => {
            Navigator.of(getContext).push(
              MaterialPageRoute(
                builder: (ctx) => const MyLeasesSignRenewScreen(),
              ),
            ),
          },
        ),
      ];

      newTaskData.sort(
        (a, b) => b.itemCount.compareTo(a.itemCount),
      );

      setTenantDashboardModel = tenantDashboardModelFromJson(response);

      dashboardData = [
        DashboardDetailModel(
          iconImage: ImgName.myTenanciesTenant,
          title: StaticString.myTenancies,
          subtitleValue: getTenantDashboardModel?.tenanciesCount,
          subtitle: StaticString.activeStatus,
          onTap: () {
            Navigator.of(getContext).push(
              MaterialPageRoute(
                builder: (ctx) => const TenantMyTenancies(),
              ),
            );
          },
        ),
        DashboardDetailModel(
          iconImage: ImgName.tenantMaintenance,
          title: StaticString.maintenance,
          subtitleValue: getTenantDashboardModel?.maintenanceCount,
          subtitle: StaticString.activeStatus,
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (ctx) => const TenantMaintenance(),
            //   ),
            // );
          },
        ),
        DashboardDetailModel(
          iconImage: ImgName.postAJobTenant,
          title: StaticString.postAJob,
          subtitleValue: getTenantDashboardModel?.postJobCount,
          subtitle: StaticString.privateJobStatus,
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (ctx) => const PostAJobScreen(),
            //   ),
            // );
          },
        ),
        DashboardDetailModel(
          iconImage: ImgName.invoicesTenant,
          title: StaticString.invoices,
          subtitleValue: getTenantDashboardModel?.invoiceCount,
          subtitle: StaticString.newStatus,
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (ctx) => const TenantInvoicesScreen(),
            //   ),
            // );
          },
        ),
        DashboardDetailModel(
          iconImage: ImgName.myViewingsTenant,
          title: StaticString.myViewings,
          subtitleValue: getTenantDashboardModel?.myViewingCount,
          subtitle: StaticString.viewings,
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (ctx) => const MyViewingsTabBarScreen(),
            //   ),
            // );
          },
        ),
        DashboardDetailModel(
          iconImage: ImgName.tenantBuisnessServices,
          title: StaticString.buisnessServices.replaceAll(" ", "\n"),
          onTap: () {},
        ),
      ];

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
