import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth/auth_model.dart';

class SharedPreferencesHelper {
  SharedPreferencesHelper._();
  static SharedPreferencesHelper instance = SharedPreferencesHelper._();
  // Shared Preference Keys
  static const String _kUserInfo = 'user_info';
  static const String _kOnBoarding = 'on_boarding';

  // Variables...
  AuthModel? _userInfo;
  bool _isShowOnBoarding = false;

  late SharedPreferences _prefs;

  // Load saved data...
  Future<void> loadSavedData() async {
    _prefs = await SharedPreferences.getInstance();
    _getUserDetail();
  }

  //!------------------------------------------------- Setter --------------------------------------------------//

  // Set UserInfo...
  set setUserInfo(
    AuthModel? userInfo,
  ) {
    _userInfo = userInfo;
    //  _userLoginModel = userLoginModel;
    if (userInfo == null) {
      removeCacheData();
    } else {
      _prefs.setString(_kUserInfo, authModelToJson(userInfo));
    }
  }

  set isShowOnBoarding(bool value) {
    _isShowOnBoarding = value;
    _prefs.setBool(_kOnBoarding, _isShowOnBoarding);
  }

//!------------------------------------------------- Getter --------------------------------------------------//

  // User detail...
  AuthModel? get getUserInfo => _userInfo;

  // User detail...
  AuthModel? _getUserDetail() {
    final String userInfo = _prefs.getString(_kUserInfo) ?? "";
    _userInfo = userInfo.isEmpty ? null : userInfoFromStoredJson(userInfo);
    return getUserInfo;
  }

  bool get isShowOnBoarding => _prefs.getBool(_kOnBoarding) ?? false;

//!----------------------------------------------- Remove Cache Data --------------------------------------------------//
  // Remove Cache Data (Use only when user wants to remove all store data on app)...
  Future<bool> removeCacheData() async {
    return _prefs.remove(_kUserInfo);
  }
}
