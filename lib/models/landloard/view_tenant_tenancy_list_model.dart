// To parse this JSON data, do
//
//     final viewTenantTenancyListModel = viewTenantTenancyListModelFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/address_model.dart';
import 'package:zungu_mobile/models/landloard/property_detail_model.dart';

import '../../constant/string_constants.dart';

ViewTenantTenancyListModel viewTenantTenancyListModelFromJson(
  Map<String, dynamic> str,
) =>
    ViewTenantTenancyListModel.fromJson(str);

String viewTenantTenancyListModelToJson(ViewTenantTenancyListModel data) =>
    json.encode(data.toJson());

class ViewTenantTenancyListModel {
  ViewTenantTenancyListModel({
    this.propertyDetailId = "",
    this.roomName = "",
    this.tenancyId = "",
    this.rentAmount = 0,
    this.depositScheme,
    this.depositAmount = 0,
    this.renewalDate,
    this.leaseUrl = "",
    this.fullName = "",
    this.mobile = "",
    this.email = "",
    this.address,
    this.category,
    this.profileImg = "",
  });

  String propertyDetailId;
  String roomName;
  String tenancyId;
  int rentAmount;
  DepositScheme? depositScheme;
  int depositAmount;
  DateTime? renewalDate;
  String leaseUrl;
  String fullName;
  String mobile;
  String email;
  AddressModel? address;
  Category? category;
  String profileImg;

  // getters and setters
  String get createFullAddress =>
      "${address?.addressLine1}, ${address?.addressLine2}";

  String get createRentAmount => "${StaticString.currency}$rentAmount";
  String get createDepositPaid => "${StaticString.currency}$depositAmount";

  factory ViewTenantTenancyListModel.fromJson(Map<String, dynamic> json) =>
      ViewTenantTenancyListModel(
        propertyDetailId: json["propertyDetailId"] ?? "",
        roomName: json["roomName"] ?? '',
        tenancyId: json["tenancyId"] ?? "",
        rentAmount: json["rentAmount"] ?? 0,
        depositScheme: json["depositScheme"] == null
            ? null
            : DepositScheme.fromJson(json["depositScheme"]),
        depositAmount: json["depositAmount"] ?? 0,
        renewalDate: (json["renewalDate"]?.isEmpty ?? true)
            ? null
            : DateTime.parse(json["renewalDate"]),
        leaseUrl: json["leaseUrl"] ?? "",
        fullName: json["fullName"] ?? "",
        mobile: json["mobile"] ?? "",
        email: json["email"] ?? "",
        address: json["address"] == null
            ? null
            : AddressModel.fromJson(json["address"]),
        category: Category(),
        profileImg: json["profileImg"] ?? "",
        // category: Category.fromJson(json["category"] ?? ""),
      );

  Map<String, dynamic> toJson() => {
        "propertyDetailId": propertyDetailId,
        "roomName": roomName,
        "tenancyId": tenancyId,
        "rentAmount": rentAmount,
        "depositScheme": depositScheme,
        "depositAmount": depositAmount,
        "renewalDate": renewalDate?.toIso8601String(),
        "leaseUrl": leaseUrl,
        "fullName": fullName,
        "mobile": mobile,
        "email": email,
        "address": address?.toJson(),
        "category": category?.toJson(),
        "profileImg": profileImg,
      };
}

class Category {
  Category({
    this.name = "",
  });

  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

// class DepositScheme {
//   DepositScheme({
//     this.id = "",
//     this.attributeType = "",
//     this.attributeValue = "",
//     this.isDeleted = false,
//     this.v = 0,
//     this.isActive = false,
//     this.createdAt,
//     this.updatedAt,
//   });

//   String id;
//   String attributeType;
//   String attributeValue;
//   bool isDeleted;
//   int v;
//   bool isActive;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   factory DepositScheme.fromJson(Map<String, dynamic> json) => DepositScheme(
//         id: json["_id"],
//         attributeType: json["attributeType"],
//         attributeValue: json["attributeValue"],
//         isDeleted: json["isDeleted"] ?? false,
//         v: json["__v"],
//         isActive: json["isActive"] ?? false,
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "attributeType": attributeType,
//         "attributeValue": attributeValue,
//         "isDeleted": isDeleted,
//         "__v": v,
//         "isActive": isActive,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//       };
// }
