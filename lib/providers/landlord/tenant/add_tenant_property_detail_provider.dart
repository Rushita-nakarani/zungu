// ignore_for_file: avoid_setters_without_getters
import 'package:flutter/cupertino.dart';
import 'package:kd_api_call/kd_api_call.dart';

import '../../../api/api_end_points.dart';
import '../../../api/api_middleware.dart';
import '../../../models/landloard/add_tenant_property_detail_model.dart';

class AddTenantPropertyDetailProvider extends ChangeNotifier {
  //-------------------------Variables--------------------------//
  AddTenantPropertiesDetailModel propertiesDetailModel =
      AddTenantPropertiesDetailModel(propertyDetail: PropertyDetail());

  //----------------------getter/setter methods-----------------//

  //Properties Details getter
  AddTenantPropertiesDetailModel get getPropertiesDetailModel =>
      propertiesDetailModel;
  //Properties Details setter
  set setPropertiesDetailModel(
    AddTenantPropertiesDetailModel _propertiesDetailModel,
  ) {
    propertiesDetailModel = _propertiesDetailModel;
  }

  String get createFullAddress =>
      "${propertiesDetailModel.propertyDetail.addressDetail?.addressLine1}, ${propertiesDetailModel.propertyDetail.addressDetail?.addressLine2}";

  //-------------------------Functions--------------------------//

  // Fetch Properties Details data
  Future<void> fetchPropertiesDetailsData({
    String propertyDetailId = "",
  }) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: "${LandLordEndPoints.fetchPropertyInfo}$propertyDetailId",
          requestType: HTTPRequestType.GET,
        ),
      );

      setPropertiesDetailModel =
          addTenantPropertiesDetailModelFromJson(response);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
