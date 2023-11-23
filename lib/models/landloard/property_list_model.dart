import 'package:zungu_mobile/models/address_model.dart';

import '../api_response_obj.dart';

LandlordAddTenantPropertyModel landlordAddTenantPropertyListFromJson(
  String str,
) {
  return LandlordAddTenantPropertyModel.fromJson(
    defaultRespInfo(str).resultObj,
  );
}

class LandlordAddTenantPropertyModel {
  int count;
  int page;
  int size;
  List<LandlordAddTenantPropertyListModel> propertyList;

  LandlordAddTenantPropertyModel({
    this.count = 0,
    this.page = 1,
    this.size = 0,
    this.propertyList = const [],
  });

  factory LandlordAddTenantPropertyModel.fromJson(Map<String, dynamic> json) =>
      LandlordAddTenantPropertyModel(
        count: json["count"] ?? 0,
        page: json["page"] ?? 1,
        size: json["size"] ?? 0,
        propertyList: List<LandlordAddTenantPropertyListModel>.from(
          json["data"].map<dynamic>(
            (x) => LandlordAddTenantPropertyListModel.fromJson(x),
          ),
        ),
      );
}

class LandlordAddTenantPropertyListModel {
  String id;
  AddressModel? address;
  PropertyResourceModel? propertyResource;
  String name;
  bool propertyOccupied;

  LandlordAddTenantPropertyListModel({
    this.id = "",
    this.address,
    this.propertyResource,
    this.name = "",
    this.propertyOccupied = false,
  });

  // getters and setters
  String get createFullAddress =>
      "${address?.addressLine1 ?? ""}, ${address?.addressLine2 ?? ""}";

  factory LandlordAddTenantPropertyListModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      LandlordAddTenantPropertyListModel(
        id: json["_id"] ?? "",
        address: json["addressId"] == null
            ? null
            : AddressModel.fromJson(json["addressId"]),
        propertyResource: PropertyResourceModel.fromJson(json),
      );
}



class PropertyResourceModel {
  List<String> photos;

  PropertyResourceModel({
    this.photos = const [],
  });

  factory PropertyResourceModel.fromJson(Map<String, dynamic> json) =>
      PropertyResourceModel(
        photos: json["property_resource"] == null
            ? []
            : json["property_resource"]["photos"] == null
                ? []
                : List<String>.from(json["property_resource"]["photos"]),
      );
}
