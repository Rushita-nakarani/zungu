// To parse this JSON data, do
//
//     final tradesServiceModel = tradesServiceModelFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

TradesServiceModel tradesServiceModelFromJson(String str) =>
    TradesServiceModel.fromJson(defaultRespInfo(str).resultObj);

List<TradesService> tradesServiceListFromJson(String str) =>
    List<TradesService>.from(
      defaultRespInfo(str).resultArray.map((x) => TradesService.fromJson(x)),
    );

String tradesServiceModelToJson(TradesServiceModel data) =>
    json.encode(data.toJson());

class TradesServiceModel {
  TradesServiceModel({
    this.services = const [],
  });

  List<TradesService> services;

  factory TradesServiceModel.fromJson(Map<String, dynamic> json) =>
      TradesServiceModel(
        services: json["services"] == null
            ? []
            : List<TradesService>.from(
                json["services"].map((x) => TradesService.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
      };
}

class TradesService {
  TradesService({
    this.name = "",
    this.child = const [],
    this.isExpaned = true,
  });

  String name;
  List<Child> child;
  bool isExpaned;

  factory TradesService.fromJson(Map<String, dynamic> json) => TradesService(
        name: json["name"],
        child: json["child"] == null
            ? []
            : List<Child>.from(json["child"].map((x) => Child.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "child": List<dynamic>.from(child.map((x) => x.toJson())),
      };

  List<Child> get tradeServiceItem =>
      child.where((element) => element.isToggle).toList();

 
}

class Child {
  Child({
    this.id = "",
    this.name = "",
    this.parentId = "",
    this.isToggle = false,
  });

  String id;
  String name;
  String parentId;
  bool isToggle;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        parentId: json["parentId"] ?? "",
        isToggle: json["is_toggle"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "parentId": parentId,
        "is_toggle": isToggle,
      };
}


