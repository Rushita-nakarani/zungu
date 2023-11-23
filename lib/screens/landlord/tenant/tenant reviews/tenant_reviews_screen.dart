import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/screens/landlord/tenant/tenant%20reviews/myreview_screen.dart';
import 'package:zungu_mobile/screens/landlord/tenant/tenant%20reviews/search_tenant_screen.dart';
import 'package:zungu_mobile/screens/landlord/tenant/tenant%20reviews/tenant_review_filter.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../providers/landlord/tenant/view_tenant_provider.dart';
import '../../../../utils/cust_eums.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/loading_indicator.dart';

class TenantReviewsScreen extends StatefulWidget {
  const TenantReviewsScreen({super.key});

  @override
  State<TenantReviewsScreen> createState() => _TenantReviewsScreenState();
}

class _TenantReviewsScreenState extends State<TenantReviewsScreen> {
  // controllers
  final TextEditingController _propertyFilterController =
      TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  // notifiers
  final LoadingIndicatorNotifier _indicatorNotifier =
      LoadingIndicatorNotifier();

  // providers
  LandlordTenantViewTenantProvider get landlordTenantViewTenantProvider =>
      Provider.of<LandlordTenantViewTenantProvider>(
        context,
        listen: false,
      );

  // variables
  TenantReviewFilter? filterType;
  bool isFilterIcon = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: tradesIncomeBuildAppbar(title: StaticString.tenantReview),
        // appBar: tenantMyTenanciesBuildAppbar(title: StaticString.myTenancies),
        body: const SafeArea(
          child: TabBarView(
            children: [SearchTenantScreen(), MyReviewScreen()],
          ),
        ),
      ),
    );
  }

  AppBar tradesIncomeBuildAppbar({
    //required TextEditingController filterController,
    required String title,
  }) {
    return AppBar(
      title: CustomText(
        txtTitle: title,
      ),
      backgroundColor: ColorConstants.custPurple500472,
      actions: [
        if (isFilterIcon == true)
          IconButton(
            onPressed: () {
              _selectModel();
            },
            icon: const CustImage(
              imgURL: ImgName.filter,
            ),
          )
        else
          Container()

        // showModalBottomSheet(
        //   context: context,
        //   barrierColor: Colors.black.withOpacity(0.5),
        //   shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(
        //       top: Radius.circular(25.0),
        //     ),
        //   ),
        //   isScrollControlled: true,
        //   backgroundColor: ColorConstants.backgroundColorFFFFFF,
        //   builder: (context) {
        //     return ApprovalFilter(
        //       controller: filterController,
        //       filterType: filterType,
        //     );
        //   },
        // ).then((value) {
        //   // after selecting the filter option, update list by fetching again
        //   if (value != null) {
        //     filterType = value;
        //     fetchCurrentTenantList(
        //       indicatorType: LoadingIndicatorType.overlay,
        //       query: _searchController.text,
        //     );
        //   }
        // });
      ],
      // actions: <Widget>[
      //   IconButton(
      //     icon: const CustImage(imgURL: ImgName.addIcon),
      //     onPressed: () {
      //       Navigator.of(context).push(
      //         MaterialPageRoute(
      //           builder: (ctx) => AddExpanseScreen(
      //             isEdit: true,
      //           ),
      //         ),
      //       );
      //     },
      //   )
      // ],
      bottom: PreferredSize(
        preferredSize: _tabBar.preferredSize,
        child: Container(
          color: ColorConstants.backgroundColorFFFFFF,
          child: _tabBar,
        ),
      ),
    );
  }

  // Filter btnAction on tap...
  Future _selectModel() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: ColorConstants.backgroundColorFFFFFF,
      builder: (context) {
        return const ReviewFilter();
        // Selector(
        //   controller: controller,
        // );
      },
    );
  }
  // fetching tenancies list
  // Future<void> fetchCurrentTenantList({
  //   required LoadingIndicatorType indicatorType,
  //   String query = "",
  // }) async {
  //   try {
  //     FocusManager.instance.primaryFocus?.unfocus();
  //     _indicatorNotifier.show(
  //       loadingIndicatorType: indicatorType,
  //     );
  //     await landlordTenantViewTenantProvider.fetchCurrentTenants(
  //       filterType: filterType,
  //       query: query,
  //     );
  //   } catch (e) {
  //     showAlert(context: context, message: e);
  //     // rethrow;
  //   } finally {
  //     _indicatorNotifier.hide();
  //   }
  // }

  TabBar get _tabBar => TabBar(
        onTap: (value) {
          tabBarOntapaction(value);
        },
        labelColor: ColorConstants.custBlue1EC0EF,
        unselectedLabelColor: ColorConstants.custGrey707070,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 2.0,
            color: ColorConstants.custBlue1EC0EF,
          ),
          insets: EdgeInsets.symmetric(horizontal: 16.0),
        ),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontFamily: CustomFont.ttCommons,
          fontWeight: FontWeight.w600,
        ),
        tabs: [
          Tab(
            text: StaticString.searchTenants.toUpperCase(),
          ),
          Tab(
            text: StaticString.myReviews.toUpperCase(),
          ),
        ],
      );

  // Tabbar on tap action...
  void tabBarOntapaction(int value) {
    if (value == 0) {
      if (mounted) {
        setState(() {
          isFilterIcon = false;
        });
      }
    } else if (value == 1) {
      if (mounted) {
        setState(() {
          isFilterIcon = true;
        });
      }
    }
  }
}
