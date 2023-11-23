// To parse this JSON data, do
//
//     final businessTypeModel = businessTypeModelFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

BusinessTypeModel businessTypeModelFromJson(String str) =>
    BusinessTypeModel.fromJson(defaultRespInfo(str).resultObj);

String businessTypeModelToJson(BusinessTypeModel data) =>
    json.encode(data.toJson());

class BusinessTypeModel {
  BusinessTypeModel({
    this.count = 0,
    this.page = 0,
    this.size = 0,
    this.data = const [],
  });

  int count;
  int page;
  int size;
  List<BussinessData> data;

  factory BusinessTypeModel.fromJson(Map<String, dynamic> json) =>
      BusinessTypeModel(
        count: json["count"],
        page: json["page"],
        size: json["size"],
        data: List<BussinessData>.from(
          json["data"].map((x) => BussinessData.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "page": page,
        "size": size,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BussinessData {
  BussinessData({
    this.isActive = false,
    this.isDeleted = false,
    this.createdBy = "",
    this.updatedBy = "",
    this.id = "",
    this.businessIcon = "",
    this.businessName = "",
    this.roleName = "",
    this.v = 0,
    this.createdOn,
    this.updatedOn,
  });

  bool isActive;
  bool isDeleted;
  String createdBy;
  String updatedBy;
  String id;
  String businessIcon;
  String businessName;
  String roleName;
  int v;
  DateTime? createdOn;
  DateTime? updatedOn;

  factory BussinessData.fromJson(Map<String, dynamic> json) => BussinessData(
        isActive: json["isActive"] ?? false,
        isDeleted: json["isDeleted"] ?? false,
        createdBy: json["createdBy"] ?? "",
        updatedBy: json["updatedBy"] ?? "",
        id: json["_id"] ?? "",
        businessIcon: json["businessIcon"] ?? "",
        businessName: json["businessName"] ?? "",
        roleName: json["roleName"] ?? "",
        v: json["__v"] ?? 0,
        createdOn: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedOn: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "isActive": isActive,
        "isDeleted": isDeleted,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "_id": id,
        "businessIcon": businessIcon,
        "businessName": businessName,
        "roleName": roleName,
        "__v": v,
        "createdAt": createdOn?.toIso8601String(),
        "updatedAt": updatedOn?.toIso8601String(),
      };
}
