import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';
import 'package:zungu_mobile/models/landloard/room_attribute_model.dart';

import '../address_model.dart';
import '../submit_property_detail_model.dart';

DraftPropertyModel draftPropertyModelFromJson(String str) =>
    DraftPropertyModel.fromJson(defaultRespInfo(str).resultObj);

String draftPropertyModelToJson(DraftPropertyModel data) =>
    json.encode(data.toJson());

class DraftPropertyModel {
  DraftPropertyModel({
    this.propertyDetail,
    this.propertyResource,
  });

  PropertyDetail? propertyDetail;
  PropertyResource? propertyResource;

  factory DraftPropertyModel.fromJson(Map<String, dynamic> json) =>
      DraftPropertyModel(
        propertyDetail: json["property_detail"] == null
            ? null
            : PropertyDetail.fromJson(json["property_detail"]),
        propertyResource: json["property_resource"] == null
            ? null
            : PropertyResource.fromJson(json["property_resource"]),
      );

  Map<String, dynamic> toJson() => {
        "property_detail": propertyDetail?.toJson(),
        "property_resource": propertyResource?.toJson(),
      };
}

class PropertyDetail {
  PropertyDetail({
    this.features = const [],
    this.documentType = "",
    this.isDeleted = false,
    this.id = "",
    this.propertyDetailId,
    this.additionalAttributes = const [],
    this.v,
    this.createdAt,
    this.updatedAt,
    this.addressId,
    this.bathRoom = 0,
    this.bedRoom = 0,
    this.category = "",
    this.createdBy = "",
    this.description = "",
    this.disabledFriendly = false,
    this.floorSize = 0,
    this.furnishing = "",
    this.livingRoom = 0,
    this.name = "",
    this.petAllowed = false,
    this.pps = 0,
    this.realEstate = "",
    this.rent = 0,
    this.type = "",
    this.updatedBy = "",
    this.classId = "",
    this.serviceType = "",
  });

  List<String> features;
  String documentType;
  bool isDeleted;
  String id;
  int? propertyDetailId;
  List<RoomAttributeModel> additionalAttributes;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;
  AddressModel? addressId;
  int bathRoom;
  int bedRoom;
  String category;
  String createdBy;
  String description;
  bool disabledFriendly;
  double floorSize;
  String furnishing;
  int livingRoom;
  String name;
  bool petAllowed;
  double pps;
  String realEstate;
  double rent;
  String type;
  String updatedBy;
  String classId;
  String serviceType;

  factory PropertyDetail.fromJson(Map<String, dynamic> json) => PropertyDetail(
        features: json["features"] == null
            ? []
            : List<String>.from(json["features"].map((x) => x)),
        documentType: json["documentType"] ?? "",
        isDeleted: json["isDeleted"] ?? false,
        id: json["_id"] ?? "",
        classId: json['class'] ?? "",
        propertyDetailId: json["id"],
        additionalAttributes: json["additional_attributes"] == null
            ? []
            : List<RoomAttributeModel>.from(
                json["additional_attributes"]
                    .map((x) => RoomAttributeModel.fromJson(x)),
              ),
        v: json["__v"],
        serviceType: json['serviceType'] ?? "",
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        addressId: json["addressId"] == null
            ? null
            : AddressModel.fromJson(json["addressId"]),
        bathRoom: json["bathRoom"] ?? 0,
        bedRoom: json["bedRoom"] ?? 0,
        category: json["category"] ?? "",
        createdBy: json["createdBy"] ?? "",
        description: json["description"] ?? "",
        disabledFriendly: json["disabledFriendly"] ?? false,
        floorSize: double.parse((json["floorSize"] ?? 0).toString()),
        furnishing: json["furnishing"] ?? "",
        livingRoom: json["livingRoom"] ?? 0,
        name: json["name"] ?? "",
        petAllowed: json["petAllowed"] ?? false,
        pps: double.parse((json["pps"] ?? 0).toString()),
        realEstate: json["realEstate"] ?? "",
        rent: double.parse((json["rent"] ?? 0).toString()),
        type: json["type"] ?? "",
        updatedBy: json["updatedBy"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "features": List<dynamic>.from(features.map((x) => x)),
        "documentType": documentType,
        "isDeleted": isDeleted,
        "_id": id,
        "id": propertyDetailId,
        "additional_attributes":
            List<dynamic>.from(additionalAttributes.map((x) => x.toJson())),
        "__v": v,
        "class": classId,
        "serviceType": serviceType,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "addressId": addressId,
        "bathRoom": bathRoom,
        "bedRoom": bedRoom,
        "category": category,
        "createdBy": createdBy,
        "description": description,
        "disabledFriendly": disabledFriendly,
        "floorSize": floorSize,
        "furnishing": furnishing,
        "livingRoom": livingRoom,
        "name": name,
        "petAllowed": petAllowed,
        "pps": pps,
        "realEstate": realEstate,
        "rent": rent,
        "type": type,
        "updatedBy": updatedBy,
      };
}

class PropertyResource {
  PropertyResource({
    this.photos = const [],
    this.videos = const [],
    this.isDeleted = false,
    this.documentType = "",
    this.id = "",
    this.floorPlan = const [],
    this.propertyDetailId = "",
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  List<String> photos;
  List<String> videos;
  bool isDeleted;
  String documentType;
  String id;
  List<FloorPlan> floorPlan;
  String propertyDetailId;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory PropertyResource.fromJson(Map<String, dynamic> json) =>
      PropertyResource(
        photos: json["photos"] == null
            ? []
            : List<String>.from(json["photos"].map((x) => x)),
        videos: json["videos"] == null
            ? []
            : List<String>.from(json["videos"].map((x) => x)),
        isDeleted: json["isDeleted"] ?? false,
        documentType: json["documentType"] ?? "",
        id: json["_id"],
        floorPlan: json["floorPlan"] == null
            ? []
            : List<FloorPlan>.from(
                json["floorPlan"].map((x) => FloorPlan.fromJson(x)),
              ),
        propertyDetailId: json["propertyDetailId"] ?? "",
        v: json["__v"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "videos": List<dynamic>.from(videos.map((x) => x)),
        "isDeleted": isDeleted,
        "documentType": documentType,
        "_id": id,
        "floorPlan": List<dynamic>.from(floorPlan.map((x) => x.toJson())),
        "propertyDetailId": propertyDetailId,
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
