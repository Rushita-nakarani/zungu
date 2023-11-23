import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/screens/settings/business%20profile/tradesman_business_profile/view_and_edit_trade_screen.dart';

import '../../../../api/api_end_points.dart';
import '../../../../constant/img_font_color_string.dart';
import '../../../../models/auth/auth_model.dart';
import '../../../../models/settings/business_profile/fetch_profile_model.dart';
import '../../../../models/settings/business_profile/view_edit_trades_document_model.dart';
import '../../../../providers/auth/auth_provider.dart';
import '../../../../providers/auth/personal_profile_provider/personal_provider.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_title_with_line.dart';
import '../../../../widgets/lenear_container.dart';
import '../../../../widgets/loading_indicator.dart';

class EditMyLocationscreen extends StatefulWidget {
  final MyLocation? myLocation;
  final String roleId;
  final bool isFromUpdate;
  const EditMyLocationscreen({
    super.key,
    required this.roleId,
    this.myLocation,
    this.isFromUpdate = false,
  });

  @override
  State<EditMyLocationscreen> createState() => _EditMyLocationscreenState();
}

class _EditMyLocationscreenState extends State<EditMyLocationscreen> {
  TextEditingController postcordController = TextEditingController();
  final AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  double _currentSliderValue = 5;

  bool isShowOnMap = false;

  final Completer<GoogleMapController> _controller = Completer();

