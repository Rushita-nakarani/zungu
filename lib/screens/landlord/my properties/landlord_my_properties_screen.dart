import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/landlord_provider.dart';
import '../../../../screens/landlord/curve_paint.dart';
import '../../../../screens/landlord/my%20properties/my_properties_list_screen.dart';
import '../../../../widgets/no_content_label.dart';
import '../../../../widgets/rich_text.dart';
import '../../../constant/img_font_color_string.dart';
import '../../../models/auth/role_model.dart';
import '../../../models/landloard/properties_static_data_model.dart';
import '../../../screens/landlord/my%20properties/landloard_add_property_screen.dart';
import '../../../widgets/cust_image.dart';
import '../../../widgets/custom_alert.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/loading_indicator.dart';

class LandlordMyPropertiesScreen extends StatefulWidget {
  const LandlordMyPropertiesScreen();

  @override
  State<LandlordMyPropertiesScreen> createState() =>
      _LandlordMyPropertiesScreenState();
}

class _LandlordMyPropertiesScreenState
    extends State<LandlordMyPropertiesScreen> {
  //------------------------------Variable-----------------------------//
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  // properties provider getter method
  LandlordProvider get getmyPropertiesProvider =>
      Provider.of<LandlordProvider>(context, listen: false);

  // Role Model List of data
  final List<RoleData> _listOfRoleModel = [
    RoleData(
      images: ImgName.landlordAddProperty,
      displayName: StaticString.addProperty,
      description: StaticString.addNewProperty,
    ),
    RoleData(
      images: ImgName.landlordReminderCircle,
      displayName: StaticString.reminders,
      description: "#34 ${StaticString.reminders}",
    ),
    RoleData(
      images: ImgName.landlordManageInventory,
      displayName: StaticString.manageInventory,
      description: "#12/23 ${StaticString.properties}",
    ),
    RoleData(
      images: ImgName.landlordBrokenSofa,
      displayName: StaticString.damageReport,
      description: "#02 ${StaticString.reports}",
    ),
    RoleData(
      images: ImgName.landlordListMyProperty,
      displayName: StaticString.listMyProperty,
      description: "#03 ${StaticString.activeListings}",
    ),
    RoleData(
      images: ImgName.landMyProfile6,
      displayName: StaticString.propertyViewings,
      description: "#11 ${StaticString.confirmed}",
    ),
  ];

  // Chart Item Name List
  List<String> chartItemList = [
    StaticString.let.toUpperCase(),
    StaticString.toLet,
    StaticString.underOffer,
    StaticString.listed,
    StaticString.hmo,
  ];

  // Chart Item Color List
  final List<Color> _colorList = [
    ColorConstants.custChartGreen,
    ColorConstants.custChartRed,
    ColorConstants.custBlue1EC0EF,
    ColorConstants.custChartYellow,
    ColorConstants.custChartLovender,
  ];

  int selectedId = 0;

  final ValueNotifier _valueNotifier = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    fetchStaticPropertyData();
  }

  //---------------------------------UI-----------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  //-------------------------------Widgets--------------------------------//

  // App bar
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        StaticString.myProperties,
      ),
      actions: [
        IconButton(
          onPressed: settingBtnAction,
          icon: const CustImage(
            imgURL: ImgName.gear,
            imgColor: Colors.white,
            height: 25,
            width: 25,
          ),
        ),
      ],
      backgroundColor: ColorConstants.custDarkPurple500472,
    );
  }

  // Body
  Widget _buildBody() {
    return SafeArea(
      child: LoadingIndicator(
        loadingStatusNotifier: _loadingIndicatorNotifier,
        child: Consumer<LandlordProvider>(
          builder: (context, propertiesStaticData, child) {
            return getmyPropertiesProvider.getPropertiesStaticDataModel == null
                ? Center(
                    child: NoContentLabel(
                      title: StaticString.nodataFound,
                      onPress: fetchStaticPropertyData,
                    ),
                  )
                : SingleChildScrollView(
                    // physics: const ClampingScrollPhysics(),
                    child: Stack(
                      children: [
                        // Background Curvey card
                        _buildBackgroundCurveyCard(),
                        //Protfolio View
                        _buildPortfolioView(),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  // Background Curvey card
  Widget _buildBackgroundCurveyCard() {
    return CustomPaint(
      painter: HeaderCurvedContainer(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }

  //Protfolio View
  Widget _buildPortfolioView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        //My ProtFolio Heder text
        Center(
          child: CustomText(
            txtTitle: StaticString.myPortfolio,
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
          ),
        ),
        const SizedBox(height: 48),

        //Portfolio chart
        Consumer<LandlordProvider>(
          builder: (context, propertiesStaticData, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Center(
                    child: _buildChart(
                      propertyData:
                          propertiesStaticData.getPropertiesStaticDataModel,
                    ),
                  ),
                ),

                // Under Offer Value Chart Card
                Positioned(
                  bottom: 2,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _chartValueCard(
                        index: 2,
                        count: propertiesStaticData.getPropertiesStaticDataModel
                                ?.details?.underOffer ??
                            0,
                      ),
                    ],
                  ),
                ),

                // To Let And Listed Value Chart Card
                Positioned(
                  bottom: 36,
                  right: 0,
                  left: 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _chartValueCard(
                        index: 1,
                        count: propertiesStaticData
                                .getPropertiesStaticDataModel?.details?.toLet ??
                            0,
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      _chartValueCard(
                        index: 3,
                        count: propertiesStaticData.getPropertiesStaticDataModel
                                ?.details?.listed ??
                            0,
                      ),
                    ],
                  ),
                ),

                // Let and Hmo Value Chart Card
                Positioned(
                  bottom: 90,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _chartValueCard(
                        index: 0,
                        count: propertiesStaticData
                                .getPropertiesStaticDataModel?.details?.let ??
                            0,
                      ),
                      const SizedBox(
                        width: 230,
                      ),
                      _chartValueCard(
                        index: 4,
                        count: propertiesStaticData
                                .getPropertiesStaticDataModel?.hmoCount ??
                            0,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        // Properties subtype GridView
        _buildPropertiesSubtypeGridview(),
      ],
    );
  }

  // Protfolio Circle Chart
  Widget _buildChart({required PropertiesStaticDataModel? propertyData}) {
    return InkWell(
      onTap: protofolioChartOntap,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(500),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: ColorConstants.custGrey707070.withOpacity(0.2),
                    )
                  ],
                ),
                child: _chart(propertyData: propertyData),
              ),
            ],
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: _buildChartValues(
                propertiesCount: propertyData?.propertiesCount ?? 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Chart card
  Widget _chart({required PropertiesStaticDataModel? propertyData}) {
    final propertiesItemCount = (propertyData?.details?.let ?? 0) +
        (propertyData?.details?.toLet ?? 0) +
        (propertyData?.details?.underOffer ?? 0) +
        (propertyData?.details?.listed ?? 0) +
        (propertyData?.hmoCount ?? 0);

    final double let =
        (propertyData?.details?.let ?? 0) * 100 / propertiesItemCount;
    final double toLet =
        (propertyData?.details?.toLet ?? 0) * 100 / propertiesItemCount;
    final double underOffer =
        (propertyData?.details?.underOffer ?? 0) * 100 / propertiesItemCount;
    final double listed =
        (propertyData?.details?.listed ?? 0) * 100 / propertiesItemCount;
    final double hmo =
        (propertyData?.hmoCount ?? 0) * 100 / propertiesItemCount;

    return PieChart(
      data: propertiesItemCount == 0
          ? []
          : [
              PieChartData(
                _colorList[0],
                let,
              ),
              PieChartData(
                _colorList[1],
                toLet,
              ),
              PieChartData(
                _colorList[2],
                underOffer,
              ),
              PieChartData(
                _colorList[3],
                listed,
              ),
              PieChartData(
                _colorList[4],
                hmo,
              ),
            ],
      radius: 100,
    );
  }

  // Chart card Value
  Widget _buildChartValues({required int propertiesCount}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 15),

        //Properties Count Text
        CustomText(
          txtTitle: propertiesCount.toString(),
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 60,
              ),
        ),

        //Properties Text
        CustomText(
          txtTitle: StaticString.properties,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: ColorConstants.custGrey707070,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 10),

        // View All text and arrow Icon
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 5),
            CustomText(
              txtTitle: StaticString.viewAll1,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custDarkPurple500472,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(width: 5),
            const Icon(
              Icons.arrow_forward_rounded,
              color: ColorConstants.custDarkPurple500472,
              size: 18,
            )
          ],
        ),
      ],
    );
  }

