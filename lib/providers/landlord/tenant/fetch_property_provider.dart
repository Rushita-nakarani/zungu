// ignore_for_file: avoid_setters_without_getters

import 'package:flutter/material.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:zungu_mobile/api/api_end_points.dart';
import 'package:zungu_mobile/api/api_middleware.dart';

import '../../../models/landloard/attribute_info_model.dart';
import '../../../models/landloard/property_list_model.dart';

class LandlordTenantPropertyProvider with ChangeNotifier {
  //-------------------------Variables--------------------------//

  // Landlord Add Tenant Property Model
  LandlordAddTenantPropertyModel property = LandlordAddTenantPropertyModel();

  // Attribute List
  List<AttributeInfoModel> _attributeList = [];

  //-------------------------getter/setter methods--------------------------//

  // Attribute List getter/setter
  List<AttributeInfoModel> get getAttributeList => _attributeList;
  set setAttributeList(List<AttributeInfoModel> value) {
    _attributeList = value;
  }

  //-------------------------Function--------------------------//

  // fetch user's own properties api call
  Future<void> fetchProperties({
    String query = "",
    int page = 1,
  }) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          requestType: HTTPRequestType.GET,
          url:
              "${LandLordEndPoints.fetchPropertyList}?page=$page&size=10&search=$query",
        ),
      );
      if (page == 1) {
        property = landlordAddTenantPropertyListFromJson(response);
      } else {
        final LandlordAddTenantPropertyModel moreProperty =
            landlordAddTenantPropertyListFromJson(response);
        property.count = moreProperty.count;
        property.page = moreProperty.page;
        property.size = moreProperty.size;
        property.propertyList.addAll(moreProperty.propertyList);
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // fetch attribute list of deposit scheme api call
  Future<void> fetchAttributeList({String attribute = "DEPOSIT_SCHEME"}) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          requestType: HTTPRequestType.GET,
          url: "${UtilityEndPoints.attributeList}?attributeType=$attribute",
        ),
      );
      setAttributeList = listOfAttributeInfoModelFromJson(response);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> tenantRenewLeaseProperty(
    String tenantId,
    String rentamount,
    String startDate,
    String endDate,
    String? leaseUrl,
  ) async {
    final Map<String, dynamic> _parms = {
      "tenancyId": tenantId,
      "rentalAmount": rentamount,
      "startDate": startDate,
      "endDate": endDate,
      if (leaseUrl?.isNotEmpty ?? false) "leaseUrl": leaseUrl,
    };
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: LandloardApiEndPoint.leaesRenew,
          parameter: _parms,
        ),
      );

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
