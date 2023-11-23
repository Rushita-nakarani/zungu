// ignore_for_file: use_build_context_synchronously

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/providers/dashboard_provider/landlord_dashboard_provider.dart';
import 'package:zungu_mobile/widgets/rich_text.dart';

import '../../cards/dashboard_card.dart';
import '../../constant/img_font_color_string.dart';
import '../../widgets/cust_image.dart';
import '../../widgets/custom_alert.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/no_content_label.dart';

class LandlordDashboardScreen extends StatefulWidget {
  const LandlordDashboardScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LandlordDashboardScreen> createState() =>
      _LandlordDashboardScreenState();
}

class _LandlordDashboardScreenState extends State<LandlordDashboardScreen> {
  //----------------------------Variable-------------------------//
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  LandlordDashboradProvider get getLandlordDashboardProvider =>
      Provider.of<LandlordDashboradProvider>(context, listen: false);

  List<String> myDashboardImages = [
    ImgName.financial,
    ImgName.invoice,
    ImgName.property,
    ImgName.landlordMaintenance,
    ImgName.tenant,
    ImgName.buisnessServicesld,
  ];

  @override
  void initState() {
    super.initState();
    fetchDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      top: false,
      child: LoadingIndicator(
        loadingStatusNotifier: _loadingIndicatorNotifier,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 20,
                    //     vertical: 10,
                    //   ),
                    //   child: _buildSearchField(),
                    // ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomText(
                        txtTitle: StaticString.newTaskLeft,
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Consumer<LandlordDashboradProvider>(
                      builder: (context, provider, child) {
                        return provider.newTaskLeftList.isEmpty
                            ? NoContentLabel(
                                title: StaticString.nodataFound,
                                onPress: fetchDashboardData,
                              )
                            : SizedBox(
                                height: 100,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: 12,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    // vertical: 10,
                                    horizontal: 20,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: provider.newTaskLeftList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _buildNewTaskCard(
                                      provider.newTaskLeftList[index],
                                    );
                                  },
                                ),
                              );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (ctx) => const SettingScreen(),
                        //   ),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomText(
                          txtTitle: StaticString.myDashboard,
                          style:
                              Theme.of(context).textTheme.headline1?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ),
                    _buildDashboardCard(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard() {
    return Consumer<LandlordDashboradProvider>(
      builder: (context, dashboardList, child) {
        return dashboardList.dashboardData.isEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 50),
                child: NoContentLabel(
                  title: StaticString.nodataFound,
                  onPress: () async {
                    fetchDashboardData();
                  },
                ),
              )
            : GridView.builder(
                itemCount: dashboardList.dashboardData.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 35),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.95,
                ),
                itemBuilder: (context, index) {
                  return DashboardCard(
                    iconImage: dashboardList.dashboardData[index].iconImage,
                    title: dashboardList.dashboardData[index].title,
                    subtitleValue:
                        dashboardList.dashboardData[index].subtitleValue,
                    subtitle: dashboardList.dashboardData[index].subtitle,
                    customSubtitle:
                        dashboardList.dashboardData[index].customSubtitle,
                    primaryColor: ColorConstants.custBlue1EC0EF,
                    bgColor: index == 0 || index == 3 || index == 4
                        ? ColorConstants.custPurple500472
                        : ColorConstants.custBlue1EC0EF,
                    isLeft: index % 2 == 0,
                    onTap: dashboardList.dashboardData[index].onTap,
                  );
                },
              );
      },
    );
  }

  // ------------ Financial content ------------
  Widget _invoiceCommonContent({
    String title = "",
    String subTitle = "",
  }) {
    return Column(
      children: [
        CustomText(
          txtTitle: title,
          align: TextAlign.center,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                height: 1,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomRichText(
          title: subTitle,
          fancyTextStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                height: 1,
                color: ColorConstants.custBlue1BC4F4,
                fontWeight: FontWeight.w700,
              ),
          normalTextStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                height: 1,
                color: ColorConstants.custDarkPurple160935,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  Widget _buildNewTaskCard(
    NewTaskLeftModel newTaskLeftList,
  ) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 85,
          width: 85,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(top: 8, bottom: 10, right: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              15,
            ),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
                blurRadius: 12,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustImage(
                height: 28,
                width: 28,
                imgURL: newTaskLeftList.icon,
              ),
              const SizedBox(
                height: 6,
              ),
              CustomText(
                txtTitle: newTaskLeftList.title.trim().replaceAll(" ", "\n"),
                maxLine: 2,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.custDarkPurple160935,
                      overflow: TextOverflow.ellipsis,
                      height: 1,
                    ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: CircleAvatar(
            maxRadius: 10,
            minRadius: 10,
            backgroundColor: ColorConstants.custBlue1BC4F4,
            child: CustomText(
              txtTitle: newTaskLeftList.count.toString(),
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  // Search field
  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
            blurRadius: 10,
          ),
        ],
      ),
      height: 46,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              cursorColor: ColorConstants.custBlue1BC4F4,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20, right: 10),
                hintText: "Search",
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
            ),
          ),
          const CustImage(
            imgURL: ImgName.landlordSearch,
            width: 24,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  // ------ Helper widgets --------
  BoxDecoration commonDecoration({
    double blurRadius = 7,
    Color color = Colors.white,
  }) {
    return BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: ColorConstants.custGrey7A7A7A.withOpacity(0.3),
          blurRadius: blurRadius,
        ),
      ],
    );
  }

  Future<void> fetchDashboardData() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      if (getLandlordDashboardProvider.subscribeRoleModel == null) {
        return;
      }

      await Future.wait([
        getLandlordDashboardProvider.fetchLandlordDashboardList(context),
        Provider.of<LandlordDashboradProvider>(context, listen: false)
            .fetchRoleList(),
      ]);
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}

class NewTaskLeftModel {
  NewTaskLeftModel({
    this.icon = "",
    this.title = "",
    this.count = 0,
  });

  String icon;
  String title;
  int count;

  factory NewTaskLeftModel.fromJson(Map<String, dynamic> json) =>
      NewTaskLeftModel(
        icon: json["icon"] ?? "",
        title: json["title"] ?? "",
        count: json["count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "icon": icon,
        "title": title,
        "count": count,
      };
}
