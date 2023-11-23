// To parse this JSON data, do
//
//     final SelectLeaseType = SelectLeaseTypeFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

List<SelectLeaseType> SelectLeaseTypeFromJson(String str) => List<SelectLeaseType>.from(
      defaultRespInfo(str).resultArray.map((x) => SelectLeaseType.fromJson(x)),
    );

String SelectLeaseTypeToJson(List<SelectLeaseType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SelectLeaseType {
  SelectLeaseType({
    this.startDate,
    this.endDate,
    this.id = "",
    this.country = "",
    this.countryCode = "",
    this.type = "",
    this.displayType = "",
    this.sampleUrl = "",
    this.previewUrl = "",
    this.inclusion = const [],
  });

  Date? startDate;
  Date? endDate;
  String id;
  String country;
  String countryCode;
  String type;
  String displayType;
  String sampleUrl;
  String previewUrl;
  List<Inclusion> inclusion;

  factory SelectLeaseType.fromJson(Map<String, dynamic> json) => SelectLeaseType(
        startDate:
            json["startDate"] == null ? null : Date.fromJson(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : Date.fromJson(json["endDate"]),
        id: json["_id"] ?? "",
        country: json["country"] ?? "",
        countryCode: json["countryCode"] ?? "",
        type: json["type"] ?? "",
        displayType: json["displayType"] ?? "",
        sampleUrl: json["sampleUrl"] ?? "",
        previewUrl: json["previewUrl"] ?? "",
        inclusion: json["inclusion"] == null
            ? []
            : List<Inclusion>.from(
                json["inclusion"].map((x) => Inclusion.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate?.toJson(),
        "endDate": endDate?.toJson(),
        "_id": id,
        "country": country,
        "countryCode": countryCode,
        "type": type,
        "displayType": displayType,
        "sampleUrl": sampleUrl,
        "previewUrl": previewUrl,
        "inclusion": List<dynamic>.from(inclusion.map((x) => x.toJson())),
      };
  List<Inclusion>? get incExcEnable =>
      inclusion.where((e) => e.isEnabled).toList();
}

class Date {
  Date({
    this.displayName = "",
    this.isEnabled = false,
    this.isRequired = false,
    this.leaseData = "",
  });

  String displayName;
  bool isEnabled;
  bool isRequired;
  String leaseData;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        displayName: json["displayName"] ?? "",
        isEnabled: json["isEnabled"] ?? false,
        isRequired: json["isRequired"] ?? false,
        leaseData: json["leaseData"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "isEnabled": isEnabled,
        "isRequired": isRequired,
        "leaseData": leaseData,
      };
}

class Inclusion {
  Inclusion({
    this.field = "",
    this.isEnabled = false,
    this.displayValue = "",
    this.leaseData = "",
  });

  String field;
  bool isEnabled;
  String displayValue;
  String leaseData;

  factory Inclusion.fromJson(Map<String, dynamic> json) => Inclusion(
        field: json["field"] ?? "",
        isEnabled: json["isEnabled"] ?? false,
        displayValue: json["displayValue"] ?? "",
        leaseData: json["leaseData"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "field": field,
        "isEnabled": isEnabled,
        "displayValue": displayValue,
        "leaseData": leaseData,
      };
}
