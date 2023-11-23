import 'package:flutter/material.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:zungu_mobile/api/api_end_points.dart';
import 'package:zungu_mobile/api/api_middleware.dart';
import 'package:zungu_mobile/models/settings/business_profile/fetch_profile_model.dart';

import '../../../models/landloard/landlord_tenant_add_tenant_to_property.dart';

class LandlordTenantProvider with ChangeNotifier {
  //-------------------------Variables--------------------------//

  // Profile Model
  FetchProfileModel? profile;

  FetchProfileModel? get getProfile => profile;

  void removeProfile() {
    profile = null;
  }

  Future<void> checkProfileExists({
    required String mobile,
  }) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          requestType: HTTPRequestType.GET,
          url: "${ProfileEndPoints.profileExist}?mobile=$mobile",
        ),
      );
      profile = fetchProfileModelFromJson(response);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTenantToProperty({
    required LandlordTenantAddTenantToPropertyModel tenantModel,
  }) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: LandLordEndPoints.propertyTenantAdd,
          parameter: tenantModel.toNewTenantJson(),
        ),
      );
      profile = fetchProfileModelFromJson(response);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editTenantToProperty({
    required LandlordTenantAddTenantToPropertyModel tenantModel,
  }) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: LandLordEndPoints.propertyTenantEdit,
          parameter: tenantModel.toExistingTenantJson(),
        ),
      );
      profile = fetchProfileModelFromJson(response);
      notifyListeners();
    } catch (e) {
      // showAlert(context: getContext, message: e);
      rethrow;
    }
  }
}
