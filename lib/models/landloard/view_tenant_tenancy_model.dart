// To parse this JSON data, do
//
//     final viewTenantTenancyModel = viewTenantTenancyModelFromJson(jsonString);

import 'dart:convert';

ViewTenantTenancyModel viewTenantTenancyModelFromJson(
  Map<String, dynamic> str,
) =>
    ViewTenantTenancyModel.fromJson(str);

String viewTenantTenancyModelToJson(ViewTenantTenancyModel data) =>
    json.encode(data.toJson());

class ViewTenantTenancyModel {
  ViewTenantTenancyModel({
    this.photos = const [],
    this.isDeleted = false,
    this.createdBy = "",
    this.updatedBy = "",
    this.id = "",
    this.isExistingUser = false,
    this.mobile = "",
    this.fullName = "",
    this.email = "",
    this.rentAmount = 0,
    this.rentDueDate,
    this.depositAmount = 0,
    this.depositScheme = "",
    this.depositId = "",
    this.startDate,
    this.endDate,
    this.leaseUrl = "",
    this.propertyId = "",
    this.tenantId = "",
    this.userId = "",
    this.profileImg = "",
    this.type = 0,
    this.status = "",
    this.v = 0,
    this.createdAt,
    this.updatedAt,
  });

  List<String> photos;
  bool isDeleted;
  String createdBy;
  String updatedBy;
  String id;
  bool isExistingUser;
  String mobile;
  String fullName;
  String email;
  int rentAmount;
  DateTime? rentDueDate;
  int depositAmount;
  String depositScheme;
  String depositId;
  DateTime? startDate;
  DateTime? endDate;
  String leaseUrl;
  String propertyId;
  String tenantId;
  String userId;
  String profileImg;
  int type;
  String status;
  int v;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ViewTenantTenancyModel.fromJson(Map<String, dynamic> json) =>
      ViewTenantTenancyModel(
        photos: List<String>.from(json["photos"].map((x) => x)),
        isDeleted: json["isDeleted"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        id: json["_id"],
        isExistingUser: json["isExistingUser"] ?? false,
        mobile: json["mobile"],
        fullName: json["fullName"],
        email: json["email"],
        rentAmount: json["rentAmount"],
        rentDueDate: DateTime.parse(json["rentDueDate"]),
        depositAmount: json["depositAmount"],
        depositScheme: json["depositScheme"],
        depositId: json["depositId"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        leaseUrl: json["leaseUrl"] ?? "",
        propertyId: json["propertyId"] ?? "",
        tenantId: json["tenantId"] ?? "",
        userId: json["userId"] ?? "",
        profileImg: json["profileImg"] ?? "",
        type: json["type"],
        status: json["status"],
        v: json["__v"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "isDeleted": isDeleted,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "_id": id,
        "isExistingUser": isExistingUser,
        "mobile": mobile,
        "fullName": fullName,
        "email": email,
        "rentAmount": rentAmount,
        "rentDueDate": rentDueDate?.toIso8601String(),
        "depositAmount": depositAmount,
        "depositScheme": depositScheme,
        "depositId": depositId,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "leaseUrl": leaseUrl,
        "propertyId": propertyId,
        "tenantId": tenantId,
        "userId": userId,
        "profileImg": profileImg,
        "type": type,
        "status": status,
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
