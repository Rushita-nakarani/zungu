import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/api_response_obj.dart';
import 'package:zungu_mobile/models/auth/auth_model.dart';
import 'package:zungu_mobile/models/auth/role_model.dart';
import 'package:zungu_mobile/models/settings/setting_content_model.dart';

import '../../api/api_end_points.dart';
import '../../api/api_middleware.dart';
import '../../constant/img_constants.dart';
import '../../utils/cust_eums.dart';
import '../../utils/push_notification.dart';
import '../../utils/shared_preference.dart';

class AuthProvider with ChangeNotifier {
  RoleModel? _roleModel;
  List<RoleData> _roleList = [];

  AuthModel? get authModel => SharedPreferencesHelper.instance.getUserInfo;

  // Setter...
  set authModel(AuthModel? value) {
    SharedPreferencesHelper.instance.setUserInfo = value;
    notifyListeners();
  }

  set isShowedOnBoarding(bool value) {
    SharedPreferencesHelper.instance.isShowOnBoarding = value;
    notifyListeners();
  }

  set roleModel(RoleModel? value) => _roleModel = value;

  set roleList(List<RoleData> value) => _roleList = value;

  // Getter...
  bool get isShowedOnBoarding =>
      SharedPreferencesHelper.instance.isShowOnBoarding;
  List<RoleData> get roleList => _roleList;
  RoleModel? get roleModel => _roleModel;

  UserRole get userRole => authModel?.profile?.userRole ?? UserRole.None;

  set userRole(UserRole value) {
    authModel?.profile?.userRole = value;
    notifyListeners();
  }

  RoleData? getRoldIdByRole(UserRole userRole) {
    return roleList.firstWhere((element) => element.roleName == userRole);
  }

  String _images(int id) {
    String image = "";

    switch (id) {
      case 1:
        image = ImgName.landlord;
        break;
      case 2:
        image = ImgName.tradesman;
        break;
      case 3:
        image = ImgName.tenantAuth;
        break;
      case 4:
        image = ImgName.owner;
        break;
      case 5:
        image = ImgName.accountant;
        break;
      case 6:
        image = ImgName.lawyer;
        break;
      default:
    }
    return image;
  }

  // Sign in with mobile number and password...
  Future<void> login(AuthModel auth) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.loggedin,
          parameter: auth.toLoginJson(),
        ),
      );
      authModel = authModelFromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Generate for sign up...
  Future<String> generateOTP(AuthModel auth) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.otpGenerate,
          parameter: auth.toGenrateOTPJson(),
        ),
      );
      final AuthModel _authModel = authModelFromJson(response);
      return _authModel.token;
    } catch (e) {
      rethrow;
    }
  }

  // Verfiy for sign up...
  Future<String> verfiyOTP(AuthModel auth) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.otpVerify,
          parameter: auth.toVerfiyOTPJson(),
        ),
      );
      return defaultRespInfo(response).resultObj['id'] ?? "";
    } catch (e) {
      rethrow;
    }
  }

  // Sign up with mobile number and password...
  Future<void> signUp(AuthModel auth) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.register,
          parameter: auth.toSignUpJson(),
        ),
      );
      authModel = authModelFromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Forgot password...
  Future<void> forgotPassword(AuthModel auth) async {
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.forgotPassword,
          parameter: auth.toForgotPasswordJson(),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  // Role list...
  Future<void> fetchRoleList() async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.fetchRole,
          requestType: HTTPRequestType.GET,
        ),
      );
      roleModel = roleModelFromJson(response);
      roleList = roleModelFromJson(response).roleData;
      for (final role in roleList) {
        role.images = _images(role.roleId);
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Role list...
  Future<void> startFreeTrail(String? orderId) async {
    final Map<String, dynamic> _parms = {
      "roleId": orderId,
      "userId": authModel?.userId
    };
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.startFreeTrial,
          parameter: _parms,
        ),
      );
      authModel = authModelFromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Reload session...
  Future<void> reloadSession() async {
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.reloadSession,
          requestType: HTTPRequestType.GET,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  // Setting content...
  Future<SettingContentModel> fetchSettingContent(
    HtmlViewType htmlViewType,
  ) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.fetchLegalDetail + htmlViewType.name,
          requestType: HTTPRequestType.GET,
        ),
      );
      return settingContentModelFromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Change password...
  Future<void> changePassword(
    AuthModel authModel,
  ) async {
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.changePassword,
          parameter: authModel.toChangePasswordJson(),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  // Change Number...
  Future<void> numberChange(
    AuthModel auth,
  ) async {
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.numberChange,
          parameter: auth.toNumberChangeJson(),
        ),
      );
      print(auth.mobile);
      authModel?.mobile = auth.mobile;
      print(authModel?.mobile);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.logout,
        ),
      );
      authModel = null;
      // Destroy pushnotification token...
      await PushNotification.instance.logout();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser() async {
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.deleteAccount,
          requestType: HTTPRequestType.DELETE,
          parameter: {},
        ),
      );
      authModel = null;
      // Destroy pushnotification token...
      await PushNotification.instance.logout();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Subscription verifiy...
  Future<void> subscriptionVerifiy({
    String? productId,
    String? transactionId,
    String? transactionDate,
    String? transactionReceipt,
    required String propertyDetailID,
    SubscriptionType subscriptionType = SubscriptionType.Property,
  }) async {
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.subscriptionVerify,
          parameter: {
            "productId": productId,
            "transactionId": transactionId,
            "transactionDate": transactionDate,
            "platform": Platform.isIOS
                ? "iOS"
                : Platform.isAndroid
                    ? "Android"
                    : "Unkowrn",
            "target": subscriptionType == SubscriptionType.Tradesperson
                ? "USER"
                : "PROPERTY_DETAIL",
            "targetId": propertyDetailID,
            "type": subscriptionType == SubscriptionType.Tradesperson
                ? "TRADESPERSON_SUBSCRIPTION"
                : "ADD_PROPERTY",
            "transactionReceipt": transactionReceipt,
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  // Switch Profile...
  Future<void> switchProfile(String roleId) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.switchProfie,
          parameter: {"roleId": roleId},
        ),
      );
      authModel = authModelFromJson(response);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
