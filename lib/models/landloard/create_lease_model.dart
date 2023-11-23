// To parse this JSON data, do
//
//     final createLeaseModel = createLeaseModelFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';
import 'package:zungu_mobile/models/landloard/fetch_lease_type.dart';

CreateLeaseModel createLeaseModelFromJson(String str) =>
    CreateLeaseModel.fromJson(json.decode(str));

List<CreateLeaseModel> createLeaseModelListFromJson(String str) =>
    List<CreateLeaseModel>.from(
      defaultRespInfo(str).resultArray.map((e) => CreateLeaseModel.fromJson(e)),
    ).toList();

String createLeaseModelToJson(CreateLeaseModel data) =>
    json.encode(data.toJson());

class CreateLeaseModel {
  CreateLeaseModel({
    this.leaseTypeId = "",
    this.agreementDate,
    this.startDate,
    this.endDate,
    this.propertyId = "",
    this.rentPressureZone = false,
    this.rentCycle = "",
    this.rentAmount = "",
    this.rentDueDate = 0,
    this.latePaymentFee = 0,
    this.deposit = 0,
    this.depositScheme = "",
    this.tenants = const [],
    this.guarantors = const [],
    this.pets,
    this.inclusion = const [],
    this.bankName = "",
    this.accountNumber = "",
    this.accountName = "",
    this.sortCode = "",
    this.selectCountry = "",
    this.selectedDisplayType = "",
    this.propertyAddress = "",
    this.depositeSchemeName = "",
    this.id = "",
    this.leaseUrl="",
  });

  String leaseTypeId;
  String id;
  DateTime? agreementDate;
  String leaseUrl;
  DateTime? startDate;
  DateTime? endDate;
  String propertyId;
  bool rentPressureZone;
  String rentCycle;
  String rentAmount;
  int rentDueDate;
  int latePaymentFee;
  int deposit;
  String depositScheme;
  List<Tenanator> tenants;
  List<Guarantor> guarantors;
  Pets? pets;
  List<Inclusion> inclusion;
  String bankName;
  String accountNumber;
  String accountName;
  String sortCode;
  String selectCountry;
  String selectedDisplayType;
  String propertyAddress;
  String depositeSchemeName;

  factory CreateLeaseModel.fromJson(Map<String, dynamic> json) =>
      CreateLeaseModel(
        id: json['_id'] ?? "",
        leaseTypeId: json["leaseTypeId"] ?? "",
        agreementDate: json["agreementDate"] == null
            ? null
            : DateTime.parse(json["agreementDate"]),
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        propertyId: json["propertyId"] ?? "",
        rentPressureZone: json["rentPressureZone"] ?? false,
        rentCycle: json["rentCycle"] ?? "",
        rentAmount: json["rentAmount"]?.toString() ?? "",
        rentDueDate: json["rentDueDate"] ?? 0,
        latePaymentFee: json["latePaymentFee"] ?? 0,
        deposit: json["deposit"] ?? 0,
        depositScheme: json["depositScheme"] ?? "",
        tenants: json["tenants"] == null
            ? []
            : List<Tenanator>.from(
                json["tenants"].map((x) => Tenanator.fromJson(x)),
              ),
        guarantors: json["guarantors"] == null
            ? []
            : List<Guarantor>.from(
                json["guarantors"].map((x) => Guarantor.fromJson(x)),
              ),
        pets: json["pets"] == null ? null : Pets.fromJson(json["pets"]),
        inclusion: json["inclusion"] == null
            ? []
            : List<Inclusion>.from(
                json["inclusion"].map((x) => Inclusion.fromJson(x)),
              ),
        bankName: json["bankName"] ?? "",
        accountNumber: json["accountNumber"] ?? "",
        accountName: json["accountName"] ?? "",
        sortCode: json["sortCode"] ?? "",
        selectCountry: json["selectCountry"] ?? "",
        selectedDisplayType: json["selectedDisplayType"] ?? "",
        propertyAddress: json["propertyAddress"] ?? "",
        depositeSchemeName: json["depositeSchemeName"] ?? "",
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _json = {
      "leaseTypeId": leaseTypeId,
      "agreementDate":
          "${agreementDate?.year.toString().padLeft(4, '0')}-${agreementDate?.month.toString().padLeft(2, '0')}-${agreementDate?.day.toString().padLeft(2, '0')}",
      "startDate": startDate == null
          ? null
          : "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
      "endDate": endDate == null
          ? null
          : "${endDate?.year.toString().padLeft(4, '0')}-${endDate?.month.toString().padLeft(2, '0')}-${endDate?.day.toString().padLeft(2, '0')}",
      "propertyId": propertyId,
      "rentPressureZone": rentPressureZone,
      "rentCycle": rentCycle,
      "rentAmount": rentAmount,
      "rentDueDate": rentDueDate,
      "latePaymentFee": latePaymentFee,
      "deposit": deposit,
      "depositScheme": depositScheme,
      "tenants": List<dynamic>.from(tenants.map((x) => x.toJson())),
      "guarantors": List<dynamic>.from(guarantors.map((x) => x.toJson())),
      "pets": pets?.toJson(),
      "inclusion": List<dynamic>.from(inclusion.map((x) => x.toJson())),
      "bankName": bankName,
      "accountNumber": accountNumber,
      "accountName": accountName,
      "sortCode": sortCode,
      "flowType": "NEW"
      // "selectCountry": selectCountry,
      // "selectedDisplayType": selectedDisplayType,
      // "propertyAddress": propertyAddress,
      // "depositeSchemeName": depositeSchemeName
    };
    return _json;
  }
}

class Guarantor {
  Guarantor({
    this.name = "",
    this.mobile = "",
    this.address = "",
  });

  String name;
  String mobile;
  String address;

  factory Guarantor.fromJson(Map<String, dynamic> json) => Guarantor(
        name: json["fullName"] ?? "",
        mobile: json["mobile"] ?? "",
        address: json["address"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "fullName": name,
        "mobile": mobile,
        "address": address,
      };
}

class Tenanator {
  Tenanator({
    this.name = "",
    this.mobile = "",
    this.address = "",
  });

  String name;
  String mobile;
  String address;

  factory Tenanator.fromJson(Map<String, dynamic> json) => Tenanator(
        name: json["fullName"] ?? "",
        mobile: json["mobile"] ?? "",
        address: json["address"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "fullName": name,
        "mobile": mobile,
        "address": address,
      };
}

class Pets {
  Pets({
    this.allowed = false,
    this.deposit = 0,
    this.refundable = false,
  });

  bool allowed;
  int deposit;
  bool refundable;

  factory Pets.fromJson(Map<String, dynamic> json) => Pets(
        allowed: json["allowed"] ?? false,
        deposit: json["deposit"] ?? 0,
        refundable: json["refundable"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "allowed": allowed,
        "deposit": deposit,
        "refundable": refundable,
      };
}
// class Inclusion {
//   Inclusion({
//     this.field = "",
//     this.isEnabled = false,
//     this.displayValue = false,
//     this.leaseData = "",
//   });

//   String field;
//   bool isEnabled;
//   bool displayValue;
//   String leaseData;

//   factory Inclusion.fromJson(Map<String, dynamic> json) => Inclusion(
//         field: json["field"] ?? "",
//         isEnabled: json["isEnabled"] ?? false,
//         displayValue: json["displayValue"] ?? false,
//         leaseData: json["leaseData"] ?? "",
//       );

//   Map<String, dynamic> toJson() => {
//         "field": field,
//         "isEnabled": isEnabled,
//         "displayValue": displayValue,
//         "leaseData": leaseData,
//       };
// }
