import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

FinancialOverViewModel financialOverViewModelFromJson(String str) =>
    FinancialOverViewModel.fromJson(defaultRespInfo(str).resultObj);

String financialOverViewModelToJson(FinancialOverViewModel data) =>
    json.encode(data.toJson());

class FinancialOverViewModel {
  FinancialOverViewModel({
    this.isDeleted = false,
    this.createdBy = "",
    this.updatedBy = "",
    this.id = "",
    this.propertyDetailId = "",
    this.purchasePrice = 0,
    this.purchaseDate,
    this.outstandingMortgage = 0,
    this.mortgagePayment = 0,
    this.mortgagePaymentDay,
    this.createdAt,
    this.updatedAt,
    this.financialOverViewModelYield = 0,
    this.yearlyRental = 0,
    this.intmortgagePaymentDay = 0,
  });

  bool isDeleted;
  String createdBy;
  String updatedBy;
  String id;
  String propertyDetailId;
  int purchasePrice;
  DateTime? purchaseDate;
  int outstandingMortgage;
  int mortgagePayment;
  DateTime? mortgagePaymentDay;
  DateTime? createdAt;
  DateTime? updatedAt;
  int financialOverViewModelYield;
  int yearlyRental;
  int intmortgagePaymentDay;

  factory FinancialOverViewModel.fromJson(Map<String, dynamic> json) =>
      FinancialOverViewModel(
        isDeleted: json["isDeleted"] ?? false,
        createdBy: json["createdBy"] ?? "",
        updatedBy: json["updatedBy"] ?? "",
        id: json["_id"] ?? "",
        propertyDetailId: json["propertyDetailId"] ?? "",
        purchasePrice: json["purchasePrice"] ?? 0,
        purchaseDate: json["purchaseDate"] == null
            ? null
            : DateTime.parse(json["purchaseDate"]),
        outstandingMortgage: json["outstandingMortgage"] ?? 0,
        mortgagePayment: json["mortgagePayment"] ?? 0,
        mortgagePaymentDay: json["mortgagePaymentDay"] == null
            ? null
            : DateTime.parse(json["mortgagePaymentDay"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        financialOverViewModelYield: json["yield"] ?? 0,
        yearlyRental: json["yearlyRental"] ?? 0,
        intmortgagePaymentDay: json["intmortgagePaymentDay"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "isDeleted": isDeleted,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "_id": id,
        "propertyDetailId": propertyDetailId,
        "purchasePrice": purchasePrice,
        "purchaseDate": purchaseDate?.toIso8601String(),
        "outstandingMortgage": outstandingMortgage,
        "mortgagePayment": mortgagePayment,
        "mortgagePaymentDay": mortgagePaymentDay?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "yield": financialOverViewModelYield,
        "yearlyRental": yearlyRental,
        "intmortgagePaymentDay": intmortgagePaymentDay,
      };
}
