import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/search/select_rental_type_popup.dart';
import 'package:zungu_mobile/widgets/common_auto_textformfield.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';

import '../../widgets/cust_image.dart';
import '../../widgets/custom_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //-----------------------Variables----------------------------//

  // Search Controller
  final TextEditingController _searchController = TextEditingController();
  String _selectedRentalType = StaticString.commercial;

  //-----------------------UI----------------------------//

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyBoardOntap,
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  //-----------------------Widget----------------------------//

  // Body
  Widget _buildBody() {
    return Stack(
      children: [
        // Back Ground Image
        const CustImage(
          imgURL: ImgName.modernVilaImg,
          height: double.infinity,
          width: double.infinity,
        ),

        // Blur Container Image
        Container(
          height: double.infinity,
          width: double.infinity,
          color: ColorConstants.custblue6E7BB0.withOpacity(.80),
        ),

        // Search Body Content
        _buildContent(),
      ],
    );
  }

  // SEarch Body Content
  Widget _buildContent() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 140),
        // Find Your Next text
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Row(
            children: [
              CustomText(
                txtTitle: StaticString.findYourNext,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),

        // Rental PRoperty Text
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(
                txtTitle: StaticString.rentalProperty,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 100),

        // Search Text Field
        _searchTextfield(),
      ],
    );
  }

  // Search Text Field
  Widget _searchTextfield() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: SearchLocationautocomplete(
        textColor: ColorConstants.custGreyB4B4B4,
        prefixIcon: SizedBox(
          width: 120,
          child: InkWell(
            onTap: searchDropDwonOntap,
            child: Row(
              children: [
                const SizedBox(width: 10),
                CustomText(
                  txtTitle: _selectedRentalType,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: ColorConstants.custGrey707070,
                ),
                Container(
                  height: 25,
                  width: 1,
                  color: ColorConstants.custGreyE6E6E6,
                )
              ],
            ),
          ),
        ),
        fillColor: Colors.white,
        onTap: () {},
        streetController: _searchController,
      ),
    );
  }

  //----------------------------Button Action--------------------------//

  // Hide KeyBoard ontap
  void hideKeyBoardOntap() {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  // search DropDwon Ontap
  void searchDropDwonOntap() {
    showAlert(
      hideButton: true,
      context: context,
      showCustomContent: true,
      showIcon: false,
      title: StaticString.selectRentalType,
      content: SelectRentalTypePopup(
        cardOntap: (selectedRentalType) {
          if (mounted) {
            setState(() {
              _selectedRentalType = selectedRentalType?.propertyName ?? "";
            });
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
