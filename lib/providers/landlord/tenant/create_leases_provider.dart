// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:zungu_mobile/api/api_end_points.dart';
import 'package:zungu_mobile/api/api_middleware.dart';
import 'package:zungu_mobile/models/api_response_obj.dart';
import 'package:zungu_mobile/models/landloard/create_lease_model.dart';

import '../../../models/landloard/fetch_country_model.dart';
import '../../../models/landloard/fetch_lease_type.dart';

class CreateLeasesProvider extends ChangeNotifier {
  //-------------------------Variables--------------------------//

  // Fetch Country List
  List<FetchCountryModel> _fetchCountryList = [];
  List<SelectLeaseType> _fetchTenanttypeList = [];

  List<SelectLeaseType> get fetchTenanttypeList => _fetchTenanttypeList;

  set fetchTenanttypeList(List<SelectLeaseType> value) {
    _fetchTenanttypeList = value;
    notifyListeners();
  }

  // Fetch Country List getter/setter
  List<FetchCountryModel> get fetchCountryList => _fetchCountryList;
  set fetchCountryList(List<FetchCountryModel> value) {
    _fetchCountryList = value;
    notifyListeners();
  }

  //-------------------------Function--------------------------//

  // Fetch Country Data api call
  Future<void> fetchCountryData() async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          requestType: HTTPRequestType.GET,
          url: LandloardApiEndPoint.createLeasesCountrySelectedApi,
        ),
      );
      fetchCountryList = fetchCountryModelFromJson(response);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Lease Type data api call
  Future<void> fetchLeaseTypeData(
    String countrycode,
  ) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          requestType: HTTPRequestType.GET,
          url:
              "${LandloardApiEndPoint.createLeaseType}fetch?country=$countrycode",
        ),
      );
      fetchTenanttypeList = SelectLeaseTypeFromJson(response);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Create Leases Data api call
  Future<CreateLeaseModel?> createLeasesData(
    CreateLeaseModel createLeaseModel,
  ) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: LandloardApiEndPoint.createDetailsLeases,
          parameter: createLeaseModel.toJson(),
        ),
      );

      final List<CreateLeaseModel> _lease =
          createLeaseModelListFromJson(response);
      if (_lease.isNotEmpty) {
        final CreateLeaseModel lease = _lease.first;
        final String response = await ApiMiddleware.instance.callService(
          requestInfo: APIRequestInfo(
            url: LandloardApiEndPoint.generateLeaseAgreement(_lease.first.id),
            requestType: HTTPRequestType.GET,
          ),
        );
        lease.leaseUrl = defaultRespInfo(response).resultObj['leaseUrl'] ?? "";
        return lease;
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
    return null;
  }

  // E-Sign Lease api call
  Future<void> eSignLease({
    required String signImage,
    required String eSignTypes,
    String leaseDetailId = "",
  }) async {
    final Map<String, dynamic> _parms = {
      "type": eSignTypes,
      "leaseDetailId": leaseDetailId,
    };
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: LeaseEndPoints.leaseEsign,
          docList: [
            UploadDocument(docKey: "sign", docPathList: [signImage]),
          ],
          parameter: _parms,
        ),
      );

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
