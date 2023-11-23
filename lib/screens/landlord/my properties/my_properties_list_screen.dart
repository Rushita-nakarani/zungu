import 'package:flutter/material.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:provider/provider.dart';

import '../../../../models/submit_property_detail_model.dart';
import '../../../../widgets/loading_indicator.dart';
import '../../../constant/img_font_color_string.dart';
import '../../../models/filter_screen_model.dart';
import '../../../models/landloard/my_property_list_model.dart';
import '../../../models/landloard/property_detail_model.dart';
import '../../../models/landloard/property_list_model.dart';
import '../../../providers/landlord_provider.dart';
import '../../../screens/landlord/my%20properties/filter_screen.dart';
import '../../../widgets/bookmark_widget.dart';
import '../../../widgets/cust_image.dart';
import '../../../widgets/custom_alert.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/no_content_label.dart';
import '../tenant/add tenants/add_tenant_rent_details_form.dart';
import 'landloard_add_property_screen.dart';
import 'landlord_my_properties_details/landlord_my_properties_details_screen.dart';

class MyPropertiesListScren extends StatefulWidget {
  const MyPropertiesListScren({Key? key}) : super(key: key);

  @override
  State<MyPropertiesListScren> createState() => _MyPropertiesListScrenState();
}

class _MyPropertiesListScrenState extends State<MyPropertiesListScren> {
  //----------------------------------------Variable---------------------------------//

  // Home Item Image List
  List<String> homeItemList = [
    ImgName.landlordBed,
    ImgName.landlordBathtub,
    ImgName.landlordSofa,
  ];

  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  // Properties List Provider getter method
  LandlordProvider get getPropertiesListProvider =>
      Provider.of<LandlordProvider>(context, listen: false);

  SubmitPropertyDetailModel? _filterPropertyModel;
  List<LettingStatus>? _lettingStatus;
  RangeValues? _rentRange;
  RangeValues? _floorSizeRange;
  RangeValues? _ppsRange;
  List<String>? _selectedPropertyType;
  List<String>? _selectedCategory;

  int _page = 1;

  @override
  void initState() {
    super.initState();
    fetchPropertyListData();
  }

  //--------------------------------------Ui---------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  //-----------------------------------Widgets------------------------------//

