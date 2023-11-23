// // To parse this JSON data, do
// //
// //     final propertyListModel = propertyListModelFromJson(jsonString);

// import 'dart:convert';

// import '../constant/img_constants.dart';

// List<PropertyListModel> propertyListModelFromJson(String str) =>
//     List<PropertyListModel>.from(
//       json.decode(str).map((x) => PropertyListModel.fromJson(x)),
//     );

// String propertyListModelToJson(List<PropertyListModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class PropertyListModel {
//   PropertyListModel({
//     this.propertyImg = "",
//     this.propertyTitle = "",
//     this.propertySubtitle = "",
//     this.offerType = "",
//     this.offerColor = "",
//     this.homeItem = const [],
//     this.isWheelChairPerson = false,
//     this.tenantImg = "",
//     this.tenantName = "",
//     this.tenantRent = 0,
//   });

//   String propertyImg;
//   String propertyTitle;
//   String propertySubtitle;
//   String offerType;
//   String offerColor;
//   List<HomeItemModel> homeItem;
//   bool isWheelChairPerson;
//   String tenantImg;
//   String tenantName;
//   int tenantRent;

//   factory PropertyListModel.fromJson(Map<String, dynamic> json) =>
//       PropertyListModel(
//         propertyImg: json["property_img"] ?? "",
//         propertyTitle: json["property_title"] ?? "",
//         propertySubtitle: json["property_subtitle"] ?? "",
//         offerType: json["offer_type"] ?? "",
//         offerColor: json["offer_color"] ?? "",
//         homeItem: List<HomeItemModel>.from(
//           (json["home_item"] ?? []).map((x) => HomeItemModel.fromJson(x)),
//         ),
//         isWheelChairPerson: json["is_wheel_chair_person"] ?? "",
//         tenantImg: json["tenant_img"] ?? "",
//         tenantName: json["tenant_name"] ?? "",
//         tenantRent: json["tenant_rent"] ?? 0,
//       );

//   Map<String, dynamic> toJson() => {
//         "property_img": propertyImg,
//         "property_title": propertyTitle,
//         "property_subtitle": propertySubtitle,
//         "offer_type": offerType,
//         "offer_color": offerColor,
//         "home_item": List<dynamic>.from(homeItem.map((x) => x.toJson())),
//         "is_wheel_chair_person": isWheelChairPerson,
//         "tenant_img": tenantImg,
//         "tenant_name": tenantName,
//         "tenant_rent": tenantRent,
//       };
// }

// class HomeItemModel {
//   HomeItemModel({
//     this.itemId = 0,
//     this.itemCount = 0,
//   });

//   int itemId;
//   int itemCount;

//   factory HomeItemModel.fromJson(Map<String, dynamic> json) => HomeItemModel(
//         itemId: json["item_id"],
//         itemCount: json["item_count"],
//       );

//   Map<String, dynamic> toJson() => {
//         "item_id": itemId,
//         "item_count": itemCount,
//       };
// }

// List<Map<String, dynamic>> myPropertyListData = [
//   {
//     "property_img":
//         "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
//     "property_title": "3 Bed Cottage",
//     "property_subtitle": "Tariff Street,Manchester M1",
//     "offer_type": "LET",
//     "offer_color": "0xFF3CAC71",
//     "home_item": [
//       {"item_id": 0, "item_count": 3},
//       {"item_id": 1, "item_count": 2},
//       {"item_id": 2, "item_count": 1}
//     ],
//     "is_wheel_chair_person": true,
//     "tenant_img": ImgName.defaultProfile1,
//     "tenant_name": "Sonata Nasha",
//     "tenant_rent": 1986,
//   },
//   {
//     "property_img":
//         "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
//     "property_title": "3 Bed Terraced House",
//     "property_subtitle": "City Gardens,3B Way, Manchester M15",
//     "offer_type": "TO LET",
//     "offer_color": "0xFFFFA216",
//     "home_item": [
//       {"item_id": 0, "item_count": 3},
//       {"item_id": 1, "item_count": 2},
//       {"item_id": 2, "item_count": 1}
//     ],
//     "is_wheel_chair_person": false,
//     "tenant_img": ImgName.tenantPersonImage,
//     "tenant_name": "Under Offer",
//     "tenant_rent": 1000,
//   },
//   {
//     "property_img":
//         "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
//     "property_title": "3 Bed Semi Dectached House",
//     "property_subtitle": "New Bridge Street,Salford M3",
//     "offer_type": "Under Offer",
//     "offer_color": "0xFFE0320D",
//     "home_item": [
//       {"item_id": 0, "item_count": 3},
//       {"item_id": 1, "item_count": 2},
//       {"item_id": 2, "item_count": 1}
//     ],
//     "is_wheel_chair_person": false,
//     "tenant_img": ImgName.tenantPersonImage,
//     "tenant_name": "Under offer",
//     "tenant_rent": 1240,
//   },
//   {
//     "property_img":
//         "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
//     "property_title": "3 Bed Semi Dectached House",
//     "property_subtitle": "City Garden, 3B Spinners, Manchester M15",
//     "offer_type": "HMO",
//     "offer_color": "0xFFB772FF",
//     "home_item": [
//       {"item_id": 0, "item_count": 3},
//       {"item_id": 1, "item_count": 2},
//       {"item_id": 2, "item_count": 1}
//     ],
//     "is_wheel_chair_person": false,
//     "tenant_img": ImgName.tenantPersonImage,
//     "tenant_name": "Under Offer",
//     "tenant_rent": 1240,
//   }
// ];
