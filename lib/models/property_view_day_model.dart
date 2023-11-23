// To parse this JSON data, do
//
// final propertyViewDayModel = propertyViewDayModelFromJson(jsonString);

import 'dart:convert';

List<PropertyViewDayModel> listOfPropertyViewDayModelFromJson(String str) =>
    List<PropertyViewDayModel>.from(
      json.decode(str)["dataset"].map(
            (x) => PropertyViewDayModel.fromJson(x),
          ),
    );

String listOfPropertyViewDayModelToJson(List<PropertyViewDayModel> data) =>
    json.encode(
      List<dynamic>.from(
        data.map(
          (x) => x.toJson(),
        ),
      ),
    );

PropertyViewDayModel propertyViewDayModelFromJson(String str) =>
    PropertyViewDayModel.fromJson(
      json.decode(str),
    );

String propertyViewDayModelToJson(PropertyViewDayModel data) => json.encode(
      data.toJson(),
    );

class PropertyViewDayModel {
  PropertyViewDayModel({
    this.day = "",
    this.enableDay = false,
    this.timeModel = const [],
  });

  String day;
  bool enableDay;
  List<TimeModel> timeModel;

  factory PropertyViewDayModel.fromJson(Map<String, dynamic> json) =>
      PropertyViewDayModel(
        day: json["day"] ?? "",
        enableDay: json["enable_day"] ?? false,
        timeModel: List<TimeModel>.from(
          json["time_model"].map(
            (x) => TimeModel.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "enable_day": enableDay,
        "time_model": List<dynamic>.from(
          timeModel.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

class TimeModel {
  TimeModel({
    this.timeSlote = "",
    this.startTime = "",
    this.endTime = "",
  });

  String timeSlote;
  String startTime;
  String endTime;

  factory TimeModel.fromJson(Map<String, dynamic> json) => TimeModel(
        timeSlote: json["time_slote"] ?? "",
        startTime: json["start_time"] ?? "",
        endTime: json["end_time"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "time_slote": timeSlote,
        "start_time": startTime,
        "end_time": endTime,
      };
}

Map<String, dynamic> dummyPropertyData = {
  "dataset": [
    {
      "day": "Monday",
      "enable_day": false,
      "time_model": [
        {"time_slote": "Morning", "start_time": "08:00", "end_time": "11:00"},
        {"time_slote": "Evening", "start_time": "17:00", "end_time": "19:00"}
      ]
    },
    {
      "day": "Tuesday",
      "enable_day": false,
      "time_model": [
        {"time_slote": "Morning", "start_time": "08:00", "end_time": "11:00"},
        {"time_slote": "Evening", "start_time": "17:00", "end_time": "19:00"}
      ]
    },
    {
      "day": "Wednesday",
      "enable_day": false,
      "time_model": [
        {"time_slote": "Morning", "start_time": "11:00", "end_time": "15:00"},
        {"time_slote": "Evening", "start_time": "17:00", "end_time": "19:00"}
      ]
    },
    {
      "day": "Thursday",
      "enable_day": false,
      "time_model": [
        {"time_slote": "Morning", "start_time": "08:00", "end_time": "11:00"},
        {"time_slote": "Evening", "start_time": "17:00", "end_time": "19:00"}
      ]
    },
    {
      "day": "Friday",
      "enable_day": false,
      "time_model": [
        {"time_slote": "Morning", "start_time": "08:00", "end_time": "11:00"},
        {"time_slote": "Evening", "start_time": "17:00", "end_time": "19:00"}
      ]
    },
    {
      "day": "Saturday",
      "enable_day": false,
      "time_model": [
        {"time_slote": "Morning", "start_time": "08:00", "end_time": "11:00"},
        {"time_slote": "Evening", "start_time": "17:00", "end_time": "19:00"}
      ]
    },
    {
      "day": "Sunday",
      "enable_day": false,
      "time_model": [
        {"time_slote": "Morning", "start_time": "08:00", "end_time": "11:00"},
        {"time_slote": "Evening", "start_time": "17:00", "end_time": "19:00"}
      ]
    },
  ]
};
