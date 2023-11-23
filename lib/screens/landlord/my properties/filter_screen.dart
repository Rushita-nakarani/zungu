// ignore_for_file: use_rethrow_when_possible, unnecessary_statements, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/loading_indicator.dart';
import '../../../../widgets/no_content_label.dart';
import '../../../constant/img_font_color_string.dart';
import '../../../models/filter_screen_model.dart';
import '../../../models/landloard/attribute_info_model.dart';
import '../../../models/landloard/category_info_model.dart';
import '../../../models/landloard/property_feature_model.dart';
import '../../../models/submit_property_detail_model.dart';
import '../../../providers/landlord_provider.dart';
import '../../../utils/cust_eums.dart';
import '../../../widgets/common_elevated_button.dart';
import '../../../widgets/common_widget.dart';
import '../../../widgets/cust_image.dart';
import '../../../widgets/custom_alert.dart';
import '../../../widgets/custom_text.dart';
import '../landlord_add_property_feature_screen.dart';

class FilterScren extends StatefulWidget {
  final Function(
    SubmitPropertyDetailModel submitPropertyDetailModel,
    List<LettingStatus> lettingStatusIsSelected,
    RangeValues rentRange,
    RangeValues? floorSizeRange,
    RangeValues? ppsRange,
    List<String> selectedPropertyType,
    List<String> selectedCategory,
  ) onPressed;
  final SubmitPropertyDetailModel? submitPropertyDetailModel;
  final List<LettingStatus>? lettingStatus;
  final RangeValues? rentRange;
  final RangeValues? floorSizeRange;
  final RangeValues? ppsRange;
  final List<String>? selectedPropertyType;
  final List<String>? selectedCategory;
  const FilterScren({
    super.key,
    required this.onPressed,
    this.submitPropertyDetailModel,
    this.lettingStatus,
    this.rentRange,
    this.floorSizeRange,
    this.ppsRange,
    this.selectedPropertyType,
    this.selectedCategory,
  });

  @override
  State<FilterScren> createState() => _FilterScrenState();
}

class _FilterScrenState extends State<FilterScren> {
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
  final ValueNotifier _petsNotifier = ValueNotifier(true);
  final ValueNotifier _disableFriednlyNotifier = ValueNotifier(true);
  final ValueNotifier _roomsNotifier = ValueNotifier(true);

  //---------- Text Editing Controller--------//
  TextEditingController floorSizeController = TextEditingController();
  TextEditingController annualRentController = TextEditingController();
  TextEditingController ppcController = TextEditingController();
  TextEditingController rentController = TextEditingController();

  //-----------------Model-----------//
  // SubmitPropertyDetail Model
  SubmitPropertyDetailModel _submitPropertyDetailModel =
      SubmitPropertyDetailModel(
    photos: [],
    videos: [],
    floorPlan: [],
    features: [],
    rooms: [],
  );

  CategoryInfoModel _categoryInfoModel = CategoryInfoModel();

  //-----------------List-----------//
  //Service Type Data List
  final List<ServiceType> _serviceType = [
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

  // Loading Indicator Notifier
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  //Property Type Enum
  final List<PropertyType> _addPropertyScreenType = [];

  //Letting Status List
  List<LettingStatus> lettingStatus = [
    LettingStatus(name: StaticString.let.toUpperCase()),
    LettingStatus(id: 1, name: StaticString.toLet),
    // LettingStatus(id: 2, name: StaticString.listed),
    // LettingStatus(id: 3, name: StaticString.underOffer),
    LettingStatus(id: 4, name: StaticString.hmo),
  ];

  // Selected Property Type List
  List<String> _selectedPropertyType = [];

  //Selected categoy List
  List<String> _selectedCategory = [];

  // Selected Category Index
  int selectedCategoryIndex = 0;

  //----------range slider value-------//
  RangeValues selectedRange = const RangeValues(50, 800);
  RangeValues? selectedFloorsize;
  RangeValues? selectedPps;

  //Properties List Privider getter method
  LandlordProvider get getPropertiesListProvider =>
      Provider.of<LandlordProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    fetchFilterScreenData();
  }

