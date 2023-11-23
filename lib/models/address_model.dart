class AddressModel {
  AddressModel({
    this.createdBy = "",
    this.updatedBy = "",
    this.isDeleted = false,
    this.id = "",
    this.addressLine1 = "",
    this.addressLine2 = "",
    this.addressLine3 = "",
    this.zipCode = "",
    this.city = "",
    this.state = "",
    this.country = "",
    this.fullAddress = "",
    this.typeId = "",
    this.type = "",
    this.v = 0,
    this.createdOn,
    this.updatedOn,
  });

  String createdBy;
  String updatedBy;
  bool isDeleted;
  String id;
  String addressLine1;
  String addressLine2;
  String addressLine3;
  String zipCode;
  String city;
  String state;
  String country;
  String fullAddress;
  String typeId;
  String type;
  int v;
  DateTime? createdOn;
  DateTime? updatedOn;

  String get addreesTitle => "$addressLine1, $addressLine2";

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        createdBy: json["createdBy"] ?? "",
        updatedBy: json["updatedBy"] ?? "",
        isDeleted: json["isDeleted"] ?? false,
        id: json["_id"] ?? "",
        addressLine1: json["addressLine1"] ?? "",
        addressLine2: json["addressLine2"] ?? "",
        addressLine3: json["addressLine3"] ?? "",
        zipCode: json["zipCode"] ?? "",
        city: json["city"] ?? "",
        state: json["state"] ?? "",
        country: json["country"] ?? "",
        fullAddress: json["fullAddress"] ?? "",
        typeId: json["typeId"] ?? "",
        type: json["type"] ?? "",
        v: json["__v"] ?? 0,
        createdOn: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedOn: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "isDeleted": isDeleted,
        "_id": id,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "zipCode": zipCode,
        "city": city,
        "state": state,
        "country": country,
        "fullAddress": fullAddress,
        "typeId": typeId,
        "type": type,
        "__v": v,
        "createdAt": createdOn?.toIso8601String(),
        "updatedAt": updatedOn?.toIso8601String(),
        if (addressLine3.isNotEmpty) "addressLine3": addressLine3,
      };

  Map<String, dynamic> toUpdateJson() => {
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "zipCode": zipCode,
        "city": city,
        "state": state,
        "country": country,
        "fullAddress": fullAddress,
        if (addressLine3.isNotEmpty) "addressLine3": addressLine3,
      };
}
