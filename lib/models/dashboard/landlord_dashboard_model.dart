// To parse this JSON data, do
//
//     final landlordDashboardModel = landlordDashboardModelFromJson(jsonString);

import 'dart:convert';

import '../api_response_obj.dart';

LandlordDashboardModel? landlordDashboardModelFromJson(String str) =>
    defaultRespInfo(str).resultObj['dashboard'] == null
        ? null
        : LandlordDashboardModel.fromJson(
            defaultRespInfo(str).resultObj['dashboard'],
          );

String landlordDashboardModelToJson(LandlordDashboardModel data) =>
    json.encode(data.toJson());

class LandlordDashboardModel {
  LandlordDashboardModel({
    this.financial = 0,
    this.invoiceCount = 0,
    this.myPropertyCount = 0,
    this.maintenanceCount = 0,
    this.tenantCount = 0,
  });

  int financial;
  int invoiceCount;
  int myPropertyCount;
  int maintenanceCount;
  int tenantCount;

  factory LandlordDashboardModel.fromJson(Map<String, dynamic> json) =>
      LandlordDashboardModel(
        financial: json["financial"] ?? 0,
        invoiceCount: json["invoiceCount"] ?? 0,
        myPropertyCount: json["myPropertyCount"] ?? 0,
        maintenanceCount: json["maintenanceCount"] ?? 0,
        tenantCount: json["tenantCount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "financial": financial,
        "invoiceCount": invoiceCount,
        "myPropertyCount": myPropertyCount,
        "maintenanceCount": maintenanceCount,
        "tenantCount": tenantCount,
      };
}
