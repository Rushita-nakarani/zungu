import '../models/landloard/attribute_info_model.dart';
import 'img_font_color_string.dart';

class FilterConstant {
  static final List<AttributeInfoModel> activeLeaseFilterList = [
    AttributeInfoModel(
      attributeValue: StaticString.all,
    ),
    AttributeInfoModel(
      attributeValue: StaticString.endingin30Days,
    ),
    AttributeInfoModel(
      attributeValue: StaticString.endingin60Days,
    ),
    AttributeInfoModel(
      attributeValue: StaticString.endingin90Days,
    ),
  ];
}
