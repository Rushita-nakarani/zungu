
class LettingStatus {
  LettingStatus({
    this.id = 0,
    this.name = "",
    this.isSelected = false,
  });

  int id;
  String name;
  bool isSelected;

  factory LettingStatus.fromJson(
    Map<String, dynamic> json,
  ) =>
      LettingStatus(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        isSelected: json["is_selected"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_selected": isSelected,
      };
}

class PropertyList {
  PropertyList({
    this.propertyId = 0,
    this.propertyImage = "",
    this.propertyName = "",
    this.isSelected = false,
  });

  int propertyId;
  String propertyImage;
  String propertyName;
  bool isSelected;

  factory PropertyList.fromJson(Map<String, dynamic> json) => PropertyList(
        propertyId: json["property_id"] ?? 0,
        propertyImage: json["property_image"] ?? "",
        propertyName: json["property_name"] ?? "",
        isSelected: json["is_selected"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "property_id": propertyId,
        "property_image": propertyImage,
        "property_name": propertyName,
        "is_selected": isSelected,
      };
}
