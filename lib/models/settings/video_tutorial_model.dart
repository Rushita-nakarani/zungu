// To parse this JSON data, do
//
//     final fetchVideoModel = fetchVideoModelFromJson(jsonString);

import 'dart:convert';

import '../api_response_obj.dart';

FetchVideoModel fetchVideoModelFromJson(String str) =>
    FetchVideoModel.fromJson(defaultRespInfo(str).resultObj);

String fetchVideoModelToJson(FetchVideoModel data) =>
    json.encode(data.toJson());

class FetchVideoModel {
  FetchVideoModel({
    this.count = 0,
    this.page = 0,
    this.size = 0,
    this.data = const [],
  });

  int count;
  int page;
  int size;
  List<VideoTutorials> data;

  factory FetchVideoModel.fromJson(Map<String, dynamic> json) =>
      FetchVideoModel(
        count: json["count"],
        page: json["page"],
        size: json["size"],
        data: List<VideoTutorials>.from(
          json["data"].map((x) => VideoTutorials.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "page": page,
        "size": size,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class VideoTutorials {
  VideoTutorials({
    this.isActive = false,
    this.isDeleted = false,
    this.createdBy = "",
    this.updatedBy = "",
    this.id = "",
    this.title = "",
    this.videoUrl = "",
    this.v = 0,
    this.createdOn,
    this.updatedOn,
  });

  bool isActive;
  bool isDeleted;
  String createdBy;
  String updatedBy;
  String id;
  String title;
  String videoUrl;
  int v;
  DateTime? createdOn;
  DateTime? updatedOn;

  factory VideoTutorials.fromJson(Map<String, dynamic> json) => VideoTutorials(
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        id: json["_id"],
        title: json["title"],
        videoUrl: json["videoUrl"],
        v: json["__v"],
        createdOn: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedOn: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "isActive": isActive,
        "isDeleted": isDeleted,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "_id": id,
        "title": title,
        "videoUrl": videoUrl,
        "__v": v,
        "createdAt": createdOn?.toIso8601String(),
        "updatedAt": updatedOn?.toIso8601String(),
      };
}
