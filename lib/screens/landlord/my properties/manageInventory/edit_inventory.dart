//---------------------- Edit Inventory Screen ----------------------//

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/landlord/my%20properties/manageInventory/edit_inventory_roomdetailscard.dart';
import 'package:zungu_mobile/widgets/bookmark_widget.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/custom_title_with_line.dart';

class EditInventoryScreen extends StatefulWidget {
  const EditInventoryScreen({super.key});

  @override
  State<EditInventoryScreen> createState() => _EditInventoryScreenState();
}

class _EditInventoryScreenState extends State<EditInventoryScreen> {
//---------------------------- Variables ----------------------------//

  final urlImage =
      "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  List<String> selectRoomImages = [
    ImgName.bedroom,
    ImgName.bathroom,
    ImgName.livingroom,
    ImgName.kitchen1,
    ImgName.diningroom,
    ImgName.conservatory,
    ImgName.downstairshall,
    ImgName.newroom,
  ];
  List<String> selectRoomNumber = [
    "4x",
    "1x",
    "1x",
    "1x",
    "1x",
    "1x",
    "1x",
    "1x",
  ];

  List<String> selectRoomName = [
    "Bedroom",
    "Bathroom",
    "Living Room",
    "Kitchen",
    "Dining Room",
    "Conseratory",
    "Downstairs Hall",
    "New Room"
  ];

//------------------------------ UI ---------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Container(
                height: 244,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 12,
                      color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: <Widget>[
                      _buildImage(),
                      _buildBookMark(),
                      _buildTitle(),
                      _buildsubTitle(),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 45),
                  _buildSelectRoomsTitle(),
                  const SizedBox(height: 40),
                  _buildSelectRoomsListViewCard(),
                  const SizedBox(height: 40),
                  const Divider(),
                  _buildAddRoom(),
                  const Divider(),
                  const SizedBox(height: 30),
                  _buildNextbutton(),
                  const SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//---------------------------- Widgets ------------------------------//

//------------------------- Next Button -----------------------------/

  Widget _buildNextbutton() {
    return CommonElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      bttnText: StaticString.next,
      color: ColorConstants.custPurple500472,
      fontSize: 14,
    );
  }
//---------------------------- Add Room -----------------------------/

  Widget _buildAddRoom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: const CustImage(
                  height: 34,
                  width: 34,
                  imgURL: ImgName.sofa,
                ),
              ),
            ),
            const SizedBox(width: 11),
            CustomText(
              txtTitle: "Add Room",
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    color: ColorConstants.custDarkBlue160935,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 23,
            width: 23,
            decoration: BoxDecoration(
              color: ColorConstants.custBlue2AC4EF,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
                )
              ],
            ),
            child: const Center(
              child: CustImage(
                width: 10,
                height: 10,
                imgURL: ImgName.addIcon,
              ),
            ),
          ),
        ),
      ],
    );
  }
//------------------------ Select Rooms Card ------------------------/

  Widget _buildSelectRoomsListViewCard() {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: selectRoomImages.length,
      itemBuilder: (context, index) {
        return EditInventoryRoomDetailsCard(
          selectRoomImages: selectRoomImages[index],
          selectRoomNumber: selectRoomNumber[index],
          selectRoomName: selectRoomName[index],
        );
      },
    );
  }
//----------------------- Select Rooms Title ------------------------/

  Widget _buildSelectRoomsTitle() {
    return CustomTitleWithLine(
      title: "Select Rooms",
      style: Theme.of(context).textTheme.headline2?.copyWith(
            color: ColorConstants.custDarkBlue160935,
            fontWeight: FontWeight.w600,
          ),
      primaryColor: ColorConstants.custPurple500472,
      secondaryColor: ColorConstants.custBlue1EC0EF,
    );
  }

//--------------------------- SubTitle ------------------------------/
  Widget _buildsubTitle() {
    return Positioned(
      top: 210,
      left: 15,
      child: CustomText(
        txtTitle: "Tariff Street, Manchester M1",
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: ColorConstants.custGrey707070,
              fontWeight: FontWeight.w400,
            ),
      ),
    );
  }

//---------------------------- Title --------------------------------/
  Widget _buildTitle() {
    return Positioned(
      top: 185,
      left: 15,
      child: CustomText(
        txtTitle: "3 Bed Cottage",
        style: Theme.of(context).textTheme.headline1?.copyWith(
              color: ColorConstants.custDarkBlue150934,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
//------------------------- Book Mark -------------------------------/

  Widget _buildBookMark() {
    return Positioned(
      top: 170,
      right: MediaQuery.of(context).size.width * 0.05,
      child: SizedBox(
        height: 50,
        width: 37,
        child: buildBookmark(
          text: "Let".toUpperCase(),
          color: ColorConstants.custGreen3CAC71,
        ),
      ),
    );
  }
//--------------------------- Image ---------------------------------/

  Widget _buildImage() {
    return Positioned(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CustImage(
          imgURL: urlImage,
          height: 170,
          width: double.infinity,
        ),
      ),
    );
  }
//-------------------------- AppBar ---------------------------------/

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.custDarkPurple500472,
      title: const CustomText(
        txtTitle: "Edit Inventory",
      ),
    );
  }
}
