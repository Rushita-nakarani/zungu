// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/widgets/no_content_label.dart';

import '../../../api/api_end_points.dart';
import '../../../constant/img_font_color_string.dart';
import '../../../models/address_model.dart';
import '../../../models/landloard/attribute_info_model.dart';
import '../../../models/landloard/category_info_model.dart';
import '../../../models/landloard/draft_property_model.dart';
import '../../../models/landloard/property_detail_model.dart';
import '../../../models/landloard/property_feature_model.dart';
import '../../../models/landloard/upsert_detail_model.dart';
import '../../../models/submit_property_detail_model.dart';
import '../../../providers/landlord_provider.dart';
import '../../../screens/landlord/my%20properties/add_property_screen.dart';
import '../../../screens/landlord/my%20properties/select_property_popup.dart';
import '../../../services/img_upload_service.dart';
import '../../../services/in_app_purchase_service.dart';
import '../../../utils/cust_eums.dart';
import '../../../utils/custom_extension.dart';
import '../../../widgets/common_auto_textformfield.dart';
import '../../../widgets/common_elevated_button.dart';
import '../../../widgets/common_widget.dart';
import '../../../widgets/cust_image.dart';
import '../../../widgets/custom_alert.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/image_upload_widget.dart';
import '../../../widgets/loading_indicator.dart';
import '../landlord_add_description_screen.dart';
import '../landlord_add_floor_plan.dart';
import '../landlord_add_property_feature_screen.dart';
import '../landlord_add_video_screen.dart';
import '../manage_room_screen.dart';

class LandlordAddFlateScreen extends StatefulWidget {
  final PropertiesDetailModel? propertiesDetailModel;
  const LandlordAddFlateScreen({Key? key, this.propertiesDetailModel})
      : super(key: key);

  @override
  State<LandlordAddFlateScreen> createState() => _LandlordAddFlateScreenState();
}

class _LandlordAddFlateScreenState extends State<LandlordAddFlateScreen> {
  //---------------------------------Variables----------------------------//

  //-------------- Bool-----------//
  bool showPetsAllowed = false;
  bool valueOfShowPetsAllowed = false;
  bool showDisableFriednly = false;
  bool valueOfDisableFriendly = false;
  bool showPropertyType = false;
  bool showShopSizeAndRent = false;
  bool showRoomsEquipementModel = false;
  bool showCategoryRent = false;
  bool showServiceType = false;
  bool showRentAmount = false;
  bool showManageBedrooms = false;
  bool showFurnishingType = false;

  //---------------- Value Notifier--------------//
  final ValueNotifier _propertyTypeNotifier = ValueNotifier(true);
  final ValueNotifier _furnishingNotifier = ValueNotifier(true);
  final ValueNotifier _categoryNotifier = ValueNotifier(true);
  final ValueNotifier _serviceTypeNotifier = ValueNotifier(true);
  final ValueNotifier _featureNotifier = ValueNotifier(true);
  final ValueNotifier _descriptionNotifier = ValueNotifier(true);
  final ValueNotifier _petsNotifier = ValueNotifier(true);
  final ValueNotifier _disableFriednlyNotifier = ValueNotifier(true);
  final ValueNotifier _roomsNotifier = ValueNotifier(true);
  final ValueNotifier _backgroundImageNotifier = ValueNotifier(true);

  //---------- Text Editing Controller--------//
  TextEditingController descriptionController = TextEditingController();
  final TextEditingController _seachController = TextEditingController();
  TextEditingController floorSizeController = TextEditingController();
  TextEditingController annualRentController = TextEditingController();
  TextEditingController ppcController = TextEditingController();
  TextEditingController rentController = TextEditingController();

  //-----------------Model-----------//
  // SubmitPropertyDetail Model
  final SubmitPropertyDetailModel _submitPropertyDetailModel =
      SubmitPropertyDetailModel(
    photos: [],
    videos: [],
    floorPlan: [],
    features: [],
    rooms: [],
  );
  //UpsetProfile Model
  UpsetProfileModel _upsetProfile = UpsetProfileModel();
  //Draft Property Model
  DraftPropertyModel? _draftPropertyModel;

  CategoryInfoModel _categoryInfoModel = CategoryInfoModel();

  //-----------------List-----------//
  //Service Type Data List
  final List<ServiceType> _serviceTypeList = [
    ServiceType(id: 1, serviceTypeName: StaticString.serviced),
    ServiceType(id: 1, serviceTypeName: StaticString.notServiced),
  ];

  // Room Equipement Data List
  final List<RoomsEquipementModel> _roomEquipementList = [
    RoomsEquipementModel(
      equipementImageUrl: ImgName.landlordBed,
      equipementName: StaticString.bedroom,
      id: 1,
    ),
    RoomsEquipementModel(
      equipementImageUrl: ImgName.landlordBathtub,
      equipementName: StaticString.bathroom,
      id: 2,
    ),
    RoomsEquipementModel(
      equipementImageUrl: ImgName.landlordSofa,
      equipementName: StaticString.livingRoom,
      id: 3,
    ),
  ];

  // Furnishing Type Data List
  final List<FurnishingType> _furnishingType = [
    FurnishingType(furnishingName: StaticString.furnished, id: 1),
    FurnishingType(furnishingName: StaticString.partlyFurnished, id: 2),
    FurnishingType(furnishingName: StaticString.unfurnished, id: 3),
  ];

  //More Information Image List
  List<String> moreInformationImageList = [
    ImgName.video,
    ImgName.floorPlan,
  ];

  //More Information Title List
  List<String> moreInformationTitleList = [
    StaticString.video,
    StaticString.floorPlanDocs,
  ];

  //-----------------getter-------------//
  // Landlor Provider getter
  LandlordProvider get getLandlordProvider =>
      Provider.of<LandlordProvider>(context, listen: false);

  // Is Edit getter method
  bool get isEdit => widget.propertiesDetailModel != null;

  // Loading Indicator Notifier
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  //Property Type Enum
  PropertyType _addPropertyScreenType = PropertyType.House;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  //---------------------------------UI----------------------------//
  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  //---------------------------------Widgets----------------------------//

  // App bar
  AppBar _buildAppBar() {
    return AppBar(
      title: CustomText(
        txtTitle: isEdit ? StaticString.editProperty : StaticString.addProperty,
      ),
      backgroundColor: ColorConstants.custDarkPurple500472,
    );
  }

