// To parse this JSON data, do
//
//     final fetchTenanciesModel = fetchTenanciesModelFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

List<FetchTenanciesModel> fetchTenanciesModelFromJson(String str) =>
    List<FetchTenanciesModel>.from(
      defaultRespInfo(str)
          .resultArray
          .map((x) => FetchTenanciesModel.fromJson(x)),
    );

String fetchTenanciesModelToJson(List<FetchTenanciesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchTenanciesModel {
  FetchTenanciesModel({
    this.id = "",
    this.status = "",
    this.type = "",
    this.fullAddress = "",
    this.rentAmount = 0,
  });

  String id;
  String status;
  String type;
  String fullAddress;
  int rentAmount;

  factory FetchTenanciesModel.fromJson(Map<String, dynamic> json) =>
      FetchTenanciesModel(
        id: json["_id"] ?? "",
        status: json["status"] ?? "",
        type: json["type"] ?? "",
        fullAddress: json["fullAddress"] ?? "",
        rentAmount: json["rentAmount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "type": type,
        "fullAddress": fullAddress,
        "rentAmount": rentAmount,
      };
}
