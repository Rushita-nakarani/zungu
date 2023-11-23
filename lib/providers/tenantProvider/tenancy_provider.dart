import 'package:flutter/cupertino.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:zungu_mobile/api/api_middleware.dart';
import 'package:zungu_mobile/constant/string_constants.dart';
import 'package:zungu_mobile/models/tenant/fetch_current_tenancy_model.dart';
import 'package:zungu_mobile/services/img_upload_service.dart';
import 'package:zungu_mobile/utils/custom_extension.dart';

import '../../api/api_end_points.dart';
import '../../models/tenant/previous_tenancy_fetch_model.dart';

class TenanciesProvider extends ChangeNotifier {
  //-------------------------Variables--------------------------//

  // Fetch Previous Tenant List
  List<FetchTenanciesModel> _fetchPreviousTenantList = [];

  // Fetch Current Tenant List
  List<CurrentTenancyModel> _fetchCurrentTenantList = [];

  //----------------------getter/setter methods-----------------//

  // Fetch Previous Tenant List getter/setter
  List<FetchTenanciesModel> get fetchPreviousTenantList =>
      _fetchPreviousTenantList;

  set fetchPreviousTenantList(List<FetchTenanciesModel> value) {
    _fetchPreviousTenantList = value;
    notifyListeners();
  }

  // Fetch Current Tenant List getter/setter
  List<CurrentTenancyModel> get fetchCurrentTenantList =>
      _fetchCurrentTenantList;

  set fetchCurrentTenantList(List<CurrentTenancyModel> value) {
    _fetchCurrentTenantList = value;
    notifyListeners();
  }

  //-----------------------------Functions--------------------------------//

  // Fetch Current and Previous Tenancy List api call...
  Future<void> fetchPreviousTenancy(String status) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: "${DashboardEndPoints.fetchTenancy}?status=$status",
          requestType: HTTPRequestType.GET,
        ),
      );
      if (status == StaticString.statusENDED) {
        fetchPreviousTenantList = fetchTenanciesModelFromJson(response);
      } else {
        fetchCurrentTenantList = fetchCurrentTenancyModelFromJson(response);
      }

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTenacy(String id) async {
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url:
              "${MyTenancyEndPoints.deleteTeanncyProperty}$id/${StaticString.delete.toLowerCase()}",
          requestType: HTTPRequestType.DELETE,
          parameter: {},
        ),
      );

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Create Tenancy api call
  Future<void> createTenancy(
    CurrentTenancyModel tenancyModel,
    String? profileId,
  ) async {
    try {
      final List<String> _uploadImages = (tenancyModel.photos)
          .where((element) => !element.isNetworkImage)
          .toList();
      if (_uploadImages.isNotEmpty) {
        tenancyModel.photos =
            await ImgUploadService.instance.uploadTenanciesPictures(
          images: _uploadImages,
          value: profileId,
        );
      }
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: LandLordEndPoints.addTenancy,
          parameter: tenancyModel.toUploadJson(),
        ),
      );
      await fetchPreviousTenancy(StaticString.statusCURRENT);
    } catch (e) {
      rethrow;
    }
  }
}
