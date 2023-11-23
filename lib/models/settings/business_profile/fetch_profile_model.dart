// To parse this JSON data, do
//
//     final fetchProfileModel = fetchProfileModelFromJson(jsonString);

import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

import '../../address_model.dart';

FetchProfileModel? fetchProfileModelFromJson(String str) {
  final ResponseObj responseObj = defaultRespInfo(str);

  if (responseObj.resultArray.isNotEmpty) {
    return FetchProfileModel.fromJson(responseObj.resultArray.first);
  }
  return null;
}

List<FetchProfileModel> fetchProfileListModelFromJson(String str) =>
    List<FetchProfileModel>.from(
      defaultRespInfo(str)
          .resultArray
          .map((x) => FetchProfileModel.fromJson(x)),
    );

FetchProfileModel profileModelFromJson(String str) =>
    FetchProfileModel.fromJson(
      defaultRespInfo(str).resultObj,
    );

String fetchProfileModelToJson(List<FetchProfileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchProfileModel {
  FetchProfileModel({
    this.profileCompleted = false,
    this.createdBy = "",
    this.updatedBy = "",
    this.isActive = false,
    this.isDeleted = false,
    this.isSubscribed = false,
    this.id = "",
    this.roleId = "",
    this.userId = "",
    this.mobile = "",
    this.fullName = "",
    this.profileImg = "",
    this.businessId = "",
    this.tradingName = "",
    this.companyReg = "",
    this.registrationNumber = "",
    this.vatNumber = "",
    this.email = "",
    this.orgWebUrl = "",
    this.companyLogo = "",
    this.tradeServiceId,
    this.latePaymentFee = 0.0,
    this.v = 0,
    this.createdOn,
    this.updatedOn,
    this.addresid,
    this.myLocation,
  });

  bool profileCompleted;
  String createdBy;
  String updatedBy;
  bool isActive;
  bool isDeleted;
  bool isSubscribed;
  String id;
  String roleId;
  String userId;
  String mobile;
  String fullName;
  String profileImg;
  String businessId;
  String tradingName;
  String? companyReg;
  String? registrationNumber;
  String? vatNumber;
  String email;
  String orgWebUrl;
  String companyLogo;
  dynamic tradeServiceId;
  double latePaymentFee;
  int v;
  DateTime? createdOn;
  DateTime? updatedOn;
  AddressModel? addresid;
  MyLocation? myLocation;

  factory FetchProfileModel.fromJson(Map<String, dynamic> json) =>
      FetchProfileModel(
        profileCompleted: json["profileCompleted"] ?? false,
        createdBy: json["createdBy"] ?? "",
        updatedBy: json["updatedBy"] ?? false,
        isDeleted: json["isDeleted"] ?? "",
        id: json["_id"] ?? "",
        isActive: json["isActive"] ?? false,
        isSubscribed: json['isSubscribed'] ?? false,
        roleId: json["roleId"] ?? "",
        userId: json["userId"] ?? "",
        mobile: json["mobile"] ?? "",
        fullName: json["fullName"] ?? "",
        profileImg: json["profileImg"] ?? "",
        businessId: json["businessId"] ?? "",
        tradingName: json["tradingName"] ?? "",
        companyReg: json["companyReg"],
        registrationNumber: json["registrationNumber"],
        vatNumber: json["vatNumber"],
        email: json["email"] ?? "",
        orgWebUrl: json["orgWebUrl"] ?? "",
        companyLogo: json["companyLogo"] ?? "",
        myLocation: json["myLocation"] == null
            ? null
            : MyLocation.fromJson(json["myLocation"]),
        tradeServiceId: json["tradeServiceId"],
        latePaymentFee: json["latePaymentFee"] ?? 0.0,
        v: json["__v"] ?? 0,
        createdOn: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedOn: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        addresid: json["addressId"] == null
            ? null
            : AddressModel.fromJson(json["addressId"]),
      );

  Map<String, dynamic> toJson() => {
        "profileCompleted": profileCompleted,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
        "isSubscribed": isSubscribed,
        "roleId": roleId,
        "userId": userId,
        "mobile": mobile,
        "fullName": fullName,
        "profileImg": profileImg,
        "businessId": businessId,
        "tradingName": tradingName,
        "companyReg": companyReg,
        "registrationNumber": registrationNumber,
        "vatNumber": vatNumber,
        "email": email,
        "orgWebUrl": orgWebUrl,
        "companyLogo": companyLogo,
        "myLocation": myLocation,
        "tradeServiceId": tradeServiceId,
        "latePaymentFee": latePaymentFee,
        "__v": v,
        "createdAt": createdOn?.toIso8601String(),
        "updatedAt": updatedOn?.toIso8601String(),
      };

  Map<String, dynamic> userUpdateJson(
    String roleeid,
    String userrid,
  ) =>
      {
        "roleId": roleeid,
        "userId": userrid,
        "mobile": mobile,
        // "fullName": fullName,
        "profileImg": profileImg,
        "tradingName": tradingName,
        "companyReg": companyReg,
        "registrationNumber": registrationNumber,
        "vatNumber": vatNumber,
        "businessId": businessId,
        "phoneNumber": mobile,
        "email": email,
        "orgWebUrl": orgWebUrl,
        "addressId": "",
        "address": {
          "addressLine1": addresid?.addressLine1,
          "addressLine2": addresid?.addressLine2,
          "addressLine3": addresid?.addressLine3,
          "zipCode": addresid?.zipCode,
          "city": addresid?.city,
          "state": addresid?.state,
          "country": addresid?.country,
          "fullAddress": addresid?.fullAddress
        },
        "companyLogo": "",
        "latePaymentFee": "",
        if (myLocation?.lat != null && myLocation?.lng != null)
          "myLocation": {
            "lat": myLocation?.lat,
            "lng": myLocation?.lng,
            "coverage": myLocation?.coverage,
            "postCode": myLocation?.postCode
          }
      };
}

class MyLocation {
  MyLocation({
    this.lat = 0.0,
    this.lng = 0.0,
    this.coverage = 0.0,
    this.postCode = "",
  });

  double lat;
  double lng;
  double coverage;
  String postCode;

  factory MyLocation.fromJson(Map<String, dynamic> json) => MyLocation(
        lat: double.parse((json["lat"] ?? 0.0).toString()),
        lng: double.parse((json["lng"] ?? 0.0).toString()),
        coverage: double.parse((json["coverage"] ?? 0.0).toString()),
        postCode: json["postCode"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "coverage": coverage,
        "postCode": postCode,
      };
}

class Service {
  Service({
    this.id = "",
    this.qualificationRequired = false,
    this.isToggle = false,
  });

  String id;
  bool qualificationRequired;
  bool isToggle;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"] ?? "",
        qualificationRequired: json["qualificationRequired"] ?? false,
        isToggle: json["is_toggle"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "qualificationRequired": qualificationRequired,
        "is_toggle": isToggle,
      };
}
