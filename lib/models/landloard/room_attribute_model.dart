// To parse this JSON data, do
//
//     final roomAttributeModel = roomAttributeModelFromJson(jsonString);

import 'dart:convert';

import '../submit_property_detail_model.dart';

RoomAttributeModel roomAttributeModelFromJson(String str) =>
    RoomAttributeModel.fromJson(json.decode(str));

String roomAttributeModelToJson(RoomAttributeModel data) =>
    json.encode(data.toJson());

class RoomAttributeModel {
  RoomAttributeModel({
    this.id = "",
    this.name = "",
    this.value = const [],
  });

  String id;
  String name;
  List<Room> value;

  factory RoomAttributeModel.fromJson(Map<String, dynamic> json) =>
      RoomAttributeModel(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        value: (json["value"]?.isEmpty ?? true)
            ? []
            : List<Room>.from(
                jsonDecode(json["value"]).map((x) => Room.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "value": List<dynamic>.from(value.map((x) => x.toJson())),
      };
}

