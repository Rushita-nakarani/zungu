// ignore_for_file: unnecessary_getters_setters, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';

import '../../../api/api_end_points.dart';
import '../../../api/api_middleware.dart';
import '../../../models/api_response_obj.dart';
import '../../../models/landloard/landlord_my_lease_model.dart';
import '../../../models/landloard/lease_detail_model.dart';
import '../../../services/img_upload_service.dart';

class LeaseDetailProvider extends ChangeNotifier {
  //------------------------------Variables---------------------//
  List<LeaseDetailModel> _leaseDetail = [];
  List<LeaseDetailModel> get leaseDetail => _leaseDetail;

  set leaseDetail(List<LeaseDetailModel> value) {
    _leaseDetail = value;
    notifyListeners();
  }

  LandlordMyLeaseModel? _landlordCurrentlease;
  LandlordMyLeaseModel? _landlordPreviouslease;
  List<Tenant> _currentLeaseTeants = [];
  List<Tenant> _previousLeaseTeants = [];

  //-----------------------------getter/setter----------------------//

  // Landlord Current My lease model
  LandlordMyLeaseModel? get landlordCurrentlease => _landlordCurrentlease;
  set landlordCurrentlease(LandlordMyLeaseModel? value) =>
      _landlordCurrentlease = value;

  List<Tenant> get currentLeaseTeants => _currentLeaseTeants;
  set currentLeaseTeants(List<Tenant> value) => _currentLeaseTeants = value;

  List<Tenant> get previousLeaseTeants => _previousLeaseTeants;
  set previousLeaseTeants(value) => _previousLeaseTeants = value;

  // Landlord Previous My lease model
  LandlordMyLeaseModel? get landlordPreviouslease => _landlordPreviouslease;
  set landlordPreviouslease(LandlordMyLeaseModel? value) =>
      _landlordPreviouslease = value;

  //------------------------------Functions---------------------//
  // fetch lease detail
  Future<void> fetchLeaseData() async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          requestType: HTTPRequestType.GET,
          url: LeaseEndPoints.leaseDetail,
          parameter: {},
        ),
      );

      leaseDetail = leaseListModelFromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Lease Fetch By Status
  Future<void> leaseFetchByStatus({
    required String status,
    required String propertyDetailId,
  }) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          requestType: HTTPRequestType.GET,
          url:
              "${LeaseEndPoints.leaseFetchByStatus}?status=$status&propertyDetailId=$propertyDetailId",
        ),
      );
      final ResponseObj responseObj = defaultRespInfo(response);
      if (responseObj.resultArray.isNotEmpty) {
        if (status == StaticString.statusCURRENT) {
          currentLeaseTeants.clear();
          landlordCurrentlease = landlordMyLeaseModelFromJson(response).first;
          landlordCurrentlease?.property.forEach((property) {
            if (property.tenants.isNotEmpty) {
              property.tenants.forEach((tenant) {
                tenant.roomName = property.roomName;
              });
              currentLeaseTeants.addAll(property.tenants);
            }
          });
        } else {
          landlordPreviouslease = landlordMyLeaseModelFromJson(response).first;
          previousLeaseTeants.clear();
          landlordPreviouslease?.property.forEach((property) {
            if (property.tenants.isNotEmpty) {
              property.tenants.forEach((tenant) {
                tenant.roomName = property.roomName;
              });
              previousLeaseTeants.addAll(property.tenants);
            }
          });
        }
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> leaesUpdateUrl({
    required String leaesId,
    required String leaesUrl,
  }) async {
    try {
      final List<String> uploadedLeaseUrl =
          await ImgUploadService.instance.uploadPropertyPictures(
        id: leaesId,
        images: [leaesUrl],
        uploadType: UploadType.PROPERTY_LEASAES,
      );
      final Map<String, dynamic> _params = {};
      if (uploadedLeaseUrl.isNotEmpty) {
        _params.addAll({"leaseUrl": uploadedLeaseUrl.first});
      }
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: "${LandloardApiEndPoint.updateLeaseUrl}?id=$leaesId",
          parameter: _params,
        ),
      );

      notifyListeners();
      return uploadedLeaseUrl.isEmpty ? "" : uploadedLeaseUrl.first;
    } catch (e) {
      rethrow;
    }
  }

  // Renew E-Sign Lease api call
  Future<void> renewESignLease({required String leaseDetailId}) async {
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: LeaseEndPoints.renewEsignLease,
          parameter: {"leaseDetailId": leaseDetailId},
        ),
      );

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
