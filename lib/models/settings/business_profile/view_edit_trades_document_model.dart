// To parse this JSON data, do
//
//     final viewEditTradesDocumentModel = viewEditTradesDocumentModelFromJson(jsonString);

import 'dart:convert';

import '../../api_response_obj.dart';

List<ViewEditTradesDocumentModel> viewEditTradesDocumentModelFromJson(
  String str,
) =>
    List<ViewEditTradesDocumentModel>.from(
      defaultRespInfo(str)
          .resultArray
          .map((x) => ViewEditTradesDocumentModel.fromJson(x)),
    );

List<ViewEditTradesDocumentModel> viewEditDocfromRef(
  List<ViewEditTradesDocumentModel> doc,
) {
  return List<ViewEditTradesDocumentModel>.from(
    doc.map(
      (e) => ViewEditTradesDocumentModel.fromJson(e.toJson()),
    ),
  );
}

String viewEditTradesDocumentModelToJson(
  List<ViewEditTradesDocumentModel> data,
) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ViewEditTradesDocumentModel {
  ViewEditTradesDocumentModel({
    this.documents = const [],
    this.deletedDocuments = const [],
    this.profileId = "",
    this.tradeDocumentTypeId,
    this.finalApprovalStatus = "",
    this.startDate,
    this.endDate,
  });

  List<Document> documents;
  List<Document> deletedDocuments;
  String profileId;
  TradeDocumentTypeId? tradeDocumentTypeId;
  String finalApprovalStatus;
  DateTime? startDate;
  DateTime? endDate;

  factory ViewEditTradesDocumentModel.fromJson(Map<String, dynamic> json) =>
      ViewEditTradesDocumentModel(
        documents: (json["documents"] == null)
            ? []
            : List<Document>.from(
                json["documents"].map((x) => Document.fromJson(x)),
              ),
        deletedDocuments: [],
        profileId: json["profileId"] ?? "",
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        tradeDocumentTypeId: (json["tradeDocumentTypeId"] == null)
            ? null
            : TradeDocumentTypeId.fromJson(json["tradeDocumentTypeId"]),
        finalApprovalStatus: json["finalApprovalStatus"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
        "profileId": profileId,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "tradeDocumentTypeId": tradeDocumentTypeId?.toJson(),
        "finalApprovalStatus": finalApprovalStatus,
      };

  List<String> get documentList => documents.map((e) => e.url).toList();

  Map<String, dynamic> toUploadJson() {
    final Map<String, dynamic> _map = {
      "tradeDocumentTypeId": tradeDocumentTypeId?.id,
      "documents":
          documents.isEmpty ? [] : documents.map((e) => e.toJson()).toList()
    };
    if (tradeDocumentTypeId?.startDateRequired ?? false) {
      _map.addAll({
        "startDate": startDate?.toIso8601String(),
      });
    }
    if (tradeDocumentTypeId?.endDateRequired ?? false) {
      _map.addAll({
        "endDate": endDate?.toIso8601String(),
      });
    }
    return _map;
  }
}

class Document {
  Document({
    this.url = "",
  });

  String url;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        url: json["url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class TradeDocumentTypeId {
  TradeDocumentTypeId({
    this.isActive = false,
    this.isDeleted = false,
    this.isRequired = false,
    this.startDateRequired = false,
    this.endDateRequired = false,
    this.createdBy = "",
    this.updatedBy = "",
    this.id = "",
    this.name = "",
    this.roleId = "",
    this.v = 0,
    this.createdOn,
    this.updatedOn,
  });

  bool isActive;
  bool isDeleted;
  bool isRequired;
  bool startDateRequired;
  bool endDateRequired;
  String createdBy;
  String updatedBy;
  String id;
  String name;
  String roleId;
  int v;
  DateTime? createdOn;
  DateTime? updatedOn;

  factory TradeDocumentTypeId.fromJson(Map<String, dynamic> json) =>
      TradeDocumentTypeId(
        isActive: json["isActive"] ?? false,
        isDeleted: json["isDeleted"] ?? false,
        isRequired: json["isRequired"] ?? false,
        startDateRequired: json["startDateRequired"] ?? false,
        endDateRequired: json["endDateRequired"] ?? false,
        createdBy: json["createdBy"] ?? "",
        updatedBy: json["updatedBy"] ?? "",
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        roleId: json["roleId"] ?? "",
        v: json["__v"] ?? 0,
        createdOn: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedOn: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "isActive": isActive,
        "isDeleted": isDeleted,
        "isRequired": isRequired,
        "startDateRequired": startDateRequired,
        "endDateRequired": endDateRequired,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "_id": id,
        "name": name,
        "roleId": roleId,
        "__v": v,
        "createdAt": createdOn?.toIso8601String(),
        "updatedAt": updatedOn?.toIso8601String(),
      };
}
