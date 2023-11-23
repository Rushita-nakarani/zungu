import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

import '../address_model.dart';

List<ActiveLeaseDataModel> activeLeaseDataModelFromJson(String str) =>
    List<ActiveLeaseDataModel>.from(
      defaultRespInfo(str)
          .resultArray
          .map((x) => ActiveLeaseDataModel.fromJson(x)),
    );

String activeLeaseDataModelToJson(List<ActiveLeaseDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActiveLeaseDataModel {
  ActiveLeaseDataModel({
    this.id = "",
    this.startDate,
    this.address,
    this.renewalDate,
    this.photos = const [],
    this.propertyDetailId = "",
    this.expiresIn,
  });

  String id;
  DateTime? startDate;
  AddressModel? address;
  DateTime? renewalDate;
  List<String> photos;
  String propertyDetailId;
  int? expiresIn;

  factory ActiveLeaseDataModel.fromJson(Map<String, dynamic> json) =>
      ActiveLeaseDataModel(
        id: json["_id"] ?? "",
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        address: json["address"] == null
            ? null
            : AddressModel.fromJson(json["address"]),
        renewalDate: json["renewalDate"] == null
            ? null
            : DateTime.parse(json["renewalDate"]),
        photos: json["photos"] == null
            ? []
            : List<String>.from(json["photos"].map((x) => x)),
        propertyDetailId: json["propertyDetailId"] ?? "",
        expiresIn: json["expiresIn"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "startDate": startDate?.toIso8601String(),
        "address": address?.toJson(),
        "renewalDate": renewalDate,
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "propertyDetailId": propertyDetailId,
        "expiresIn": expiresIn,
      };
}
