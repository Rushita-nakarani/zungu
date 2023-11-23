import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';

import '../../utils/generic_enum.dart';
import '../api_response_obj.dart';

AuthModel authModelFromJson(String str) =>
    AuthModel.fromJson(defaultRespInfo(str).resultObj);

String authModelToJson(AuthModel data) => json.encode(data.toJson());

// UserInfo from stored json...
AuthModel? userInfoFromStoredJson(String str) => str.isEmpty
    ? null
    : AuthModel.fromJson(
        json.decode(str),
      );

class AuthModel {
  AuthModel({
    this.userId = "",
    this.token = "",
    this.email = "",
    this.fullName = "",
    this.mobile = "",
    this.id = "",
    this.oldPassword = "",
    this.newPassword = "",
    this.password = "",
    this.otp = "",
    this.type = 1,
    this.profileImg = "",
    this.profile,
  });

  String id;
  String fullName;
  String profileImg;
  String email;
  String userId;
  String token;
  String mobile;
  String password;
  String oldPassword;
  String newPassword;
  String otp;
  int type;
  ProfileModel? profile;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        userId: json["userId"] ?? "",
        token: json["token"] ?? "",
        id: json['id'] ?? "",
        profileImg: json['profileImg'] ?? "",
        fullName: json['fullName'] ?? "",
        mobile: json['mobile'] ?? "",
        oldPassword: json['oldPassword'] ?? "",
        newPassword: json['newPassword'] ?? "",
        password: json['password'] ?? "",
        email: json['email'] ?? "",
        otp: json['otp'] ?? "",
        profile: json["profile"] == null
            ? null
            : ProfileModel.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "token": token,
        "id": id,
        "profileImg": profileImg,
        "fullName": fullName,
        "mobile": mobile,
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "password": password,
        "email": email,
        "otp": otp,
        "profile": profile?.toJson(),
      };

  Map<String, dynamic> toLoginJson() => {
        "mobile": mobile,
        "password": password,
      };

  Map<String, dynamic> toGenrateOTPJson() => {
        "fullName": fullName,
        "mobile": mobile,
        "type": type,
      };

  Map<String, dynamic> toSignUpJson() => {
        "id": id,
        "mobile": mobile,
        "password": password,
        "confirmPassword": newPassword,
        "fullName": fullName,
      };

  Map<String, dynamic> toForgotPasswordJson() => {
        "id": id,
        "password": password,
      };

  Map<String, dynamic> toVerfiyOTPJson() => {
        "token": token,
        "otp": otp,
      };

  Map<String, dynamic> toChangePasswordJson() => {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      };

  Map<String, dynamic> getUserData() => {
        "userId": userId,
      };

  Map<String, dynamic> toNumberChangeJson() => {"id": id, "mobile": mobile};
}

class ProfileModel {
  ProfileModel({
    this.roleId = "",
    this.userRole = UserRole.None,
    this.profileCompleted = false,
    this.isActive = false,
    this.isSubscribed = false,
  });

  String roleId;
  UserRole userRole;
  bool profileCompleted;
  bool isActive;
  bool isSubscribed;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        roleId: json["roleId"] ?? "",
        profileCompleted: json['profileCompleted'] ?? false,
        isActive: json['isActive'] ?? false,
        isSubscribed: json['isSubscribed'] ?? false,
        userRole: GenericEnum<UserRole>().getEnumValue(
          key: json["roleName"],
          enumValues: UserRole.values,
          defaultEnumValue: UserRole.None,
        ),
      );

  Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "roleName": describeEnum(userRole),
        "profileCompleted": profileCompleted,
        "isActive": isActive,
        "isSubscribed": isSubscribed,
      };
}
