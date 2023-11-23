// To parse this JSON data, do
//
//     final submitPropertyDetailModel = submitPropertyDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/address_model.dart';

import 'landloard/property_feature_model.dart';

SubmitPropertyDetailModel submitPropertyDetailModelFromJson(String str) =>
    SubmitPropertyDetailModel.fromJson(json.decode(str));

class SubmitPropertyDetailModel {
  SubmitPropertyDetailModel({
    this.name = "",
    this.category = "",
    this.className = "",
    this.type = "",
    this.propertyTypeName = "",
    this.rent = 0,
    this.realEstate = "",
    this.petAllowed = false,
    this.disabledFriendly = false,
    this.leaseEnding = false,
    this.showDeleted = false,
    this.address,
    this.lat = "",
    this.lng = "",
    this.photos = const [],
    this.videos = const [],
    this.floorPlan = const [],
    this.features = const [],
    this.bedRoom = 0,
    this.bathRoom = 0,
    this.livingRoom = 0,
    this.classId = "",
    this.floorSize = 0,
    this.pps = 0.0,
    this.serviceType = "",
    this.rooms = const [],
    this.furnishedType = "",
    this.rentalType = "",
    this.description = "",
    this.isEdit = false,
  });

  String name;
  String category;
  String type;
  String propertyTypeName;
  String description;
  double rent;
  double floorSize;
  double pps;
  String realEstate;
  bool petAllowed;
  bool disabledFriendly;
  bool leaseEnding;
  bool showDeleted;
  AddressModel? address;
  String className;
  String lat;
  String lng;
  List<String> photos;
  List<String> videos;
  List<FloorPlan> floorPlan;
  List<PropertyFeatureModel> features;
  int bedRoom;
  int bathRoom;
  int livingRoom;
  String classId;
  bool isEdit;
  String serviceType;
  String furnishedType;
  List<Room> rooms;
  String rentalType;

