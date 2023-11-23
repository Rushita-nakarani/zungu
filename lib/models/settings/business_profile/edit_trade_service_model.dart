// To parse this JSON data, do
//
//     final editTradeServiceModel = editTradeServiceModelFromJson(jsonString);

import 'dart:convert';

import '../../api_response_obj.dart';

EditTradeServiceModel editTradeServiceModelFromJson(String str) =>
    EditTradeServiceModel.fromJson(defaultRespInfo(str).resultObj);

String editTradeServiceModelToJson(EditTradeServiceModel data) =>
    json.encode(data.toJson());

class EditTradeServiceModel {
  EditTradeServiceModel({
    this.count = 0,
    this.page = 0,
    this.size = 0,
    this.data = const [],
  });

  int count;
  int page;
  int size;
  List<ProfessionData> data;

  factory EditTradeServiceModel.fromJson(Map<String, dynamic> json) =>
      EditTradeServiceModel(
        count: json["count"] ?? 0,
        page: json["page"] ?? 0,
        size: json["size"] ?? 0,
        data: json["data"] == null
            ? []
            : List<ProfessionData>.from(
                json["data"].map((x) => ProfessionData.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "page": page,
        "size": size,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  Map<String, dynamic> toUploadJson() => {
        "services": List<dynamic>.from(data.map((x) => x.toUploadJson())),
      };
}

class ProfessionData {
  ProfessionData({
    this.id = "",
    this.isActive = false,
    this.isDeleted = false,
    this.createdBy = "",
    this.updatedBy = "",
    this.name = "",
    this.v = 0,
    this.createdOn,
    this.updatedOn,
    this.child = const [],
    this.parentId = "",
  });

  String id;
  bool isActive;
  bool isDeleted;
  String createdBy;
  String updatedBy;
  String name;
  int v;
  DateTime? createdOn;
  DateTime? updatedOn;
  List<ProfessionData> child;
  String parentId;

  factory ProfessionData.fromJson(Map<String, dynamic> json) => ProfessionData(
        id: json["_id"] ?? "",
        isActive: json["isActive"] ?? false,
        isDeleted: json["isDeleted"] ?? false,
        createdBy: json["createdBy"] ?? "",
        updatedBy: json["updatedBy"] ?? "",
        name: json["name"] ?? "",
        v: json["__v"] ?? 0,
        createdOn: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedOn: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        child: json["child"] == null
            ? []
            : List<ProfessionData>.from(
                json["child"].map((x) => ProfessionData.fromJson(x)),
              ),
        parentId: json["parentId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "name": name,
        "__v": v,
        "createdAt": createdOn?.toIso8601String(),
        "updatedAt": updatedOn?.toIso8601String(),
        "child": child == null
            ? []
            : List<dynamic>.from(child.map((x) => x.toJson())),
        "parentId": parentId,
      };

  Map<String, dynamic> toUploadJson() => {
        "_id": id,
        "is_toggle": isActive,
        "name": name,
        "child": child == null
            ? []
            : List<dynamic>.from(child.map((x) => x.toUploadJson())),
        "parentId": parentId,
      };
}
