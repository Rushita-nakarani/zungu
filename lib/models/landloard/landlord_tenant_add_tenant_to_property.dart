// To parse this JSON data, do
//
//     final landlordTenantAddTenantToPropertyModel = landlordTenantAddTenantToPropertyModelFromMap(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/utils/custom_extension.dart';

// import 'package:zungu_mobile/utils/custom_extension.dart';

class LandlordTenantAddTenantToPropertyModel {
  LandlordTenantAddTenantToPropertyModel({
    this.userId = "",
    this.tenancyId = "",
    this.fullName = "",
    this.email = "",
    this.mobile = "",
    this.rentAmount = 0,
    this.rentDueDate = 1,
    this.depositAmount = 0,
    this.depositScheme = "",
    this.depositId = "",
    this.startDate,
    this.endDate,
    this.propertyId = "",
    this.leaseUrl = "",
  });

  String userId;
  String tenancyId;
  String fullName;
  String email;
  String mobile;
  int rentAmount;
  int rentDueDate;
  int depositAmount;
  String depositScheme;
  String depositId;
  DateTime? startDate;
  DateTime? endDate;
  String propertyId;
  String leaseUrl;

  factory LandlordTenantAddTenantToPropertyModel.fromJson(String str) =>
      LandlordTenantAddTenantToPropertyModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LandlordTenantAddTenantToPropertyModel.fromMap(
    Map<String, dynamic> json,
  ) =>
      LandlordTenantAddTenantToPropertyModel(
        userId: json["userId"] ?? "",
        tenancyId: json["tenancyId"] ?? "",
        fullName: json["fullName"] ?? "",
        email: json["email"] ?? "",
        mobile: json["mobile"] ?? "",
        rentAmount: json["rentAmount"] ?? 0,
        rentDueDate: json["rentDueDate"] ?? DateTime.parse(json["rentDueDate"]),
        depositAmount: json["depositAmount"] ?? 0,
        depositScheme: json["depositScheme"] ?? "",
        depositId: json["depositId"] ?? "",
        startDate: json["startDate"] ?? DateTime.parse(json["startDate"]),
        endDate: json["endDate"] ?? DateTime.parse(json["endDate"]),
        propertyId: json["propertyId"] ?? "",
        leaseUrl: json["leaseUrl"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "tenancyId": tenancyId,
        "fullName": fullName,
        "email": email,
        "mobile": mobile,
        "rentAmount": rentAmount,
        "rentDueDate": rentDueDate,
        "depositAmount": depositAmount,
        "depositScheme": depositScheme,
        "depositId": depositId,
        "startDate": startDate,
        "endDate": endDate,
        "propertyId": propertyId,
        "leaseUrl": leaseUrl,
      };

  Map<String, dynamic> toNewTenantJson() {
    return {
      if (userId.isEmpty) ...{
        "fullName": fullName,
        if (email.isNotEmpty) "email": email,
        "mobile": mobile,
      } else ...{
        "userId": userId,
      },
      "rentAmount": rentAmount,
      "rentDueDate": rentDueDate,
      "depositAmount": depositAmount,
      "depositScheme": depositScheme,
      "depositId": depositId,
      "startDate": startDate?.toFilterDate,
      "endDate": endDate?.toFilterDate,
      "propertyId": propertyId,
      "leaseUrl": leaseUrl,
    };
  }

  Map<String, dynamic> toExistingTenantJson() {
    return {
      "tenancyId": tenancyId,
      if (userId.isEmpty) ...{
        "fullName": fullName,
        if (email.isNotEmpty) "email": email,
        "mobile": mobile,
      } else ...{
        "userId": userId,
      },
      "rentAmount": rentAmount,
      "rentDueDate": rentDueDate,
      "depositAmount": depositAmount,
      "depositScheme": depositScheme,
      "depositId": depositId,
      "startDate": startDate?.toFilterDate,
      "endDate": endDate?.toFilterDate,
      "propertyId": propertyId,
      "leaseUrl": leaseUrl,
    };
  }
}
