// To parse this JSON data, do
//
//     final facilityModel = facilityModelFromJson(jsonString);

import 'dart:convert';

FacilityModel facilityModelFromJson(String str) =>
    FacilityModel.fromJson(json.decode(str));

String facilityModelToJson(FacilityModel data) => json.encode(data.toJson());

class FacilityModel {
  FacilityModel({
    this.title = "",
    this.selectedFacility = "",
    this.selectedFacilityId = "",
  });

  String title;
  String selectedFacility;
  String selectedFacilityId;

  factory FacilityModel.fromJson(Map<String, dynamic> json) => FacilityModel(
        title: json["title"] ?? "",
        selectedFacility: json["selected_facility"] ?? "",
        selectedFacilityId: json["selected_facility_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "selected_facility": selectedFacility,
        "selected_facility_id": selectedFacilityId,
      };
}
