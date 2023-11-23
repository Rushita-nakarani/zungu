// To parse this JSON data, do
//
//     final eSignedLeaseListModel = eSignedLeaseListModelFromJson(jsonString);

import 'dart:convert';

import '../../constant/string_constants.dart';
import '../../utils/cust_eums.dart';
import '../../utils/generic_enum.dart';
import '../address_model.dart';
import '../api_response_obj.dart';

List<ESignedLeaseListModel> eSignedLeaseListModelFromJson(String str) =>
    List<ESignedLeaseListModel>.from(
      defaultRespInfo(str)
          .resultArray
          .map((x) => ESignedLeaseListModel.fromJson(x)),
    );

String eSignedLeaseListModelToJson(List<ESignedLeaseListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ESignedLeaseListModel {
  ESignedLeaseListModel({
    this.propertyId = "",
    this.roomName = "",
    this.rentAmount = 0,
    this.deposit = 0,
    this.flowType = "",
    this.status = "",
    this.leaseUrl = "",
    this.address,
    this.leaseDetailId = "",
    this.signedDate,
    this.fullName = "",
    this.mobile = "",
    this.profileId = "",
    this.action = EsignLeasesAction.NONE,
    this.tenantName = "",
  });

  String propertyId;
  String roomName;
  int rentAmount;
  int deposit;
  String flowType;
  String status;
  String leaseUrl;
  AddressModel? address;
  String leaseDetailId;
  DateTime? signedDate;
  String fullName;
  String mobile;
  String profileId;
  EsignLeasesAction action;
  String tenantName;

  factory ESignedLeaseListModel.fromJson(Map<String, dynamic> json) =>
      ESignedLeaseListModel(
        propertyId: json["propertyId"] ?? "",
        tenantName: json["tenantName"] ?? "",
        roomName: json["roomName"] ?? "",
        rentAmount: json["rentAmount"] ?? "",
        deposit: json["deposit"] ?? 0,
        flowType: json["flowType"] ?? "",
        status: json["status"] ?? "",
        leaseUrl: json["leaseUrl"] ?? "",
        address: (json["address"] == null)
            ? null
            : AddressModel.fromJson(json["address"]),
        leaseDetailId: json["leaseDetailId"] ?? "",
        signedDate: (json["signedDate"] == null)
            ? null
            : DateTime.parse(json["signedDate"]),
        fullName: json["fullName"] ?? "",
        mobile: json["mobile"] ?? "",
        profileId: json["profileId"] ?? "",
        action: GenericEnum<EsignLeasesAction>().getEnumValue(
          key: json["action"],
          enumValues: EsignLeasesAction.values,
          defaultEnumValue: EsignLeasesAction.NONE,
        ),
      );

  Map<String, dynamic> toJson() => {
        "propertyId": propertyId,
        "roomName": roomName,
        "rentAmount": rentAmount,
        "deposit": deposit,
        "flowType": flowType,
        "status": status,
        "leaseUrl": leaseUrl,
        "address": address?.toJson(),
        "leaseDetailId": leaseDetailId,
        "signedDate": signedDate?.toIso8601String(),
        "fullName": fullName,
        "mobile": mobile,
        "profileId": profileId,
        "action": action,
        "tenantName": tenantName,
      };

  String get updateLeasesinfo =>
      "${StaticString.updateLeases} \n $fullName\n To \n ${address?.fullAddress}";
  String get addLeasesinfo =>
      "${StaticString.updateLeases} \n $fullName\n To \n ${address?.fullAddress}";
}
