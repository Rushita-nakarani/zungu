// To parse this JSON data, do
//
//     final roomListModel = roomListModelFromJson(jsonString);

import 'dart:convert';

List<RoomListModel> roomListModelFromJson(String str) =>
    List<RoomListModel>.from(
      json.decode(str).map((x) => RoomListModel.fromJson(x)),
    );

String roomListModelToJson(List<RoomListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoomListModel {
  RoomListModel({
    this.roomNo = 0,
    this.color = "",
    this.tenantPersonName = "",
    this.tenantRent = 0,
  });

  int roomNo;
  String color;
  String tenantPersonName;
  int tenantRent;

  factory RoomListModel.fromJson(Map<String, dynamic> json) => RoomListModel(
        roomNo: json["room_no"] ?? 0,
        color: json["color"] ?? "",
        tenantPersonName: json["tenant_person_name"] ?? "",
        tenantRent: json["tenant_rent"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "room_no": roomNo,
        "color": color,
        "tenant_person_name": tenantPersonName,
        "tenant_rent": tenantRent,
      };
}

List<Map<String, dynamic>> roomListDummyData = [
  {
    "room_no": 1,
    "color": "0xFF3CAC71",
    "tenant_person_name": "john Smith",
    "tenant_rent": 325,
  },
  {
    "room_no": 2,
    "color": "0xFF3CAC71",
    "tenant_person_name": "Betty Rodgers",
    "tenant_rent": 655,
  },
  {
    "room_no": 3,
    "color": "0xFFFFA216",
    "tenant_person_name": "Not Occupied",
    "tenant_rent": 595,
  },
  {
    "room_no": 4,
    "color": "0xFFE0320D",
    "tenant_person_name": "Not Occupied",
    "tenant_rent": 455,
  }
];