// Custom Chart Value card
  Widget _chartValueCard({required int index, required int count}) {
    return Column(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: _colorList[index],
              width: 2,
            ),
            borderRadius: BorderRadius.circular(500),
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                color: const Color(0xFF000000).withOpacity(0.35),
                offset: const Offset(0, 3),
              )
            ],
          ),

          // Chart Item count text
          child: Center(
            child: CustomText(
              txtTitle: count.toString(),
              style: Theme.of(context).textTheme.headline2?.copyWith(
                    color: _colorList[index],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),

        // Chart Item Name Text
        CustomText(
          txtTitle: chartItemList[index],
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w500,
                color: _colorList[index],
              ),
        ),
      ],
    );
  }

  // Properties subtype GridView
  GridView _buildPropertiesSubtypeGridview() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 24,
        crossAxisSpacing: 12,
      ),
      itemCount: _listOfRoleModel.length,
      itemBuilder: (BuildContext context, int index) {
        return ValueListenableBuilder(
          valueListenable: _valueNotifier,
          builder: (context, val, child) {
            return InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () => propertiesSubtypeCardOntap(index: index),
              child: _custPropertiesSubtypeCard(
                roleModelData: _listOfRoleModel[index],
                index: index,
              ),
            );
          },
        );
      },
    );
  }

  // Custom Properties Subtype Card
  Widget _custPropertiesSubtypeCard({
    required RoleData roleModelData,
    required int index,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: selectedId.toString() == roleModelData.id
            ? ColorConstants.custDarkPurple500472
            : Colors.white,
        borderRadius: BorderRadius.circular(
          10,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: ColorConstants.custGrey707070.withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // properties Icon Image
          CustImage(
            imgURL: roleModelData.images,
            imgColor: index == 4 ? ColorConstants.custDarkPurple500472 : null,
            width: 72,
          ),
          const SizedBox(
            height: 6,
          ),
          // properties Title text
          CustomText(
            txtTitle: roleModelData.displayName,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.custDarkPurple160935,
                ),
          ),

          // properties subTitle text
          CustomRichText(
            title: roleModelData.description,
            normalTextStyle: Theme.of(context).textTheme.caption,
            fancyTextStyle: Theme.of(context).textTheme.caption?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.custBlue1BC4F4,
                ),
          )
        ],
      ),
    );
  }

  //--------------------------Button Action----------------------//

  // Setting Button Action
  void settingBtnAction() {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => const LandlordSettingsScreen(),
    //   ),
    // );
  }

  // Protofolio Chart Ontap
  void protofolioChartOntap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const MyPropertiesListScren(),
      ),
    );
  }

  // Properties SubType Card Ontap
  void propertiesSubtypeCardOntap({required int index}) {
    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LandlordAddFlateScreen(),
          ),
        );
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (ctx) => const ListMyPorpertySCreen(),
        //   ),
        // );
        break;
      case 5:
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => const MyViewingScreen(),
        //   ),
        // );
        break;
      default:
    }
  }

  //-------------------------Helper function----------------------//

  // Fetch Static Property Data function
  Future<void> fetchStaticPropertyData() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );

      await getmyPropertiesProvider.fetchPropertiesStaticData();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}

// CustomPainter class to for the header curved-container
class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = ColorConstants.custPurple500472;
    final Path path = Path()
      ..relativeLineTo(0, 220)
      ..quadraticBezierTo(size.width / 2, 270.0, size.width, 220)
      ..relativeLineTo(0, -220)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
