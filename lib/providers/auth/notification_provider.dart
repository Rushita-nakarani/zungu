// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/cupertino.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:zungu_mobile/api/api_end_points.dart';
import 'package:zungu_mobile/models/auth/notification_model.dart';

import '../../api/api_middleware.dart';
import '../../utils/cust_eums.dart';

class NotificationProvider extends ChangeNotifier {
  //-----------------------Variables----------------------//
  NotificationScreenModel? notificationLandlordModel;
  NotificationScreenModel? notificationTenantModel;
  NotificationScreenModel? notificationTradesmanModel;
  List<NotificationDatum>? _notificationListLandlordData;

  List<NotificationDatum>? _notificationListTenantData;

  List<NotificationDatum>? _notificationListTradesmanData;

  //------------------getter/setter methods---------------------//

  // Landlord data
  List<NotificationDatum>? get notificationListLandlordData =>
      _notificationListLandlordData;

  set notificationListLandlordData(List<NotificationDatum>? value) =>
      _notificationListLandlordData = value;

  // Tenant data
  List<NotificationDatum>? get notificationListTenantData =>
      _notificationListTenantData;

  set notificationListTenantData(List<NotificationDatum>? value) =>
      _notificationListTenantData = value;

  // Tradesman data
  List<NotificationDatum>? get notificationListTradesmanData =>
      _notificationListTradesmanData;

  set notificationListTradesmanData(List<NotificationDatum>? value) =>
      _notificationListTradesmanData = value;
  //-------------------------function--------------------------//

  Future<void> fetchNotification({
    required int page,
    required UserRole? userRole,
    required String profileId,
  }) async {
    switch (userRole) {
      case UserRole.LANDLORD:
        await fetchNotificationLandlordData(profileId: profileId, page: page);
        break;
      case UserRole.TRADESPERSON:
        await fetchNotificationTradesmanData(profileId: profileId, page: page);
        break;
      case UserRole.TENANT:
        await fetchNotificationTenantData(profileId: profileId, page: page);
        break;
      default:
    }
  }

  Future<void> fetchNotificationLandlordData({
    int page = 1,
    String profileId = "",
  }) async {
    final Map<String, dynamic> _params = {"profileId": profileId};
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: "${NotificationEndPoints.fetchNotification}?page=$page&size=5",
          parameter: _params,
        ),
      );

      if (page == 1) {
        notificationLandlordModel = notificationScreenModelFromJson(response);
        notificationListLandlordData =
            notificationScreenModelFromJson(response).data;
      } else {
        notificationListLandlordData?.addAll(
          notificationScreenModelFromJson(response).data,
        );
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchNotificationTenantData({
    int page = 1,
    String profileId = "",
  }) async {
    final Map<String, dynamic> _params = {"profileId": profileId};
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: "${NotificationEndPoints.fetchNotification}?page=$page&size=10",
          parameter: _params,
        ),
      );

      if (page == 1) {
        notificationTenantModel = notificationScreenModelFromJson(response);
        notificationListTenantData =
            notificationScreenModelFromJson(response).data;
      } else {
        notificationListTenantData?.addAll(
          notificationScreenModelFromJson(response).data,
        );
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchNotificationTradesmanData({
    int page = 1,
    String profileId = "",
  }) async {
    final Map<String, dynamic> _params = {"profileId": profileId};
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: "${NotificationEndPoints.fetchNotification}?page=$page&size=5",
          parameter: _params,
        ),
      );

      if (page == 1) {
        notificationTradesmanModel = notificationScreenModelFromJson(response);
        notificationListTradesmanData =
            notificationScreenModelFromJson(response).data;
      } else {
        notificationListTradesmanData?.addAll(
          notificationScreenModelFromJson(response).data,
        );
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> readNotification({
    required String profileId,
  }) async {
    final Map<String, dynamic> _params = {
      "profileId": profileId,
    };
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: NotificationEndPoints.readNotification,
          parameter: _params,
        ),
      );
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearAllNotification({
    required String profileId,
    required UserRole userRole,
  }) async {
    final Map<String, dynamic> _params = {
      "profileId": profileId,
    };
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: NotificationEndPoints.clearAllNotification,
          parameter: _params,
        ),
      );
      switch (userRole) {
        case UserRole.LANDLORD:
          await fetchNotificationLandlordData(profileId: profileId);
          break;
        case UserRole.TRADESPERSON:
          await fetchNotificationTradesmanData(profileId: profileId);
          break;
        case UserRole.TENANT:
          await fetchNotificationTenantData(profileId: profileId);
          break;
        default:
      }
    } catch (e) {
      rethrow;
    }
  }
}
