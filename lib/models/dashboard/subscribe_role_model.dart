import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:zungu_mobile/models/api_response_obj.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';

import '../../utils/generic_enum.dart';

SubscribeRoleModel subscribeRoleModelFromJson(String str) =>
    SubscribeRoleModel.fromJson(defaultRespInfo(str).resultObj);

String subscribeRoleModelToJson(SubscribeRoleModel data) =>
    json.encode(data.toJson());

class SubscribeRoleModel {
  SubscribeRoleModel({
    this.active = const [],
    this.inActive = const [],
  });

  List<Role> active;
  List<Role> inActive;

  factory SubscribeRoleModel.fromJson(Map<String, dynamic> json) =>
      SubscribeRoleModel(
        active: List<Role>.from(
          json["active"].map((x) => Role.fromJson(x)),
        ),
        inActive: List<Role>.from(
          json["inActive"].map((x) => Role.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "active": List<dynamic>.from(active.map((x) => x.toJson())),
        "inActive": List<dynamic>.from(inActive.map((x) => x.toJson())),
      };
}

class Role {
  Role({
    this.id = 0,
    this.roleId = "",
    this.profileId="",
    this.roleName = UserRole.None,
    this.displayName = "",
    this.img = "",
    this.page = 1,
    this.isActive = false,
  });

  int id;
  String roleId;
  String profileId;
  UserRole roleName;
  String displayName;
  String img;
  int page;
  bool isActive;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"]??"",
        roleId: json["roleId"]??"",
        profileId: json["profileId"]??"",
        roleName: GenericEnum<UserRole>().getEnumValue(
          key: json["roleName"],
          enumValues: UserRole.values,
          defaultEnumValue: UserRole.None,
        ),
        displayName: json["displayName"]??"",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profileId":profileId,
        "roleId": roleId,
        "roleName": describeEnum(roleName),
        "displayName": displayName,
      };
}
