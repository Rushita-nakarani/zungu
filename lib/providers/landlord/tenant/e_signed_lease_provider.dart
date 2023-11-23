// ignore_for_file: avoid_setters_without_getters, unnecessary_getters_setters

import 'package:flutter/cupertino.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:zungu_mobile/constant/string_constants.dart';
import 'package:zungu_mobile/models/landloard/e_signed_lease_list_model.dart';

import '../../../api/api_end_points.dart';
import '../../../api/api_middleware.dart';

class ESignedLeaseProvider extends ChangeNotifier {
  //-------------------------Variables--------------------------//

  // E-SignedLease List
  List<ESignedLeaseListModel> _pendingESignList = [];

  // E-SignedLease List
  List<ESignedLeaseListModel> _eSignedLeaseList = [];

  //----------------------getter/setter methods-----------------//

  // Pending E-Signed List getter/setter
  List<ESignedLeaseListModel> get pendingESignList => _pendingESignList;
  set pendingESignList(List<ESignedLeaseListModel> value) {
    _pendingESignList = value;
    notifyListeners();
  }

  // E-Signed Lease List getter/setter
  List<ESignedLeaseListModel> get eSignedLeaseList => _eSignedLeaseList;
  set eSignedLeaseList(List<ESignedLeaseListModel> value) {
    _eSignedLeaseList = value;
    notifyListeners();
  }
  //-------------------------Functions--------------------------//

  // Fetch E-Signed Lease And Pending E-Sign List data
  Future<void> fetchESignedLeaseListData({
    String status = StaticString.statusPENDING,
    String? fromDate,
    String? toDate,
  }) async {
    try {
      String custAPI = "${LeaseEndPoints.fetchESignedLeaseList}?status=$status";

      if (fromDate != null) {
        custAPI = "$custAPI&fromDate=$fromDate";
      }
      if (toDate != null) {
        custAPI = "$custAPI&toDate=$toDate";
      }

      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: custAPI,
          requestType: HTTPRequestType.GET,
        ),
      );

      if (status == StaticString.statusPENDING) {
        pendingESignList = eSignedLeaseListModelFromJson(response);
      } else {
        eSignedLeaseList = eSignedLeaseListModelFromJson(response);
      }

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Delete E-sign Lease api call
  Future<void> deleteESignedLease(String leaseDetailId) async {
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          requestType: HTTPRequestType.DELETE,
          url: LeaseEndPoints.deleteESignLease + leaseDetailId,
          parameter: {},
        ),
      );

      notifyListeners();
      await fetchESignedLeaseListData();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addEsignedTenantLeases(
    String propertyId,
    String leaseDetailId,
  ) async {
    try {
      final Map<String, dynamic> _params = {
        "propertyId": propertyId,
        "leaseDetailId": leaseDetailId
      };
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: LeaseEndPoints.leaseEsigntenantAdd,
          parameter: _params,
        ),
      );

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateEsignedTenantLeases(
    String leaseDetailId,
  ) async {
    try {
      final Map<String, dynamic> _params = {"leaseDetailId": leaseDetailId};
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: LeaseEndPoints.leaseEsigntenantupdate,
          parameter: _params,
        ),
      );

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> leaseSignGuarantor(
    String sign,
    String leaseDetailId,
  ) async {
    try {
      final Map<String, dynamic> _params = {"leaseDetailId": leaseDetailId};
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: LeaseEndPoints.leaseSignGuarantor,
          parameter: _params,
          docList: [
            UploadDocument(docKey: "sign", docPathList: [sign])
          ],
        ),
      );

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
