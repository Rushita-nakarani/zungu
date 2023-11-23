import 'package:flutter/material.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:zungu_mobile/api/api_end_points.dart';

import '../../api/api_middleware.dart';
import '../../models/landloard/active_leases_data_model.dart';

class ActiveLeasesProvider extends ChangeNotifier {
  List<ActiveLeaseDataModel> _activeLeaseDataList = [];

  List<ActiveLeaseDataModel> get activeLeaseDataList => _activeLeaseDataList;

  set activeLeaseDataList(List<ActiveLeaseDataModel> value) {
    _activeLeaseDataList = value;
    notifyListeners();
  }

  Future<void> tenantActiveLeases({String? endingValue}) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: (endingValue?.isEmpty ?? true)
              ? LandloardApiEndPoint.activeLeases
              : "${LandloardApiEndPoint.activeLeases}?endingDays=$endingValue",
          requestType: HTTPRequestType.GET,
        ),
      );
      activeLeaseDataList = activeLeaseDataModelFromJson(response);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
