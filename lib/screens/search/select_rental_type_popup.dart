import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../../models/filter_screen_model.dart';
import '../../widgets/custom_text.dart';

class SelectRentalTypePopup extends StatefulWidget {
  final Function(PropertyList? selectedRentalType) cardOntap;
  const SelectRentalTypePopup({super.key, required this.cardOntap});

  @override
  State<SelectRentalTypePopup> createState() => _SelectRentalTypePopupState();
}

class _SelectRentalTypePopupState extends State<SelectRentalTypePopup> {
  //------------------------ Variable-----------------------//

  List<PropertyList> rentalTypeList = [
    PropertyList(
      propertyImage: ImgName.filterHouse,
      propertyName: StaticString.residential,
    ),
    PropertyList(
      propertyId: 1,
      propertyImage: ImgName.filterOffice,
      propertyName: StaticString.commercial,
    )
  ];
  PropertyList? _selectedRentalType;
  //------------------------ UI-----------------------//

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            rentalTypeList.length,
            (index) {
              return InkWell(
                onTap: () => cardOntap(rentalType: rentalTypeList[index]),
                child: custCard(
                  rentalTypeData: rentalTypeList[index],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: CommonElevatedButton(
            bttnText: StaticString.select.toUpperCase(),
            color: ColorConstants.custBlue1EC0EF,
            onPressed: () => widget.cardOntap(_selectedRentalType),
          ),
        ),
      ],
    );
  }

  //-------------------------Widget----------------------//

  Widget custCard({required PropertyList rentalTypeData}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: rentalTypeData.isSelected
                ? ColorConstants.custDarkPurple500472
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
                blurRadius: 12,
              ),
            ],
          ),

          //Property Image
          child: CustImage(
            imgURL: rentalTypeData.propertyImage,
            height: 80,
            width: 90,
          ),
        ),
        const SizedBox(height: 12),

        //Property Name Text
        CustomText(
          txtTitle: rentalTypeData.propertyName,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorConstants.custBlack2B1818,
              ),
        )
      ],
    );
  }
  //-----------------------------Button Action----------------------------//

  void cardOntap({required PropertyList rentalType}) {
    if (mounted) {
      setState(() {
        for (final element in rentalTypeList) {
          if (element.propertyId == rentalType.propertyId) {
            element.isSelected = true;
            _selectedRentalType = element;
          } else {
            element.isSelected = false;
          }
        }
      });
    }
  }
}
