// To parse this JSON data, do
//
//     final fetchTradesDocumentsModel = fetchTradesDocumentsModelFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

FetchTradesDocumentsModel fetchTradesDocumentsModelFromJson(String str) =>
    FetchTradesDocumentsModel.fromJson(defaultRespInfo(str).resultObj);

String fetchTradesDocumentsModelToJson(FetchTradesDocumentsModel data) =>
    json.encode(data.toJson());

class FetchTradesDocumentsModel {
  FetchTradesDocumentsModel({
    this.count=0,
    this.page=0,
    this.size=0,
    this.data=const[],
  });

  int count;
  int page;
  int size;
  List<DocumentData> data;

  factory FetchTradesDocumentsModel.fromJson(Map<String, dynamic> json) =>
      FetchTradesDocumentsModel(
        count: json["count"],
        page: json["page"],
        size: json["size"],
        data: List<DocumentData>.from(json["data"].map((x) => DocumentData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "page": page,
        "size": size,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DocumentData {
  DocumentData({
    this.isActive=false,
    this.isDeleted=false,
    this.id="",
    this.name="",
  });

  bool isActive;
  bool isDeleted;
  String id;
  String name;

  factory DocumentData.fromJson(Map<String, dynamic> json) => DocumentData(
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
        "name": name,
      };
}
