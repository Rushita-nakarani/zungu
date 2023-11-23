// To parse this JSON data, do
//
//     final landlordMyPropertyModel = landlordMyPropertyModelFromJson(jsonString);

import 'dart:convert';

LandlordMyPropertyModel landlordMyPropertyModelFromJson(String str) =>
    LandlordMyPropertyModel.fromJson(
      json.decode(str),
    );

String landlordMyPropertyModelToJson(LandlordMyPropertyModel data) =>
    json.encode(
      data.toJson(),
    );

List<LandlordMyPropertyModel> listOfLandlordMyPropertyModelFromJson(
  String str,
) =>
    List<LandlordMyPropertyModel>.from(
      json.decode(str).map(
            (x) => LandlordMyPropertyModel.fromJson(
              x,
            ),
          ),
    );

String listOfLandlordMyPropertyModelToJson(
  List<LandlordMyPropertyModel> data,
) =>
    json.encode(
      List<dynamic>.from(
        data.map(
          (x) => x.toJson(),
        ),
      ),
    );

class LandlordMyPropertyModel {
  LandlordMyPropertyModel({
    this.id,
    this.roomImgUrl = "",
    this.title = "",
    this.subTitle = "",
    this.bookmarkLable = "",
    this.labelColor = "",
    this.roomDetail = const [],
    this.tenantDetail = const [],
  });

  int? id;
  String roomImgUrl;
  String title;
  String subTitle;
  String bookmarkLable;
  String labelColor;
  List<RoomDetail> roomDetail;
  List<TenantDetail> tenantDetail;

  factory LandlordMyPropertyModel.fromJson(Map<String, dynamic> json) =>
      LandlordMyPropertyModel(
        id: json["id"],
        roomImgUrl: json["room_img_url"] ?? "",
        title: json["title"] ?? "",
        subTitle: json["sub_title"] ?? "",
        bookmarkLable: json["bookmark_lable"] ?? "",
        labelColor: json["label_color"] ?? "",
        roomDetail: json["room_detail"] == null
            ? []
            : List<RoomDetail>.from(
                (json["room_detail"] ?? []).map(
                  (x) => RoomDetail.fromJson(x),
                ),
              ),
        tenantDetail: json["tenant_detail"] == null
            ? []
            : List<TenantDetail>.from(
                (json["tenant_detail"] ?? []).map(
                  (x) => TenantDetail.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "room_img_url": roomImgUrl,
        "title": title,
        "sub_title": subTitle,
        "bookmark_lable": bookmarkLable,
        "label_color": labelColor,
        "room_detail": List<dynamic>.from(
          roomDetail.map(
            (x) => x.toJson(),
          ),
        ),
        "tenant_detail": List<dynamic>.from(
          tenantDetail.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

class RoomDetail {
  RoomDetail({
    this.icon = "",
    this.count = "",
  });

  String icon;
  String count;

  factory RoomDetail.fromJson(Map<String, dynamic> json) => RoomDetail(
        icon: json["icon"] ?? "",
        count: json["count"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "icon": icon,
        "count": count,
      };
}

class TenantDetail {
  TenantDetail({
    this.id,
    this.imgUrl = "",
    this.tag = "",
    this.name = "",
    this.rentAmount = "",
    this.lableColor = "",
  });

  int? id;
  String imgUrl;
  String tag;
  String name;
  String rentAmount;
  String lableColor;

  factory TenantDetail.fromJson(Map<String, dynamic> json) => TenantDetail(
        id: json["id"],
        imgUrl: json["img_url"] ?? "",
        tag: json["tag"] ?? "",
        name: json["name"] ?? "",
        rentAmount: json["rent_amount"] ?? "",
        lableColor: json["lable_color"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "img_url": imgUrl,
        "tag": tag,
        "name": name,
        "rent_amount": rentAmount,
        "lable_color": lableColor,
      };
}
