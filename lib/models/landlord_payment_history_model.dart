// To parse this JSON data, do
//
//     final propertyHistoryModel = propertyHistoryModelFromJson(jsonString);

import 'dart:convert';

List<PropertyHistoryModel> propertyHistoryModelFromJson(String str) =>
    List<PropertyHistoryModel>.from(
      json.decode(str).map((x) => PropertyHistoryModel.fromJson(x)),
    );

String propertyHistoryModelToJson(List<PropertyHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PropertyHistoryModel {
  PropertyHistoryModel({
    this.paymentRent = "",
    this.paymentType = "",
    this.paymentDate = "",
    this.rentPeriod = "",
    this.lateFee = "",
    this.isRecuringPayment = false,
  });

  String paymentRent;
  String paymentType;
  String paymentDate;
  String rentPeriod;
  String lateFee;
  bool isRecuringPayment;

  factory PropertyHistoryModel.fromJson(Map<String, dynamic> json) =>
      PropertyHistoryModel(
        paymentRent: json["payment_rent"],
        paymentType: json["payment_type"],
        paymentDate: json["payment_date"],
        rentPeriod: json["rent_period"],
        lateFee: json["late_fee"],
        isRecuringPayment: json["lis_recuring_payment"],
      );

  Map<String, dynamic> toJson() => {
        "payment_rent": paymentRent,
        "payment_type": paymentType,
        "payment_date": paymentDate,
        "rent_period": rentPeriod,
        "late_fee": lateFee,
        "lis_recuring_payment": isRecuringPayment,
      };
}

List<Map<String, dynamic>> paymentHistoryDummyData = [
  {
    "payment_rent": "1,250",
    "payment_type": "Bank Transfer",
    "payment_date": "15 Sep 2022",
    "rent_period": "30 aug 2021",
    "late_fee": "",
    "lis_recuring_payment": true,
  },
  {
    "payment_rent": "1,250",
    "payment_type": "Cash",
    "payment_date": "20 Aug 2021",
    "rent_period": "01 jul 2021",
    "late_fee": "",
    "lis_recuring_payment": false,
  },
  {
    "payment_rent": "1,250",
    "payment_type": "Paypal",
    "payment_date": "10 Jul 2022",
    "rent_period": "05 jun 2021",
    "late_fee": "70",
    "lis_recuring_payment": false,
  }
];
