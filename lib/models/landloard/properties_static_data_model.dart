// To parse this JSON data, do
//
//     final propertiesStaticDataModel = propertiesStaticDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

PropertiesStaticDataModel propertiesStaticDataModelFromJson(String str) =>
    PropertiesStaticDataModel.fromJson(defaultRespInfo(str).resultObj);

String propertiesStaticDataModelToJson(PropertiesStaticDataModel data) =>
    json.encode(data.toJson());

class PropertiesStaticDataModel {
  PropertiesStaticDataModel({
    this.propertiesCount = 0,
    this.hmoCount = 0,
    this.details,
  });

  int propertiesCount;
  int hmoCount;
  Details? details;

  factory PropertiesStaticDataModel.fromJson(Map<String, dynamic> json) =>
      PropertiesStaticDataModel(
        propertiesCount: json["propertiesCount"] ?? 0,
        hmoCount: json["hmoCount"] ?? 0,
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "propertiesCount": propertiesCount,
        "hmoCount": hmoCount,
        "details": details?.toJson(),
      };
}

class Details {
  Details({
    this.let = 0,
    this.toLet = 0,
    this.listed = 0,
    this.underOffer = 0,
  });

  int let;
  int toLet;
  int listed;
  int underOffer;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        let: json["LET"] ?? 0,
        toLet: json["TO_LET"] ?? 0,
        listed: json["LISTED"] ?? 0,
        underOffer: json["UNDER_OFFER"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "LET": let,
        "TO_LET": toLet,
        "LISTED": listed,
        "UNDER_OFFER": underOffer,
      };
}


// // To parse this JSON data, do
// //
// //     final propertiesStaticDataModel = propertiesStaticDataModelFromJson(jsonString);

// import 'dart:convert';

// import 'package:zungu_mobile/models/api_response_obj.dart';

// PropertiesStaticDataModel propertiesStaticDataModelFromJson(String str) =>
//     PropertiesStaticDataModel.fromJson(defaultRespInfo(str).resultObj);

// String propertiesStaticDataModelToJson(PropertiesStaticDataModel data) =>
//     json.encode(data.toJson());

// class PropertiesStaticDataModel {
//   PropertiesStaticDataModel({
//     this.propertiesCount = 0,
//     this.hmoCount = 0,
//     this.details = const [],
//   });

//   int propertiesCount;
//   int hmoCount;
//   List<Detail> details;

//   factory PropertiesStaticDataModel.fromJson(Map<String, dynamic> json) =>
//       PropertiesStaticDataModel(
//         propertiesCount: json["propertiesCount"],
//         hmoCount: json["hmoCount"],
//         details:
//             List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "propertiesCount": propertiesCount,
//         "hmoCount": hmoCount,
//         "details": List<dynamic>.from(details.map((x) => x.toJson())),
//       };
// }

// class Detail {
//   Detail({
//     this.let = 0,
//     this.toLet = 0,
//     this.listed = 0,
//     this.underOffer = 0,
//   });

//   int let;
//   int toLet;
//   int listed;
//   int underOffer;

//   factory Detail.fromJson(Map<String, dynamic> json) => Detail(
//         let: json["LET"] ?? 0,
//         toLet: json["TO_LET"] ?? 0,
//         listed: json["LISTED"] ?? 0,
//         underOffer: json["UNDER_OFFER"] ?? 0,
//       );

//   Map<String, dynamic> toJson() => {
//         "LET": let,
//         "TO_LET": toLet,
//         "LISTED": listed,
//         "UNDER_OFFER": underOffer,
//       };
// }
