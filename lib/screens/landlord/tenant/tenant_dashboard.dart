import 'package:flutter/material.dart';
import 'package:zungu_mobile/main.dart';
import 'package:zungu_mobile/screens/landlord/tenant/active%20leases/active_leases_listing_screen.dart';
import 'package:zungu_mobile/screens/landlord/tenant/add%20tenants/add_tenant.dart';
import 'package:zungu_mobile/screens/landlord/tenant/view_end%20tenancy/view_tenants.dart';
import 'package:zungu_mobile/widgets/statusbar_content_style.dart';

import '../../../../constant/img_font_color_string.dart';
import '../../../../widgets/cust_image.dart';
import '../../../cards/dashboard_ractangle_card.dart';
import '../../../widgets/custom_text.dart';
import 'create lease/create_new_lease_agree_proceed_screen.dart';
import 'e_signed_leases/e_signed_leases_screen.dart';

class LandlordTenantScreen extends StatelessWidget {
  LandlordTenantScreen({super.key});

  List<LandlordTenantDashboardModel> allItems = [
    LandlordTenantDashboardModel(
      iconImage: ImgName.addTenant,
      title: StaticString.addTenant,
      onTap: () {
        Navigator.of(getContext).push(
          MaterialPageRoute(
            builder: (ctx) => const LandlordAddTenant(),
          ),
        );
      },
    ),
    LandlordTenantDashboardModel(
      iconImage: ImgName.addTenant,
      title: StaticString.tenantReview,
      onTap: () {
        // Navigator.of(getContext).push(
        //   MaterialPageRoute(
        //     builder: (ctx) => const TenantReviewsScreen(),
        //   ),
        // );
      },
    ),
    LandlordTenantDashboardModel(
      iconImage: ImgName.activeLeases,
      title: StaticString.activeLeases,
      onTap: () {
        Navigator.of(getContext).push(
          MaterialPageRoute(
            builder: (ctx) => const ActiveLeasesListingScreen(),
          ),
        );
      },
    ),
    LandlordTenantDashboardModel(
      iconImage: ImgName.viewEndTenancy,
      title: StaticString.viewEndTenancy,
      onTap: () {
        Navigator.of(getContext).push(
          MaterialPageRoute(
            builder: (ctx) => const LandlordTenantViewEndTenants(),
          ),
        );
      },
    ),
    LandlordTenantDashboardModel(
      iconImage: ImgName.createNewLease,
      title: StaticString.createNewLease,
      onTap: () {
        Navigator.of(getContext).push(
          MaterialPageRoute(
            builder: (ctx) => const CreateNewLeaseAgreeAndProceed(),
          ),
        );
      },
    ),
    LandlordTenantDashboardModel(
      iconImage: ImgName.eSignedLeases,
      title: StaticString.eSignedLeases,
      onTap: () {
        Navigator.of(getContext).push(
          MaterialPageRoute(
            builder: (ctx) => const ESignedLeasesScreen(),
          ),
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return StatusbarContentStyle(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child:
            // full screen design
            _buildScaffold(context),
      ),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    final size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height -
            kToolbarHeight +
            MediaQuery.of(context).padding.top -
            24) /
        4;
    final double itemWidth = size.width / 2;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              // Background circle Image
              _buildTopBackgroundImage(context),
              _buildBackArrow(context),
              _buildBottomBackgroundImage(context),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // top space
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 3.5,
                    ),

                    // title
                    _buildTitle(),
                    const SizedBox(
                      height: 20,
                    ),

                    // dashboard tiles
                    _buildDashboardTiles(itemWidth, itemHeight, size),

                    // bottom space
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 3.5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Backgroung circle Image
  Positioned _buildTopBackgroundImage(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: SafeArea(
        child: CustImage(
          imgURL: ImgName.tenantTop,
          width: MediaQuery.of(context).size.width / 1.2,
        ),
      ),
    );
  }

  Widget _buildBackArrow(BuildContext context) {
    return Positioned(
      top: 50,
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: ColorConstants.custDarkPurple500472,
        ),
      ),
    );
  }

  Padding _buildTitle() {
    return const Padding(
      padding: EdgeInsets.only(top: 20),
      child: CustomText(
        txtTitle: StaticString.tenants,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w400,
          color: ColorConstants.custDarkPurple500472,
        ),
      ),
    );
  }

  Widget _buildDashboardTiles(
    double itemWidth,
    double itemHeight,
    Size size,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: allItems.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: itemWidth / itemHeight,
      ),
      itemBuilder: (BuildContext context, int index) {
        return DashboardRactangleCard(
          iconImage: allItems[index].iconImage,
          title: allItems[index].title,
          onTap: allItems[index].onTap,
        );
      },
    );
  }

  Positioned _buildBottomBackgroundImage(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: SafeArea(
        child: CustImage(
          imgURL: ImgName.tenantBottom,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}

class LandlordTenantDashboardModel {
  final String iconImage;
  final String title;
  final VoidCallback onTap;

  LandlordTenantDashboardModel({
    required this.iconImage,
    required this.title,
    required this.onTap,
  });
}