  //----------------------------------------Ui---------------------------------//
  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Scaffold(
        appBar: _buildAppbar(),
        body: _buildBody(),
      ),
    );
  }

  //----------------------------------------Widgets---------------------------------//

  // Appbar
  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: ColorConstants.custDarkPurple500472,
      title: const Text(StaticString.filter),
    );
  }

  // Body
  Widget _buildBody() {
    return SafeArea(
      child: Consumer<LandlordProvider>(
        builder: (context, landLordDataProvider, child) {
          return landLordDataProvider.getCategoryList.isEmpty
              ? Center(
                  child: NoContentLabel(
                    title: StaticString.nodataFound,
                    onPress: fetchFilterScreenData,
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Property List Grid
                      _propertyGridView(),
                      const SizedBox(height: 40),

                      // Property Type List
                      Visibility(
                        visible: showPropertyType,
                        child: _propertyTypeList(),
                      ),
                      SizedBox(height: showPropertyType ? 40 : 0),

                      //Letting Status List
                      _lettingStatusList(),
                      const SizedBox(height: 30),

                      // property type selection content
                      Visibility(
                        visible: showServiceType,
                        child: _buildServiceTypeCOntent(),
                      ),
                      SizedBox(height: showServiceType ? 40 : 0),

                      // Category Class Content
                      Consumer<LandlordProvider>(
                        builder: (context, provider, child) {
                          return Visibility(
                            visible: showCategoryRent &&
                                provider.getAttributeList.isNotEmpty,
                            child: _buildCategoryClass(
                              attributeList: provider.getAttributeList,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: showCategoryRent ? 40 : 0),

                      // Rooms Part Content
                      Visibility(
                        visible: showRoomsEquipementModel,
                        child: _buildRoomsPart(),
                      ),
                      SizedBox(height: showRoomsEquipementModel ? 40 : 0),

                      // furnishing selection content
                      Visibility(
                        visible: showFurnishingType,
                        child: _buildFurnishingSelections(),
                      ),
                      SizedBox(height: showFurnishingType ? 40 : 0),

                      // add Features Content
                      ValueListenableBuilder(
                        valueListenable: _featureNotifier,
                        builder: (context, val, child) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: _buildAddFeatureContent(),
                          );
                        },
                      ),
                      Visibility(
                        visible: showShopSizeAndRent,
                        child: const SizedBox(height: 45),
                      ),

                      // Floor size Range Slider and Size value text row
                      Visibility(
                        visible: showShopSizeAndRent,
                        child: commonRangeSlider(
                          headerTitle: StaticString.floorSize1,
                          rangeValue:
                              selectedFloorsize ?? const RangeValues(50, 800),
                          showCurrency: false,
                          selectedRangeOntap: (newRange) {
                            if (mounted) {
                              setState(() {
                                selectedFloorsize = newRange;
                              });
                            }
                          },
                        ),
                      ),
                      Visibility(
                        visible: showShopSizeAndRent,
                        child: const SizedBox(height: 40),
                      ),

                      // Price Per Square foot Range Slider and amount value text row
                      Visibility(
                        visible: showShopSizeAndRent,
                        child: commonRangeSlider(
                          headerTitle: StaticString.pricePerSquareFoot1,
                          rangeValue: selectedPps ?? const RangeValues(50, 800),
                          selectedRangeOntap: (newRange) {
                            if (mounted) {
                              setState(() {
                                selectedPps = newRange;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Range Slider and Rent amount value text row
                      commonRangeSlider(
                        headerTitle: StaticString.rentAmount,
                        rangeValue: selectedRange,
                        selectedRangeOntap: (newRange) {
                          if (mounted) {
                            setState(() {
                              selectedRange = newRange;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 40),

                      //Pets Allowed Content
                      Visibility(
                        visible: showPetsAllowed,
                        child: ValueListenableBuilder(
                          valueListenable: _petsNotifier,
                          builder: (context, val, child) {
                            return _buildPetsAllowedContent();
                          },
                        ),
                      ),
                      SizedBox(height: showPetsAllowed ? 25 : 0),

                      // Disable Friendly Content
                      Visibility(
                        visible: showDisableFriednly,
                        child: ValueListenableBuilder(
                          valueListenable: _disableFriednlyNotifier,
                          builder: (context, val, child) {
                            return _buildDisableFriendlyContent();
                          },
                        ),
                      ),
                      SizedBox(height: showDisableFriednly ? 20 : 0),
                      // Show Deleted Properties switch row
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: custDisableFrdlySwitch(
                          switchValueText: StaticString.showDeltedProperties,
                          switchValue: _submitPropertyDetailModel.showDeleted,
                          switchOntap: (val) {
                            if (mounted) {
                              setState(() {
                                _submitPropertyDetailModel.showDeleted = val;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 40),

                      //Apply Elaveted Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CommonElevatedButton(
                          bttnText: StaticString.applyFilters,
                          onPressed: () => applyFilterBtnAction(),
                          color: ColorConstants.custBlue1EC0EF,
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }

  // Property Grid View
  Widget _propertyGridView() {
    return Consumer<LandlordProvider>(
      builder: (context, landLordProvider, child) {
        return GridView.builder(
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          itemCount: getLandlordProvider.getCategoryList.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => propertyTypeMgnt(
                getLandlordProvider.getCategoryList[index],
                getLandlordProvider.getCategoryList[index].propertyTypeEnum,
              ),
              child: _propertyCard(
                categoryInfoModel: getLandlordProvider.getCategoryList[index],
              ),
            );
          },
        );
      },
    );
  }

  // Proprty Card
  Widget _propertyCard({
    required CategoryInfoModel categoryInfoModel,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Property Card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: categoryInfoModel.isSelected
                  ? ColorConstants.custDarkPurple500472
                  : Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
                  blurRadius: 12,
                )
              ],
            ),

            //Property Image
            child: CustImage(
              imgURL: categoryInfoModel.iconImage,
              height: MediaQuery.of(context).size.height / 10,
            ),
          ),
          const SizedBox(height: 5),

          //Property Name
          CustomText(
            txtTitle: categoryInfoModel.name,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  // Property type List
  Widget _propertyTypeList() {
    return Consumer<LandlordProvider>(
      builder: (context, landLordProvider, child) {
        final List<CategoryInfoModel> propertyTypeList =
            getLandlordProvider.getCategoryList[0].propertyType;
        return landLordProvider.getCategoryList.isEmpty
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(left: 30),
                child: commonHeaderLable(
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
                              propertyTypeList: propertyTypeList,
                              propertyType: propertyTypeList[index],
                            ),
                            isSelected: propertyTypeList[index].isSelected,
                            propertyName: propertyTypeList[index].name,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
      },
    );
  }

  // Letting Status List
  Widget _lettingStatusList() {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: commonHeaderLable(
        title: StaticString.lettingStatus,
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(
            lettingStatus.length,
            (index) => commonPropertyCard(
              ontap: () => lettingStatusOntapAction(
                lettingStatus: lettingStatus[index],
              ),
              isSelected: lettingStatus[index].isSelected,
              propertyName: lettingStatus[index].name,
            ),
          ),
        ),
      ),
    );
  }

  // Service type content
  Widget _buildServiceTypeCOntent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: commonHeaderLable(
        title: StaticString.serviceType,
        child: ValueListenableBuilder(
          valueListenable: _serviceTypeNotifier,
          builder: (context, value, child) => Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
              _serviceType.length,
              (index) => commonPropertyCard(
                ontap: () => serviceTypeCardOntap(
                  serviceTypeName: _serviceType[index].serviceTypeName,
                ),
                isSelected: _submitPropertyDetailModel.serviceType ==
                    _serviceType[index].serviceTypeName,
                propertyName: _serviceType[index].serviceTypeName,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Category Class content
  Widget _buildCategoryClass({
    required List<AttributeInfoModel> attributeList,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: commonHeaderLable(
        title: StaticString.categoryClass,
        child: ValueListenableBuilder(
          valueListenable: _categoryNotifier,
          builder: (context, val, child) {
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: List.generate(
                attributeList.length,
                (index) => InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => categoryAttributeCardOntap(
                    attributeId: attributeList[index].id,
                  ),
                  child: Container(
                    height: 46,
                    width: attributeList[index].attributeValue.length * 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _submitPropertyDetailModel.classId ==
                              attributeList[index].id
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

                    //Attribute Value Name Text
                    child: CustomText(
                      txtTitle: attributeList[index].attributeValue,
                      style: Theme.of(context).textTheme.headline1?.copyWith(
                            color: _submitPropertyDetailModel.classId ==
                                    attributeList[index].id
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
      ),
    );
  }

  // Rooms Portion
  Widget _buildRoomsPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: commonHeaderLable(
        title: StaticString.rooms,
        child: ValueListenableBuilder(
          valueListenable: _roomsNotifier,
          builder: (context, val, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                children: [
                  //Bed Room Card
                  Expanded(
                    child: _buildRoomsCard(
                      _roomEquipementList[0],
                    ),
                  ),
                  const SizedBox(width: 10),

                  //Bath Room Card
                  Expanded(
                    child: _buildRoomsCard(
                      _roomEquipementList[1],
                    ),
                  ),
                  const SizedBox(width: 10),

                  //Living Room card
                  Expanded(
                    child: _buildRoomsCard(
                      _roomEquipementList[2],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // furnishing selection content
  Widget _buildFurnishingSelections() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: commonHeaderLable(
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
                    furnishingName: _furnishingType[index].furnishingName,
                  ),
                  isSelected: _submitPropertyDetailModel.furnishedType ==
                      _furnishingType[index].furnishingName,
                  propertyName: _furnishingType[index].furnishingName,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Add Feature Content
  Widget _buildAddFeatureContent() {
    // Selected Features List
    final List<PropertyFeatureModel> selectedFeaturesList =
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
            if (selectedFeaturesList.isNotEmpty)
              // Selected Features List
              _selectedFeaturesList(selectedFeatureList: selectedFeaturesList)
            else
              // Add Features TextField
              _addFeatureTextField(placeHolder: StaticString.addFeature),
            // Add FEatures Add Icon
            _addIcon(selectedFeaturesList: selectedFeaturesList)
          ],
        ),
      ),
    );
  }

  // Selected Feature List
  Widget _selectedFeaturesList({
    required List<PropertyFeatureModel> selectedFeatureList,
  }) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 12,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: selectedFeatureList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              children: [
                // Next Key Arrow Icon
                const CustImage(
                  imgURL: ImgName.nextKeyAerrow,
                  height: 15,
                  width: 15,
                  imgColor: ColorConstants.custGrey707070,
                ),
                const SizedBox(width: 8),

                //Selected Features Name Text
                CustomText(
                  txtTitle: selectedFeatureList[index].name,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custDarkBlue150934,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),

            //Selected Fetures Item List
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 9,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: selectedFeatureList[index]
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

                    // Dot Icon Image
                    const CustImage(
                      imgURL: ImgName.dot,
                      imgColor: ColorConstants.custGrey707070,
                    ),
                    const SizedBox(width: 8),

                    // Selected Feature Switch Value Name Text
                    CustomText(
                      txtTitle: selectedFeatureList[index]
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

  // Add Features TextField
  Widget _addFeatureTextField({required String placeHolder}) {
    return TextFormField(
      cursorColor: ColorConstants.custBlue1BC4F4,
      onTap: addFeaturesTextfieldOntap,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20, right: 10),
        hintText: placeHolder,
        hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: ColorConstants.custGreyAEAEAE,
            ),
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }

  // Add Features Add Icon
  Widget _addIcon({required List<PropertyFeatureModel> selectedFeaturesList}) {
    return Positioned(
      top: 0,
      right: 0,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: addFeaturesTextfieldOntap,
        child: Container(
          height: 36,
          width: 48,
          decoration: const BoxDecoration(
            color: ColorConstants.custBlue1EC0EF,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4),
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

  // Pets allowed Content
  Widget _buildPetsAllowedContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: commonHeaderLable(
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
      ),
    );
  }

  // Disable Friendly Content
  Widget _buildDisableFriendlyContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Disable Friendly Text
          CustomText(
            txtTitle: StaticString.disableFriednly,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.custDarkBlue150934,
                ),
          ),
          const SizedBox(height: 10),
          // Houses Adapted For wheel chair users switch row
          custDisableFrdlySwitch(
            textColor: ColorConstants.custGrey707070,
            switchValueText: StaticString.houseAdaptedFor,
            switchValue: _submitPropertyDetailModel.disabledFriendly,
            switchOntap: (val) {
              if (mounted) {
                setState(() {
                  _submitPropertyDetailModel.disabledFriendly = val;
                });
              }
            },
          ),
          const SizedBox(height: 20),
          // Lease Ending 30 days switch row
          custDisableFrdlySwitch(
            switchValueText: StaticString.leaseEndlingin30Days,
            switchValue: _submitPropertyDetailModel.leaseEnding,
            switchOntap: (val) {
              if (mounted) {
                setState(() {
                  _submitPropertyDetailModel.leaseEnding = val;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  //-----------------------------------Helper Widget--------------------------------//

  // Custom Rooms Card
  Widget _buildRoomsCard(RoomsEquipementModel roomsEquipementModel) {
    return Column(
      children: [
        //Rooms Image Card
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
          child: CustImage(
            imgURL: roomsEquipementModel.equipementImageUrl,
            boxfit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 2),

        // Rooms Name Text
        CustomText(
          txtTitle: roomsEquipementModel.equipementName,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
        ),
        const SizedBox(height: 10),

        // Plus Minus And Item Count Card
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
              // Minus Icon Card
              Expanded(
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => minusIconOntap(
                    roomsEquipementModel: roomsEquipementModel,
                  ),
                  child: const Icon(
                    Icons.remove,
                    size: 14,
                    color: ColorConstants.custGrey707070,
                  ),
                ),
              ),

              // Room Item Count Text
              CustomText(
                txtTitle: roomsEquipementModel.id == 1
                    ? _submitPropertyDetailModel.bedRoom.toString()
                    : roomsEquipementModel.id == 2
                        ? _submitPropertyDetailModel.bathRoom.toString()
                        : roomsEquipementModel.id == 3
                            ? _submitPropertyDetailModel.livingRoom.toString()
                            : "0",
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: ColorConstants.custBlue1EC0EF,
                    ),
              ),

              //Plus Icon Card
              Expanded(
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () =>
                      plusIconOntap(roomsEquipementModel: roomsEquipementModel),
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

  // Custom Range Slider
  Widget commonRangeSlider({
    required String headerTitle,
    required RangeValues rangeValue,
    required void Function(RangeValues newRange) selectedRangeOntap,
    bool showCurrency = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // rent amount title text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomText(
              txtTitle: headerTitle,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custDarkBlue150934,
                  ),
            ),
          ),
          const SizedBox(height: 20),

          //Range Slider
          RangeSlider(
            min: 50,
            max: 1000,
            labels: const RangeLabels("50", "1000"),
            inactiveColor: ColorConstants.custGreyE9EDF5,
            activeColor: ColorConstants.custskyblue22CBFE,
            values: rangeValue,
            onChanged: selectedRangeOntap,
          ),

          // Selected Range Value Text Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  txtTitle:
                      "${showCurrency ? StaticString.currency : ""}${rangeValue.start.toStringAsFixed(0)}",
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                CustomText(
                  txtTitle:
                      "${showCurrency ? StaticString.currency : ""}${rangeValue.end.toStringAsFixed(0)}",
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //--------------------------------------Button action ------------------------------//

  // apply filters button action
  Future<void> applyFilterBtnAction() async {
    widget.onPressed(
      _submitPropertyDetailModel,
      lettingStatus,
      selectedRange,
      selectedFloorsize,
      selectedPps,
      _selectedPropertyType,
      _selectedCategory,
    );
    Navigator.of(context).pop();
  }

  // Letting Status Card ontap
  void lettingStatusOntapAction({
    required LettingStatus lettingStatus,
  }) {
    if (mounted) {
      setState(() {
        lettingStatus.isSelected = !lettingStatus.isSelected;
      });
    }
  }

  // Property Card Ontap
  void propertyTypeMgnt(
    CategoryInfoModel categoryInfoModel,
    PropertyType propertyTypeEnum,
  ) {
    categoryInfoModel.isSelected = !categoryInfoModel.isSelected;
    if (mounted) {
      setState(() {
        if (categoryInfoModel.isSelected == true) {
          _selectedCategory.add(categoryInfoModel.id);
          _addPropertyScreenType.add(propertyTypeEnum);
          _buildFilterContentShowHide(propertyTypeEnum, true);
        } else if (categoryInfoModel.isSelected == false) {
          _selectedCategory.remove(categoryInfoModel.id);
          _addPropertyScreenType.remove(propertyTypeEnum);
          _buildFilterContentShowHide(propertyTypeEnum, false);
        }
      });
    }

    _submitPropertyDetailModel.rentalType = categoryInfoModel.name;
    _submitPropertyDetailModel.realEstate = categoryInfoModel.realEstate;

    _categoryInfoModel = categoryInfoModel;
    if (mounted) {
      setState(() {});
    }
  }

  void _buildFilterContentShowHide(
    PropertyType propertyScreenType,
    bool value,
  ) {
    switch (propertyScreenType) {
      case PropertyType.House:
        showDisableFriednly = value;
        showFurnishingType = value;
        showPetsAllowed = value;
        showPropertyType = value;
        showRentAmount = value;
        showRoomsEquipementModel = value;

        break;
      case PropertyType.Flats:
        showDisableFriednly = value;
        showFurnishingType = value;
        showPetsAllowed = value;
        showRentAmount = value;
        showRoomsEquipementModel = value;

        break;
      case PropertyType.HMO:
        showDisableFriednly = value;
        showFurnishingType = value;
        showManageBedrooms = value;
        showPetsAllowed = value;
        showPropertyType = value;
        showRentAmount = value;
        showRoomsEquipementModel = value;

        break;
      case PropertyType.Shops:
        showCategoryRent = value;
        showShopSizeAndRent = value;

        break;
      case PropertyType.Office:
        showCategoryRent = value;
        showFurnishingType = value;
        showShopSizeAndRent = value;
        showServiceType = value;

        break;
      case PropertyType.Industry:
        showCategoryRent = value;
        showShopSizeAndRent = value;

        break;
      case PropertyType.None:
        break;
    }
  }

  // Property Type Card Ontap
  void propertyTypeCardOntap({
    required List<CategoryInfoModel> propertyTypeList,
    required CategoryInfoModel propertyType,
  }) {
    propertyType.isSelected = !propertyType.isSelected;
    _selectedPropertyType =
        propertyTypeList.where((e) => e.isSelected).map((e) => e.id).toList();

    _propertyTypeNotifier.notifyListeners();
  }

  // Service Type Card Ontap
  void serviceTypeCardOntap({required String serviceTypeName}) {
    _submitPropertyDetailModel.serviceType = serviceTypeName;

    _serviceTypeNotifier.notifyListeners();
  }

  // Category Attribute Card Ontap
  void categoryAttributeCardOntap({required String attributeId}) {
    _submitPropertyDetailModel.classId = attributeId;

    _categoryNotifier.notifyListeners();
  }

  // Minus Icon Ontap
  void minusIconOntap({required RoomsEquipementModel roomsEquipementModel}) {
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

  // Plus Icon Ontap
  void plusIconOntap({required RoomsEquipementModel roomsEquipementModel}) {
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

  // Furnishing Card Ontap
  void furnishingCardOntap({required String furnishingName}) {
    _submitPropertyDetailModel.furnishedType = furnishingName;

    _furnishingNotifier.notifyListeners();
  }

  // Add Features Textfeild Ontap
  Future<void> addFeaturesTextfieldOntap() async {
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

  //-----------------------Helper function------------------//

  // Fetch Attributes api call
  Future<void> fetchAttributes(String attribute) async {
    try {
      await getLandlordProvider.attributeList(attribute: attribute);
    } catch (e) {
      rethrow;
    }
  }

  //Fetch Filter Data
  Future<void> fetchFilterScreenData() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );

      // if (getLandlordProvider.getCategoryList.isEmpty) {
      await getLandlordProvider.fetchCategoryList();
      await fetchAttributes("HMO_ROOM_TYPE");
      await fetchAttributes("CATEGORY_CLASS");
      await getLandlordProvider.fetchProperty();

      if (getLandlordProvider.getCategoryList.isNotEmpty) {
        // _submitPropertyDetailModel.category =
        //     getLandlordProvider.getCategoryList[0].id;

        // _categoryInfoModel = getLandlordProvider.getCategoryList[0];

        // _submitPropertyDetailModel.category = _categoryInfoModel.id;
        _submitPropertyDetailModel.rentalType = _categoryInfoModel.name;
        _submitPropertyDetailModel.realEstate = _categoryInfoModel.realEstate;
      }
      // }

      if (widget.submitPropertyDetailModel != null &&
          widget.lettingStatus != null &&
          widget.rentRange != null &&
          widget.selectedCategory != null) {
        _submitPropertyDetailModel = widget.submitPropertyDetailModel!;
        _categoryInfoModel.id = widget.submitPropertyDetailModel!.category;
        switch (_submitPropertyDetailModel.rentalType.toLowerCase()) {
          case "house":
            selectedCategoryIndex = 0;
            _addPropertyScreenType.add(PropertyType.House);
            break;
          case "flats":
            selectedCategoryIndex = 1;
            _addPropertyScreenType.add(PropertyType.Flats);
            break;
          case "hmo":
            selectedCategoryIndex = 2;
            _addPropertyScreenType.add(PropertyType.HMO);
            break;
          case "shops":
            selectedCategoryIndex = 3;
            _addPropertyScreenType.add(PropertyType.Shops);
            break;
          case "office":
            selectedCategoryIndex = 4;
            _addPropertyScreenType.add(PropertyType.Office);
            break;
          case "industry":
            selectedCategoryIndex = 5;
            _addPropertyScreenType.add(PropertyType.Industry);
            break;
          default:
        }

        lettingStatus = widget.lettingStatus!;
        selectedRange = RangeValues(
          widget.rentRange!.start,
          widget.rentRange!.end,
        );
        if (showShopSizeAndRent) {
          selectedFloorsize = RangeValues(
            widget.floorSizeRange!.start,
            widget.floorSizeRange!.end,
          );
          selectedPps = RangeValues(
            widget.ppsRange!.start,
            widget.ppsRange!.end,
          );
        }
        _selectedPropertyType = widget.selectedPropertyType!;

        for (final categoryList in getLandlordProvider.getCategoryList) {
          if (widget.selectedCategory
                  ?.any((selectedId) => selectedId == categoryList.id) ??
              false) {
            propertyTypeMgnt(categoryList, categoryList.propertyTypeEnum);
          }
        }

        getLandlordProvider.setPropertyElementModel =
            widget.submitPropertyDetailModel?.features ?? [];

        _selectedCategory = widget.selectedCategory!;
      }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
