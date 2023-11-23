// To parse this JSON data, do
//
//     final CurrentTenancyModel = FetchCurrentTenancyModelFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

import '../address_model.dart';

List<CurrentTenancyModel> fetchCurrentTenancyModelFromJson(String str) =>
    List<CurrentTenancyModel>.from(
      defaultRespInfo(str)
          .resultArray
          .map((x) => CurrentTenancyModel.fromJson(x)),
    );

String fetchCurrentTenancyModelToJson(List<CurrentTenancyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CurrentTenancyModel {
  CurrentTenancyModel({
    this.id = "",
    this.status = "",
    this.type = "",
    this.fullAddress = "",
    this.rentAmount = 0,
    this.lettingStatus = "",
    this.bedRoom = 0,
    this.bathRoom = 0,
    this.livingRoom = 0,
    this.disabledFriendly = false,
    this.name = "",
    this.photos = const [],
    this.address,
    this.mobileNumber = "",
  });

  String id;
  String status;
  String type;
  String fullAddress;
  int rentAmount;
  String lettingStatus;
  int bedRoom;
  int bathRoom;
  int livingRoom;
  bool disabledFriendly;
  String name;
  String mobileNumber;
  List<String> photos;
  AddressModel? address;

  factory CurrentTenancyModel.fromJson(Map<String, dynamic> json) =>
      CurrentTenancyModel(
        id: json["_id"] ?? "",
        status: json["status"] ?? "",
        type: json["type"] ?? "",
        fullAddress: json["fullAddress"] ?? "",
        rentAmount: json["rentAmount"] ?? "",
        lettingStatus: json["lettingStatus"] ?? "",
        bedRoom: json["bedRoom"] ?? 0,
        bathRoom: json["bathRoom"] ?? 0,
        livingRoom: json["livingRoom"] ?? 0,
        disabledFriendly: json["disabledFriendly"] ?? false,
        name: json["name"] ?? "",
        address: json["address"] == null
            ? null
            : AddressModel.fromJson(json["address"]),
        photos: json["photos"] == null
            ? []
            : List<String>.from(json["photos"].map((x) => x)),
      );

  String get photo => photos.isNotEmpty ? photos.first : "";
  String get firstAddress =>
      "${address?.addressLine1} ${address?.addressLine2} ";

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "type": type,
        "fullAddress": fullAddress,
        "rentAmount": rentAmount,
        "lettingStatus": lettingStatus,
        "bedRoom": bedRoom,
        "bathRoom": bathRoom,
        "livingRoom": livingRoom,
        "disabledFriendly": disabledFriendly,
        "name": name,
        "photos":
            photos == null ? null : List<dynamic>.from(photos.map((x) => x)),
      };

  Map<String, dynamic> toUploadJson() => {
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "rentAmount": rentAmount,
        "landlordsName": name,
        "landloardsMobileNumber": mobileNumber,
        "address": address?.toUpdateJson()
      };
}
