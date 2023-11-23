import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

import '../address_model.dart';

LeaseDetailModel leaseDetailModelFromJson(Map<String, dynamic> str) =>
    LeaseDetailModel.fromJson(str);

List<LeaseDetailModel> leaseListModelFromJson(String str) =>
    List<LeaseDetailModel>.from(
      defaultRespInfo(str).resultArray.map((x) => LeaseDetailModel.fromJson(x)),
    );
String leaseDetailModelToJson(LeaseDetailModel data) =>
    json.encode(data.toJson());

class LeaseDetailModel {
  LeaseDetailModel({
    this.leaseDetailId = "",
    this.address,
    this.photos = const [],
    this.propertyId = "",
    this.propertyDetailId = "",
    this.name = "",
    this.rentAmount = -1,
    this.flowType = "",
    this.endDate,
    this.startDate,
    this.leaseUrl = "",
  });

  String leaseDetailId;
  AddressModel? address;
  List<String> photos;
  String propertyId;
  String propertyDetailId;
  String name;
  int rentAmount;
  String flowType;
  DateTime? endDate;
  DateTime? startDate;
  String leaseUrl;

  factory LeaseDetailModel.fromJson(Map<String, dynamic> json) =>
      LeaseDetailModel(
        leaseDetailId: json["leaseDetailId"] ?? "",
        address: json["address"] == null
            ? null
            : AddressModel.fromJson(json["address"]),
        photos: json["photos"] == null
            ? []
            : List<String>.from(json["photos"].map((x) => x)),
        propertyId: json["propertyId"] ?? "",
        propertyDetailId: json["propertyDetailId"] ?? "",
        name: json["name"] ?? "",
        rentAmount: json["rentAmount"] ?? 0,
        flowType: json["flowType"] ?? "",
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        leaseUrl: json["leaseUrl"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "leaseDetailId": leaseDetailId,
        "address": address?.toJson(),
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "propertyId": propertyId,
        "propertyDetailId": propertyDetailId,
        "name": name,
        "rentAmount": rentAmount,
        "flowType": flowType,
        "endDate": endDate?.toIso8601String(),
        "startDate": startDate?.toIso8601String(),
        "leaseUrl": leaseUrl,
      };
}
