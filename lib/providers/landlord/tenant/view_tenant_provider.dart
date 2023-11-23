import 'package:flutter/material.dart';
import 'package:kd_api_call/kd_api_call.dart';

import '../../../api/api_end_points.dart';
import '../../../api/api_middleware.dart';
import '../../../models/api_response_obj.dart';
import '../../../models/landloard/view_tenant_tenancy_list_model.dart';
import '../../../models/landloard/view_tenant_tenancy_model.dart';
import '../../../utils/cust_eums.dart';
import '../../../utils/custom_extension.dart';

class LandlordTenantViewTenantProvider with ChangeNotifier {
  //-------------------------Variables--------------------------//

  // View Tenant Tenancy List and Model
  List<ViewTenantTenancyListModel> tenancies = [];
  ViewTenantTenancyModel tenant = ViewTenantTenancyModel();

  //----------------------getter/setter methods-----------------//

  // View Tenant Tenancy List getter
  List<ViewTenantTenancyListModel> get getTenancy => tenancies;

  // View Tenant Tenancy Model getter
  ViewTenantTenancyModel get getTenant => tenant;

  //-------------------------Functions--------------------------//

  // Remove Tenant Detail
  void removeTenantDetail() {
    tenant.fullName = "";
    tenant.email = "";
    tenant.mobile = "";
    tenant.userId = "";
  }

  // Fetch Current Tenants Data api call
  Future<void> fetchCurrentTenants({
    CurrentTenantsFilter? filterType,
    String query = "",
  }) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: "${LandLordEndPoints.fetchCurrentTenant}?search=$query",
          parameter:
              filterType == null ? {} : {"type": filterType.parseToString()},
        ),
      );

      final ResponseObj responseObj = defaultRespInfo(response);
      tenancies = responseObj.resultArray
          .map((e) => viewTenantTenancyListModelFromJson(e))
          .toList();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Tenancy Data By Id api call
  Future<void> fetchTenancyById({String tenancyId = ""}) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          requestType: HTTPRequestType.GET,
          url: "${LandLordEndPoints.fetchTenantById}$tenancyId",
          parameter: {},
        ),
      );
      final ResponseObj responseObj = defaultRespInfo(response);
      if (responseObj.resultArray.isNotEmpty) {
        tenant = viewTenantTenancyModelFromJson(
          responseObj.resultArray.first,
        ); // call method
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Remove Tenancy api call
  Future<void> removeTenancy({required String tenancyId}) async {
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          requestType: HTTPRequestType.DELETE,
          url: "${LandLordEndPoints.propertyTenancy}$tenancyId/delete",
          parameter: {},
        ),
      );
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
