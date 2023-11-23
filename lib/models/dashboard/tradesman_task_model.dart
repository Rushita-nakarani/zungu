import 'dart:convert';

import '../api_response_obj.dart';

TradesmanTaskModel? tradesmanTaskModelFromJson(String str) =>
    defaultRespInfo(str).resultObj['task'] == null
        ? null
        : TradesmanTaskModel.fromJson(defaultRespInfo(str).resultObj['task']);

String tradesmanTaskModelToJson(TradesmanTaskModel data) =>
    json.encode(data.toJson());

class TradesmanTaskModel {
  TradesmanTaskModel({
    this.latestJobsCount = 0,
    this.sentQuotesCount = 0,
    this.confirmedJobCount = 0,
  });

  int latestJobsCount;
  int sentQuotesCount;
  int confirmedJobCount;

  factory TradesmanTaskModel.fromJson(Map<String, dynamic> json) =>
      TradesmanTaskModel(
        latestJobsCount: json["latestJobsCount"],
        sentQuotesCount: json["sentQuotesCount"],
        confirmedJobCount: json["confirmedJobCount"],
      );

  Map<String, dynamic> toJson() => {
        "latestJobsCount": latestJobsCount,
        "sentQuotesCount": sentQuotesCount,
        "confirmedJobCount": confirmedJobCount,
      };
}
