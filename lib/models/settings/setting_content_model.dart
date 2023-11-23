// To parse this JSON data, do
//
//     final settingContentModel = settingContentModelFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

SettingContentModel settingContentModelFromJson(String str) =>
    SettingContentModel.fromJson(defaultRespInfo(str).resultObj);

String settingContentModelToJson(SettingContentModel data) =>
    json.encode(data.toJson());

class SettingContentModel {
  SettingContentModel({
    this.heading,
    this.points = const [],
  });

  Heading? heading;
  List<Heading> points;

  factory SettingContentModel.fromJson(Map<String, dynamic> json) =>
      SettingContentModel(
        heading:
            json["heading"] == null ? null : Heading.fromJson(json["heading"]),
        points: json["points"] == null
            ? []
            : List<Heading>.from(
                json["points"].map((x) => Heading.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "heading": heading?.toJson(),
        "points": List<dynamic>.from(points.map((x) => x.toJson())),
      };
}

class Heading {
  Heading({
    this.isHeading,
    this.isDeleted,
    this.createdBy,
    this.updatedBy,
    this.id,
    this.title,
    this.description,
    this.type,
    this.v,
    this.createdOn,
    this.updatedOn,
  });

  bool? isHeading;
  bool? isDeleted;
  String? createdBy;
  String? updatedBy;
  String? id;
  String? title;
  String? description;
  String? type;
  int? v;
  DateTime? createdOn;
  DateTime? updatedOn;

  factory Heading.fromJson(Map<String, dynamic> json) => Heading(
        isHeading: json["isHeading"],
        isDeleted: json["isDeleted"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        type: json["type"],
        v: json["__v"],
        createdOn: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedOn: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "isHeading": isHeading,
        "isDeleted": isDeleted,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "_id": id,
        "title": title,
        "description": description,
        "type": type,
        "__v": v,
        "createdAt": createdOn?.toIso8601String(),
        "updatedAt": updatedOn?.toIso8601String(),
      };
}
