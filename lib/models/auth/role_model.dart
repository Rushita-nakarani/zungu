import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:zungu_mobile/models/api_response_obj.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';

import '../../utils/generic_enum.dart';

RoleModel roleModelFromJson(String str) =>
    RoleModel.fromJson(defaultRespInfo(str).resultObj);

String roleModelToJson(RoleModel data) => json.encode(data.toJson());

class RoleModel {
  RoleModel({
    this.roleCount = 0,
    this.page = 0,
    this.size = 0,
    this.roleData = const [],
  });

  int roleCount;
  int page;
  int size;
  List<RoleData> roleData;

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        roleCount: json["count"],
        page: json["page"],
        size: json["size"],
        roleData: List<RoleData>.from(
          json["data"].map((x) => RoleData.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "count": roleCount,
        "page": page,
        "size": size,
        "data": List<dynamic>.from(roleData.map((x) => x.toJson())),
      };
}

class RoleData {
  RoleData({
    this.currency = "",
    this.source = const [],
    this.isActive = false,
    this.paid = true,
    this.isDeleted = false,
    this.createdBy = "",
    this.updatedBy = "",
    this.id = "",
    this.roleId = 0,
    this.roleName = UserRole.None,
    this.freeTrial = 0,
    this.freeTrialType = "",
    this.description = "",
    this.features = "",
    this.v = 0,
    this.createdOn,
    this.updatedOn,
    this.images = "",
    this.displayName = "",
    this.price = 0,
  });

  String currency;
  List<String> source;
  bool isActive;
  bool paid;
  bool isDeleted;
  String createdBy;
  String updatedBy;
  String id;
  int roleId;
  UserRole roleName;
  String images;
  int freeTrial;
  String freeTrialType;
  String description;
  String features;
  int v;
  DateTime? createdOn;
  DateTime? updatedOn;
  String displayName;
  int price;

  factory RoleData.fromJson(Map<String, dynamic> json) => RoleData(
        currency: json["currency"] ?? "",
        source: json["source"] == null
            ? []
            : List<String>.from(json["source"].map((x) => x)),
        isActive: json["isActive"] ?? false,
        paid: json["paid"] ?? true,
        isDeleted: json["isDeleted"] ?? false,
        createdBy: json["createdBy"] ?? "",
        updatedBy: json["updatedBy"] ?? "",
        id: json["_id"] ?? "",
        roleId: json["roleId"] ?? 0,
        roleName: GenericEnum<UserRole>().getEnumValue(
          key: json["roleName"],
          enumValues: UserRole.values,
          defaultEnumValue: UserRole.None,
        ),
        freeTrial: json["freeTrial"] ?? 0,
        freeTrialType: json["freeTrialType"] ?? "",
        description: json["description"] ?? "",
        features: json["features"] ?? "",
        v: json["__v"] ?? 0,
        createdOn: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedOn: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        displayName: json["displayName"] ?? "",
        price: json['price'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "source": List<dynamic>.from(source.map((x) => x)),
        "isActive": isActive,
        "paid": paid,
        "isDeleted": isDeleted,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "_id": id,
        "roleId": roleId,
        "roleName": describeEnum(roleName),
        "freeTrial": freeTrial,
        "freeTrialType": freeTrialType,
        "description": description,
        "features": features,
        "__v": v,
        "createdAt": createdOn?.toIso8601String(),
        "updatedAt": updatedOn?.toIso8601String(),
        "displayName": displayName,
        "price": price
      };
}
