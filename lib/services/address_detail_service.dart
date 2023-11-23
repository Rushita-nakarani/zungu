import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';

import '../api/api_end_points.dart';
import '../models/address_model.dart';

class AddressDetailService {
  AddressDetailService._();

  static AddressDetailService instance = AddressDetailService._();

  Future<AddressModel?> getAddressDetailFromAddress(String address) async {
    try {
      final GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: APISetup.kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      final PlacesSearchResponse result = await places.searchByText(
        "address=$address",
      );

      if (result.results.isNotEmpty) {
        if (result.results.first.geometry?.location != null) {
          final Location location = result.results.first.geometry!.location;

          final List<geo.Placemark> placemarks =
              await geo.placemarkFromCoordinates(location.lat, location.lng);
          if (placemarks.isNotEmpty) {
            final geo.Placemark _placeMark = placemarks.first;
            String addressLine1 = _placeMark.subThoroughfare ?? "";
            String addressLine2 = _placeMark.thoroughfare ?? "";
            String addressLine3 = _placeMark.street ?? "";
            if (addressLine1.isEmpty) {
              addressLine1 = addressLine2;
              addressLine2 = addressLine3;
              addressLine3 = "";
            }
            return AddressModel(
              fullAddress: address,
              addressLine1: addressLine1,
              addressLine2: addressLine2,
              addressLine3: addressLine3,
              city: _placeMark.subAdministrativeArea ?? "",
              state: _placeMark.administrativeArea ?? "",
              country: _placeMark.country ?? "",
              zipCode: _placeMark.postalCode ?? "",
            );
          }
        }
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
