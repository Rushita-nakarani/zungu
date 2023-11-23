import 'package:flutter/material.dart';

import '../../../../cards/inventory_room_card.dart';
import '../../../../cards/inventory_tenant_profile_card.dart';
import '../../../../constant/img_font_color_string.dart';
import '../../../../models/inventory_room_model.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_title_with_line.dart';
import '../../../../widgets/rounded_lg_shape_widget.dart';

class LandlordTenantCheckInventoryRoomDetail extends StatefulWidget {
  const LandlordTenantCheckInventoryRoomDetail({super.key});

  @override
  State<LandlordTenantCheckInventoryRoomDetail> createState() =>
      _LandlordTenantCheckInventoryRoomDetailState();
}

class _LandlordTenantCheckInventoryRoomDetailState
    extends State<LandlordTenantCheckInventoryRoomDetail> {
  final roomList = [
    InventoryRoom(
      iconImage: ImgName.whiteBedroom,
      title: "Bedroom",
      color: ColorConstants.custRedD92A2A,
    ),
    InventoryRoom(
      iconImage: ImgName.whiteBathroom,
      title: "Bathroom",
      color: ColorConstants.custBlue4831D4,
    ),
    InventoryRoom(
      iconImage: ImgName.whiteLivingRoom,
      title: "Living Room",
      color: ColorConstants.custPinkED2188,
    ),
    InventoryRoom(
      iconImage: ImgName.whiteKitchen,
      title: "Kitchen",
      color: ColorConstants.custGreen2BAD2D,
    ),
    InventoryRoom(
      iconImage: ImgName.whiteDining,
      title: "Dining Room",
      color: ColorConstants.custLavenderA04EF6,
    ),
    InventoryRoom(
      iconImage: ImgName.whiteConservatory,
      title: "Conservatory",
      color: ColorConstants.custBlue00C0FF,
    ),
    InventoryRoom(
      iconImage: ImgName.whiteDownstairs,
      title: "Downstairs Hall",
      color: ColorConstants.custGreen1BE8B0,
    ),
    InventoryRoom(
      iconImage: ImgName.whiteRoom,
      title: "New Room",
      color: ColorConstants.custDarkPurple500472,
    ),
  ];

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
                    const SizedBox(height: 15),
                    _buildRoomCards(),
                    const SizedBox(height: 50),
                    _buildStartInventoryCheckButton(),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            )
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

  Widget _buildRoomCards() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: roomList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: InventoryTenantRoomCard(
            iconImage: roomList[index].iconImage,
            title: roomList[index].title,
            color: roomList[index].color,
          ),
        );
      },
    );
  }

  Widget _buildStartInventoryCheckButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: CommonElevatedButton(
        bttnText: StaticString.startInventoryCheck.toUpperCase(),
        color: ColorConstants.custBlue1EC0EF,
        fontSize: 18,
        onPressed: () {},
      ),
    );
  }
}
