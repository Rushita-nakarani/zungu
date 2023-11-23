import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';
import 'package:zungu_mobile/models/settings/business_profile/fetch_profile_model.dart';

import '../../address_model.dart';

List<UserProfileModel> userProfileModelFromJson(String str) =>
    List<UserProfileModel>.from(
      defaultRespInfo(str).resultArray.map((x) => UserProfileModel.fromJson(x)),
    );

String userProfileModelToJson(List<UserProfileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserProfileModel {
  UserProfileModel({
    this.countryCode = "",
    this.createdBy = "",
    this.updatedBy = "",
    this.isDeleted = false,
    this.id = "",
    this.mobile = "",
    this.fullName = "",
    this.v = 0,
    this.createdOn,
    this.updatedOn,
    this.lastProfile = "",
    this.address,
    this.email = "",
    this.addressId = "",
    this.userId = "",
    this.profileImg = "",
    this.notificationCount = 0,
  });

  String countryCode;
  String createdBy;
  String updatedBy;
  bool isDeleted;
  String id;
  String mobile;
  String fullName;
  int v;
  DateTime? createdOn;
  DateTime? updatedOn;
  String lastProfile;
  String userId;
  String profileImg;
  String email;
  String addressId;
  AddressModel? address;
  int notificationCount;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        countryCode: json["countryCode"] ?? "",
        createdBy: json["createdBy"] ?? "",
        updatedBy: json["updatedBy"] ?? "",
        isDeleted: json["isDeleted"] ?? false,
        id: json["_id"] ?? "",
        mobile: json["mobile"] ?? "",
        fullName: json["fullName"] ?? "",
        profileImg: (json['profileImg']?.isEmpty ?? true)
            ? (json['user'] != null ? (json['user']['profileImg'] ?? "") : "")
            : (json['profileImg'] ?? ""),
        v: json["__v"] ?? 0,
        notificationCount: json['notificationCount'] ?? 0,
        createdOn: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedOn: json["createdAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        lastProfile: json["lastProfile"] ?? "",
        email: json["email"] ?? "",
        address: json["addressId"] == null
            ? null
            : AddressModel.fromJson(json["addressId"]),
      );

  Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "isDeleted": isDeleted,
        "_id": id,
        "mobile": mobile,
        "fullName": fullName,
        "__v": v,
        "createdAt": createdOn?.toIso8601String(),
        "updatedAt": updatedOn?.toIso8601String(),
        "lastProfile": lastProfile,
        "profileImg": profileImg,
        "notificationCount": notificationCount
      };

  Map<String, dynamic> userUpdateJson() => {
        "userId": userId,
        "countryCode": countryCode,
        "mobile": mobile,
        "fullName": fullName,
        // "lastProfile": lastProfile,
        "email": email,
        "address": {
          "addressLine1": address?.addressLine1,
          "addressLine2": address?.addressLine2,
          "addressLine3": address?.addressLine3,
          "zipCode": address?.zipCode,
          "city": address?.city,
          "state": address?.state,
          "country": address?.country,
          "fullAddress": address?.fullAddress,
        },
        "profileImg": profileImg
      };
}
