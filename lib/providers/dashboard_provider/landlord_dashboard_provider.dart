// ignore_for_file: avoid_setters_without_getters

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:zungu_mobile/models/dashboard/landlord_dashboard_model.dart';
import 'package:zungu_mobile/models/dashboard/subscribe_role_model.dart';

import '../../api/api_end_points.dart';
import '../../api/api_middleware.dart';
import '../../constant/color_constants.dart';
import '../../constant/img_constants.dart';
import '../../constant/string_constants.dart';
import '../../models/dashboard/dashboard_model.dart';
import '../../models/dashboard/landlord_task_model.dart';
import '../../screens/landlord/landlord_dashboard_screen.dart';
import '../../screens/landlord/my properties/landlord_my_properties_screen.dart';
import '../../screens/landlord/tenant/tenant_dashboard.dart';
import '../../widgets/custom_text.dart';

class LandlordDashboradProvider extends ChangeNotifier {
  //-------------------------------Variables-----------------------------------//
  LandlordDashboardModel? landlordDashboardModel;
  LandlordTaskModel? landlordTaskModel;
  List<NewTaskLeftModel> newTaskLeftList = [];
  List<DashboardDetailModel> _dashboardData = [];
  List<DashboardDetailModel> get dashboardData => _dashboardData;

  set dashboardData(List<DashboardDetailModel> value) => _dashboardData = value;

  bool isAppbarremove = false;

  bool get getIsAppbarremove => isAppbarremove;

  set setIsAppbarremove(bool isAppbarremove) {
    this.isAppbarremove = isAppbarremove;
    notifyListeners();
  }

  int index = 0;
  //---------------------------getter/setter methods------------------------//

  //Landlord dashboard getter/setter method
  LandlordDashboardModel? get getLandlordDashboardModel =>
      landlordDashboardModel;

  set setLandlordDashboardModel(
    LandlordDashboardModel? _landlordDashboardModel,
  ) {
    landlordDashboardModel = _landlordDashboardModel;
  }

  //Landlord task getter/setter method
  LandlordTaskModel? get getLandlordTaskModel => landlordTaskModel;

  set setLandlordTaskModel(LandlordTaskModel? _landlordTaskModel) {
    landlordTaskModel = _landlordTaskModel;
  }

  SubscribeRoleModel? _subscribeRoleModel;
  SubscribeRoleModel? get subscribeRoleModel => _subscribeRoleModel;

  set subscribeRoleModel(SubscribeRoleModel? value) =>
      _subscribeRoleModel = value;

  //--------------------------------Function---------------------------//

  // Fetch Landlord Dashboard data List
  Future<void> fetchLandlordDashboardList([BuildContext? context]) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: DashboardEndPoints.landlordDashboard,
          requestType: HTTPRequestType.GET,
        ),
      );

      setLandlordTaskModel = landlordTaskModelFromJson(response);

      newTaskLeftList = [
        NewTaskLeftModel(
          icon: ImgName.ntl1,
          title: StaticString.maintainanceRequest,
          count: getLandlordTaskModel?.maintenanceRequest ?? 0,
        ),
        NewTaskLeftModel(
          icon: ImgName.ntl2,
          title: StaticString.newQuotes,
          count: getLandlordTaskModel?.newQuote ?? 0,
        ),
        NewTaskLeftModel(
          icon: ImgName.ntl3,
          title: StaticString.propertyViewings,
          count: getLandlordTaskModel?.propertyViewing ?? 0,
        ),
        NewTaskLeftModel(
          icon: ImgName.landlordCalender,
          title: StaticString.newReminder,
          count: getLandlordTaskModel?.newReminderCount ?? 0,
        ),
      ];

      newTaskLeftList.sort((a, b) => b.count.compareTo(a.count));

      setLandlordDashboardModel = landlordDashboardModelFromJson(response);

      dashboardData = [
        DashboardDetailModel(
          iconImage: ImgName.financial,
          title: StaticString.financials,
          customSubtitle: Column(
            children: [
              CustomText(
                txtTitle:
                    "Income (${DateFormat("MMM yyyy").format(DateTime.now())})",
                align: TextAlign.center,
                style: Theme.of(context!).textTheme.bodyText1?.copyWith(
                      color: ColorConstants.custDarkPurple150934,
                      height: 1,
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomText(
                txtTitle:
                    "${StaticString.currency}${getLandlordDashboardModel?.financial.toString()}",
                align: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: ColorConstants.custDarkPurple150934,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
              ),
            ],
          ),
          onTap: () {},
        ),
        DashboardDetailModel(
          iconImage: ImgName.invoice,
          title: StaticString.invoices,
          subtitleValue: getLandlordDashboardModel?.invoiceCount,
          subtitle: StaticString.newStatus,
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (ctx) => const LandlordInvoicesHome(),
            //   ),
            // );
          },
        ),
        DashboardDetailModel(
          iconImage: ImgName.property,
          title: StaticString.myProperties,
          subtitleValue: getLandlordDashboardModel?.myPropertyCount,
          subtitle: StaticString.properties,
          onTap: () async {
            setIsAppbarremove = true;

            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LandlordMyPropertiesScreen(),
              ),
            );
            setIsAppbarremove = false;
          },
        ),
        DashboardDetailModel(
          iconImage: ImgName.landlordMaintenance,
          title: StaticString.maintenance,
          subtitleValue: getLandlordDashboardModel?.maintenanceCount,
          subtitle: StaticString.newRequest,
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (ctx) => const MaintenanceRequest(),
            //   ),
            // );
          },
        ),
        DashboardDetailModel(
          iconImage: ImgName.tenant,
          title: StaticString.tenants,
          subtitleValue: getLandlordDashboardModel?.tenantCount,
          subtitle: StaticString.activeStatus,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LandlordTenantScreen(),
              ),
            );
          },
        ),
        DashboardDetailModel(
          iconImage: ImgName.buisnessServicesld,
          title: StaticString.buisnessServices.replaceAll(" ", "\n"),
          onTap: () {},
        ),
      ];

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Role list...
  Future<void> fetchRoleList() async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.fetchUserSubscriptions,
          requestType: HTTPRequestType.GET,
        ),
      );
      subscribeRoleModel = subscribeRoleModelFromJson(response);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
