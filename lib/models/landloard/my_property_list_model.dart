// To parse this JSON data, do
//
//     final propertiesListModel = propertiesListModelFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

import '../address_model.dart';
import '../settings/business_profile/fetch_profile_model.dart';
import '../submit_property_detail_model.dart';

PropertiesListModel propertiesListModelFromJson(String str) =>
    PropertiesListModel.fromJson(
      defaultRespInfo(str).resultObj,
    );

String propertiesListModelToJson(List<PropertiesListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PropertiesListModel {
  int count;
  int page;
  int size;
  List<PropertiesList> propertyList;

  PropertiesListModel({
    this.count = 0,
    this.page = 1,
    this.size = 0,
    this.propertyList = const [],
  });

  factory PropertiesListModel.fromJson(Map<String, dynamic> json) =>
      PropertiesListModel(
        count: json["count"] ?? 0,
        page: json["page"] ?? 1,
        size: json["size"] ?? 0,
        propertyList: List<PropertiesList>.from(
          json["data"].map<dynamic>(
            (x) => PropertiesList.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "page": page,
        "size": size,
        "data": List<dynamic>.from(propertyList.map((x) => x.toJson())),
      };
}

class PropertiesList {
  PropertiesList({
    this.id = "",
    this.bedRoom = 0,
    this.bathRoom = 0,
    this.livingRoom = 0,
    this.disabledFriendly = false,
    this.name = "",
    this.furnishing = "",
    this.category,
    this.propertyType,
    this.isDeleted = false,
    this.rent = 0,
    this.propertyDetail = const [],
    this.propertyResourceDetail,
    this.addressDetail,
  });

  String id;
  int bedRoom;
  int bathRoom;
  int livingRoom;
  bool disabledFriendly;
  String name;
  String furnishing;
  Category? category;
  PropertyTypeModel? propertyType;
  bool isDeleted;
  int rent;
  List<PropertyDetail> propertyDetail;
  PropertyResourceDetail? propertyResourceDetail;
  AddressModel? addressDetail;

  factory PropertiesList.fromJson(Map<String, dynamic> json) => PropertiesList(
        id: json["_id"] ?? "",
        bedRoom: json["bedRoom"] ?? 0,
        bathRoom: json["bathRoom"] ?? 0,
        livingRoom: json["livingRoom"] ?? 0,
        disabledFriendly: json["disabledFriendly"] ?? false,
        name: json["name"] ?? "",
        furnishing: json["furnishing"] ?? "",
        category: (json["category"] == null)
            ? null
            : Category.fromJson(json["category"]),
        propertyType: (json["propertyType"] == null)
            ? null
            : PropertyTypeModel.fromJson(json["propertyType"]),
        isDeleted: json["isDeleted"] ?? false,
        rent: json["rent"] ?? 0,
        propertyDetail: (json["propertyDetail"] == null)
            ? []
            : List<PropertyDetail>.from(
                json["propertyDetail"].map((x) => PropertyDetail.fromJson(x)),
              ),
        propertyResourceDetail: (json["propertyResourceDetail"] == null)
            ? null
            : PropertyResourceDetail.fromJson(json["propertyResourceDetail"]),
        addressDetail: (json["addressDetail"] == null)
            ? null
            : AddressModel.fromJson(json["addressDetail"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "bedRoom": bedRoom,
        "bathRoom": bathRoom,
        "livingRoom": livingRoom,
        "disabledFriendly": disabledFriendly,
        "name": name,
        "furnishing": furnishing,
        "category": category?.toJson(),
        "propertyType": propertyType?.toJson(),
        "isDeleted": isDeleted,
        "rent": rent,
        "propertyDetail":
            List<dynamic>.from(propertyDetail.map((x) => x.toJson())),
        "propertyResourceDetail": propertyResourceDetail?.toJson(),
        "addressDetail": addressDetail?.toJson(),
      };
  // String? get fullAddress => addressDetail?.fullAddress;
  // String? get type => addressDetail?.type;
}

class Category {
  Category({
    this.isDeleted = false,
    this.createdBy = "",
    this.updatedBy = "",
    this.id = "",
    this.name = "",
    this.realEstate = "",
    this.v = 0,
    this.createdOn,
    this.updatedOn,
    this.coverImage = "",
    this.iconImage = "",
  });

  bool isDeleted;
  String createdBy;
  String updatedBy;
  String id;
  String name;
  String realEstate;
  int v;
  DateTime? createdOn;
  DateTime? updatedOn;
  String coverImage;
  String iconImage;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        isDeleted: json["isDeleted"] ?? false,
        createdBy: json["createdBy"] ?? "",
        updatedBy: json["updatedBy"] ?? "",
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        realEstate: json["realEstate"] ?? "",
        v: json["__v"] ?? 0,
        createdOn: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedOn: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        coverImage: json["coverImage"] ?? "",
        iconImage: json["iconImage"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "isDeleted": isDeleted,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "_id": id,
        "name": name,
        "realEstate": realEstate,
        "__v": v,
        "createdAt": createdOn?.toIso8601String(),
        "updatedAt": updatedOn?.toIso8601String(),
        "coverImage": coverImage,
        "iconImage": iconImage,
      };
}

class PropertyDetail {
  PropertyDetail({
    this.id = "",
    this.status = "",
    this.isDeleted = false,
    this.propertyDetailId = "",
    this.createdBy = "",
    this.updatedBy = "",
    this.v = 0,
    this.createdOn,
    this.updatedOn,
    this.tenancyDetail,
    this.roomType = "",
    this.roomName = "",
    this.propertyTypeValue = "",
  });

  String id;
  String status;
  bool isDeleted;
  String propertyDetailId;
  String createdBy;
  String updatedBy;
  int v;
  DateTime? createdOn;
  DateTime? updatedOn;
  TenancyDetail? tenancyDetail;
  String roomType;
  String roomName;
  String propertyTypeValue;

  factory PropertyDetail.fromJson(Map<String, dynamic> json) => PropertyDetail(
        id: json["_id"],
        status: json["status"],
        isDeleted: json["isDeleted"],
        propertyDetailId: json["propertyDetailId"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        v: json["__v"],
        createdOn: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedOn: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        tenancyDetail: json["tenancyDetail"] == null
            ? null
            : TenancyDetail.fromJson(json["tenancyDetail"]),
        roomType: json["roomType"] ?? "",
        roomName: json["roomName"] ?? "",
        propertyTypeValue: json["propertyTypeValue"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "isDeleted": isDeleted,
        "propertyDetailId": propertyDetailId,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "__v": v,
        "createdAt": createdOn?.toIso8601String(),
        "updatedAt": updatedOn?.toIso8601String(),
        "tenancyDetail": tenancyDetail == null ? null : tenancyDetail?.toJson(),
        "roomType": roomType,
        "roomName": roomName,
        "propertyTypeValue": propertyTypeValue,
      };
}

class TenancyDetail {
  TenancyDetail({
    this.id = "",
    this.isDeleted = false,
    this.createdBy = "",
    this.updatedBy = "",
    this.rentAmount = 0,
    this.rentDueDate,
    this.depositAmount = 0,
    this.depositScheme = "",
    this.depositId = "",
    this.startDate,
    this.endDate,
    this.propertyId = "",
    this.tenantId = "",
    this.type = 0,
    this.status = "",
    this.v = 0,
    this.createdOn,
    this.updatedOn,
    this.tenantProfile,
  });

  String id;
  bool isDeleted;
  String createdBy;
  String updatedBy;
  int rentAmount;
  DateTime? rentDueDate;
  int depositAmount;
  String depositScheme;
  String depositId;
  DateTime? startDate;
  DateTime? endDate;
  String propertyId;
  String tenantId;
  int type;
  String status;
  int v;
  DateTime? createdOn;
  DateTime? updatedOn;
  FetchProfileModel? tenantProfile;

  factory TenancyDetail.fromJson(Map<String, dynamic> json) => TenancyDetail(
        id: json["_id"] ?? "",
        isDeleted: json["isDeleted"] ?? false,
        createdBy: json["createdBy"] ?? "",
        updatedBy: json["updatedBy"] ?? "",
        rentAmount: json["rentAmount"] ?? 0,
        rentDueDate: DateTime.parse(json["rentDueDate"]),
        depositAmount: json["depositAmount"] ?? 0,
        depositScheme: json["depositScheme"] ?? "",
        depositId: json["depositId"] ?? "",
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        propertyId: json["propertyId"] ?? "",
        tenantId: json["tenantId"] ?? "",
        type: json["type"] ?? 0,
        status: json["status"] ?? "",
        v: json["__v"] ?? 0,
        createdOn: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedOn: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        tenantProfile: json["tenantProfile"] == null
            ? null
            : FetchProfileModel.fromJson(json["tenantProfile"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isDeleted": isDeleted,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
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
        "status": status,
        "__v": v,
        "createdAt": createdOn?.toIso8601String(),
        "updatedAt": updatedOn?.toIso8601String(),
        "tenantProfile": tenantProfile == null ? null : tenantProfile?.toJson(),
      };
}

class PropertyResourceDetail {
  PropertyResourceDetail({
    this.id = "",
    this.photos = const [],
    this.videos = const [],
    this.isDeleted = false,
    this.floorPlan = const [],
    this.propertyDetailId = "",
    this.v = 0,
    this.createdOn,
    this.updatedOn,
  });

  String id;
  List<String> photos;
  List<String> videos;
  bool isDeleted;
  List<FloorPlan> floorPlan;
  String propertyDetailId;
  int v;
  DateTime? createdOn;
  DateTime? updatedOn;

  factory PropertyResourceDetail.fromJson(Map<String, dynamic> json) =>
      PropertyResourceDetail(
        id: json["_id"] ?? "",
        photos: (json["photos"] == null)
            ? []
            : List<String>.from(json["photos"].map((x) => x)),
        videos: (json["videos"] == null)
            ? []
            : List<String>.from(json["videos"].map((x) => x)),
        isDeleted: json["isDeleted"] ?? false,
        floorPlan: (json["floorPlan"] == null)
            ? []
            : List<FloorPlan>.from(
                json["floorPlan"].map((x) => FloorPlan.fromJson(x)),
              ),
        propertyDetailId: json["propertyDetailId"] ?? "",
        v: json["__v"] ?? 0,
        createdOn: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedOn: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "videos": List<dynamic>.from(videos.map((x) => x)),
        "isDeleted": isDeleted,
        "floorPlan": List<dynamic>.from(floorPlan.map((x) => x.toJson())),
        "propertyDetailId": propertyDetailId,
        "__v": v,
        "createdAt": createdOn?.toIso8601String(),
        "updatedAt": updatedOn?.toIso8601String(),
      };
}

class PropertyTypeModel {
  PropertyTypeModel({
    this.id = "",
    this.isActive = false,
    this.isDeleted = false,
    this.createdBy = "",
    this.updatedBy = "",
    this.name = "",
    this.propertyCatId = "",
    this.v = 0,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  bool isActive;
  bool isDeleted;
  String createdBy;
  String updatedBy;
  String name;
  String propertyCatId;
  int v;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory PropertyTypeModel.fromJson(Map<String, dynamic> json) =>
      PropertyTypeModel(
        id: json["_id"] ?? "",
        isActive: json["isActive"] ?? false,
        isDeleted: json["isDeleted"] ?? false,
        createdBy: json["createdBy"] ?? "",
        updatedBy: json["updatedBy"] ?? "",
        name: json["name"] ?? "",
        propertyCatId: json["propertyCatId"] ?? "",
        v: json["__v"] ?? 0,
        createdAt: (json["createdAt"] == null)
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: (json["updatedAt"] == null)
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "name": name,
        "propertyCatId": propertyCatId,
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
