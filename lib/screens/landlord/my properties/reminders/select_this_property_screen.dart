//-------------------------------- Select This Property Screen ---------------------//

import 'package:flutter/material.dart';
import 'package:zungu_mobile/cards/selected_property_card_reminder.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/common_searchbar.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/rounded_lg_shape_widget.dart';

class SelectThisPropertyScreen extends StatefulWidget {
  const SelectThisPropertyScreen({super.key});

  @override
  State<SelectThisPropertyScreen> createState() =>
      _SelectThisPropertyScreenState();
}

class _SelectThisPropertyScreenState extends State<SelectThisPropertyScreen> {
//------------------------------------ Variables ----------------------------------//

  final urlImages = [
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
  ];

  final TextEditingController _searchController = TextEditingController();
  //-------------------------------------- UI ---------------------------------------//

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
        child: Column(
          children: [
            //Title Text
            _buildTitle(),
            const SizedBox(height: 18),
            //Common Search Bar
            buildCommonSearchBar(
              context: context,
              doubleBorderRadius: 30,
              color: ColorConstants.custDarkPurple662851,
              image: ImgName.searchTenant,
              title: "40 Cherwell Drive, Marston Oxford OX3 0LZ",
              controller: _searchController,
              hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custGreyAEAEAE,
                  ),
              searchFunc: () {},
            ),
            const SizedBox(height: 50),
            //Select Property Card
            _buildSelectPropertyCard(),
            const SizedBox(height: 50),
            //Select This Property Button
            _buildSelectThisPropertyBtn(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

//----------------------------- Select This Property Button ------------------------/

  Widget _buildSelectThisPropertyBtn() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: CommonElevatedButton(
        color: ColorConstants.custBlue1EC0EF,
        bttnText: StaticString.selectThisProperty1.toUpperCase(),
        onPressed: () {},
      ),
    );
  }
//-------------------------------- Select Property Card ----------------------------/

  Widget _buildSelectPropertyCard() {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 30),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: urlImages.length,
      itemBuilder: (context, index) {
        final urlImage = urlImages[index];
        return InkWell(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: SelectedPropertyCardReminder(
              imageUrl: urlImage,
              propertyTitle: "40 Cherwell Drive",
              propertySubtitle: "Marston Oxford OX3 OLZ",
              border: Border.all(
                color: Colors.white.withOpacity(0),
                width: 1.5,
              ),
            ),
          ),
        );
      },
    );
  }
//------------------------------------- Title --------------------------------------/

  Widget _buildTitle() {
    return Column(
      children: const [
        SizedBox(
          width: double.infinity,
          child: RoundedLgShapeWidget(
            color: ColorConstants.custDarkPurple500472,
            title: StaticString.selectProperty,
          ),
        ),
      ],
    );
  }

  //------------------------------------- AppBar --------------------------------------/

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const CustomText(
        txtTitle: StaticString.addReminder,
      ),
      backgroundColor: ColorConstants.custDarkPurpule500B72,
    );
  }
}
