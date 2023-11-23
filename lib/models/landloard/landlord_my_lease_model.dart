// To parse this JSON data, do
//
//     final landlordMyLeaseModel = landlordMyLeaseModelFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

import '../address_model.dart';

List<LandlordMyLeaseModel> landlordMyLeaseModelFromJson(String str) =>
    List<LandlordMyLeaseModel>.from(
      defaultRespInfo(str)
          .resultArray
          .map((x) => LandlordMyLeaseModel.fromJson(x)),
    );

String landlordMyLeaseModelToJson(List<LandlordMyLeaseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LandlordMyLeaseModel {
  LandlordMyLeaseModel({
    this.id = "",
    this.addressId = "",
    this.category = "",
    this.name = "",
    this.rent = 0,
    this.address,
    this.property = const [],
    this.photos = const [],
  });

  String id;
  String addressId;
  String category;
  String name;
  int rent;
  AddressModel? address;
  List<Property> property;
  List<String> photos;

  factory LandlordMyLeaseModel.fromJson(Map<String, dynamic> json) =>
      LandlordMyLeaseModel(
        id: json["_id"] ?? "",
        addressId: json["addressId"] ?? "",
        category: json["category"] ?? "",
        name: json["name"] ?? "",
        rent: json["rent"] ?? 0,
        address: (json["address"] == null)
            ? null
            : AddressModel.fromJson(json["address"]),
        property: List<Property>.from(
          json["property"].map((x) => Property.fromJson(x)),
        ),
        photos: List<String>.from(json["photos"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "addressId": addressId,
        "category": category,
        "name": name,
        "rent": rent,
        "address": address?.toJson(),
        "property": List<dynamic>.from(property.map((x) => x.toJson())),
        "photos": List<dynamic>.from(photos.map((x) => x)),
      };
}

class Property {
  Property({
    this.id = "",
    this.roomName = "",
    this.rentAmount = 0,
    this.tenants = const [],
  });

  String id;
  String roomName;
  int rentAmount;
  List<Tenant> tenants;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["_id"] ?? "",
        roomName: json["roomName"] ?? "",
        rentAmount: json["rentAmount"] ?? 0,
        tenants: (json["tenants"] == null)
            ? []
            : List<Tenant>.from(json["tenants"].map((x) => Tenant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "roomName": roomName,
        "rentAmount": rentAmount,
        "tenants": List<dynamic>.from(tenants.map((x) => x.toJson())),
      };
}

class Tenant {
  Tenant({
    this.id = "",
    this.roomName = "",
    this.profileImg = "",
    this.rentAmount = 0,
    this.fullName = "",
    this.leases = const [],
  });

  String fullName;
  String id;
  String roomName;
  String profileImg;
  int rentAmount;
  List<Lease> leases;

  factory Tenant.fromJson(Map<String, dynamic> json) => Tenant(
        id: json["_id"] ?? "",
        roomName: json["roomName"] ?? "",
        profileImg: json["profileImg"] ?? "",
        rentAmount: json["rentAmount"] ?? 0,
        fullName: json["fullName"] ?? "",
        leases: (json["leases"] == null)
            ? []
            : List<Lease>.from(json["leases"].map((x) => Lease.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "roomName": roomName,
        "profileImg": profileImg,
        "rentAmount": rentAmount,
        "fullName": fullName,
        "leases": List<dynamic>.from(leases.map((x) => x.toJson())),
      };
}

class Lease {
  Lease({
    this.id = "",
    this.rentAmount = 0,
    this.fullName = "",
    this.leaseUrl = "",
    this.startDate,
    this.endDate,
    this.isExpired = false,
  });

  String id;
  int rentAmount;
  String fullName;
  String leaseUrl;
  DateTime? startDate;
  DateTime? endDate;
  bool isExpired;

  factory Lease.fromJson(Map<String, dynamic> json) => Lease(
        id: json["_id"] ?? "",
        rentAmount: json["rentAmount"] ?? 0,
        fullName: json["fullName"] ?? "",
        leaseUrl: json["leaseUrl"] ?? "",
        startDate: (json["startDate"] == null)
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            (json["endDate"] == null) ? null : DateTime.parse(json["endDate"]),
        isExpired: json["isExpired"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "rentAmount": rentAmount,
        "fullName": fullName,
        "leaseUrl": leaseUrl,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "isExpired": isExpired,
      };
}
