// To parse this JSON data, do
//
//     final propertyFeatureModel = propertyFeatureModelFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

List<PropertyFeatureModel> listOfPropertyFeatureModelFromJson(String str) =>
    List<PropertyFeatureModel>.from(
      defaultRespInfo(str).resultArray.map(
            (x) => PropertyFeatureModel.fromJson(x),
          ),
    );

String listOfPropertyFeatureModelToJson(List<PropertyFeatureModel> data) =>
    json.encode(
      List<dynamic>.from(
        data.map(
          (x) => x.toJson(),
        ),
      ),
    );

class PropertyFeatureModel {
  PropertyFeatureModel({
    this.name = "",
    this.id = "",
    this.child = const [],
    this.showSwitch = false,
    this.switchValue = false,
  });

  String name;
  String id;
  List<PropertyFeatureElementModel> child;
  bool showSwitch;
  bool switchValue;

  factory PropertyFeatureModel.fromJson(Map<String, dynamic> json) =>
      PropertyFeatureModel(
        name: json["name"] ?? "",
        id: json["_id"] ?? "",
        child: json["child"] == null
            ? []
            : json["child"].isEmpty
                ? []
                : List<PropertyFeatureElementModel>.from(
                    json["child"].map(
                      (x) => PropertyFeatureElementModel.fromJson(
                        x,
                      ),
                    ),
                  ),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "_id": id,
        "child": List<dynamic>.from(
          child.map(
            (x) => x.toJson(),
          ),
        ),
      };

  bool get getShowSwitch => child.isEmpty;
}

class PropertyFeatureElementModel {
  PropertyFeatureElementModel({
    this.name = "",
    this.parentId = "",
    this.id = "",
    this.showSwitch = true,
    this.switchValue = false,
  });

  String name;
  String parentId;
  String id;
  bool showSwitch;
  bool switchValue;

  factory PropertyFeatureElementModel.fromJson(Map<String, dynamic> json) =>
      PropertyFeatureElementModel(
        name: json["name"] ?? "",
        parentId: (json["parentId"]?.toString()) ?? "",
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "parentId": parentId.toString(),
        "_id": id,
      };
}
