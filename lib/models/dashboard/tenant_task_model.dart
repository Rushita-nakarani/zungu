import 'dart:convert';

import '../api_response_obj.dart';

TenantTaskModel? tenantTaskModelFromJson(String str) =>
    defaultRespInfo(str).resultObj['task'] == null
        ? null
        : TenantTaskModel.fromJson(defaultRespInfo(str).resultObj['task']);

String tenantTaskModelToJson(TenantTaskModel data) =>
    json.encode(data.toJson());

class TenantTaskModel {
  TenantTaskModel({
    this.bookedJobsCount = 0,
    this.newQuote = 0,
    this.propertyViewing = 0,
    this.signRenewLeaseCount = 0,
  });

  int bookedJobsCount;
  int newQuote;
  int propertyViewing;
  int signRenewLeaseCount;

  factory TenantTaskModel.fromJson(Map<String, dynamic> json) =>
      TenantTaskModel(
        bookedJobsCount: json["bookedJobsCount"] ?? 0,
        newQuote: json["newQuote"] ?? 0,
        propertyViewing: json["propertyViewing"] ?? 0,
        signRenewLeaseCount: json["signRenewLeaseCount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "bookedJobsCount": bookedJobsCount,
        "newQuote": newQuote,
        "propertyViewing": propertyViewing,
        "signRenewLeaseCount": signRenewLeaseCount,
      };
}