  // App Bar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorConstants.custPurple500472,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            StaticString.myProperties,
          ),
          // Count Properties text
          Consumer<LandlordProvider>(
            builder: (context, property, child) => CustomText(
              txtTitle:
                  "${property.propertiesListModel?.count ?? 0} ${StaticString.properties}",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          )
        ],
      ),
      actions: [
        // Add Property Icon Button
        IconButton(
          onPressed: addBtnaction,
          icon: const CustImage(
            imgURL: ImgName.addIcon,
            imgColor: Colors.white,
            height: 17,
            width: 17,
          ),
        ),
        // Filter Icon button
        IconButton(
          onPressed: filterBtnaction,
          icon: const CustImage(
            imgURL: ImgName.filterIcon,
            imgColor: Colors.white,
            height: 25,
            width: 25,
          ),
        ),
      ],
    );
  }

  // Body
  Widget _buildBody() {
    return SafeArea(
      child: LoadingIndicator(
        loadingStatusNotifier: _loadingIndicatorNotifier,
        child: Consumer<LandlordProvider>(
          builder: (context, myPropertyListData, child) {
            return myPropertyListData.myPropertyList.isEmpty
                ? NoContentLabel(
                    title: StaticString.nodataFound,
                    onPress: () async {
                      await fetchPropertyListData();
                    },
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      _page = 1;
                      await myPropertyListData.fetchPropertiesListData(_page);
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 20, bottom: 30),
                      shrinkWrap: true,
                      itemCount: myPropertyListData.myPropertyList.length,
                      itemBuilder: (context, index) {
                        return LazyLoadingList(
                          index: index,
                          initialSizeOfItems:
                              myPropertyListData.propertiesListModel!.size,
                          hasMore: myPropertyListData
                                  .propertiesListModel!.count >
                              myPropertyListData.propertiesListModel!.page *
                                  myPropertyListData.propertiesListModel!.size,
                          loadMore: () async {
                            _page++;
                            await myPropertyListData
                                .fetchPropertiesListData(_page);
                          },
                          child: _propetyCard(
                            propertyList:
                                myPropertyListData.myPropertyList[index],
                          ),
                        );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }

  // custom Property Card
  Widget _propetyCard({
    required PropertiesList propertyList,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => propertyList.isDeleted
              ? null
              : cardOntapAction(id: propertyList.id),
          child: Column(
            children: [
              // Property Image
              _propertyImage(
                propertyList: propertyList,
              ),

              //property title,subtitle text and offer card
              _propertyTitleSubtitleTextAndOfferCard(
                propertyList: propertyList,
              ),

              // Home Property item count
              _homeItemList(propertyList: propertyList),
              const SizedBox(height: 20),
            ],
          ),
        ),
        // Tenant Details card
        Column(
          children: List.generate(
            propertyList.propertyDetail.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(top: 15),
                child: InkWell(
                  onTap: () => propertyList.isDeleted
                      ? null
                      : tenantDetailCardOntap(
                          propertyList: propertyList,
                          propertyDetail: propertyList.propertyDetail[index],
                        ),
                  child: _tenantDetailsCard(
                    propertyList: propertyList,
                    propertyModel: propertyList.propertyDetail[index],
                    categoryData: propertyList.category,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  // Properties Image
  Widget _propertyImage({
    required PropertiesList propertyList,
  }) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CustImage(
              height: 250,
              width: double.infinity,
              imgURL: propertyList.propertyResourceDetail?.photos.isNotEmpty ??
                      false
                  ? propertyList.propertyResourceDetail?.photos.first ?? ""
                  : "",
            ),
          ),
        ),

        //Property Deteleted Container
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: propertyList.isDeleted
                ? ColorConstants.custGrey707070.withOpacity(0.70)
                : null,
          ),
        ),

        //Deleted Tag Card
        if (propertyList.isDeleted)
          Positioned(
            top: 15,
            left: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: ColorConstants.custBlack5A5A5A.withOpacity(0.80),
                borderRadius: BorderRadius.circular(20),
              ),
              child: CustomText(
                align: TextAlign.center,
                txtTitle: StaticString.deleted,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: Colors.white),
              ),
            ),
          )
        else
          Container(),
      ],
    );
  }

  //property title,subtitle text and offer card
  Widget _propertyTitleSubtitleTextAndOfferCard({
    required PropertiesList propertyList,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Property Name text
                CustomText(
                  textOverflow: TextOverflow.ellipsis,
                  maxLine: 1,
                  txtTitle: propertyList.name,
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: propertyList.addressDetail?.isDeleted ?? false
                            ? ColorConstants.custBlack808080.withOpacity(0.30)
                            : ColorConstants.custDarkPurple150934,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),

                //Property Address text
                CustomText(
                  txtTitle: propertyList.addressDetail?.fullAddress,
                  textOverflow: TextOverflow.ellipsis,
                  maxLine: 1,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: propertyList.addressDetail?.isDeleted ?? false
                            ? ColorConstants.custBlack808080.withOpacity(0.30)
                            : ColorConstants.custGrey707070,
                      ),
                )
              ],
            ),
          ),

          // Property Book Mark Card
          if (propertyList.propertyDetail.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                bottom: 25,
              ),
              child: buildBookmark(
                text: propertyList.propertyDetail.first.status
                    .replaceAll("_", "\n"),
                color: propertyList.propertyDetail.first.isDeleted
                    ? ColorConstants.custGrey707070.withOpacity(0.70)
                    : propertyList.propertyDetail.first.status == "TO_LET"
                        ? ColorConstants.custRedE0320D
                        : propertyList.propertyDetail.first.status == "LET"
                            ? ColorConstants.custGreen3CAC71
                            : propertyList.category?.name == "HMO"
                                ? ColorConstants.custPurpleB772FF
                                : ColorConstants.custBlue29C3EF,
              ),
            )
          else
            Container()
        ],
      ),
    );
  }

  // Home Property item count
  Widget _homeItemList({required PropertiesList propertyList}) {
    final List<int> homeItemnCount = [
      propertyList.bedRoom,
      propertyList.bathRoom,
      propertyList.livingRoom,
    ];
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              homeItemList.length,
              (index) => _custHomeItemCard(
                img: homeItemList[index],
                homeItemCount: homeItemnCount[index],
                propertyListModel: propertyList,
              ),
            ),
          ),
          // Wheel chair image
          CustImage(
            imgColor: propertyList.propertyResourceDetail?.isDeleted ?? false
                ? ColorConstants.custBlack808080.withOpacity(0.30)
                : null,
            imgURL: propertyList.disabledFriendly
                ? ImgName.landlordDisableAllow
                : ImgName.landlordDisableNotAllow,
            height: 36,
            width: 36,
          ),
        ],
      ),
    );
  }

  // Custom Home Item Card
  Widget _custHomeItemCard({
    required String img,
    required int homeItemCount,
    required PropertiesList propertyListModel,
  }) {
    return Row(
      children: [
        //Home Item Icon Image
        CustImage(
          imgColor: propertyListModel.propertyResourceDetail?.isDeleted ?? false
              ? ColorConstants.custBlack808080.withOpacity(0.30)
              : null,
          imgURL: img,
          boxfit: BoxFit.contain,
          height: 36,
          width: 36,
        ),
        const SizedBox(width: 15),

        //Home Item Count text
        CustomText(
          txtTitle: homeItemCount.toString(),
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color:
                    propertyListModel.propertyResourceDetail?.isDeleted ?? false
                        ? ColorConstants.custBlack808080.withOpacity(0.30)
                        : ColorConstants.custBlack808080,
                fontWeight: FontWeight.w400,
              ),
        ),
        const SizedBox(width: 30),
      ],
    );
  }

  // Tenant Details card
  Widget _tenantDetailsCard({
    required PropertiesList propertyList,
    required PropertyDetail propertyModel,
    required Category? categoryData,
  }) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: propertyModel.isDeleted
            ? Colors.white.withOpacity(0.60)
            : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
            blurRadius: 12,
          )
        ],
      ),
      child: Row(
        children: [
          // Tenant Person Image
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CustImage(
                    imgURL: propertyModel
                            .tenancyDetail?.tenantProfile?.profileImg ??
                        ImgName.defaultProfile1,
                    height: 60,
                    width: 60,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: propertyModel.isDeleted
                      ? ColorConstants.custGrey707070.withOpacity(0.60)
                      : null,
                ),
              ),
            ],
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TENANT Text
                CustomText(
                  txtTitle: categoryData?.name == "HMO"
                      ? propertyModel.roomName.toUpperCase()
                      : StaticString.tenantCapital,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: categoryData?.name == "HMO"
                            ? ColorConstants.custRedE0320D
                            : ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                ),
                // tenant person name text
                CustomText(
                  txtTitle: categoryData?.name == "HMO"
                      ? (propertyModel.tenancyDetail?.tenantProfile?.fullName
                                  .isNotEmpty ??
                              false)
                          ? propertyModel.tenancyDetail?.tenantProfile?.fullName
                          : StaticString.addTenant
                      : propertyModel.tenancyDetail == null
                          ? StaticString.notOccupied
                          : (propertyModel
                                  .tenancyDetail?.tenantProfile?.fullName ??
                              ""),
                  textOverflow: TextOverflow.ellipsis,
                  maxLine: 1,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: categoryData?.name == "HMO"
                            ? ColorConstants.custBlue1EC0EF
                            : ColorConstants.custGrey707070,
                      ),
                )
              ],
            ),
          ),

          // Tenant rent card
          Container(
            width: 115,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(65),
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: propertyModel.isDeleted
                  ? ColorConstants.custGrey707070.withOpacity(0.70)
                  : (categoryData?.name == "HMO" ||
                          propertyModel.status == "TO_LET")
                      ? ColorConstants.custRedE0320D
                      : propertyModel.status == "LET"
                          ? ColorConstants.custGreen3CAC71
                          : ColorConstants.custPurpleB772FF,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // RENT Text
                CustomText(
                  txtTitle: StaticString.rent.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: propertyModel.isDeleted
                            ? ColorConstants.custWhiteF1F0F0.withOpacity(0.70)
                            : Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                ),

                // rent text
                CustomText(
                  txtTitle:
                      "${StaticString.currency}${(propertyModel.tenancyDetail != null) ? (propertyModel.tenancyDetail?.rentAmount ?? 0) : propertyList.rent}",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: propertyModel.isDeleted
                            ? ColorConstants.custWhiteF1F0F0.withOpacity(0.70)
                            : Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //--------------------------------Button Action-----------------------------//

  //Filter button action
  void filterBtnaction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FilterScren(
          onPressed: fetchPropertyFilterData,
          submitPropertyDetailModel: _filterPropertyModel,
          lettingStatus: _lettingStatus,
          rentRange: _rentRange,
          floorSizeRange: _floorSizeRange,
          ppsRange: _ppsRange,
          selectedPropertyType: _selectedPropertyType,
          selectedCategory: _selectedCategory,
        ),
      ),
    );
  }

  // Add Button Action
  void addBtnaction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LandlordAddFlateScreen(),
      ),
    );
  }

  // Card ontap action
  Future<void> cardOntapAction({required String id}) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LandlordMyPropertiesDetailsScreen(
          propertyId: id,
        ),
      ),
    );
  }

  //Tenant Detail Card On tap
  void tenantDetailCardOntap({
    required PropertiesList propertyList,
    required PropertyDetail propertyDetail,
  }) {
    if (propertyList.propertyDetail.isNotEmpty &&
        propertyDetail.tenancyDetail != null) {
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => LandlordAddEditTenantRentDetailForm(
          property: LandlordAddTenantPropertyListModel(
            address: propertyList.addressDetail,
            propertyResource: PropertyResourceModel(
              photos: propertyList.propertyResourceDetail?.photos ?? [],
            ),
            id: propertyList.id,
          ),
          doPop: true,
        ),
      ),
    );
  }

