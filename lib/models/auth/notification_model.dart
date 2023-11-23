// To parse this JSON data, do
//
//     final NotificationScreenModel = NotificationScreenModelFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

import '../settings/business_profile/fetch_profile_model.dart';

NotificationScreenModel notificationScreenModelFromJson(String str) =>
    NotificationScreenModel.fromJson(defaultRespInfo(str).resultObj);

String notificationScreenModelToJson(NotificationScreenModel data) =>
    json.encode(data.toJson());

class NotificationScreenModel {
  NotificationScreenModel({
    this.unreadCount,
    this.count = 0,
    this.page = 0,
    this.size = 0,
    this.data = const [],
  });

  Map<String, dynamic>? unreadCount;
  int count;
  int page;
  int size;
  List<NotificationDatum> data;

  factory NotificationScreenModel.fromJson(Map<String, dynamic> json) =>
      NotificationScreenModel(
        unreadCount: json["unreadCount"],
        count: json["count"] ?? 0,
        page: json["page"] ?? 0,
        size: json["size"] ?? 0,
        data: (json["data"] == null)
            ? []
            : List<NotificationDatum>.from(
                json["data"].map((x) => NotificationDatum.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "unreadCount": unreadCount,
        "count": count,
        "page": page,
        "size": size,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class NotificationDatum {
  NotificationDatum({
    this.isRead = false,
    this.isAppNotication = false,
    this.isDeleted = false,
    this.createdBy = "",
    this.updatedBy = "",
    this.id = "",
    this.recordId,
    this.profileId = "",
    this.type = "",
    this.label = "",
    this.title = "",
    this.headLine = "",
    this.imgUrl = "",
    this.userId = "",
    this.v = 0,
    this.createdAt,
    this.updatedAt,
  });

  bool isRead;
  bool isAppNotication;
  bool isDeleted;
  String createdBy;
  String updatedBy;
  String id;
  ProfileId? recordId;
  String profileId;
  String type;
  String label;
  String title;
  String headLine;
  String imgUrl;
  String userId;
  int v;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NotificationDatum.fromJson(Map<String, dynamic> json) =>
      NotificationDatum(
        isRead: json["isRead"] ?? false,
        isAppNotication: json["isAppNotication"] ?? false,
        isDeleted: json["isDeleted"] ?? false,
        createdBy: json["createdBy"] ?? "",
        updatedBy: json["updatedBy"] ?? "",
        id: json["_id"] ?? "",
        recordId: (json["recordId"] == null)
            ? null
            : ProfileId.fromJson(json["recordId"]),
        profileId: json["profileId"] ?? "",
        type: json["type"] ?? "",
        label: json["label"] ?? "",
        title: json["title"] ?? "",
        headLine: json["headLine"] ?? "",
        imgUrl: json["imgUrl"] ?? "",
        userId: json["userId"] ?? "",
        v: json["__v"] ?? 0,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "isRead": isRead,
        "isAppNotication": isAppNotication,
        "isDeleted": isDeleted,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "_id": id,
        "recordId": recordId?.toJson(),
        "profileId": profileId,
        "type": type,
        "label": label,
        "title": title,
        "headLine": headLine,
        "imgUrl": imgUrl,
        "userId": userId,
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class ProfileId {
  ProfileId({
    this.profileCompleted = false,
    this.createdBy = "",
    this.updatedBy = "",
    this.isActive = false,
    this.isDeleted = false,
    this.id = "",
    this.roleId = "",
    this.userId = "",
    this.mobile = "",
    this.fullName = "",
    this.businessId = "",
    this.tradingName = "",
    this.companyReg = "",
    this.registrationNumber = "",
    this.vatNumber = "",
    this.email = "",
    this.orgWebUrl = "",
    this.addressId = "",
    this.companyLogo = "",
    this.myLocation,
    this.tradeServiceId,
    this.latePaymentFee,
    this.v = 0,
    this.createdAt,
    this.updatedAt,
    this.profileImg = "",
  });

  bool profileCompleted;
  String createdBy;
  String updatedBy;
  bool isActive;
  bool isDeleted;
  String id;
  String roleId;
  String userId;
  String mobile;
  String fullName;
  String businessId;
  String tradingName;
  String companyReg;
  String registrationNumber;
  String vatNumber;
  String email;
  String orgWebUrl;
  String addressId;
  String companyLogo;
  MyLocation? myLocation;
  dynamic tradeServiceId;
  dynamic latePaymentFee;
  int v;
  DateTime? createdAt;
  DateTime? updatedAt;
  String profileImg;

  factory ProfileId.fromJson(Map<String, dynamic> json) => ProfileId(
        profileCompleted: json["profileCompleted"] ?? false,
        createdBy: json["createdBy"] ?? "",
        updatedBy: json["updatedBy"] ?? "",
        isActive: json["isActive"] ?? false,
        isDeleted: json["isDeleted"] ?? false,
        id: json["_id"] ?? "",
        roleId: json["roleId"] ?? "",
        userId: json["userId"] ?? "",
        mobile: json["mobile"] ?? "",
        fullName: json["fullName"] ?? "",
        businessId: json["businessId"] ?? "",
        tradingName: json["tradingName"] ?? "",
        companyReg: json["companyReg"] ?? "",
        registrationNumber: json["registrationNumber"] ?? "",
        vatNumber: json["vatNumber"] ?? "",
        email: json["email"] ?? "",
        orgWebUrl: json["orgWebUrl"] ?? "",
        addressId: json["addressId"] ?? "",
        companyLogo: json["companyLogo"] ?? "",
        myLocation: (json["myLocation"] == null)
            ? null
            : MyLocation.fromJson(json["myLocation"]),
        tradeServiceId: json["tradeServiceId"],
        latePaymentFee: json["latePaymentFee"],
        v: json["__v"] ?? 0,
        createdAt: (json["createdAt"] == null)
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: (json["updatedAt"] == null)
            ? null
            : DateTime.parse(json["updatedAt"]),
        profileImg: json["profileImg"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "profileCompleted": profileCompleted,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
        "roleId": roleId,
        "userId": userId,
        "mobile": mobile,
        "fullName": fullName,
        "businessId": businessId,
        "tradingName": tradingName,
        "companyReg": companyReg,
        "registrationNumber": registrationNumber,
        "vatNumber": vatNumber,
        "email": email,
        "orgWebUrl": orgWebUrl,
        "addressId": addressId,
        "companyLogo": companyLogo,
        "myLocation": myLocation?.toJson(),
        "tradeServiceId": tradeServiceId,
        "latePaymentFee": latePaymentFee,
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "profileImg": profileImg,
      };
}
