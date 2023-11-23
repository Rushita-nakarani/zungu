// To parse this JSON data, do
//
//     final addFeatureScreenUiModel = addFeatureScreenUiModelFromJson(jsonString);

import 'dart:convert';

List<AddFeatureScreenUiModel> addFeatureScreenUiModelFromJson(String str) =>
    List<AddFeatureScreenUiModel>.from(
      json.decode(str)["dataset"].map(
            (x) => AddFeatureScreenUiModel.fromJson(x),
          ),
    );

String addFeatureScreenUiModelToJson(List<AddFeatureScreenUiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddFeatureScreenUiModel {
  AddFeatureScreenUiModel({
    this.title = "",
    this.showSwitch = false,
    this.switchIsOn = false,
    this.subContent = const [],
  });

  String title;
  bool showSwitch;
  bool switchIsOn;
  List<AddFeatureScreenUiModel> subContent;

  factory AddFeatureScreenUiModel.fromJson(Map<String, dynamic> json) =>
      AddFeatureScreenUiModel(
        title: json["title"] ?? "",
        showSwitch: json["showSwitch"] ?? false,
        switchIsOn: json["switchIsOn"] ?? false,
        subContent: json["sub_content"] == null
            ? []
            : List<AddFeatureScreenUiModel>.from(
                json["sub_content"].map(
                  (x) => AddFeatureScreenUiModel.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "showSwitch": showSwitch,
        "switchIsOn": switchIsOn,
        "sub_content": subContent == null
            ? []
            : List<dynamic>.from(subContent.map((x) => x.toJson())),
      };
}

Map<String, dynamic> addFeatureScreenData = {
  "dataset": [
    {
      "title": "Bills Included",
      "showSwitch": false,
      "switchIsOn": false,
      "sub_content": [
        {"title": "Electricity", "showSwitch": true, "switchIsOn": false},
        {"title": "Gas", "showSwitch": true, "switchIsOn": false},
        {"title": "Internet", "showSwitch": true, "switchIsOn": false},
        {
          "title": "Satellite Cable TV",
          "showSwitch": true,
          "switchIsOn": false
        },
        {"title": "Telephone", "showSwitch": true, "switchIsOn": false},
        {"title": "TV License", "showSwitch": true, "switchIsOn": false},
        {"title": "Water", "showSwitch": true, "switchIsOn": false},
      ]
    },
    {
      "title": "Outside Space",
      "showSwitch": false,
      "switchIsOn": false,
      "sub_content": [
        {"title": "Private garden", "showSwitch": true, "switchIsOn": false},
        {"title": "Communal garden", "showSwitch": true, "switchIsOn": false},
        {"title": "Terrace", "showSwitch": true, "switchIsOn": false},
        {"title": "Roof terrace", "showSwitch": true, "switchIsOn": false},
        {"title": "Balcony", "showSwitch": true, "switchIsOn": false},
      ]
    },
    {
      "title": "Parking",
      "showSwitch": false,
      "switchIsOn": false,
      "sub_content": [
        {"title": "Single garage", "showSwitch": true, "switchIsOn": false},
        {"title": "Double garage", "showSwitch": true, "switchIsOn": false},
        {
          "title": "Underground parking",
          "showSwitch": true,
          "switchIsOn": false
        },
        {
          "title": "Off street parking",
          "showSwitch": true,
          "switchIsOn": false
        },
        {
          "title": "On street/residents parking",
          "showSwitch": true,
          "switchIsOn": false
        },
      ]
    },
    {
      "title": "Central heating",
      "showSwitch": true,
      "switchIsOn": false,
      "sub_content": []
    },
    {
      "title": "Disable features",
      "showSwitch": true,
      "switchIsOn": false,
      "sub_content": []
    },
    {
      "title": "Double glazing",
      "showSwitch": true,
      "switchIsOn": false,
      "sub_content": []
    },
    {
      "title": "Fireplace",
      "showSwitch": true,
      "switchIsOn": false,
      "sub_content": []
    },
    {
      "title": "Porter/security",
      "showSwitch": true,
      "switchIsOn": false,
      "sub_content": []
    },
    {
      "title": "Rural/secluded",
      "showSwitch": true,
      "switchIsOn": false,
      "sub_content": []
    },
    {
      "title": "Swimming pool",
      "showSwitch": true,
      "switchIsOn": false,
      "sub_content": []
    },
    {
      "title": "Waterfront",
      "showSwitch": true,
      "switchIsOn": false,
      "sub_content": []
    },
    {
      "title": "Wood floors",
      "showSwitch": true,
      "switchIsOn": false,
      "sub_content": []
    },
  ]
};
