// To parse this JSON data, do
//
//     final landlordTaskModel = landlordTaskModelFromJson(jsonString);

import 'dart:convert';

import '../api_response_obj.dart';

LandlordTaskModel? landlordTaskModelFromJson(String str) =>
    defaultRespInfo(str).resultObj['task'] == null
        ? null
        :
    LandlordTaskModel.fromJson(defaultRespInfo(str).resultObj['task']);

String landlordTaskModelToJson(LandlordTaskModel data) =>
    json.encode(data.toJson());

class LandlordTaskModel {
  LandlordTaskModel({
    this.maintenanceRequest = 0,
    this.newQuote = 0,
    this.propertyViewing = 0,
    this.newReminderCount = 0,
  });

  int maintenanceRequest;
  int newQuote;
  int propertyViewing;
  int newReminderCount;

  factory LandlordTaskModel.fromJson(Map<String, dynamic> json) =>
      LandlordTaskModel(
        maintenanceRequest: json["maintenanceRequest"] ?? 0,
        newQuote: json["newQuote"] ?? 0,
        propertyViewing: json["propertyViewing"] ?? 0,
        newReminderCount: json["newReminderCount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "maintenanceRequest": maintenanceRequest,
        "newQuote": newQuote,
        "propertyViewing": propertyViewing,
        "newReminderCount": newReminderCount,
      };
}