//--------------------------Helper function--------------------------//

// Fetch Property List Data
  Future<void> fetchPropertyListData() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );

      await getPropertiesListProvider.fetchPropertiesListData(_page);
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

// fetch Property Filter Data
  Future<void> fetchPropertyFilterData(
    SubmitPropertyDetailModel submitPropertyDetailModel,
    List<LettingStatus> lettingStatus,
    RangeValues rentRange,
    RangeValues? floorSizeRange,
    RangeValues? ppsRange,
    List<String> propertyTypeList,
    List<String> categoryList,
  ) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );

      final List<String> _lettingStatusList = lettingStatus
          .where((element) => element.isSelected)
          .map((e) => e.name == StaticString.toLet ? "TO_LET" : e.name)
          .toList();

      final List<String> _featuresIdList =
          submitPropertyDetailModel.features.map((e) => e.id).toList();

      final PropertyfilterModel _properttyfilter = PropertyfilterModel(
        bathRoom: submitPropertyDetailModel.bathRoom,
        bedRoom: submitPropertyDetailModel.bedRoom,
        livingRoom: submitPropertyDetailModel.livingRoom,
        disabledFriendly: submitPropertyDetailModel.disabledFriendly,
        leaseEnding: submitPropertyDetailModel.leaseEnding,
        isDeleted: submitPropertyDetailModel.showDeleted,
        petAllowed: submitPropertyDetailModel.petAllowed,
        category: categoryList,
        type: propertyTypeList,
        lettingStatus: _lettingStatusList,
        features: _featuresIdList,
        furnishing: [submitPropertyDetailModel.furnishedType],
        serviceType: submitPropertyDetailModel.serviceType,
        propertyfilterModelClass: [submitPropertyDetailModel.classId],
        rentAmountGte: int.parse(rentRange.start.toStringAsFixed(0)),
        rentAmountLte: int.parse(rentRange.end.toStringAsFixed(0)),
        floorSizeGte: floorSizeRange == null
            ? null
            : int.parse(floorSizeRange.start.toStringAsFixed(0)),
        floorSizeLte: floorSizeRange == null
            ? null
            : int.parse(floorSizeRange.end.toStringAsFixed(0)),
        ppsGte: ppsRange == null
            ? null
            : int.parse(ppsRange.start.toStringAsFixed(0)),
        ppsLte: ppsRange == null
            ? null
            : int.parse(ppsRange.end.toStringAsFixed(0)),
      );
      _page = 1;
      await getPropertiesListProvider.fetchPropertiesListData(
        _page,
        propertyfilterModel: _properttyfilter,
      );
      _filterPropertyModel = submitPropertyDetailModel;
      _lettingStatus = lettingStatus;
      _rentRange = rentRange;
      _floorSizeRange = floorSizeRange;
      _ppsRange = ppsRange;
      _selectedPropertyType = propertyTypeList;
      _selectedCategory = categoryList;
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}

// //----------------------------- Custom AppBar------------------------------//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final Widget? title;
//   final Widget? leading;
//   final List<Widget>? actions;
//   const CustomAppBar({Key? key, this.title, this.leading, this.actions})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final TextTheme thm = Theme.of(context).textTheme;
//     return BackdropFilter(
//       filter: ImageFilter.blur(
//         sigmaX: -1.0,
//         sigmaY: -1.0,
//       ),
//       child: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           color: Colors.white12,
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             stops: [0.0, 1.0],
//             colors: [
//               ColorConstants.custGrey707070,
//               ColorConstants.custWhiteF1F0F0
//             ],
//           ),
//         ),
//         child: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           backgroundColor: Colors.transparent,
//           title: title,
//           actions: actions,
//         ),
//       ),
//     );
//     // );
//   }

//   @override
//   Size get preferredSize => const Size(double.infinity, 56);
// }
