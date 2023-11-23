import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/string_constants.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';

import '../constant/color_constants.dart';
import '../models/address_model.dart';

String getRoleTitle(UserRole userRole) {
  switch (userRole) {
    case UserRole.LANDLORD:
      return StaticString.landlordSmall;
    case UserRole.TENANT:
      return StaticString.tenant;
    case UserRole.TRADESPERSON:
      return StaticString.tradsemanSmall;
    case UserRole.None:
      return StaticString.landlordSmall;
  }
}

Color getRoleColor(UserRole userRole) {
  switch (userRole) {
    case UserRole.LANDLORD:
      return ColorConstants.custBlue1BC4F4;
    case UserRole.TENANT:
      return ColorConstants.custDarkYellow838500;
    case UserRole.TRADESPERSON:
      return ColorConstants.custDarkTeal017781;
    case UserRole.None:
      return ColorConstants.custBlue1BC4F4;
  }
}

String getFullAddress(AddressModel address) {
  String _address = "";
  if (address.addressLine1.isNotEmpty) {
    _address += address.addressLine1;
    _address += " ";
  }

  if (address.addressLine2.isNotEmpty) {
    _address += address.addressLine2;
    _address += " ";
  }

  if (address.addressLine3.isNotEmpty) {
    _address += address.addressLine3;
    _address += " ";
  }
  _address += address.city;
  _address += " ";
  _address += address.state;
  _address += " ";
  _address += address.country;
  _address += " ";
  _address += address.zipCode;

  return _address;
}
