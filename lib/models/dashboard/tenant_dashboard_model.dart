import 'dart:convert';

import '../api_response_obj.dart';

TenantDashboardModel? tenantDashboardModelFromJson(String str) =>
    defaultRespInfo(str).resultObj['dashboard'] == null
        ? null
        : TenantDashboardModel.fromJson(
            defaultRespInfo(str).resultObj['dashboard'],
          );

String tenantDashboardModelToJson(TenantDashboardModel data) =>
    json.encode(data.toJson());

class TenantDashboardModel {
  TenantDashboardModel({
    this.tenanciesCount = 0,
    this.maintenanceCount = 0,
    this.postJobCount = 0,
    this.invoiceCount = 0,
    this.myViewingCount = 0,
  });

  int tenanciesCount;
  int maintenanceCount;
  int postJobCount;
  int invoiceCount;
  int myViewingCount;

  factory TenantDashboardModel.fromJson(Map<String, dynamic> json) =>
      TenantDashboardModel(
        tenanciesCount: json["tenanciesCount"] ?? 0,
        maintenanceCount: json["maintenanceCount"] ?? 0,
        postJobCount: json["postJobCount"] ?? 0,
        invoiceCount: json["invoiceCount"] ?? 0,
        myViewingCount: json["myViewingCount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "tenanciesCount": tenanciesCount,
        "maintenanceCount": maintenanceCount,
        "postJobCount": postJobCount,
        "invoiceCount": invoiceCount,
        "myViewingCount": myViewingCount,
      };
}
