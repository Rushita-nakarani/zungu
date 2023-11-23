import 'dart:convert';

import 'package:kd_api_call/kd_api_call.dart';

import '../api/api_end_points.dart';

ResponseObj defaultRespInfo(String str) =>
    str.isEmpty ? ResponseObj() : ResponseObj.fromJson(json.decode(str));

class ResponseObj {
  ResponseObj({
    this.message = APIErrorMsg.somethingWentWrong,
    this.resultObj = const {},
    this.resultArray = const [],
    this.title = APIErrorMsg.defaultErrorTitle,
  });

  String message;
  String title;
  Map<String, dynamic> resultObj;
  List resultArray;

  factory ResponseObj.fromJson(Map<String, dynamic> json) {
    return ResponseObj(
      title: json[APISetup.titleKey],
      message: json[APISetup.messageKey],
      resultObj: json[APISetup.dataKey] is Map<String, dynamic>
          ? json[APISetup.dataKey]
          : <String, dynamic>{},
      resultArray: json[APISetup.dataKey] is List ? json[APISetup.dataKey] : [],
    );
  }
}
