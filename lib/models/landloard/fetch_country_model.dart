// To parse this JSON data, do
//
//     final fetchCountry = fetchCountryFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

List<FetchCountryModel> fetchCountryModelFromJson(String str) => List<FetchCountryModel>.from(
      defaultRespInfo(str).resultArray.map((x) => FetchCountryModel.fromJson(x)),
    );

String fetchCountryModelToJson(List<FetchCountryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchCountryModel {
  FetchCountryModel({
    this.country,
    this.countryCode,
  });

  String? country;
  String? countryCode;

  factory FetchCountryModel.fromJson(Map<String, dynamic> json) => FetchCountryModel(
        country: json["country"],
        countryCode: json["countryCode"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "countryCode": countryCode,
      };
}
