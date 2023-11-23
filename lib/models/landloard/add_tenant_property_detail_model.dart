// To parse this JSON data, do
//
//     final addTenantPropertiesDetailModel = addTenantPropertiesDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

AddTenantPropertiesDetailModel addTenantPropertiesDetailModelFromJson(
  String str,
) =>
    AddTenantPropertiesDetailModel.fromJson(defaultRespInfo(str).resultObj);

String addTenantPropertiesDetailModelToJson(
  AddTenantPropertiesDetailModel data,
) =>
    json.encode(data.toJson());

class AddTenantPropertiesDetailModel {
  AddTenantPropertiesDetailModel({
    required this.propertyDetail,
    this.property = const [],
    this.propertyId = "",
  });

  PropertyDetail propertyDetail;
  List<Property> property;
  String propertyId;

  factory AddTenantPropertiesDetailModel.fromJson(Map<String, dynamic> json) =>
      AddTenantPropertiesDetailModel(
        propertyDetail: PropertyDetail.fromJson(json["propertyDetail"]),
        property: List<Property>.from(
          json["property"].map((x) => Property.fromJson(x)),
        ),
        propertyId: json["propertyId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "propertyDetail": propertyDetail.toJson(),
        "property": List<dynamic>.from(property.map((x) => x.toJson())),
        "propertyId": propertyId,
      };
}

class Property {
  Property({
    this.id = "",
    this.status = "",
    this.propertyDetailId = "",
    this.roomType = "",
    this.roomName = "",
    this.tenancyDetail = const [],
    this.propertyType = "",
  });

  String id;
  String status;
  String propertyDetailId;
  String roomType;
  String roomName;
  List<dynamic> tenancyDetail;
  String propertyType;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["_id"] ?? "",
        status: json["status"] ?? "",
        propertyDetailId: json["propertyDetailId"] ?? "",
        roomType: json["roomType"] ?? "",
        roomName: json["roomName"] ?? "",
        tenancyDetail: List<dynamic>.from(json["tenancyDetail"].map((x) => x)),
        propertyType: json["propertyType"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "propertyDetailId": propertyDetailId,
        "roomType": roomType,
        "roomName": roomName,
        "tenancyDetail": List<dynamic>.from(tenancyDetail.map((x) => x)),
        "propertyType": propertyType,
      };
}

class PropertyDetail {
  PropertyDetail({
    this.id = "",
    this.name = "",
    this.addressDetail,
    this.photos = const [],
  });

  String id;
  String name;
  AddressDetail? addressDetail;
  List<String> photos;

  factory PropertyDetail.fromJson(Map<String, dynamic> json) => PropertyDetail(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        addressDetail: AddressDetail.fromJson(json["addressDetail"]),
        photos: List<String>.from(json["photos"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "addressDetail": addressDetail?.toJson(),
        "photos": List<dynamic>.from(photos.map((x) => x)),
      };
}

class AddressDetail {
  AddressDetail({
    this.fullAddress = "",
    this.addressLine1 = "",
    this.addressLine2 = "",
    this.addressLine3 = "",
    this.zipCode = "",
    this.city = "",
    this.state = "",
    this.country = "",
    this.type = "",
    this.typeId = "",
  });

  String fullAddress;
  String addressLine1;
  String addressLine2;
  String addressLine3;
  String zipCode;
  String city;
  String state;
  String country;
  String type;
  String typeId;

  factory AddressDetail.fromJson(Map<String, dynamic> json) => AddressDetail(
        fullAddress: json["fullAddress"] ?? "",
        addressLine1: json["addressLine1"] ?? "",
        addressLine2: json["addressLine2"] ?? "",
        addressLine3: json["addressLine3"] ?? "",
        zipCode: json["zipCode"] ?? "",
        city: json["city"] ?? "",
        state: json["state"] ?? "",
        country: json["country"] ?? "",
        type: json["type"] ?? "",
        typeId: json["typeId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "fullAddress": fullAddress,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "addressLine3": addressLine3,
        "zipCode": zipCode,
        "city": city,
        "state": state,
        "country": country,
        "type": type,
        "typeId": typeId,
      };
}
