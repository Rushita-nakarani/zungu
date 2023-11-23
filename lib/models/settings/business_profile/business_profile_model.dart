// To parse this JSON data, do
//
//     final bussinessProfileModel = bussinessProfileModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:zungu_mobile/models/api_response_obj.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';

import '../../../utils/generic_enum.dart';

List<BussinessProfileModel> bussinessProfileModelFromJson(String str) =>
    List<BussinessProfileModel>.from(
      defaultRespInfo(str)
          .resultArray
          .map((x) => BussinessProfileModel.fromJson(x)),
    );

String bussinessProfileModelToJson(List<BussinessProfileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BussinessProfileModel {
  BussinessProfileModel({
    this.profileImg = "",
    this.roleName = UserRole.None,
    this.businessName = "",
    this.roleId = "",
    this.tradingName = "",
  });

  String profileImg;
  UserRole roleName;
  String businessName;
  String roleId;
  String tradingName;

  factory BussinessProfileModel.fromJson(Map<String, dynamic> json) =>
      BussinessProfileModel(
        profileImg: json["profileImg"] ?? "",
        roleName: GenericEnum<UserRole>().getEnumValue(
          key: json["roleName"],
          enumValues: UserRole.values,
          defaultEnumValue: UserRole.None,
        ),
        businessName: json["businessName"] ?? "",
        tradingName: json["tradingName"] ?? "",
        roleId: json["roleId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "profileImg": profileImg,
        "roleName": describeEnum(roleName),
        "businessName": businessName,
        "tradingName": tradingName,
        "roleId": roleId,
      };
}
