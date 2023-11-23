// To parse this JSON data, do
//
//     final upsetProfileModel = upsetProfileModelFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

UpsetProfileModel upsetProfileModelFromJson(String str) =>
    UpsetProfileModel.fromJson(defaultRespInfo(str).resultObj);

String upsetProfileModelToJson(UpsetProfileModel data) =>
    json.encode(data.toJson());

class UpsetProfileModel {
  UpsetProfileModel({
    this.id = "",
    this.inAppPurchaseId = "",
  });

  String id;
  String inAppPurchaseId;

  factory UpsetProfileModel.fromJson(Map<String, dynamic> json) =>
      UpsetProfileModel(
        id: json["_id"],
        inAppPurchaseId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id": inAppPurchaseId,
      };
}
