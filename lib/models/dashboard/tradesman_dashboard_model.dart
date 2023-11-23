// To parse this JSON data, do
//
//     final tradesmanDashboardModel = tradesmanDashboardModelFromJson(jsonString);

import 'dart:convert';

import '../api_response_obj.dart';

TradesmanDashboardModel? tradesmanDashboardModelFromJson(String str) =>
    defaultRespInfo(str).resultObj['dashboard'] == null
        ? null
        : TradesmanDashboardModel.fromJson(
            defaultRespInfo(str).resultObj['dashboard'],
          );

String tradesmanDashboardModelToJson(TradesmanDashboardModel data) =>
    json.encode(data.toJson());

class TradesmanDashboardModel {
  TradesmanDashboardModel({
    this.invoiceCount = 0,
    this.myJobCount = 0,
    this.myViewingCount = 0,
  });

  int invoiceCount;
  int myJobCount;
  int myViewingCount;

  factory TradesmanDashboardModel.fromJson(Map<String, dynamic> json) =>
      TradesmanDashboardModel(
        invoiceCount: json["invoiceCount"],
        myJobCount: json["myJobCount"],
        myViewingCount: json["myViewingCount"],
      );

  Map<String, dynamic> toJson() => {
        "invoiceCount": invoiceCount,
        "myJobCount": myJobCount,
        "myViewingCount": myViewingCount,
      };
}