  factory SubmitPropertyDetailModel.fromJson(Map<String, dynamic> json) =>
      SubmitPropertyDetailModel(
        name: json["name"] ?? "",
        rentalType: json["rental_type"] ?? "",
        category: json["category"] ?? "",
        type: json["type"] ?? "",
        propertyTypeName: json["property_type_name"] ?? "",
        realEstate: json["realEstate"] ?? "",
        petAllowed: json["petAllowed"] ?? false,
        disabledFriendly: json["disabledFriendly"] ?? false,
        leaseEnding: json["lease_ending"] ?? false,
        showDeleted: json["show_deleted"] ?? false,
        description: json['description'] ?? "",
        furnishedType: json["furnishedType"] ?? "",
        address: json["address"] == null
            ? null
            : AddressModel.fromJson(
                json["address"],
              ),
        lat: json["lat"] ?? "",
        lng: json["lng"] ?? "",
        photos: json["photos"] == null || json["photos"].isEmpty
            ? []
            : List<String>.from(json["photos"].map((x) => x)),
        videos: json["videos"] == null || json["videos"].isEmpty
            ? []
            : List<String>.from(json["videos"].map((x) => x)),
        floorPlan: json["floorPlan"] == null || json["floorPlan"].isEmpty
            ? []
            : List<FloorPlan>.from(
                json["floorPlan"].map(
                  (x) => FloorPlan.fromJson(x),
                ),
              ),
        // features: json["features"] == null || json["features"].isEmpty
        //     ? []
        //     : List<PropertyFeatureModel>.from(
        //         json["features"].map((x) => x),
        //       ),
        bedRoom: json["bedRoom"] ?? 0,
        bathRoom: json["bathRoom"] ?? 0,
        livingRoom: json["livingRoom"] ?? 0,
        classId: json["class"] ?? "",
        rent: double.parse((json["rent"] ?? 0).toString()),
        floorSize: double.parse((json["floorSize"] ?? 0).toString()),
        pps: double.parse((json["pps"] ?? 0).toString()),
        serviceType: json["serviceType"] ?? "",
        rooms: json["rooms"] == null || json["rooms"].isEmpty
            ? []
            : List<Room>.from(
                json["rooms"].map(
                  (x) => Room.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson(String? id) {
    final List<String> _features = [];
    for (final feature in features) {
      if (feature.switchValue && feature.getShowSwitch) {
        _features.add(feature.id);
      }
      for (final child in feature.child) {
        if (child.switchValue) {
          _features.add(child.id);
        }
      }
    }
    //  List<dynamic>.from(features.where((x) => x.getShowSwitch||x.child.any((element) => element.showSwitch)).map((e) => e.))
    final Map<String, dynamic> json = {
      "name": name,
      // "rentalType": rentalType,
      "category": category,
      "type": type,
      "description": description,
      // "property_type_name": propertyTypeName,
      "rent": rent,
      "realEstate": realEstate,
      "petAllowed": petAllowed,
      "disabledFriendly": disabledFriendly,
      "address": address?.toUpdateJson(),
      "lat": lat,
      "lng": lng,
      "_id": id,
      "floorPlan": List<dynamic>.from(floorPlan.map((x) => x.toJson())),
      "photos": List<dynamic>.from(photos.map((x) => x)),
      "videos": List<dynamic>.from(videos.map((x) => x)),
      "features": _features,
      "bedRoom": bedRoom,
      "bathRoom": bathRoom,
      "livingRoom": livingRoom,
      "class": classId,
      "floorSize": floorSize,
      "pps": pps,
      "serviceType": serviceType,
      "rooms": List<dynamic>.from(rooms.map((x) => x.toJson())),
      "furnishing": furnishedType,
    };
    switch (rentalType.toLowerCase()) {
      case "flats":
        json.remove("type");
        json.remove("class");
        json.remove("serviceType");
        json.remove("pps");
        json.remove("floorSize");
        break;
      case "hmo":
      case "house":
        json.remove("serviceType");
        json.remove("class");
        json.remove("pps");
        json.remove("floorSize");
        break;

      case "office":
        json.remove("type");
        json.remove("furnishing");
        break;
      case "shops":
      case "industry":
        json.remove("type");
        json.remove("serviceType");
        json.remove("furnishing");
        break;
      default:
    }
    return json;
  }
}

class FloorPlan {
  FloorPlan({
    this.type = "pdf",
    this.fileName = "",
    this.previewUrl = "",
    this.originalUrl = "",
  });

  String type;
  String fileName;
  String previewUrl;
  String originalUrl;

  factory FloorPlan.fromJson(Map<String, dynamic> json) => FloorPlan(
        type: json["type"] ?? "",
        fileName: json["fileName"] ?? "",
        previewUrl: json["previewUrl"] ?? "",
        originalUrl: json["originalUrl"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "fileName": fileName,
        "previewUrl": originalUrl,
        "originalUrl": originalUrl,
      };
}

class Room {
  Room({
    this.id = "",
    this.typeId = "",
    this.name = "",
    this.typeName = "",
  });

  String id;
  String typeId;
  String name;
  String typeName;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["_id"] ?? "",
        typeId: json["type"] ?? "",
        name: json["name"] ?? "",
        typeName: json["type_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        // "_id": id,
        "type": typeId,
        "name": name,
      };
}

class ServiceType {
  ServiceType({
    this.id,
    this.serviceTypeName = "",
  });

  int? id;
  String serviceTypeName;

  factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
        id: json["id"],
        serviceTypeName: json["service_type_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_type_name": serviceTypeName,
      };
}

class FurnishingType {
  FurnishingType({
    this.id,
    this.furnishingName = "",
  });

  int? id;
  String furnishingName;

  factory FurnishingType.fromJson(Map<String, dynamic> json) => FurnishingType(
        id: json["id"],
        furnishingName: json["furnishing_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "furnishing_name": furnishingName,
      };
}

class RoomsEquipementModel {
  RoomsEquipementModel({
    this.id,
    this.equipementName = "",
    this.equipementCount = 0,
    this.equipementImageUrl = "",
  });

  int? id;
  String equipementName;
  int equipementCount;
  String equipementImageUrl;

  factory RoomsEquipementModel.fromJson(Map<String, dynamic> json) =>
      RoomsEquipementModel(
        id: json["id"],
        equipementName: json["equipement_name"] ?? "",
        equipementCount: json["equipement_count"] ?? 0,
        equipementImageUrl: json["equipement_image_url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "equipement_name": equipementName,
        "equipement_count": equipementCount,
        "equipement_image_url": equipementImageUrl,
      };
}
