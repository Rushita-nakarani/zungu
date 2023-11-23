import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:zungu_mobile/api/api_end_points.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/drop_down_serach.dart';

class SearchLocationautocomplete extends StatefulWidget {
  Widget? prefixIcon;
  final Color fillColor;
  Color? textColor;
  final void Function() onTap;
  final void Function(String)? onAddressSelect;
  final String icon;
  TextEditingController streetController;
  SearchLocationautocomplete({
    super.key,
    this.prefixIcon,
    this.textColor,
    this.fillColor = Colors.transparent,
    required this.onTap,
    required this.streetController,
    this.icon = ImgName.landlordSearch,
    this.onAddressSelect,
  });

  @override
  State<SearchLocationautocomplete> createState() =>
      _SearchLocationautocompleteState();
}

class _SearchLocationautocompleteState
    extends State<SearchLocationautocomplete> {
  Mode mode = Mode.overlay;

  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  final searchScaffoldKey = GlobalKey<ScaffoldState>();

  List<Prediction> _serachList = [];
  // String searchValue = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownTextSearch(
      onTap: widget.onTap,
      onTextChange: (val) {
        displayPrediction(val);
      },
      onChange: (val) {
        widget.streetController.text = val;
        if (widget.onAddressSelect != null) {
          widget.onAddressSelect!(val);
        }
      },
      highlightColor: Colors.grey[50],
      controller: widget.streetController,
      overlayHeight: _serachList.isEmpty ? 0 : 300,
      items: _serachList.map((e) => e.description ?? "").toList(),
      filterFnc: (String a, String b) {
        return true;
      },
      textStyle: Theme.of(context)
          .textTheme
          .headline1
          ?.copyWith(color: widget.textColor),
      decorator: InputDecoration(
        fillColor: widget.fillColor,
        contentPadding: const EdgeInsets.only(left: 20),
        hintText: "Search Address",
        prefixIcon: widget.prefixIcon,
        suffixIcon: CustImage(
          imgURL: widget.icon,
          width: 24,
        ),
        counterText: "",
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorConstants.custGreyEEEEEF,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorConstants.custGreyEEEEEF,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        labelStyle: const TextStyle(
          fontSize: 16,
          color: ColorConstants.custDarkPurple160935,
        ),
        floatingLabelStyle: const TextStyle(
          fontSize: 20,
          color: ColorConstants.custDarkPurple160935,
        ),
      ),
    );
  }

  Future<void> displayPrediction(String val) async {
    try {
      final GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: APISetup.kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );

      final PlacesAutocompleteResponse detail = await places.autocomplete(
        val,
        types: ['street_address'],
        components: [Component(Component.country, "uk")],
      );

      _serachList = detail.predictions;

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

// void onError(PlacesAutocompleteResponse response) {

//     homeScaffoldKey.currentState.showSnackBar(
//       SnackBar(content: Text(response.errorMessage)),
//     );
//   }
