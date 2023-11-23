import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/tenant/my_tenancies/tenancy_detail.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';
import 'package:zungu_mobile/widgets/no_content_label.dart';

import '../../../models/tenant/fetch_current_tenancy_model.dart';
import '../../../providers/dashboard_provider/tenant_dashboard_provider.dart';
import '../../../providers/tenantProvider/tenancy_provider.dart';
import '../../../widgets/bookmark_widget.dart';
import '../../../widgets/cust_image.dart';
import '../../../widgets/custom_alert.dart';
import '../../../widgets/custom_text.dart';

class TenantMyTenanciesCurrentTenancy extends StatefulWidget {
  const TenantMyTenanciesCurrentTenancy({super.key});

  @override
  State<TenantMyTenanciesCurrentTenancy> createState() =>
      _TenantMyTenanciesCurrentTenancyState();
}

class _TenantMyTenanciesCurrentTenancyState
    extends State<TenantMyTenanciesCurrentTenancy> {
  // final List<ItemAndCount> homeItemList = [
  //   ItemAndCount(
  //     image: ImgName.tenantBed,
  //     count: 3,
  //   ),
  //   ItemAndCount(
  //     image: ImgName.tenantBath,
  //     count: 3,
  //   ),
  //   ItemAndCount(
  //     image: ImgName.tenantSofa,
  //     count: 3,
  //   ),
  //   ItemAndCount(
  //     image: ImgName.tenantDisableAllow,
  //     // count: -1,
  //   ),
  // ];
  // Home Item Image List
  List<String> homeList = [
    ImgName.tenantBed,
    ImgName.tenantBath,
    ImgName.tenantSofa,
  ];
  TenanciesProvider get tenancyProvider =>
      Provider.of<TenanciesProvider>(context, listen: false);

  TenantDashboradProvider get getTenantDashboardProvider =>
      Provider.of<TenantDashboradProvider>(context, listen: false);
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();
  @override
  void initState() {
    fetchCurrentTenancies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Consumer<TenanciesProvider>(
        builder: (context, currentTennacy, child) => currentTennacy
                .fetchCurrentTenantList.isEmpty
            ? Center(
                child: NoContentLabel(
                  title: StaticString.nodataFound,
                  onPress: () {
                    fetchCurrentTenancies();
                  },
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  await Provider.of<TenanciesProvider>(context, listen: false)
                      .fetchPreviousTenancy(StaticString.statusCURRENT);
                },
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: currentTennacy.fetchCurrentTenantList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return currentTenancyCard(
                        currentTenancyModel:
                            currentTennacy.fetchCurrentTenantList[index],
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }

  Widget currentTenancyCard({
    required CurrentTenancyModel currentTenancyModel,
  }) {
    return Stack(
      children: [
        Column(
          children: [
            InkWell(
              onTap: () {
                currentTenancyModel.lettingStatus.isNotEmpty
                    ? Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => TenantMyTenanciesDetailScreen(
                            fetchCurrentTenancyModel: currentTenancyModel,
                          ),
                        ),
                      )
                    : null;
              },
              child: Column(
                children: [
                  // Property Image
                  _tenancyImage(
                    currentTenancyModel: currentTenancyModel,
                  ),

                  //property title,subtitle text and offer card
                  _tenancyAddressDetails(
                    currentTenancy: currentTenancyModel,
                  ),

                  // Home Property item count
                  if (currentTenancyModel.lettingStatus.isNotEmpty)
                    _homeItemList(currentTenancyModel: currentTenancyModel)
                  else
                    Container(),
                  SizedBox(
                    height:
                        currentTenancyModel.lettingStatus.isNotEmpty ? 20 : 0,
                  ),
                ],
              ),
            ),
            // Tenant Details card
            // InkWell(
            //   onTap: () => tenantDetailCardOntap(propertyList: propertyList),
            //   child: Column(
            //     children: List.generate(
            //       propertyList.propertyDetail.length,
            //       (index) {
            //         return Padding(
            //           padding: const EdgeInsets.only(top: 15),
            //           child: _tenantDetailsCard(
            //             propertyList: propertyList,
            //             propertyModel: propertyList.propertyDetail[index],
            //             categoryData: propertyList.category,
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            const SizedBox(height: 40),
          ],
        ),
        Positioned(
          top: 230,
          left: MediaQuery.of(context).size.width * 0.08,
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              color: ColorConstants.custDarkPurple150934.withOpacity(0.7),
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: CustomText(
              txtTitle: "£${currentTenancyModel.rentAmount}/month",
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.backgroundColorFFFFFF,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _tenancyImage({
    required CurrentTenancyModel currentTenancyModel,
  }) {
    return Stack(
      // alignment: Alignment.bottomLeft,
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
              imgURL: currentTenancyModel.photos.isNotEmpty
                  ? currentTenancyModel.photos.first
                  : "",
            ),
          ),
        ),

        //Property Deteleted Container
        // Container(
        //   height: 250,
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(20),
        //     color: propertyList.isDeleted
        //         ? ColorConstants.custGrey707070.withOpacity(0.70)
        //         : null,
        //   ),
        // ),

        //Deleted Tag Card

        // Positioned(
        //   top: 15,
        //   left: 15,
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        //     decoration: BoxDecoration(
        //       color: ColorConstants.custBlack5A5A5A.withOpacity(0.80),
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     child: CustomText(
        //       align: TextAlign.center,
        //       txtTitle: StaticString.deleted,
        //       style: Theme.of(context)
        //           .textTheme
        //           .caption
        //           ?.copyWith(color: Colors.white),
        //     ),
        //   ),
        // )
      ],
    );
  }

  //property title,subtitle text and offer card
  Widget _tenancyAddressDetails({
    required CurrentTenancyModel currentTenancy,
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
                  txtTitle: currentTenancy.firstAddress,
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: ColorConstants.custDarkPurple150934,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),

                //Property Address text
                CustomText(
                  txtTitle: currentTenancy.address?.fullAddress,
                  textOverflow: TextOverflow.ellipsis,
                  maxLine: 1,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custGrey707070,
                      ),
                )
              ],
            ),
          ),

          // Property Book Mark Card
          if (currentTenancy.lettingStatus.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                bottom: 25,
              ),
              child: buildBookmark(
                text: currentTenancy.lettingStatus,
                color: setBookMarkColor(currentTenancy),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: InkWell(
                onTap: () {
                  showAlert(
                    context: context,
                    title: StaticString.deleteTenancy,
                    singleBtnTitle: StaticString.delete,
                    showIcon: false,
                    singleBtnColor: ColorConstants.custChartRed,
                    message: AlertMessageString.deleteTenancyConf,
                    onRightAction: () {
                      deleteTenancy(currentTenancy.id);
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: _commonCardDecoration,
                  child: const CustImage(
                    width: 25,
                    imgURL: ImgName.deleteRed,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color setBookMarkColor(CurrentTenancyModel currentTennacy) {
    switch (currentTennacy.lettingStatus) {
      case "TO_LET":
        return ColorConstants.custRedE0320D;
      case "LET":
        return ColorConstants.custGreen3CAC71;
      case "HMO":
        return ColorConstants.custPurpleB772FF;
      default:
        return ColorConstants.custBlue29C3EF;
    }
  }

  // Home Property item count
  Widget _homeItemList({required CurrentTenancyModel currentTenancyModel}) {
    final List<int> homeItemnCount = [
      currentTenancyModel.bedRoom,
      currentTenancyModel.bathRoom,
      currentTenancyModel.livingRoom,
    ];
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              homeList.length,
              (index) => _custHomeItemCard(
                img: homeList[index],
                homeItemCount: homeItemnCount[index],
                currentTenancyModel: currentTenancyModel,
              ),
            ),
          ),
          // Wheel chair image
          CustImage(
            imgURL: currentTenancyModel.disabledFriendly
                ? ImgName.tenantDisableAllow
                : ImgName.tenantDisableNotAllow,
            height: 36,
            width: 36,
          ),
        ],
      ),
    );
  }

  Widget _custHomeItemCard({
    required String img,
    required int homeItemCount,
    required CurrentTenancyModel currentTenancyModel,
  }) {
    return Row(
      children: [
        //Home Item Icon Image
        CustImage(
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
                color: ColorConstants.custBlack808080,
                fontWeight: FontWeight.w400,
              ),
        ),
        const SizedBox(width: 30),
      ],
    );
  }

  // Widget currentTenancyCard(
  //   CurrentTenancyModel fetchCurrentTenancyModel,
  // ) {
  //   return InkWell(
  //     onTap: () {},
  //     child: Container(
  //       margin: const EdgeInsets.only(top: 35),
  //       height: 370,
  //       child: Stack(
  //         children: <Widget>[
  //           Positioned(
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(30),
  //               child: InkWell(
  //                 onTap: () {
  //                   Navigator.of(context).push(
  //                     MaterialPageRoute(
  //                       builder: (ctx) => TenantMyTenanciesDetailScreen(
  //                         fetchCurrentTenancyModel: fetchCurrentTenancyModel,
  //                       ),
  //                     ),
  //                   );
  //                 },
  //                 child: CustImage(
  //                   imgURL: fetchCurrentTenancyModel.photo,
  //                   height: 250,
  //                   width: double.infinity,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Positioned(
  //             top: 230,
  //             left: MediaQuery.of(context).size.width * 0.08,
  //             child: Container(
  //               height: 30,
  //               decoration: BoxDecoration(
  //                 color: ColorConstants.custDarkPurple150934.withOpacity(0.7),
  //                 borderRadius: BorderRadius.circular(25),
  //               ),
  //               padding:
  //                   const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
  //               child: CustomText(
  //                 txtTitle: "£${fetchCurrentTenancyModel.rentAmount}/month",
  //                 style: Theme.of(context).textTheme.bodyText2?.copyWith(
  //                       color: ColorConstants.backgroundColorFFFFFF,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //               ),
  //             ),
  //           ),
  //           if (fetchCurrentTenancyModel.lettingStatus.isNotEmpty)
  //             Positioned(
  //               top: 250,
  //               right: MediaQuery.of(context).size.width * 0.05,
  //               child: buildBookmark(
  //                 text: fetchCurrentTenancyModel.lettingStatus,
  //                 color: ColorConstants.custChartGreen,
  //               ),
  //             )
  //           else
  //             Positioned(
  //               top: 280,
  //               right: MediaQuery.of(context).size.width * 0.05,
  //               child: InkWell(
  //                 onTap: () {
  //                   showAlert(
  //                     context: context,
  //                     title: StaticString.deleteTenancy,
  //                     singleBtnTitle: StaticString.delete,
  //                     showIcon: false,
  //                     singleBtnColor: ColorConstants.custChartRed,
  //                     message: AlertMessageString.deleteTenancyConf,
  //                     onRightAction: () {
  //                       deleteTenancy(fetchCurrentTenancyModel.id);
  //                     },
  //                   );
  //                 },
  //                 child: Container(
  //                   padding: const EdgeInsets.all(5),
  //                   decoration: _commonCardDecoration,
  //                   child: const CustImage(
  //                     width: 25,
  //                     imgURL: ImgName.deleteRed,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           Positioned(
  //             top: 272,
  //             left: 30,
  //             right: 20,
  //             child: CustomText(
  //               txtTitle: fetchCurrentTenancyModel.firstAddress,
  //               style: Theme.of(context).textTheme.headline2?.copyWith(
  //                     fontWeight: FontWeight.w700,
  //                   ),
  //             ),
  //           ),
  //           Positioned(
  //             top: 294,
  //             left: 30,
  //             child: CustomText(
  //               txtTitle: fetchCurrentTenancyModel.address?.fullAddress,
  //               style: Theme.of(context).textTheme.bodyText2?.copyWith(
  //                     color: ColorConstants.custGrey8A8A8A,
  //                   ),
  //             ),
  //           ),
  //           if (fetchCurrentTenancyModel.lettingStatus.isNotEmpty)
  //             Positioned(
  //               bottom: 0,
  //               width: MediaQuery.of(context).size.width,
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 30),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     CustHomeItemRowWidget(
  //                       item: ItemAndCount(
  //                         image: ImgName.tenantBed,
  //                         count: fetchCurrentTenancyModel.bedRoom,
  //                       ),
  //                     ),
  //                     CustHomeItemRowWidget(
  //                       item: ItemAndCount(
  //                         image: ImgName.tenantBath,
  //                         count: fetchCurrentTenancyModel.bathRoom,
  //                       ),
  //                     ),
  //                     CustHomeItemRowWidget(
  //                       item: ItemAndCount(
  //                         image: ImgName.tenantSofa,
  //                         count: fetchCurrentTenancyModel.livingRoom,
  //                       ),
  //                     ),
  //                     CustImage(
  //                       imgURL: fetchCurrentTenancyModel.disabledFriendly
  //                           ? ImgName.tenantDisableAllow
  //                           : ImgName.tenantDisableNotAllow,
  //                       height: 30,
  //                       width: 36,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             )
  //           else
  //             Container(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  final BoxDecoration _commonCardDecoration = BoxDecoration(
    color: ColorConstants.backgroundColorFFFFFF,
    borderRadius: BorderRadius.circular(3),
    boxShadow: [
      BoxShadow(
        color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
        blurRadius: 12,
      ),
    ],
  );

  Future<void> fetchCurrentTenancies() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      await Provider.of<TenanciesProvider>(context, listen: false)
          .fetchPreviousTenancy(StaticString.statusCURRENT);
      // getTenantDashboardProvider.fetchTenantTaskList();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  Future<void> deleteTenancy(String tenancyId) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      await tenancyProvider.deleteTenacy(tenancyId);
      tenancyProvider.fetchPreviousTenancy(StaticString.statusCURRENT);
      getTenantDashboardProvider.fetchTenantDashboardList();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