  // Body
  Widget _buildBody() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: keyboardHideOntap,
      child: SafeArea(
        child: Consumer<LandlordProvider>(
          builder: (context, landlord, child) => (landlord
                      .getCategoryList.isEmpty &&
                  landlord.getPropertyElementModel.isEmpty)
              ? NoContentLabel(
                  title: StaticString.nodataFound,
                  onPress: fetchData,
                )
              : SingleChildScrollView(
                  // physics: const ClampingScrollPhysics(),
                  child: Stack(
                    children: [
                      // Back Ground Category Image
                      ValueListenableBuilder(
                        valueListenable: _backgroundImageNotifier,
                        builder: (context, val, child) {
                          return Stack(
                            children: [
                              CustImage(
                                imgURL: _categoryInfoModel.coverImage,
                                width: double.infinity,
                                height: 120,
                              ),
                              Container(
                                width: double.infinity,
                                height: 120,
                                color: ColorConstants.custDarkBlue160935
                                    .withOpacity(0.65),
                              )
                            ],
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 100),

                            // Search Fields card
                            _buildSearchFieldCard(),
                            const SizedBox(height: 40),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Property card list
                                  _buildPropertyCardList(),
                                  const SizedBox(height: 40),

                                  // property type selection content
                                  Visibility(
                                    visible: showPropertyType,
                                    child: getLandlordProvider
                                            .getCategoryList.isEmpty
                                        ? Container()
                                        : _buildPropertyTypeCOntent(
                                            propertyTypeList:
                                                getLandlordProvider
                                                    .getCategoryList
                                                    .firstWhere(
                                                      (e) =>
                                                          e.propertyTypeEnum ==
                                                          _addPropertyScreenType,
                                                    )
                                                    .propertyType,
                                          ),
                                  ),
                                  SizedBox(height: showPropertyType ? 40 : 0),

                                  // Shop Size And Rent Amount TextField content
                                  Visibility(
                                    visible: showShopSizeAndRent,
                                    child: _buildShopSizeAndRent(),
                                  ),
                                  SizedBox(
                                    height: showShopSizeAndRent ? 40 : 0,
                                  ),

                                  // Service type selection content
                                  Visibility(
                                    visible: showServiceType,
                                    child: _buildServiceTypeCOntent(),
                                  ),
                                  SizedBox(height: showServiceType ? 40 : 0),

                                  // Category Class Content
                                  Visibility(
                                    visible: showCategoryRent &&
                                        getLandlordProvider
                                            .getAttributeList.isNotEmpty,
                                    child: _buildCategoryClass(),
                                  ),
                                  SizedBox(height: showCategoryRent ? 40 : 0),

                                  // Enter amount Text filed
                                  Visibility(
                                    visible: showRentAmount,
                                    child: _enterAmountField(),
                                  ),
                                  SizedBox(height: showRentAmount ? 40 : 0),

                                  // Room Portion
                                  Visibility(
                                    visible: showRoomsEquipementModel,
                                    child: _buildRoomsPortion(),
                                  ),
                                  SizedBox(
                                    height: showRoomsEquipementModel ? 40 : 0,
                                  ),

                                  // Manage Bed Room Content
                                  Visibility(
                                    visible: showManageBedrooms,
                                    child: _buildManageBedRoom(),
                                  ),
                                  SizedBox(height: showManageBedrooms ? 45 : 0),

                                  // furnishing selection content
                                  Visibility(
                                    visible: showFurnishingType,
                                    child: _buildFurnishingSelections(),
                                  ),
                                  SizedBox(height: showFurnishingType ? 45 : 0),

                                  // Add Feature Content Card
                                  ValueListenableBuilder(
                                    valueListenable: _featureNotifier,
                                    builder: (context, val, child) {
                                      return _buildAddFeatureContent();
                                    },
                                  ),
                                  const SizedBox(height: 45),

                                  //Add DEscription Content card
                                  _buildAddDescriptionContent(),
                                  const SizedBox(height: 45),

                                  // Pet Allowed Swicth Content
                                  Visibility(
                                    visible: showPetsAllowed,
                                    child: ValueListenableBuilder(
                                      valueListenable: _petsNotifier,
                                      builder: (context, val, child) {
                                        return _buildPetsAllowedContent();
                                      },
                                    ),
                                  ),
                                  SizedBox(height: showPetsAllowed ? 45 : 0),

                                  // Disable Friendly Swicth Content
                                  Visibility(
                                    visible: showDisableFriednly,
                                    child: ValueListenableBuilder(
                                      valueListenable: _disableFriednlyNotifier,
                                      builder: (context, val, child) {
                                        return _buildDisableFriendlyContent();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: showDisableFriednly ? 45 : 0,
                                  ),

                                  // Photos Content
                                  _buildPhotoesContent(),
                                  const SizedBox(height: 45),

                                  // More Information Content
                                  _buildMoreInformationContent(),
                                  const SizedBox(height: 45),

                                  // Next Elevated Button
                                  CommonElevatedButton(
                                    bttnText: isEdit
                                        ? StaticString.uPDATE
                                        : StaticString.next,
                                    onPressed: nextButtonAction,
                                    color: isEdit
                                        ? null
                                        : ColorConstants.custBlue1EC0EF,
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  // Search Text Fields card
  Widget _buildSearchFieldCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey707070.withOpacity(
              0.30,
            ),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomText(
              txtTitle: StaticString.yourPropertyAddress,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custBlue1EC0EF,
                  ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          SearchLocationautocomplete(
            streetController: _seachController,
            onAddressSelect: (address) async {
              checkPropertyExistence(address);
            },
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // Property card  Grid View list
  Widget _buildPropertyCardList() {
    return GridView.builder(
      itemCount: getLandlordProvider.getCategoryList.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 20,
        childAspectRatio: 10 / 12,
      ),
      itemBuilder: (context, index) => _propertyCard(
        categoryInfoModel: getLandlordProvider.getCategoryList[index],
        addPropertyScreenType:
            getLandlordProvider.getCategoryList[index].propertyTypeEnum,
      ),
    );
  }

  // Property Card
  Widget _propertyCard({
    required CategoryInfoModel categoryInfoModel,
    required PropertyType addPropertyScreenType,
  }) {
    return FittedBox(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              propertyTypeMgnt(categoryInfoModel, addPropertyScreenType);
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _addPropertyScreenType == addPropertyScreenType
                    ? ColorConstants.custDarkPurple500472
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
                    blurRadius: 12,
                  ),
                ],
              ),

              //Property Image
              child: CustImage(
                imgURL: categoryInfoModel.iconImage,
                height: 60,
                width: 60,
              ),
            ),
          ),
          const SizedBox(height: 6),

          //Property Name Text
          CustomText(
            txtTitle: categoryInfoModel.name,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.custBlack2B1818,
                ),
          )
        ],
      ),
    );
  }

  // property type selection content
  Widget _buildPropertyTypeCOntent({
    required List<CategoryInfoModel> propertyTypeList,
  }) {
    return commonHeaderLable(
      title: StaticString.propertyType,
      child: ValueListenableBuilder(
        valueListenable: _propertyTypeNotifier,
        builder: (context, val, child) {
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
              propertyTypeList.length,
              (index) => commonPropertyCard(
                ontap: () => propertyTypeCardOntap(
                  propertyType: propertyTypeList[index],
                ),
                isSelected: _submitPropertyDetailModel.type ==
                    propertyTypeList[index].id,
                propertyName: propertyTypeList[index].name,
              ),
            ),
          );
        },
      ),
    );
  }

  // Shop Size And Rent Amount text field
  Widget _buildShopSizeAndRent() {
    return commonHeaderLable(
      title: _addPropertyScreenType.name + StaticString.shopSizeAndRent,
      child: Column(
        children: [
          //Floor Size Textfield
          TextFormField(
            controller: floorSizeController,
            onChanged: (val) => floorSizeTextFieldOntap(val),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              counterText: "",
              labelText: StaticString.floorSize,
            ),
          ),
          const SizedBox(height: 24),

          //Annual Rent TextField
          TextFormField(
            controller: annualRentController,
            onChanged: (val) => annualRentTextfieldOntap(val),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: commonImputdecoration(
              labletext: StaticString.annualRent,
            ),
          ),
          const SizedBox(height: 24),

          // Price Per Square Foot Textfield
          TextFormField(
            controller: ppcController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (val) => ppsFootTextFieldOntap(val),
            decoration: commonImputdecoration(
              labletext: StaticString.pricePerSquareFoot,
            ),
          ),
        ],
      ),
    );
  }

