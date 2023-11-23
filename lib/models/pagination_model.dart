import 'package:zungu_mobile/models/api_response_obj.dart';

import '../api/api_end_points.dart';

ResponseObj paginationRespInfo(String str) => str.isEmpty
    ? ResponseObj()
    : ResponseObj.fromJson(defaultRespInfo(str).resultObj);

class ResponseObj {
  ResponseObj({
    this.count = 0,
    this.resultObj = const {},
    this.resultArray = const [],
    this.page = 0,
    this.size = 0,
  });
  int count;
  int page;
  int size;
  Map<String, dynamic> resultObj;
  List resultArray;

  factory ResponseObj.fromJson(Map<String, dynamic> json) {
    return ResponseObj(
      count: json[APISetup.countKey],
      page: json[APISetup.pageKey],
      size: json[APISetup.sizeKey],
      resultObj: json[APISetup.dataKey] is Map<String, dynamic>
          ? json[APISetup.dataKey]
          : <String, dynamic>{},
      resultArray: json[APISetup.dataKey] is List ? json[APISetup.dataKey] : [],
    );
  }
}
