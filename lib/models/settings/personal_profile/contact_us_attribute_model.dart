// To parse this JSON data, do
//
//     final contactUsAttributeModel = contactUsAttributeModelFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

List<ContactUsAttributeModel> contactUsAttributeModelFromJson(String str) =>
    List<ContactUsAttributeModel>.from(
      defaultRespInfo(str)
          .resultArray
          .map((x) => ContactUsAttributeModel.fromJson(x)),
    );

String contactUsAttributeModelToJson(List<ContactUsAttributeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContactUsAttributeModel {
  ContactUsAttributeModel({
    this.isActive = false,
    this.isDeleted = false,
    this.isSelected=false,
    this.id = "",
    this.attributeType = "",
    this.attributeValue = "",
  });

  bool isActive;
  bool isDeleted;
  bool isSelected;
  String id;
  String attributeType;
  String attributeValue;

  factory ContactUsAttributeModel.fromJson(Map<String, dynamic> json) =>
      ContactUsAttributeModel(
        isActive: json["isActive"] ?? false,
        isSelected: json["isSelected"] ?? false,
        isDeleted: json["isDeleted"] ?? false,
        id: json["_id"] ?? "",
        attributeType: json["attributeType"] ?? "",
        attributeValue: json["attributeValue"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "isActive": isActive,
        "isSelected": isSelected,
        "isDeleted": isDeleted,
        "_id": id,
        "attributeType": attributeType,
        "attributeValue": attributeValue,
      };
}
