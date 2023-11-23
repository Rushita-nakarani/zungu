// To parse this JSON data, do
//
//     final ContactUsModel = ContactUsModelFromJson(jsonString);

import 'dart:convert';

import '../api_response_obj.dart';

List<ContactUsModel> contactUsModelFromJson(String str) =>
    List<ContactUsModel>.from(
      defaultRespInfo(str).resultArray.map((x) => ContactUsModel.fromJson(x)),
    );

String contactUsModelToJson(List<ContactUsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContactUsModel {
  ContactUsModel({
    this.isDeleted = false,
    this.createdBy = " ",
    this.updatedBy = " ",
    this.id = "",
    this.type = "",
    this.name = "",
    this.mobile = "",
    this.message = "",
    this.userId = "",
    this.v = 0,
    this.createdOn,
    this.updatedOn,
  });

  bool isDeleted;
  String createdBy;
  String updatedBy;
  String id;
  String type;
  String name;
  String mobile;
  String message;
  String userId;
  int v;
  DateTime? createdOn;
  DateTime? updatedOn;

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
        isDeleted: json["isDeleted"] ?? [],
        createdBy: json["createdBy"] ?? [],
        updatedBy: json["updatedBy"] ?? [],
        id: json["_id"] ?? [],
        type: json["type"] ?? [],
        name: json["name"] ?? "",
        mobile: json["mobile"] ?? "",
        message: json["message"] ?? "",
        userId: json["userId"] ?? "",
        v: json["__v"] ?? 0,
        createdOn: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedOn: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "isDeleted": isDeleted,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "_id": id,
        "type": type,
        "name": name,
        "mobile": mobile,
        "message": message,
        "userId": userId,
        "__v": v,
        "createdAt": createdOn == null ? null : createdOn?.toIso8601String(),
        "updatedAt": updatedOn == null ? null : updatedOn?.toIso8601String(),
      };
}
