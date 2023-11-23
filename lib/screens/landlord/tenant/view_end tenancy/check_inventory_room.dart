import 'package:flutter/material.dart';

import '../../../../cards/inventory_tenant_profile_card.dart';
import '../../../../constant/img_font_color_string.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_title_with_line.dart';
import '../../../../widgets/rounded_lg_shape_widget.dart';
import 'check_inventory_room_detail.dart';

class LandlordTenantCheckInventoryRoom extends StatefulWidget {
  const LandlordTenantCheckInventoryRoom({super.key});

  @override
  State<LandlordTenantCheckInventoryRoom> createState() =>
      LandlordTenantCheckInventoryRoomState();
}

class LandlordTenantCheckInventoryRoomState
    extends State<LandlordTenantCheckInventoryRoom> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: _buildScaffold(),
    );
  }

  Widget _buildScaffold() {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const RoundedLgShapeWidget(
              title: StaticString.startInventoryCheck,
              color: ColorConstants.custDarkPurple500472,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    const InventoryTenantProfileCard(
                      tenantName: "John Smith",
                      tenantAddress:
                          "City Gardens, 3B Spinners, Manchester M15",
                      leaseEndDate: "20 Mar 2022",
                      tenantImage: ImgName.zunguFloating,
                      calenderColor: ColorConstants.custDarkPurple500472,
                    ),
                    const SizedBox(height: 30),
                    _buildBottomTitle(),
                    const SizedBox(height: 30),
                    _buildRoomCard(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    _buildStartInventoryCheckButton(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const CustomText(
        txtTitle: StaticString.checkInventory,
      ),
      backgroundColor: ColorConstants.custDarkPurple500472,
    );
  }

  Widget _buildBottomTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 28),
      child: CustomTitleWithLine(
        title: StaticString.rooms,
        primaryColor: ColorConstants.custDarkPurple500472,
        secondaryColor: ColorConstants.custBlue1EC0EF,
      ),
    );
  }

  Widget _buildRoomCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorConstants.backgroundColorFFFFFF,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custBlack000000.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 0.2,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorConstants.custRedD7181F,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const CustImage(
              imgURL: ImgName.whiteBedroom,
            ),
          ),
          const SizedBox(width: 10),
          CustomText(
            txtTitle: "Room 1 - Single",
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          )
        ],
      ),
    );
  }

  Widget _buildStartInventoryCheckButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: CommonElevatedButton(
        bttnText: StaticString.startInventoryCheck.toUpperCase(),
        color: ColorConstants.custBlue1EC0EF,
        fontSize: 18,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const LandlordTenantCheckInventoryRoomDetail(),
            ),
          );
        },
      ),
    );
  }
}
