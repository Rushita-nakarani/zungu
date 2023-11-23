import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';

import '../../utils/generic_enum.dart';

List<CategoryInfoModel> listOfCategoryInfoModelFromJson(String str) =>
    List<CategoryInfoModel>.from(
      defaultRespInfo(str).resultArray.map(
            (x) => CategoryInfoModel.fromJson(x),
          ),
    );

String listOfCategoryInfoModelToJson(List<CategoryInfoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryInfoModel {
  CategoryInfoModel({
    this.id = "",
    this.isDeleted = false,
    this.isSelected = false,
    this.createdBy = "",
    this.updatedBy = "",
    this.name = "",
    this.realEstate = "",
    this.v = 0,
    this.createdOn,
    this.updatedOn,
    this.propertyType = const [],
    this.isActive = false,
    this.propertyCatId = "",
    this.iconImage = "",
    this.coverImage = "",
    this.propertyTypeEnum = PropertyType.None,
  });

  String id;
  bool isDeleted;
  bool isSelected;
  String createdBy;
  String updatedBy;
  String name;
  String realEstate;
  int v;
  DateTime? createdOn;
  DateTime? updatedOn;
  List<CategoryInfoModel> propertyType;
  PropertyType propertyTypeEnum;
  bool isActive;
  String propertyCatId;
  String iconImage;
  String coverImage;

  factory CategoryInfoModel.fromJson(Map<String, dynamic> json) =>
      CategoryInfoModel(
        id: json["_id"],
        isDeleted: json["isDeleted"],
        isSelected: json["isSelected"] ?? false,
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        name: json["name"],
        propertyTypeEnum: GenericEnum<PropertyType>().getEnumValue(
          key: json["name"],
          enumValues: PropertyType.values,
          defaultEnumValue: PropertyType.None,
        ),
        realEstate: json["realEstate"] ?? "",
        v: json["__v"],
        createdOn: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedOn: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        propertyType: json["propertyType"] == null
            ? []
            : List<CategoryInfoModel>.from(
                json["propertyType"].map(
                  (x) => CategoryInfoModel.fromJson(x),
                ),
              ),
        isActive: json["isActive"] ?? false,
        propertyCatId: json["propertyCatId"] ?? "",
        iconImage: json["iconImage"] ?? "",
        coverImage: json["coverImage"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isDeleted": isDeleted,
        "isSelected": isSelected,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "name": name,
        "realEstate": realEstate,
        "__v": v,
        "createdAt": createdOn?.toIso8601String(),
        "updatedAt": updatedOn?.toIso8601String(),
        "propertyType": List<dynamic>.from(
          propertyType.map(
            (x) => x.toJson(),
          ),
        ),
        "isActive": isActive,
        "propertyCatId": propertyCatId,
        "iconImage": iconImage,
        "coverImage": coverImage,
      };
}