  static CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 8,
  );

  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  PersonalProfileProvider get personalProfileProvider =>
      Provider.of<PersonalProfileProvider>(context, listen: false);

  AuthProvider get authProvider => Provider.of<AuthProvider>(
        context,
        listen: false,
      );

  Set<Circle> circles = {
    Circle(
      circleId: const CircleId("map_id"),
      strokeColor: ColorConstants.custDarkPurple150934,
      strokeWidth: 2,
      fillColor: ColorConstants.custBlue1EC0EF.withOpacity(0.4),
      center: const LatLng(37.43296265331129, -122.08832357078792),
      radius: 5 * 1609.344,
    )
  };
  Set<Marker> _markers = <Marker>{
    const Marker(
      markerId: MarkerId('selected_location'),
      position: LatLng(37.43296265331129, -122.08832357078792),
    )
  };

  GoogleMapController? mapController;
  Location _location = Location(lat: 0.0, lng: 0.0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.myLocation != null &&
        widget.myLocation?.lng != null &&
        widget.myLocation?.lat != null) {
      postcordController.text = widget.myLocation?.postCode ?? "";
      _location = Location(
        lng: widget.myLocation!.lng,
        lat: widget.myLocation!.lat,
      );
      _currentSliderValue =
          widget.myLocation!.coverage == 0 ? 5 : widget.myLocation!.coverage;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _kGooglePlex = CameraPosition(
          target: LatLng(
            _location.lat,
            _location.lng,
          ),
          zoom: 8,
        );
        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                _location.lat,
                _location.lng,
              ),
              zoom: 8,
            ),
          ),
        );
        setCircleAndMarker(
          _location.lat,
          _location.lng,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          personalProfileProvider.fetchProfileModel?.profileCompleted == false
              ? StaticString.myLocation
              : StaticString.editMyLocation,
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: LoadingIndicator(
        loadingStatusNotifier: _loadingIndicatorNotifier,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (isShowOnMap) Container() else _buildInfoCard(context),
                if (isShowOnMap)
                  Container()
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 30,
                    ),
                    child: Consumer<PersonalProfileProvider>(
                      builder: (context, myLocationData, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTitleWithLine(
                              title: StaticString.selectArea,
                              primaryColor: ColorConstants.custDarkBlue160935,
                              secondaryColor: ColorConstants.custskyblue22CBFE,
                            ),
                            const SizedBox(height: 29),
                            TextFormField(
                              autovalidateMode: _autovalidateMode,
                              controller: postcordController,
                              cursorColor: ColorConstants.custDarkBlue160935,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                counterText: "",
                                labelText: StaticString.postcodeCity,
                                suffixIcon: InkWell(
                                  onTap: () async {
                                    final GoogleMapsPlaces places =
                                        GoogleMapsPlaces(
                                      apiKey: APISetup.kGoogleApiKey,
                                      apiHeaders: await const GoogleApiHeaders()
                                          .getHeaders(),
                                    );
                                    final PlacesSearchResponse result =
                                        await places.searchByText(
                                      "address=${postcordController.text}",
                                    );

                                    if (result.results.isNotEmpty) {
                                      if (result.results.first.geometry
                                              ?.location !=
                                          null) {
                                        final Location location = result
                                            .results.first.geometry!.location;
                                        _location = location;
                                        _kGooglePlex = CameraPosition(
                                          target: LatLng(
                                            location.lat,
                                            location.lng,
                                          ),
                                          zoom: 8,
                                        );
                                        mapController?.animateCamera(
                                          CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                              target: LatLng(
                                                location.lat,
                                                location.lng,
                                              ),
                                              zoom: 8,
                                            ),
                                          ),
                                        );
                                        setCircleAndMarker(
                                          location.lat,
                                          location.lng,
                                        );
                                      }
                                    }
                                  },
                                  child: const CustImage(
                                    imgURL: ImgName.landlordSearch,
                                    width: 24,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                SizedBox(height: isShowOnMap ? 30 : 0),
                _buildDistanceRange(),
                _buildMap(),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: CommonElevatedButton(
                    bttnText: personalProfileProvider
                                .fetchProfileModel?.profileCompleted ==
                            false
                        ? StaticString.next
                        : StaticString.uPDATE,
                    color: personalProfileProvider
                                .fetchProfileModel?.profileCompleted ==
                            false
                        ? ColorConstants.custDarkBlue150934
                        : ColorConstants.custskyblue22CBFE,
                    onPressed: updateButtonAction,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDistanceRange() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                txtTitle: StaticString.selectDistance,
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: ColorConstants.custDarkBlue160935,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      isShowOnMap = !isShowOnMap;
                    });
                  }
                },
                child: CustomText(
                  txtTitle: isShowOnMap
                      ? StaticString.hidenMap
                      : StaticString.showonMap,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custskyblue22CBFE,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: LinearContainer(
            width: MediaQuery.of(context).size.width / 8,
            color: ColorConstants.custDarkBlue160935,
          ),
        ),
        const SizedBox(height: 3),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: LinearContainer(
            width: MediaQuery.of(context).size.width / 10,
            color: ColorConstants.custskyblue22CBFE,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 30,
            top: 10,
            bottom: 20,
          ),
          child: Row(
            children: [
              Expanded(
                child: Slider(
                  thumbColor: ColorConstants.custDarkBlue150934,
                  inactiveColor: ColorConstants.custGrey707070,
                  activeColor: ColorConstants.custskyblue22CBFE,
                  value: _currentSliderValue,
                  min: 1,
                  max: 50,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    if (mounted) {
                      setState(() {
                        _currentSliderValue = value;
                        _currentSliderValue.toInt();
                        setCircleAndMarker(
                          _location.lat,
                          _location.lng,
                        );
                      });
                    }
                  },
                ),
              ),
              Text(
                "${_currentSliderValue.round().toString()} Miles",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMap() {
    return AnimatedContainer(
      padding: EdgeInsets.symmetric(
        horizontal: isShowOnMap ? 0 : 30,
      ),
      duration: const Duration(milliseconds: 100),
      height: isShowOnMap ? (MediaQuery.of(context).size.height / 1.7) : 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GoogleMap(
          circles: circles,
          markers: _markers,
          myLocationButtonEnabled: false,
          initialCameraPosition: _kGooglePlex,
          // onTap: (latlong) {
          //   _location = Location(
          //     lat: latlong.latitude,
          //     lng: latlong.longitude,
          //   );
          //   setCircleAndMarker(
          //     latlong.latitude,
          //     latlong.longitude,
          //   );
          // },
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            mapController = controller;
          },
        ),
      ),
    );
  }

  Container _buildInfoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, top: 25, right: 10, bottom: 25),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        color: ColorConstants.custskyblue22CBFE,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            txtTitle: StaticString.chooseAreabeingServiced,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: ColorConstants.backgroundColorFFFFFF,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 14),
          CustomText(
            txtTitle: StaticString.editLocationDescription,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  void setCircleAndMarker(double lat, double long) {
    circles = {
      Circle(
        circleId: const CircleId("map_id"),
        center: LatLng(
          lat,
          long,
        ),
        fillColor: ColorConstants.custBlue1EC0EF.withOpacity(0.4),
        strokeColor: ColorConstants.custDarkPurple150934,
        strokeWidth: 2,
        radius: _currentSliderValue * 1609.344,
      )
    };
    _markers = <Marker>{
      Marker(
        markerId: const MarkerId('selected_location'),
        position: LatLng(
          lat,
          long,
        ),
      )
    };
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> updateButtonAction() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      final FetchProfileModel? _profileModel =
          personalProfileProvider.fetchProfileModel;
      _profileModel?.myLocation = MyLocation(
        postCode: postcordController.text,
        coverage: _currentSliderValue,
        lat: _location.lat,
        lng: _location.lng,
      );
      await personalProfileProvider.updateMylocation(
        fetchProfileModel: _profileModel,
        roleId: widget.roleId,
      );

      if (!(personalProfileProvider.fetchProfileModel?.profileCompleted ??
          true)) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ViewEditTradeDocumentscreen(
              getProfileData: personalProfileProvider.fetchProfileModel!,
              viewEditTradesDocumentsList: viewEditDocfromRef(
                personalProfileProvider.viewEditTradesDocumentList,
              ),
              isFromUpdate: widget.isFromUpdate,
            ),
          ),
        );
      } else if (personalProfileProvider.fetchProfileModel?.profileCompleted ??
          false) {
        final AuthModel? _auth = authProvider.authModel;
        _auth?.profile?.profileCompleted =
            personalProfileProvider.fetchProfileModel?.profileCompleted ??
                false;
        authProvider.authModel = _auth;
        if (widget.isFromUpdate) {
          Navigator.of(context).pop();
        }
      } else {
        Navigator.of(context).pop();
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