  // Service type content
  Widget _buildServiceTypeCOntent() {
    return commonHeaderLable(
      title: StaticString.serviceType,
      child: ValueListenableBuilder(
        valueListenable: _serviceTypeNotifier,
        builder: (context, value, child) => Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(
            _serviceTypeList.length,
            (index) => commonPropertyCard(
              ontap: () =>
                  serviceTypeCardontap(servicetype: _serviceTypeList[index]),
              isSelected: _submitPropertyDetailModel.serviceType ==
                  _serviceTypeList[index].serviceTypeName,
              propertyName: _serviceTypeList[index].serviceTypeName,
            ),
          ),
        ),
      ),
    );
  }

  // Category Class Content
  Widget _buildCategoryClass() {
    return commonHeaderLable(
      title: StaticString.categoryClass,
      child: ValueListenableBuilder(
        valueListenable: _categoryNotifier,
        builder: (context, val, child) {
          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(
              getLandlordProvider.getAttributeList.length,
              (index) => InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => categoryCardOntap(
                  attributeModel: getLandlordProvider.getAttributeList[index],
                ),
                //Category Card
                child: Container(
                  height: 46,
                  width: getLandlordProvider
                          .getAttributeList[index].attributeValue.length *
                      20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _submitPropertyDetailModel.classId ==
                            getLandlordProvider.getAttributeList[index].id
                        ? ColorConstants.custBlue1BC4F4
                        : Colors.white,
                    borderRadius: BorderRadius.circular(200),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
                        blurRadius: 12,
                      ),
                    ],
                  ),

                  //Category attribute text
                  child: CustomText(
                    txtTitle: getLandlordProvider
                        .getAttributeList[index].attributeValue,
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          color: _submitPropertyDetailModel.classId ==
                                  getLandlordProvider.getAttributeList[index].id
                              ? Colors.white
                              : ColorConstants.custGrey707070,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Enter amount filed
  Widget _enterAmountField() {
    return TextFormField(
      controller: rentController,
      onChanged: (val) => rentAmountTextfieldOntap(val),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.next,
      style: Theme.of(context).textTheme.headline2?.copyWith(
            color: ColorConstants.custGrey707070,
            fontWeight: FontWeight.w500,
          ),
      decoration: commonImputdecoration(
        labletext: StaticString.rentAmount.addStarAfter,
      ),
    );
  }

  // Rooms Portion
  Widget _buildRoomsPortion() {
    return commonHeaderLable(
      title: StaticString.rooms,
      child: ValueListenableBuilder(
        valueListenable: _roomsNotifier,
        builder: (context, val, child) {
          return Row(
            children: [
              Expanded(
                child: _buildRoomsCard(
                  _roomEquipementList[0],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: _buildRoomsCard(
                  _roomEquipementList[1],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: _buildRoomsCard(
                  _roomEquipementList[2],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Manage Bed room Conetent
  Widget _buildManageBedRoom() {
    return ValueListenableBuilder(
      valueListenable: _roomsNotifier,
      builder: (context, val, child) {
        return InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: manageBedRoomOntap,
          child: Column(
            children: [
              Container(
                height: 1,
                width: double.infinity,
                color: ColorConstants.custLightGreyEBEAEA,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: _submitPropertyDetailModel.rooms.isNotEmpty
                    ? _manageBedRoomView()
                    : _manageBedroomRow(),
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: ColorConstants.custLightGreyEBEAEA,
              ),
            ],
          ),
        );
      },
    );
  }

  //Manage Bed Room View
  Widget _manageBedRoomView() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Manage Bed Room text
            CustomText(
              txtTitle: StaticString.manageBedRooms,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    color: ColorConstants.custDarkBlue160935,
                    fontWeight: FontWeight.w600,
                  ),
            ),

            // Edit Icon Image
            Container(
              height: 30,
              width: 30,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: ColorConstants.custBlue1BC4F4,
                  width: 2,
                ),
              ),
              child: const CustImage(
                imgURL: ImgName.editIcon,
                imgColor: ColorConstants.custGrey707070,
              ),
            )
          ],
        ),
        const SizedBox(height: 10),

        // Selected Room Name and type text List View
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemCount: _submitPropertyDetailModel.rooms.length,
          itemBuilder: (context, index) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Room Name text
              CustomText(
                txtTitle: _submitPropertyDetailModel.rooms[index].name,
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: ColorConstants.custGrey707070,
                      fontWeight: FontWeight.w500,
                    ),
              ),

              //Room Type Name text
              CustomText(
                txtTitle: _submitPropertyDetailModel.rooms[index].typeName,
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: ColorConstants.custBlue1BC4F4,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Manage Bed Room Row
  Widget _manageBedroomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Manage Bed Rooms Text
        CustomText(
          txtTitle: StaticString.manageBedRooms,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                color: ColorConstants.custDarkBlue160935,
                fontWeight: FontWeight.w600,
              ),
        ),

        // Add Icon
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            color: ColorConstants.custBlue1BC4F4,
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  // furnishing selection content
  Widget _buildFurnishingSelections() {
    return commonHeaderLable(
      title: StaticString.furnishing,
      child: ValueListenableBuilder(
        valueListenable: _furnishingNotifier,
        builder: (context, val, child) {
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
              _furnishingType.length,
              (index) => commonPropertyCard(
                ontap: () => furnishingCardOntap(
                  furnishingTypeModel: _furnishingType[index],
                ),
                isSelected: _submitPropertyDetailModel.furnishedType ==
                    _furnishingType[index].furnishingName,
                propertyName: _furnishingType[index].furnishingName,
              ),
            ),
          );
        },
      ),
    );
  }

  // Add Features Content
  Widget _buildAddFeatureContent() {
    final List<PropertyFeatureModel> _selectedFeaturesList =
        _submitPropertyDetailModel.features
            .where(
              (element) =>
                  element.switchValue ||
                  element.child.any((element) => element.switchValue),
            )
            .toList();
    return commonHeaderLable(
      title: StaticString.addFeature,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
              blurRadius: 10,
            ),
          ],
        ),
        width: double.infinity,
        child: Stack(
          children: [
            if (_selectedFeaturesList.isNotEmpty)
              //Selected Features List
              _selectedFeaturesListView(
                selectedFeaturesList: _selectedFeaturesList,
              )
            else
              // Add Fetures Text Field
              TextFormField(
                cursorColor: ColorConstants.custBlue1BC4F4,
                onTap: featuresAddIconOntap,
                readOnly: true,
                decoration:
                    _custTextFieldDecoration(hintText: StaticString.addFeature),
              ),
            // Add Icon
            _addFeaturesAddIcon(selectedFeaturesList: _selectedFeaturesList)
          ],
        ),
      ),
    );
  }

  // Selected Features List
  Widget _selectedFeaturesListView({
    required List<PropertyFeatureModel> selectedFeaturesList,
  }) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 12,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: selectedFeaturesList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              children: [
                //Next Arrow ky Icon Image
                const CustImage(
                  imgURL: ImgName.nextKeyAerrow,
                  height: 15,
                  width: 15,
                  imgColor: ColorConstants.custGrey707070,
                ),
                const SizedBox(width: 8),

                // Selected Features Name text
                CustomText(
                  txtTitle: selectedFeaturesList[index].name,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custDarkBlue150934,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 9,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: selectedFeaturesList[index]
                  .child
                  .where(
                    (element) => element.switchValue,
                  )
                  .toList()
                  .length,
              itemBuilder: (context, sIndex) {
                return Row(
                  children: [
                    const SizedBox(width: 24),
                    //Dot Image
                    const CustImage(
                      imgURL: ImgName.dot,
                      imgColor: ColorConstants.custGrey707070,
                    ),
                    const SizedBox(width: 8),

                    // Selected Features Switch Value Text
                    CustomText(
                      txtTitle: selectedFeaturesList[index]
                          .child
                          .where(
                            (element) => element.switchValue,
                          )
                          .toList()[sIndex]
                          .name,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstants.custGrey707070,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                );
              },
            )
          ],
        );
      },
    );
  }

  // Add Features Add Icon
  Widget _addFeaturesAddIcon({
    required List<PropertyFeatureModel> selectedFeaturesList,
  }) {
    return Positioned(
      top: 0,
      right: 0,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: featuresAddIconOntap,
        child: Container(
          height: 36,
          width: 48,
          decoration: const BoxDecoration(
            color: ColorConstants.custBlue1EC0EF,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(4),
            ),
          ),
          child: selectedFeaturesList.isEmpty
              ? const Icon(
                  Icons.add,
                  color: Colors.white,
                )
              : const CustImage(
                  imgURL: ImgName.editIcon,
                  height: 24,
                  width: 24,
                ),
        ),
      ),
    );
  }

  // Add Description Content
  Widget _buildAddDescriptionContent() {
    return commonHeaderLable(
      title: StaticString.addDescription,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
              blurRadius: 10,
            ),
          ],
        ),
        width: double.infinity,
        child: ValueListenableBuilder(
          valueListenable: _descriptionNotifier,
          builder: (context, val, child) {
            return Stack(
              children: [
                ValueListenableBuilder(
                  valueListenable: _descriptionNotifier,
                  builder: (context, val, child) {
                    return
                        // Add Description Textfild
                        TextFormField(
                      controller: descriptionController,
                      cursorColor: ColorConstants.custBlue1BC4F4,
                      readOnly: true,
                      onTap: addDescriptionAddOntap,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: ColorConstants.custGrey707070,
                            fontWeight: FontWeight.w500,
                          ),
                      maxLines: null,
                      decoration: _custTextFieldDecoration(
                        hintText: StaticString.addDescription,
                      ),
                    );
                  },
                ),
                // add Icon Button
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: addDescriptionAddOntap,
                    child: Container(
                      height: 36,
                      width: 48,
                      decoration: const BoxDecoration(
                        color: ColorConstants.custBlue1EC0EF,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topRight: Radius.circular(4),
                        ),
                      ),
                      child: descriptionController.text.isEmpty
                          ? const Icon(
                              Icons.add,
                              color: Colors.white,
                            )
                          : const CustImage(
                              imgURL: ImgName.editIcon,
                              height: 24,
                              width: 24,
                            ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  // Pet allowed Content
  Widget _buildPetsAllowedContent() {
    return commonHeaderLable(
      title: StaticString.petsAllowed,
      spaceBetween: 14,
      child: custDisableFrdlySwitch(
        textColor: ColorConstants.custGrey707070,
        switchValueText: StaticString.doYouAllowPetsIn,
        switchValue: _submitPropertyDetailModel.petAllowed,
        switchOntap: (val) {
          _submitPropertyDetailModel.petAllowed = val;
          _petsNotifier.notifyListeners();
        },
      ),
    );
  }

  // Disable Friendly Content
  Widget _buildDisableFriendlyContent() {
    return commonHeaderLable(
      title: StaticString.disableFriednly,
      spaceBetween: 20,
      child: custDisableFrdlySwitch(
        textColor: ColorConstants.custGrey707070,
        switchValueText: StaticString.isTheHouse,
        switchValue: _submitPropertyDetailModel.disabledFriendly,
        switchOntap: (val) {
          _submitPropertyDetailModel.disabledFriendly = val;

          _disableFriednlyNotifier.notifyListeners();
        },
      ),
    );
  }

  // Photos Content
  Widget _buildPhotoesContent() {
    return commonHeaderLable(
      title: StaticString.photoes,
      spaceBetween: 26,
      child: UploadMediaWidget(
        images: _submitPropertyDetailModel.photos,
        image: ImgName.landlordCamera,
        userRole: UserRole.LANDLORD,
        multipicker: true,
        maxUpload: 20,
        imageList: (images) {
          _submitPropertyDetailModel.photos = images;
        },
      ),
    );
  }

  // More Information Content
  Widget _buildMoreInformationContent() {
    return commonHeaderLable(
      title: StaticString.moreInformation,
      spaceBetween: 10,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => moreInformationCardOntap(index: index),
          child: _moreInformationCard(
            imgUrl: moreInformationImageList[index],
            title: moreInformationTitleList[index],
          ),
        ),
        separatorBuilder: (context, index) => Container(
          height: 1,
          color: ColorConstants.custGreyEBEAEA,
          width: double.infinity,
        ),
        itemCount: moreInformationImageList.length,
      ),
    );
  }

  //----------------------------------Helper Widget---------------------------//
  // Custom Room Card
  Widget _buildRoomsCard(RoomsEquipementModel roomsEquipementModel) {
    return Column(
      children: [
        //Room Item Card
        Container(
          height: 50,
          width: 50,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
                blurRadius: 12,
              ),
            ],
          ),

          //Room Item Image
          child: CustImage(
            imgURL: roomsEquipementModel.equipementImageUrl,
            boxfit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 2),

        //Room Item Name Text
        CustomText(
          txtTitle: roomsEquipementModel.equipementName,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
        ),
        const SizedBox(height: 10),

        // Plus Minus and Count Card
        Container(
          height: 30,
          width: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
                blurRadius: 12,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Minus Icon
              Expanded(
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => roomMinusOntap(
                    roomsEquipementModel: roomsEquipementModel,
                  ),
                  child: const Icon(
                    Icons.remove,
                    size: 14,
                    color: ColorConstants.custGrey707070,
                  ),
                ),
              ),

              // Room Equipement Count Text
              CustomText(
                txtTitle: roomsEquipementModel.equipementCount.toString(),
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: ColorConstants.custBlue1EC0EF,
                    ),
              ),

              // Plus Icon
              Expanded(
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => roomPlusOntap(
                    roomsEquipementModel: roomsEquipementModel,
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 14,
                    color: ColorConstants.custGrey707070,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // TextField Input Decoration (Currency Symboll)
  InputDecoration commonImputdecoration({
    required String labletext,
  }) {
    return InputDecoration(
      counterText: "",
      labelText: labletext,
      prefixText: StaticString.currency.addSpaceAfter,
    );
  }

  // Add Features And Add DEscription Textfield Decoration
  InputDecoration _custTextFieldDecoration({required String hintText}) {
    return InputDecoration(
      contentPadding: EdgeInsets.only(
        left: 20,
        right: 10,
        top: descriptionController.text.isEmpty ? 0 : 40,
        bottom: descriptionController.text.isEmpty ? 0 : 20,
      ),
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
            color: ColorConstants.custGreyAEAEAE,
          ),
      border: InputBorder.none,
      errorBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
    );
  }

  // Custom More Information Card
  Widget _moreInformationCard({
    required String imgUrl,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Row(
        children: [
          // More Information Item Image
          CustImage(
            imgURL: imgUrl,
            height: 24,
            width: 24,
            boxfit: BoxFit.contain,
          ),
          const SizedBox(width: 12),

          // More Information Item Title Text
          CustomText(
            txtTitle: title,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey707070,
                ),
          ),
          const Spacer(),

          // Arrow Icon
          const Icon(
            Icons.keyboard_arrow_right,
            color: ColorConstants.custGrey707070,
          )
        ],
      ),
    );
  }
  //--------------------------------Helper Function---------------------------//

  //Fetch Data
  Future<void> fetchData() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );

      // if (getLandlordProvider.getCategoryList.isEmpty) {
      await getLandlordProvider.fetchCategoryList();
      await getLandlordProvider.fetchProperty();
      if (isEdit) {
        await editProperty();
      } else {
        final DraftPropertyModel _draftProperty =
            await getLandlordProvider.draftProperty();
        if (_draftProperty.propertyDetail != null) {
          showAlert(
            hideButton: true,
            showCustomContent: true,
            barrierDismissible: false,
            context: context,
            content: SelectPropertyPopup(
              onDiscard: discardOntapAction,
              onContintue: () async {
                _draftPropertyModel = _draftProperty;
                final PropertyDetail? _propertyDetail =
                    _draftPropertyModel?.propertyDetail;
                _upsetProfile.id =
                    _draftPropertyModel?.propertyDetail?.id ?? "";
                if (_propertyDetail != null) {
                  _submitPropertyDetailModel.category =
                      _propertyDetail.category;
                  _submitPropertyDetailModel.type = _propertyDetail.type;

                  _submitPropertyDetailModel.furnishedType =
                      _propertyDetail.furnishing;
                  _submitPropertyDetailModel.rentalType = _propertyDetail.name;
                  _submitPropertyDetailModel.realEstate =
                      _propertyDetail.realEstate;
                  _submitPropertyDetailModel.serviceType =
                      _propertyDetail.serviceType;
                }
                for (final room in _roomEquipementList) {
                  if (room.id == 1) {
                    room.equipementCount = _propertyDetail?.bedRoom ?? 0;
                  } else if (room.id == 2) {
                    room.equipementCount = _propertyDetail?.bathRoom ?? 0;
                  } else if (room.id == 3) {
                    room.equipementCount = _propertyDetail?.livingRoom ?? 0;
                  }
                }

                for (final property
                    in getLandlordProvider.getPropertyElementModel) {
                  for (final feature in _propertyDetail?.features ?? []) {
                    if (property.id == feature) {
                      property.switchValue = true;
                    }
                    for (final child in property.child) {
                      if (child.id == feature) {
                        child.switchValue = true;
                      }
                    }
                  }
                }
                _submitPropertyDetailModel.features =
                    getLandlordProvider.getPropertyElementModel;
                if (_propertyDetail?.additionalAttributes.isNotEmpty ?? false) {
                  final List<Room> _rooms = [];

                  for (int i = 0;
                      i <
                          (_propertyDetail
                                  ?.additionalAttributes.first.value.length ??
                              0);
                      i++) {
                    final Room _room = Room(
                      name: _propertyDetail!
                          .additionalAttributes.first.value[i].name,
                      typeId: _propertyDetail
                          .additionalAttributes.first.value[i].typeId,
                    );
                    final List<AttributeInfoModel> _roomList =
                        getLandlordProvider.getAttributeList
                            .where((element) => element.id == _room.typeId)
                            .toList();
                    if (_roomList.isNotEmpty) {
                      _room.typeId = _roomList.first.id;
                      _room.typeName = _roomList.first.attributeValue;
                      _room.name = _propertyDetail
                          .additionalAttributes.first.value[i].name;
                    }
                    _rooms.add(_room);
                  }

                  _submitPropertyDetailModel.rooms = _rooms;
                }

                _submitPropertyDetailModel.address = _propertyDetail?.addressId;
                _submitPropertyDetailModel.photos =
                    _draftPropertyModel?.propertyResource?.photos ?? [];
                _submitPropertyDetailModel.videos =
                    _draftPropertyModel?.propertyResource?.videos ?? [];
                _submitPropertyDetailModel.floorPlan =
                    _draftPropertyModel?.propertyResource?.floorPlan ?? [];
                _submitPropertyDetailModel.petAllowed =
                    _propertyDetail!.petAllowed;
                _submitPropertyDetailModel.disabledFriendly =
                    _propertyDetail.disabledFriendly;
                _submitPropertyDetailModel.description =
                    _propertyDetail.description;
                _submitPropertyDetailModel.bedRoom = _propertyDetail.bedRoom;
                _submitPropertyDetailModel.bathRoom = _propertyDetail.bathRoom;
                _submitPropertyDetailModel.livingRoom =
                    _propertyDetail.livingRoom;
                descriptionController.text = _propertyDetail.description;
                _submitPropertyDetailModel.rent = _propertyDetail.rent;

                rentController.text = _propertyDetail.rent.toString();
                floorSizeController.text = _propertyDetail.floorSize.toString();
                _submitPropertyDetailModel.floorSize =
                    _propertyDetail.floorSize;
                annualRentController.text = _propertyDetail.rent.toString();
                _submitPropertyDetailModel.rent = _propertyDetail.rent;
                ppcController.text = _propertyDetail.pps.toString();
                _submitPropertyDetailModel.pps = _propertyDetail.pps;
                _submitPropertyDetailModel.classId = _propertyDetail.classId;
                final List<String> _classList =
                    getLandlordProvider.getAttributeList
                        .where(
                          (element) => element.id == _propertyDetail.classId,
                        )
                        .map((e) => e.attributeValue)
                        .toList();
                if (_classList.isNotEmpty) {
                  _submitPropertyDetailModel.className = _classList.first;
                }
                if (_propertyDetail.addressId?.fullAddress.isNotEmpty ??
                    false) {
                  _seachController.text =
                      _propertyDetail.addressId!.fullAddress;
                  await checkPropertyExistence(
                    _propertyDetail.addressId!.fullAddress,
                  );
                }
                final List<CategoryInfoModel> _categoryList =
                    getLandlordProvider.getCategoryList
                        .where(
                          (element) => element.id == _propertyDetail.category,
                        )
                        .toList();
                if (_categoryList.isNotEmpty) {
                  final List<CategoryInfoModel> propertyType = _categoryList
                      .first.propertyType
                      .where((element) => element.id == _propertyDetail.type)
                      .toList();

                  if (propertyType.isNotEmpty) {
                    _submitPropertyDetailModel.propertyTypeName =
                        propertyType.first.name;
                  }
                  propertyTypeMgnt(
                    _categoryList.first,
                    _categoryList.first.propertyTypeEnum,
                  );
                }
              },
            ),
          );
        } else {
          initialConfig();
        }
      }
      PaymentService.instance.initConnection();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  // Initial Config
  Future<void> initialConfig() async {
    // if (getLandlordProvider.getCategoryList.isNotEmpty) {
    _submitPropertyDetailModel.category =
        getLandlordProvider.getCategoryList[0].id;

    _categoryInfoModel = getLandlordProvider.getCategoryList[0];
    _submitPropertyDetailModel.category = _categoryInfoModel.id;
    _addPropertyScreenType = _categoryInfoModel.propertyTypeEnum;

    _submitPropertyDetailModel.rentalType = _categoryInfoModel.name;
    _submitPropertyDetailModel.realEstate = _categoryInfoModel.realEstate;
    propertyTypeMgnt(
      _categoryInfoModel,
      _categoryInfoModel.propertyTypeEnum,
    );
    _backgroundImageNotifier.notifyListeners();

    // }
    // }
  }

  // Dicard On tap Action
  Future<void> discardOntapAction() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      Navigator.of(context).pop();
      await Provider.of<LandlordProvider>(context, listen: false)
          .deleteDraftProperty();
      await initialConfig();
    } catch (e) {
      // showAlert(context: context, message: e);
      rethrow;
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  // Property Type Management
  void propertyTypeMgnt(
    CategoryInfoModel categoryInfoModel,
    PropertyType addPropertyScreenType,
  ) {
    if (_addPropertyScreenType != addPropertyScreenType) {
      // _submitPropertyDetailModel.type = "";
    }

    _addPropertyScreenType = addPropertyScreenType;

    switch (_addPropertyScreenType) {
      case PropertyType.House:
        showCategoryRent = false;
        showDisableFriednly = true;
        showFurnishingType = true;
        showManageBedrooms = false;
        showPetsAllowed = true;
        showPropertyType = true;
        showRentAmount = true;
        showRoomsEquipementModel = true;
        showShopSizeAndRent = false;
        showServiceType = false;

        break;
      case PropertyType.Flats:
        showCategoryRent = false;
        showDisableFriednly = true;
        showFurnishingType = true;
        showManageBedrooms = false;
        showPetsAllowed = true;
        showPropertyType = false;
        showRentAmount = true;
        showRoomsEquipementModel = true;
        showShopSizeAndRent = false;
        showServiceType = false;

        break;
      case PropertyType.HMO:
        fetchAttributes(StaticString.hmoRoomType);
        showCategoryRent = false;
        showDisableFriednly = true;
        showFurnishingType = true;
        showManageBedrooms = true;
        showPetsAllowed = true;
        showPropertyType = true;
        showRentAmount = true;
        showRoomsEquipementModel = true;
        showShopSizeAndRent = false;
        showServiceType = false;

        break;
      case PropertyType.Shops:
        fetchAttributes(StaticString.categoryClass1);
        showCategoryRent = true;
        showDisableFriednly = false;
        showFurnishingType = false;
        showManageBedrooms = false;
        showPetsAllowed = false;
        showPropertyType = false;
        showRentAmount = false;
        showRoomsEquipementModel = false;
        showShopSizeAndRent = true;
        showServiceType = false;

        break;
      case PropertyType.Office:
        fetchAttributes(StaticString.categoryClass1);
        showCategoryRent = true;
        showDisableFriednly = false;
        showFurnishingType = true;
        showManageBedrooms = false;
        showPetsAllowed = false;
        showPropertyType = false;
        showRentAmount = false;
        showRoomsEquipementModel = false;
        showShopSizeAndRent = true;
        showServiceType = true;

        break;
      case PropertyType.Industry:
        fetchAttributes(StaticString.categoryClass1);
        showCategoryRent = true;
        showDisableFriednly = false;
        showFurnishingType = false;
        showManageBedrooms = false;
        showPetsAllowed = false;
        showPropertyType = false;
        showRentAmount = false;
        showRoomsEquipementModel = false;
        showShopSizeAndRent = true;
        showServiceType = false;

        break;
      case PropertyType.None:
        break;
    }

    _submitPropertyDetailModel.category = categoryInfoModel.id;
    _submitPropertyDetailModel.rentalType = categoryInfoModel.name;
    _submitPropertyDetailModel.realEstate = categoryInfoModel.realEstate;

    _categoryInfoModel = categoryInfoModel;
    if (mounted) {
      setState(() {});
    }
  }

  // Fetch Attribute Data
  Future<void> fetchAttributes(String attribute) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      // if (getLandlordProvider.getAttributeList.isEmpty) {
      await getLandlordProvider.attributeList(attribute: attribute);
      // }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  // Check Property Existence
  Future<void> checkPropertyExistence(
    String address,
  ) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );

      final GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: APISetup.kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      final PlacesSearchResponse result = await places.searchByText(
        "${StaticString.address.toLowerCase()}=$address",
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
            if (!isEdit) {
              final bool isExist =
                  await getLandlordProvider.checkPropertyExistence(
                addressLine1,
                _placeMark.postalCode ?? "",
              );
              if (isExist) {
                showAlert(
                  context: context,
                  message: StaticString.thisPropertyAlreadyExist,
                );
                return;
              }
            }

            _submitPropertyDetailModel.address = AddressModel(
              fullAddress: address,
              addressLine1: addressLine1,
              addressLine2: addressLine2,
              addressLine3: addressLine3,
              city: _placeMark.subAdministrativeArea ?? "",
              state: _placeMark.administrativeArea ?? "",
              country: _placeMark.country ?? "",
              zipCode: _placeMark.postalCode ?? "",
            );
            _submitPropertyDetailModel.lat = location.lat.toString();
            _submitPropertyDetailModel.lng = location.lng.toString();
          }
        }
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  //--------------------------- button action -------------------------//

  //Keyboard Hide Ontap
  void keyboardHideOntap() {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  // Floor Size Textfield Ontap
  void floorSizeTextFieldOntap(String val) {
    if (val.isNotEmpty) {
      _submitPropertyDetailModel.floorSize =
          double.parse(double.parse(val).toStringAsFixed(0));
    }
    if (val.isNotEmpty && (_submitPropertyDetailModel.rent != 0)) {
      _submitPropertyDetailModel.pps = _submitPropertyDetailModel.rent /
          _submitPropertyDetailModel.floorSize;
      ppcController.text = _submitPropertyDetailModel.pps.toStringAsFixed(2);
    }
  }

  // annual Rent TextField Ontap
  void annualRentTextfieldOntap(String val) {
    if (val.isNotEmpty) {
      _submitPropertyDetailModel.rent =
          double.parse(double.parse(val).toStringAsFixed(0));
    }
    if (val.isNotEmpty && (_submitPropertyDetailModel.floorSize != 0)) {
      _submitPropertyDetailModel.pps = _submitPropertyDetailModel.rent /
          _submitPropertyDetailModel.floorSize;
      ppcController.text = _submitPropertyDetailModel.pps.toStringAsFixed(2);
    }
  }

  // Price Per Square Foot Textfield Ontap
  void ppsFootTextFieldOntap(String val) {
    if (val.isNotEmpty) {
      _submitPropertyDetailModel.pps = double.parse(val);
    }
    if (val.isNotEmpty && (_submitPropertyDetailModel.rent != 0)) {
      _submitPropertyDetailModel.rent =
          _submitPropertyDetailModel.pps * _submitPropertyDetailModel.floorSize;
      annualRentController.text =
          _submitPropertyDetailModel.pps.toStringAsFixed(2);
    }
  }

  // Rent Amount TextField Ontap
  void rentAmountTextfieldOntap(String val) {
    _submitPropertyDetailModel.rent =
        double.parse(double.parse(val).toStringAsFixed(0));
  }

  // Servic Type Card Ontap
  void serviceTypeCardontap({required ServiceType servicetype}) {
    _submitPropertyDetailModel.serviceType = servicetype.serviceTypeName;

    _serviceTypeNotifier.notifyListeners();
  }

  // Category Card Ontap
  void categoryCardOntap({required AttributeInfoModel attributeModel}) {
    _submitPropertyDetailModel.classId = attributeModel.id;
    _submitPropertyDetailModel.className = attributeModel.attributeValue;

    _categoryNotifier.notifyListeners();
  }

  // Furnishing Card Ontap
  void furnishingCardOntap({required FurnishingType furnishingTypeModel}) {
    _submitPropertyDetailModel.furnishedType =
        furnishingTypeModel.furnishingName;

    _furnishingNotifier.notifyListeners();
  }

  // Property Type Card Ontap
  void propertyTypeCardOntap({required CategoryInfoModel propertyType}) {
    _submitPropertyDetailModel.type = propertyType.id;
    _submitPropertyDetailModel.propertyTypeName = propertyType.name;

    _propertyTypeNotifier.notifyListeners();
  }

  // Room Minus Icon Ontap
  void roomMinusOntap({required RoomsEquipementModel roomsEquipementModel}) {
    if (roomsEquipementModel.equipementCount <= 0) return;
    roomsEquipementModel.equipementCount =
        roomsEquipementModel.equipementCount - 1;

    if (roomsEquipementModel.equipementName == StaticString.bedroom) {
      _submitPropertyDetailModel.bedRoom = roomsEquipementModel.equipementCount;
    } else if (roomsEquipementModel.equipementName == StaticString.bathroom) {
      _submitPropertyDetailModel.bathRoom =
          roomsEquipementModel.equipementCount;
    } else if (roomsEquipementModel.equipementName == StaticString.livingRoom) {
      _submitPropertyDetailModel.livingRoom =
          roomsEquipementModel.equipementCount;
    }

    _roomsNotifier.notifyListeners();
  }

  // Room Plus Icon Ontap
  void roomPlusOntap({required RoomsEquipementModel roomsEquipementModel}) {
    roomsEquipementModel.equipementCount =
        roomsEquipementModel.equipementCount + 1;

    if (roomsEquipementModel.equipementName == StaticString.bedroom) {
      _submitPropertyDetailModel.bedRoom = roomsEquipementModel.equipementCount;
    } else if (roomsEquipementModel.equipementName == StaticString.bathroom) {
      _submitPropertyDetailModel.bathRoom =
          roomsEquipementModel.equipementCount;
    } else if (roomsEquipementModel.equipementName == StaticString.livingRoom) {
      _submitPropertyDetailModel.livingRoom =
          roomsEquipementModel.equipementCount;
    }

    _roomsNotifier.notifyListeners();
  }

  // Manage Bed Room Ontap
  Future<void> manageBedRoomOntap() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ManageRoomsScreen(
          numberOfRoom: _roomEquipementList[0].equipementCount,
          facilitylist: _submitPropertyDetailModel.rooms,
          onPressed: (rooms) {
            _submitPropertyDetailModel.rooms = rooms;
            _roomsNotifier.notifyListeners();
          },
        ),
      ),
    );
  }

  // Features Add Icon Ontap
  Future<void> featuresAddIconOntap() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LandlordAddpropertyFeatureScreen(
          selectedFeature: _submitPropertyDetailModel.features,
          addFeatureScreenModel: List<PropertyFeatureModel>.from(
            getLandlordProvider.getPropertyElementModel
                .map((e) => PropertyFeatureModel.fromJson(e.toJson())),
          ),
          onPressed: (propertyFeatureList) {
            _submitPropertyDetailModel.features = propertyFeatureList;
            _featureNotifier.notifyListeners();
          },
        ),
      ),
    );
  }

  // Add Description Add Icon Ontap
  Future<void> addDescriptionAddOntap() async {
    descriptionController.text = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LandlordAddDescriptionScreen(
          descriptionText: descriptionController.text,
        ),
      ),
    );

    _descriptionNotifier.notifyListeners();
  }

  // More Information card Ontap
  Future<void> moreInformationCardOntap({required int index}) async {
    switch (index) {
      case 0:
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddPropertyVideoScreen(
              videoList: _submitPropertyDetailModel.videos,
            ),
          ),
        );

        break;
      case 1:
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddFloorPlanScreen(
              floorList: _submitPropertyDetailModel.floorPlan,
            ),
          ),
        );

        break;
    }
  }

  // Next Button Action
  Future<void> nextButtonAction() async {
    if (_submitPropertyDetailModel.address?.city.isEmpty ?? true) {
      onError(message: StaticString.pleaseEnterAddressFirst);

      return;
    } else if (showPropertyType && _submitPropertyDetailModel.type.isEmpty) {
      onError(message: StaticString.pleaseSelectAnyPropertyType);

      return;
    } else if (showRentAmount && _submitPropertyDetailModel.rent == 0) {
      onError(message: StaticString.pleaseAddRentAmount);

      return;
    } else if (showFurnishingType &&
        _submitPropertyDetailModel.furnishedType.isEmpty) {
      onError(message: StaticString.pleaseSelectAnyFurnishingType);

      return;
    }
    // End Validation
    upsetPropertyDetail();
  }

  // Upset Property Detail
  Future<void> upsetPropertyDetail() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      if (_submitPropertyDetailModel.photos.isEmpty) {
        throw StaticString.pleaseSelectAtLeastOneImage;
      }
      if (_upsetProfile.id.isEmpty) {
        _upsetProfile = await getLandlordProvider.propertyDetailUpsert();
      }
      final List<String> _localVideos = _submitPropertyDetailModel.videos
          .where((element) => !element.isNetworkImage)
          .toList();
      if (_localVideos.isNotEmpty) {
        _submitPropertyDetailModel.videos.addAll(
          await ImgUploadService.instance.uploadPropertyPictures(
            images: _localVideos,
            uploadType: UploadType.PROPERTYVIDEO,
            id: _upsetProfile.id,
          ),
        );
        for (final local in _localVideos) {
          _submitPropertyDetailModel.videos.removeWhere((all) => local == all);
        }
      }
      final List<String> _localImages = _submitPropertyDetailModel.photos
          .where((element) => !element.isNetworkImage)
          .toList();
      if (_localImages.isNotEmpty) {
        _submitPropertyDetailModel.photos.addAll(
          await ImgUploadService.instance.uploadPropertyPictures(
            images: _localImages,
            id: _upsetProfile.id,
          ),
        );
        for (final local in _localImages) {
          _submitPropertyDetailModel.photos.removeWhere((all) => local == all);
        }
      }
      final List<String> _localDocs = _submitPropertyDetailModel.floorPlan
          .where((element) => !element.originalUrl.isNetworkImage)
          .map((e) => e.originalUrl)
          .toList();
      if (_localDocs.isNotEmpty) {
        _submitPropertyDetailModel.floorPlan.addAll(
          (await ImgUploadService.instance.uploadPropertyPictures(
            images: _localDocs,
            uploadType: UploadType.PROPERTYDOCS,
            id: _upsetProfile.id,
          ))
              .map(
                (e) => FloorPlan(
                  originalUrl: e,
                  previewUrl: e,
                  fileName: e.split("/").last.replaceAll("%20", " "),
                ),
              )
              .toList(),
        );
        for (final local in _localDocs) {
          _submitPropertyDetailModel.floorPlan
              .removeWhere((all) => local == all.originalUrl);
        }
      }
      _submitPropertyDetailModel.description = descriptionController.text;
      _upsetProfile = await getLandlordProvider.propertyDetailUpsert(
        submitPropertyDetailModel: _submitPropertyDetailModel,
        id: _upsetProfile.id,
      );
      if (isEdit) {
        Navigator.of(context).pop();
        Provider.of<LandlordProvider>(context, listen: false)
            .fetchPropertiesDetailsData(
          propertyId: widget.propertiesDetailModel!.id,
        );
        Provider.of<LandlordProvider>(context, listen: false)
            .fetchPropertiesListData(1);
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SubmitPropertyScreen(
              submitPropertyDetailModelClass: _submitPropertyDetailModel,
              upsetProfileModel: _upsetProfile,
            ),
          ),
        );
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  // OnError Function
  void onError({required String message}) {
    Fluttertoast.showToast(msg: message);
  }

  // Edit Property
  Future<void> editProperty() async {
    if (widget.propertiesDetailModel != null) {
      _upsetProfile.id = widget.propertiesDetailModel?.id ?? "";

      _submitPropertyDetailModel.category =
          widget.propertiesDetailModel!.category;
      _submitPropertyDetailModel.type = widget.propertiesDetailModel!.type;

      _submitPropertyDetailModel.furnishedType =
          widget.propertiesDetailModel!.furnishing;
      _submitPropertyDetailModel.rentalType =
          widget.propertiesDetailModel!.name;
      _submitPropertyDetailModel.realEstate =
          widget.propertiesDetailModel!.realEstate;
      _submitPropertyDetailModel.serviceType =
          widget.propertiesDetailModel!.serviceType;

      for (final room in _roomEquipementList) {
        if (room.id == 1) {
          room.equipementCount = widget.propertiesDetailModel!.bedRoom;
        } else if (room.id == 2) {
          room.equipementCount = widget.propertiesDetailModel!.bathRoom;
        } else if (room.id == 3) {
          room.equipementCount = widget.propertiesDetailModel!.livingRoom;
        }
      }

      for (final property in getLandlordProvider.getPropertyElementModel) {
        for (final feature in widget.propertiesDetailModel!.features) {
          if (property.id == feature) {
            property.switchValue = true;
          }
          for (final child in property.child) {
            if (child.id == feature) {
              child.switchValue = true;
            }
          }
        }
      }
      _submitPropertyDetailModel.features =
          getLandlordProvider.getPropertyElementModel;
      if (widget.propertiesDetailModel?.additionalAttributes.isNotEmpty ??
          false) {
        final List<Room> _rooms = [];

        for (int i = 0;
            i <
                (widget.propertiesDetailModel!.additionalAttributes.first.value
                    .length);
            i++) {
          final Room _room = Room(
            name: widget.propertiesDetailModel!.additionalAttributes.first
                .value[i].name,
            typeId: widget.propertiesDetailModel!.additionalAttributes.first
                .value[i].typeId,
          );
          final List<AttributeInfoModel> _roomList = getLandlordProvider
              .getAttributeList
              .where((element) => element.id == _room.typeId)
              .toList();
          if (_roomList.isNotEmpty) {
            _room.typeId = _roomList.first.id;
            _room.typeName = _roomList.first.attributeValue;
            _room.name = widget.propertiesDetailModel!.additionalAttributes
                .first.value[i].name;
          }
          _rooms.add(_room);
        }

        _submitPropertyDetailModel.rooms = _rooms;
      }

      _submitPropertyDetailModel.address =
          widget.propertiesDetailModel!.address;
      _submitPropertyDetailModel.photos =
          widget.propertiesDetailModel?.photos ?? [];
      _submitPropertyDetailModel.videos =
          widget.propertiesDetailModel?.videos ?? [];
      _submitPropertyDetailModel.floorPlan =
          widget.propertiesDetailModel?.floorPlan ?? [];
      _submitPropertyDetailModel.petAllowed =
          widget.propertiesDetailModel!.petAllowed;
      _submitPropertyDetailModel.disabledFriendly =
          widget.propertiesDetailModel!.disabledFriendly;
      _submitPropertyDetailModel.description =
          widget.propertiesDetailModel!.description;
      _submitPropertyDetailModel.bedRoom =
          widget.propertiesDetailModel!.bedRoom;
      _submitPropertyDetailModel.bathRoom =
          widget.propertiesDetailModel!.bathRoom;
      _submitPropertyDetailModel.livingRoom =
          widget.propertiesDetailModel!.livingRoom;
      descriptionController.text = widget.propertiesDetailModel!.description;
      _submitPropertyDetailModel.rent = widget.propertiesDetailModel!.rent;

      rentController.text = widget.propertiesDetailModel!.rent.toString();
      floorSizeController.text =
          widget.propertiesDetailModel!.floorSize.toString();
      _submitPropertyDetailModel.floorSize =
          widget.propertiesDetailModel!.floorSize;
      annualRentController.text = widget.propertiesDetailModel!.rent.toString();
      _submitPropertyDetailModel.rent = widget.propertiesDetailModel!.rent;
      ppcController.text = widget.propertiesDetailModel!.pps.toString();
      _submitPropertyDetailModel.isEdit = isEdit;
      _submitPropertyDetailModel.pps = widget.propertiesDetailModel!.pps;
      _submitPropertyDetailModel.classId =
          widget.propertiesDetailModel!.classId;
      final List<String> _classList = getLandlordProvider.getAttributeList
          .where(
            (element) => element.id == widget.propertiesDetailModel!.classId,
          )
          .map((e) => e.attributeValue)
          .toList();
      if (_classList.isNotEmpty) {
        _submitPropertyDetailModel.className = _classList.first;
      }
      if (widget.propertiesDetailModel!.address?.fullAddress.isNotEmpty ??
          false) {
        _seachController.text =
            widget.propertiesDetailModel!.address!.fullAddress;
        await checkPropertyExistence(
          widget.propertiesDetailModel!.address!.fullAddress,
        );
      }
      final List<CategoryInfoModel> _categoryList =
          getLandlordProvider.getCategoryList
              .where(
                (element) =>
                    element.id == widget.propertiesDetailModel!.category,
              )
              .toList();
      if (_categoryList.isNotEmpty) {
        final List<CategoryInfoModel> propertyType =
            _categoryList.first.propertyType
                .where(
                  (element) => element.id == widget.propertiesDetailModel!.type,
                )
                .toList();

        if (propertyType.isNotEmpty) {
          _submitPropertyDetailModel.propertyTypeName = propertyType.first.name;
        }
        propertyTypeMgnt(
          _categoryList.first,
          _categoryList.first.propertyTypeEnum,
        );
      }
    }
  }
}
