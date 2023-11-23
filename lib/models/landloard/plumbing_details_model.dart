// To parse this JSON data, do
//
//     final plumbingDetailsModel = plumbingDetailsModelFromJson(jsonString);

import 'dart:convert';

List<PlumbingDetailsModel> plumbingDetailsModelFromJson(String str) =>
    List<PlumbingDetailsModel>.from(
      json.decode(str).map((x) => PlumbingDetailsModel.fromJson(x)),
    );

String plumbingDetailsModelToJson(List<PlumbingDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlumbingDetailsModel {
  PlumbingDetailsModel({
    this.isFavourite = false,
    this.jobType = "",
    this.contractorRate = "",
    this.price = "",
    this.availableDate = "",
    this.availableTime = "",
    this.quoteExpiryDate = "",
  });

  bool isFavourite;
  String jobType;
  String contractorRate;
  String price;
  String availableDate;
  String availableTime;
  String quoteExpiryDate;

  factory PlumbingDetailsModel.fromJson(Map<String, dynamic> json) =>
      PlumbingDetailsModel(
        isFavourite: json["is_favourite"] ?? false,
        jobType: json["job_type"] ?? "",
        contractorRate: json["contractor_rate"] ?? "",
        price: json["price"] ?? "",
        availableDate: json["available_date"] ?? "",
        availableTime: json["available_time"] ?? "",
        quoteExpiryDate: json["quote_expiry_date"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "is_favourite": isFavourite,
        "job_type": jobType,
        "contractor_rate": contractorRate,
        "price": price,
        "available_date": availableDate,
        "available_time": availableTime,
        "quote_expiry_date": quoteExpiryDate,
      };
}

List<Map<String, dynamic>> newquotesPlumbingDetailsDummyData23 = [
  {
    "is_favourite": true,
    "job_type": "M Lewis Plumbing",
    "contractor_rate": "3.5",
    "price": "£296.00",
    "available_date": "20 Mar 2022",
    "available_time": "16:00 - 17:30",
    "quote_expiry_date": "26 Mar 2022"
  },
  {
    "is_favourite": true,
    "job_type": "Aleesa Gas & Heating",
    "contractor_rate": "3.5",
    "price": "£325.46",
    "available_date": "22 Mar 2022",
    "available_time": "10:00 - 11:30",
    "quote_expiry_date": "24 Mar 2022"
  },
  {
    "is_favourite": true,
    "job_type": "M Lewis Plumbing",
    "contractor_rate": "3.5",
    "price": "£230.00",
    "available_date": "22 Mar 2022",
    "available_time": "09:00 - 10:15",
    "quote_expiry_date": "23 Mar 2022"
  }
];

List<Map<String, dynamic>> newquotesPlumbingDetailsDummyData4 = [
  {
    "is_favourite": true,
    "job_type": "M Lewis Plumbing",
    "contractor_rate": "3.5",
    "price": "£296.00",
    "available_date": "20 Mar 2022",
    "available_time": "16:00 - 17:30",
    "quote_expiry_date": "26 Mar 2022"
  },
  {
    "is_favourite": true,
    "job_type": "Aleesa Gas & Heating",
    "contractor_rate": "3.5",
    "price": "£325.46",
    "available_date": "22 Mar 2022",
    "available_time": "10:00 - 11:30",
    "quote_expiry_date": "24 Mar 2022"
  },
  
];
