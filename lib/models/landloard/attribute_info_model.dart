import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

List<AttributeInfoModel> listOfAttributeInfoModelFromJson(String str) =>
    List<AttributeInfoModel>.from(
      defaultRespInfo(str).resultArray.map(
            (x) => AttributeInfoModel.fromJson(x),
          ),
    );

String listOfAttributeInfoModelToJson(List<AttributeInfoModel> data) =>
    json.encode(
      List<dynamic>.from(
        data.map(
          (x) => x.toJson(),
        ),
      ),
    );

class AttributeInfoModel {
  AttributeInfoModel({
    this.isActive = false,
    this.isDeleted = false,
    this.id = "",
    this.attributeType = "",
    this.attributeValue = "",
  });

  bool isActive;
  bool isDeleted;
  String id;
  String attributeType;
  String attributeValue;

  factory AttributeInfoModel.fromJson(Map<String, dynamic> json) =>
      AttributeInfoModel(
        isActive: json["isActive"] ?? false,
        isDeleted: json["isDeleted"] ?? false,
        id: json["_id"] ?? "",
        attributeType: json["attributeType"] ?? "",
        attributeValue: json["attributeValue"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
        "attributeType": attributeType.isEmpty,
        "attributeValue": attributeValue,
      };
}
