// To parse this JSON data, do
//
//     final propertiesDetailModel = propertiesDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:zungu_mobile/models/landloard/room_attribute_model.dart';
import 'package:zungu_mobile/models/settings/personal_profile/user_profile_model.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';

import '../../utils/generic_enum.dart';
import '../address_model.dart';
import '../api_response_obj.dart';
import '../submit_property_detail_model.dart';

List<PropertiesDetailModel> propertiesDetailModelFromJson(String str) =>
    List<PropertiesDetailModel>.from(
      defaultRespInfo(str)
          .resultArray
          .map((x) => PropertiesDetailModel.fromJson(x)),
    );

String propertiesDetailModelToJson(List<PropertiesDetailModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PropertiesDetailModel {
  PropertiesDetailModel({
    this.id = "",
    this.addressId = "",
    this.bathRoom = 0,
    this.bedRoom = 0,
    this.disabledFriendly = false,
    this.livingRoom = 0,
    this.name = "",
    this.address,
    this.property = const [],
    this.photos = const [],
    this.videos = const [],
    this.floorPlan = const [],
    this.additionalAttributes = const [],
    this.category = "",
    this.createdBy = "",
    this.description = "",
    this.features = const [],
    this.floorSize = 0,
    this.furnishing = "",
    this.isDeleted = false,
    this.petAllowed = false,
    this.pps = 0,
    this.realEstate = "",
    this.rent = 0,
    this.roomAttributeModelId = 0,
    this.updatedBy = "",
    this.classId = "",
    this.serviceType = "",
    this.type = "",
  });

  String id;
  List<String> features;
  bool isDeleted;
  int roomAttributeModelId;
  List<RoomAttributeModel> additionalAttributes;
  String classId;
  String serviceType;
  String createdBy;
  String updatedBy;
  String addressId;
  int bathRoom;
  int bedRoom;
  String category;
  String description;
  bool disabledFriendly;
  String type;
  String furnishing;
  int livingRoom;
  String name;
  bool petAllowed;
  String realEstate;
  double rent;
  double floorSize;
  double pps;
  AddressModel? address;
  List<Property> property;
  List<String> photos;
  List<String> videos;
  List<FloorPlan> floorPlan;

  factory PropertiesDetailModel.fromJson(Map<String, dynamic> json) =>
      PropertiesDetailModel(
        features: json["features"] == null
            ? []
            : List<String>.from(json["features"].map((x) => x)),
        isDeleted: json["isDeleted"] ?? false,
        roomAttributeModelId: json["id"] ?? 0,
        additionalAttributes: json["additional_attributes"] == null
            ? []
            : List<RoomAttributeModel>.from(
                json["additional_attributes"]
                    .map((x) => RoomAttributeModel.fromJson(x)),
              ),
        type: json['type'] ?? "",
        createdBy: json["createdBy"] ?? "",
        updatedBy: json["updatedBy"] ?? "",
        category: json["category"] ?? "",
        description: json["description"] ?? "",
        rent: double.parse((json["rent"] ?? 0).toString()),
        floorSize: double.parse((json["floorSize"] ?? 0).toString()),
        pps: double.parse((json["pps"] ?? 0).toString()),
        furnishing: json["furnishing"] ?? "",
        petAllowed: json["petAllowed"] ?? false,
        realEstate: json["realEstate"] ?? "",
        id: json["_id"] ?? "",
        serviceType: json['serviceType'] ?? "",
        classId: json['class'] ?? "",
        addressId: json["addressId"] ?? "",
        bathRoom: json["bathRoom"] ?? 0,
        bedRoom: json["bedRoom"] ?? 0,
        disabledFriendly: json["disabledFriendly"] ?? false,
        livingRoom: json["livingRoom"] ?? 0,
        name: json["name"] ?? "",
        address: (json["address"] == null)
            ? null
            : AddressModel.fromJson(json["address"]),
        property: json["property"] == null
            ? []
            : List<Property>.from(
                json["property"].map((x) => Property.fromJson(x)),
              ),
        photos: json["photos"] == null
            ? []
            : List<String>.from(json["photos"].map((x) => x)),
        videos: json["videos"] == null
            ? []
            : List<String>.from(json["videos"].map((x) => x)),
        floorPlan: json["floorPlan"] == null
            ? []
            : List<FloorPlan>.from(
                json["floorPlan"].map((x) => FloorPlan.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "addressId": addressId,
        "bathRoom": bathRoom,
        "bedRoom": bedRoom,
        "disabledFriendly": disabledFriendly,
        "livingRoom": livingRoom,
        "name": name,
        "address": address?.toJson(),
        "property": List<dynamic>.from(property.map((x) => x.toJson())),
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "videos": List<dynamic>.from(videos.map((x) => x)),
        "floorPlan": List<dynamic>.from(floorPlan.map((x) => x.toJson())),
      };
  String get firstaddress =>
      "${address?.addressLine1} ${address?.addressLine2}";
}

class Property {
  Property({
    this.id = "",
    this.status = "",
    this.roomName = "",
    this.tenants = const [],
  });

  String id;
  String status;
  String roomName;
  List<Tenant> tenants;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["_id"] ?? "",
        status: json["status"] ?? "",
        roomName: json["roomName"] ?? "",
        tenants: json["tenants"] == null
            ? []
            : List<Tenant>.from(json["tenants"].map((x) => Tenant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "roomName": roomName,
        "tenants": List<dynamic>.from(tenants.map((x) => x.toJson())),
      };
}

class Tenant {
  Tenant({
    this.status = TenantStatus.None,
    this.tenancies = const [],
  });

  TenantStatus status;
  List<Tenancy> tenancies;

  factory Tenant.fromJson(Map<String, dynamic> json) => Tenant(
        status: GenericEnum<TenantStatus>().getEnumValue(
          key: json["status"],
          enumValues: TenantStatus.values,
          defaultEnumValue: TenantStatus.None,
        ),
        tenancies: json["tenancies"] == null
            ? []
            : List<Tenancy>.from(
                json["tenancies"].map((x) => Tenancy.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "tenancies": List<dynamic>.from(tenancies.map((x) => x.toJson())),
      };
}

class Tenancy {
  Tenancy({
    this.id = "",
    this.propertyStatus = "",
    this.roomName = "",
    this.photos = const [],
    this.rentAmount = 0,
    this.rentDueDate,
    this.depositAmount = 0,
    this.depositScheme,
    this.depositId = "",
    this.startDate,
    this.endDate,
    this.propertyId = "",
    this.tenantId = "",
    this.type = 0,
    this.status = TenantStatus.None,
    this.profile,
    this.leaseUrl = "",
    this.leaseId = "",
  });

  String id;
  String propertyStatus;
  String roomName;
  List<String> photos;
  int rentAmount;
  DateTime? rentDueDate;
  int depositAmount;
  DepositScheme? depositScheme;
  String depositId;
  DateTime? startDate;
  DateTime? endDate;
  String propertyId;
  String tenantId;
  int type;
  TenantStatus status;
  UserProfileModel? profile;
  String leaseUrl;
  String leaseId;

  factory Tenancy.fromJson(Map<String, dynamic> json) => Tenancy(
        id: json["_id"] ?? 0,
        photos: (json["photos"] == null)
            ? []
            : List<String>.from(json["photos"].map((x) => x)),
        rentAmount: json["rentAmount"] ?? 0,
        leaseUrl: json["leaseUrl"] ?? "",
        leaseId: json["leaseId"] ?? "",
        rentDueDate: json["rentDueDate"] == null
            ? null
            : DateTime.parse(json["rentDueDate"]),
        depositAmount: json["depositAmount"] ?? 0,
        depositScheme: json["depositScheme"] == null
            ? null
            : DepositScheme.fromJson(json["depositScheme"]),
        depositId: json["depositId"] ?? "",
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        propertyId: json["propertyId"] ?? "",
        tenantId: json["tenantId"] ?? "",
        type: json["type"] ?? 0,
        status: GenericEnum<TenantStatus>().getEnumValue(
          key: json["status"],
          enumValues: TenantStatus.values,
          defaultEnumValue: TenantStatus.None,
        ),
        profile: json["profile"] == null
            ? null
            : UserProfileModel.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "leaseUrl": leaseUrl,
        "leaseId": leaseId,
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "rentAmount": rentAmount,
        "rentDueDate": rentDueDate?.toIso8601String(),
        "depositAmount": depositAmount,
        "depositScheme": depositScheme,
        "depositId": depositId,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "propertyId": propertyId,
        "tenantId": tenantId,
        "type": type,
        "status": describeEnum(status),
        "profile": profile?.toJson(),
      };
}

class DepositScheme {
  DepositScheme({
    this.id = "",
    this.attributeType = "",
    this.attributeValue = "",
    this.isDeleted = false,
    this.v = 0,
    this.isActive = false,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String attributeType;
  String attributeValue;
  bool isDeleted;
  int v;
  bool isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DepositScheme.fromJson(Map<String, dynamic> json) => DepositScheme(
        id: json["_id"] ?? "",
        attributeType: json["attributeType"] ?? "",
        attributeValue: json["attributeValue"] ?? "",
        isDeleted: json["isDeleted"] ?? false,
        v: json["__v"] ?? 0,
        isActive: json["isActive"] ?? false,
        createdAt: (json["createdAt"] == null)
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: (json["updatedAt"] == null)
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "attributeType": attributeType,
        "attributeValue": attributeValue,
        "isDeleted": isDeleted,
        "__v": v,
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
// To parse this JSON data, do
//
//     final propertyfilterModel = propertyfilterModelFromJson(jsonString);

PropertyfilterModel propertyfilterModelFromJson(String str) =>
    PropertyfilterModel.fromJson(json.decode(str));

String propertyfilterModelToJson(PropertyfilterModel data) =>
    json.encode(data.toJson());

class PropertyfilterModel {
  PropertyfilterModel({
    this.category = const [],
    this.type = const [],
    this.lettingStatus = const [],
    this.features = const [],
    this.furnishing = const [],
    this.propertyfilterModelClass = const [],
    this.serviceType = "",
    this.bathRoom = 0,
    this.bedRoom = 0,
    this.livingRoom = 0,
    this.rentAmountLte = 0,
    this.rentAmountGte = 0,
    this.floorSizeLte,
    this.floorSizeGte,
    this.ppsLte,
    this.ppsGte,
    this.disabledFriendly = false,
    this.petAllowed = false,
    this.leaseEnding = false,
    this.isDeleted = false,
  });

  List<String> category;
  List<String> type;
  List<String> lettingStatus;
  List<String> features;
  List<String> furnishing;
  List<String> propertyfilterModelClass;
  String serviceType;
  int bathRoom;
  int bedRoom;
  int livingRoom;
  int rentAmountLte;
  int rentAmountGte;
  int? floorSizeLte;
  int? floorSizeGte;
  int? ppsLte;
  int? ppsGte;
  bool disabledFriendly;
  bool petAllowed;
  bool leaseEnding;
  bool isDeleted;

  factory PropertyfilterModel.fromJson(Map<String, dynamic> json) =>
      PropertyfilterModel(
        category: (json["category"] == null)
            ? []
            : List<String>.from(json["category"].map((x) => x)),
        type: (json["type"] == null)
            ? []
            : List<String>.from(json["type"].map((x) => x)),
        lettingStatus: (json["lettingStatus"] == null)
            ? []
            : List<String>.from(json["lettingStatus"].map((x) => x)),
        features: (json["features"] == null)
            ? []
            : List<String>.from(json["features"].map((x) => x)),
        furnishing: (json["furnishing"] == null)
            ? []
            : List<String>.from(json["furnishing"].map((x) => x)),
        propertyfilterModelClass:
            List<String>.from(json["class"].map((x) => x)),
        serviceType: json["serviceType"] ?? "",
        bathRoom: json["bathRoom"] ?? 0,
        bedRoom: json["bedRoom"] ?? 0,
        livingRoom: json["livingRoom"] ?? 0,
        rentAmountLte: json["rentAmount_lte"] ?? 0,
        rentAmountGte: json["rentAmount_gte"] ?? 0,
        floorSizeLte: json["floorSize_lte"] ?? 0,
        floorSizeGte: json["floorSize_gte"] ?? 0,
        ppsLte: json["pps_lte"] ?? 0,
        ppsGte: json["pps_gte"] ?? 0,
        disabledFriendly: json["disabledFriendly"] ?? false,
        petAllowed: json["petAllowed"] ?? false,
        leaseEnding: json["leaseEnding"] ?? false,
        isDeleted: json["isDeleted"] ?? false,
      );

  Map<String, dynamic> toJson() {
    furnishing.removeWhere((element) => element.isEmpty);
    propertyfilterModelClass.removeWhere((element) => element.isEmpty);
    final Map<String, dynamic> json = {
      "category":
          category.isEmpty ? null : List<dynamic>.from(category.map((x) => x)),
      "type": type.isEmpty ? null : List<dynamic>.from(type.map((x) => x)),
      "lettingStatus": lettingStatus.isEmpty
          ? null
          : List<dynamic>.from(lettingStatus.map((x) => x)),
      "features":
          features.isEmpty ? null : List<dynamic>.from(features.map((x) => x)),
      "furnishing": furnishing.isEmpty
          ? null
          : List<dynamic>.from(furnishing.map((x) => x)),
      "class": propertyfilterModelClass.isEmpty
          ? null
          : List<dynamic>.from(propertyfilterModelClass.map((x) => x)),
      "serviceType": serviceType,
      "bathRoom": bathRoom,
      "bedRoom": bedRoom,
      "livingRoom": livingRoom,
      "rentAmount_lte": rentAmountLte,
      "rentAmount_gte": rentAmountGte,
      "floorSize_lte": floorSizeLte,
      "floorSize_gte": floorSizeGte,
      "pps_lte": ppsLte,
      "pps_gte": ppsGte,
      "disabledFriendly": disabledFriendly,
      "petAllowed": petAllowed,
      "leaseEnding": leaseEnding,
      "isDeleted": isDeleted,
    };
    json.removeWhere(
      (key, value) => value == "" || value == [],
    );
    return json;
  }
}
