import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kd_api_call/kd_api_call.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:zungu_mobile/utils/push_notification.dart';

import '../api/api_end_points.dart';
import '../utils/shared_preference.dart';

class ApiMiddleware {
  ApiMiddleware._();

  static ApiMiddleware instance = ApiMiddleware._();

  String _deivceType = "";
  String _appVersion = "";
  String appVersionBuild = "";
  String _deviceUUID = "";
  String appName = "";
  String apiResponse = "";
  String? fcmToken;

  // Default params...
  Future<void> getDefaultParams() async {
    // Get user info...
    await SharedPreferencesHelper.instance.loadSavedData();
    await _fetchAppVersion();
    await _fetchDeviceInfo();
  }

  // Fetch app. version...
  Future<void> _fetchAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String version = packageInfo.version;
    final String buildNumber = packageInfo.buildNumber;
    appVersionBuild = 'Version:$version Build:$buildNumber';
    _appVersion = version;
    appName = packageInfo.appName;
  }

  // Default parameter to add in all parameter...
  Map<String, dynamic> get _getDefaultParams {
    final Map<String, dynamic> map = {
      "sessionDetails": {
        "deviceToken": fcmToken,
        "deviceId": _deviceUUID,
        "deviceOs": _deivceType,
        "osVersion": appVersionBuild
      }
    };

    return map;
  }

  // Get Device Info... (Device Unique Id(UUID))
  Future<void> _fetchDeviceInfo() async {
    try {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        _deviceUUID = androidInfo.id ?? "";
        _deivceType = androidInfo.model ?? "Android";
      } else {
        final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        _deviceUUID = iosInfo.identifierForVendor ?? "";
        _deivceType =
            "${iosInfo.model ?? "iOS"} ${iosInfo.systemVersion ?? ""}";
      }
    } catch (e) {
      print("Error fetching device info");
    }
  }

  //Get Final Url...
  String getFinalURL({String endpoint = ""}) {
    //Live Base URL...
    const String liveBaseURL =
        kReleaseMode ? APISetup.productionURL : APISetup.staggingURL;

    //Check if App is in Debug or Live Mode...
    final String finalURL = liveBaseURL + endpoint;
    return finalURL;
  }

  //Get Header...
  Map<String, String> get getHeader {
    final Map<String, String> _header = {'Content-Type': 'application/json'};

    if (SharedPreferencesHelper.instance.getUserInfo?.token.isNotEmpty ??
        false) {
      _header["token"] = SharedPreferencesHelper.instance.getUserInfo!.token;
    }
    return _header;
  }

  // Call API Service...
  Future<String> callService({
    required APIRequestInfo requestInfo,
  }) async {
    try {
      // Get Final URL...
      requestInfo.url = getFinalURL(endpoint: requestInfo.url);

      // Get header...
      requestInfo.headers = getHeader;

      if (requestInfo.url == getFinalURL(endpoint: AuthEndPoints.loggedin) ||
          requestInfo.url ==
              getFinalURL(endpoint: AuthEndPoints.startFreeTrial)) {
        fcmToken = await PushNotification.instance.getFCMToken();
      }

      // Add Default params to API Params...
      if (requestInfo.parameter == null) {
        if (requestInfo.url == getFinalURL(endpoint: AuthEndPoints.loggedin) ||
            requestInfo.url ==
                getFinalURL(endpoint: AuthEndPoints.startFreeTrial)) {
          requestInfo.parameter = _getDefaultParams;
        }
        if (requestInfo.url == getFinalURL(endpoint: AuthEndPoints.logout)) {
          requestInfo.parameter = {
            "deviceId": _deviceUUID,
          };
        }
      } else {
        if ((requestInfo.parameter is Map?) || (requestInfo.parameter is Map)) {
          final Map<String, dynamic> data =
              Map<String, dynamic>.from(requestInfo.parameter as Map);
          if (requestInfo.url ==
                  getFinalURL(endpoint: AuthEndPoints.loggedin) ||
              requestInfo.url ==
                  getFinalURL(endpoint: AuthEndPoints.startFreeTrial)) {
            data.addAll(_getDefaultParams);
          }

          data.removeWhere((key, value) => value == null);

          requestInfo.parameter = data;
        }
      }

      // Call Serivce...
      final http.Response apiResponse =
          await ApiCall.instance.callService(requestInfo: requestInfo);

      return processResponse(apiResponse);
    } on FormatException catch (e) {
      throw e.message;
    } catch (error) {
      rethrow;
    }
  }

  //Get Error Title...
  String _getErrorTitle(http.Response response) => response.body.isEmpty
      ? APIErrorMsg.defaultErrorTitle
      : (jsonDecode(response.body)[APISetup.titleKey]) ?? "";

  //Get Error Message...
  String _getErrorMsg(http.Response response) => response.body.isEmpty
      ? APIErrorMsg.somethingWentWrong
      : (jsonDecode(response.body)[APISetup.messageKey]) ??
          APIErrorMsg.somethingWentWrong;

  //Process Response...
  String processResponse(http.Response response) {
    String title = "";
    String msg = "";
    if (response.statusCode != 200) {
      title = _getErrorTitle(response);
      msg = _getErrorMsg(response);
    }

    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
      case 204:
        // Fluttertoast.showToast(msg: _getErrorMsg(response));
        return response.body;

      case 401:
      case 403:
      case 410:
        throw AppException(
          statusCode: response.statusCode,
          title: title,
          message: msg,
          type: ExceptionType.UnAuthorised,
        );

      case 400:
      case 404:
      case 422:
      case 500:
        throw AppException(
          statusCode: response.statusCode,
          title: title,
          message: msg,
        );

      // Service Unavailable...
      case 502:
      case 503:
        throw AppException(
          statusCode: response.statusCode,
          title: APIErrorMsg.underMaintainanceTitle,
          message: APIErrorMsg.underMaintainanceMsg,
          type: ExceptionType.UnderMaintainance,
        );

      default:
        throw AppException(
          statusCode: response.statusCode,
          title: title,
          message: msg,
        );
    }
  }
}
