//----------------------------- Manage Inventory Screen ------------------------------//

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/landlord/my%20properties/manageInventory/edit_inventory.dart';
import 'package:zungu_mobile/screens/landlord/my%20properties/manageInventory/previous_inventories_tabbar.dart';
import 'package:zungu_mobile/widgets/bookmark_widget.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class ManageInventoryScreen extends StatefulWidget {
  const ManageInventoryScreen({super.key});

  @override
  State<ManageInventoryScreen> createState() => _ManageInventoryScreenState();
}

class _ManageInventoryScreenState extends State<ManageInventoryScreen> {
  //----------------------------------- Variables -------------------------------------//

  final urlImage =
      "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";

//-------------------------------------- UI -----------------------------------------//

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
              SizedBox(
                height: 350,
                child: Stack(
                  children: <Widget>[
                    _buildImage(),
                    _buildBookMark(),
                    _buildTitle(),
                    _buildsubTitle(),
                    _buildInventoryAndLinkTenantCard(),
                  ],
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 20),
                  _buildRoomDetailsListviewCard(),
                  const SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//------------------------------------ Widgets --------------------------------------//
//-------------------------- Rooms Details Listview Card ----------------------------/

  Widget _buildRoomDetailsListviewCard() {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        return _buildRoomDetailsCard();
      },
    );
  }
//----------------------------- Room Details Card -----------------------------------/

  Widget _buildRoomDetailsCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 76,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTitleandSubTitleImageRow(),
                      _buildCheckInventoryCard(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

//----------------------------- Check Inventory Card --------------------------------/

  Widget _buildCheckInventoryCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 74,
          width: 120,
          decoration: const BoxDecoration(
            color: ColorConstants.custGreen3CAC71,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Center(
            child: CustomText(
              align: TextAlign.center,
              txtTitle: "CHECK\nINVENTORY".toUpperCase(),
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.backgroundColorFFFFFF,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
      ],
    );
  }
//------------------------- Title And SubTitle Image Row ----------------------------/

  Row _buildTitleandSubTitleImageRow() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: const CustImage(
              height: 50,
              width: 50,
              imgURL: ImgName.tenantUserIcon,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              txtTitle: "Room 2".toUpperCase(),
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custGreen3CAC71,
                    fontWeight: FontWeight.w500,
                    //ColorsRed = #E0320D
                  ),
            ),
            const SizedBox(height: 3),
            CustomText(
              txtTitle: "Peter Jones",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custGrey707070,
                    fontWeight: FontWeight.w400,
                  ),
            )
          ],
        )
      ],
    );
  }
//----------------------- Inventory And Link Tenant Card-----------------------------/

  Widget _buildInventoryAndLinkTenantCard() {
    return Positioned(
      top: 220,
      left: 15,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              children: [
                Row(
                  children: [
                    _buildInventoryCard(
                      "Inventory",
                      "View/Edit",
                    ),
                    _buildInventoriesCard(
                      "Inventories",
                      "Previous",
                    ),
                    _buildLinkTenant()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//------------------------------- LinkTenant ----------------------------------------/
  Widget _buildLinkTenant() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: ColorConstants.custLightCyan2FD6EF,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 22,
          horizontal: 20,
        ),
        child: CustomText(
          align: TextAlign.center,
          txtTitle: "Link\nTenant".toUpperCase(),
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: ColorConstants.custWhiteFFFFFF,
                //#2FD6EF
                //grey #DEDEDE
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
//------------------------------ Inventories Card --------------------------------------/

  Widget _buildInventoriesCard(String title, String value) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const PreviousInventroiesTabBarScreen(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: ColorConstants.backgroundColorFFFFFF,
          boxShadow: [
            BoxShadow(
              color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
              blurRadius: 7,
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustImage(
                imgURL: ImgName.commonCalendar,
                imgColor: ColorConstants.custDarkPurple500472,
                width: 15,
                height: 15,
              ),
              const SizedBox(height: 5),
              CustomText(
                txtTitle: value,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstants.custDarkBlue160935,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              CustomText(
                txtTitle: title,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: ColorConstants.custGrey6E6E6E,
                      fontWeight: FontWeight.w500,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //-------------------------------- Inventory Card --------------------------------------/

  Widget _buildInventoryCard(String title, String value) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const EditInventoryScreen(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: ColorConstants.backgroundColorFFFFFF,
          boxShadow: [
            BoxShadow(
              color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
              blurRadius: 7,
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustImage(
                imgURL: ImgName.commonCalendar,
                imgColor: ColorConstants.custDarkPurple500472,
                width: 15,
                height: 15,
              ),
              const SizedBox(height: 5),
              CustomText(
                txtTitle: value,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstants.custDarkBlue160935,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              CustomText(
                txtTitle: title,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: ColorConstants.custGrey6E6E6E,
                      fontWeight: FontWeight.w500,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }

//-------------------------------- Sub Title ----------------------------------------/
  Widget _buildsubTitle() {
    return Positioned(
      top: 215,
      left: 12,
      child: CustomText(
        txtTitle: "City Gardens, 3B Way, Manchester M15",
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: ColorConstants.custGrey707070,
              fontWeight: FontWeight.w400,
            ),
      ),
    );
  }

//---------------------------------- Title ------------------------------------------/
  Widget _buildTitle() {
    return Positioned(
      top: 190,
      left: 12,
      child: CustomText(
        txtTitle: "3 Bed Terraced House",
        style: Theme.of(context).textTheme.headline1?.copyWith(
              color: ColorConstants.custDarkBlue150934,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
//--------------------------------- Book Mark ---------------------------------------/

  Widget _buildBookMark() {
    return Positioned(
      top: 175,
      right: MediaQuery.of(context).size.width * 0.05,
      child: SizedBox(
        width: 37,
        height: 50,
        child: buildBookmark(
          text: "Let".toUpperCase(),
          //Red #E0320D
          //Green #3CAC71
          //Purpul #B772FF
          color: ColorConstants.custGreen3CAC71,
        ),
      ),
    );
  }
//---------------------------------- Image ------------------------------------------/

  Widget _buildImage() {
    return Positioned(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CustImage(
          imgURL: urlImage,
          height: 175,
          width: double.infinity,
        ),
      ),
    );
  }
//---------------------------------- AppBar -----------------------------------------/

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.custDarkPurple500472,
      title: const CustomText(
        txtTitle: "Manage Inventory",
      ),
    );
  }
}
