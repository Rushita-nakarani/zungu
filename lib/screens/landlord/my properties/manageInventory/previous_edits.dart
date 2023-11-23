//------------------------------ Previous Edits Screen -----------------------------//

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class PreviousEditsScreen extends StatefulWidget {
  const PreviousEditsScreen({super.key});

  @override
  State<PreviousEditsScreen> createState() => _PreviousEditsScreenState();
}

class _PreviousEditsScreenState extends State<PreviousEditsScreen> {
  //-------------------------------------- UI -----------------------------------------//

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          children: [
            _buildPreviousEditsCard(),
          ],
        ),
      ),
    );
  }
//------------------------------------ Widgets --------------------------------------//

//------------------------------- Previous Edits Card -------------------------------/

  Widget _buildPreviousEditsCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 39),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 10, right: 10),
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
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  _profileImagecard(),
                  const SizedBox(width: 14),
                  CustomText(
                    txtTitle: "Theresa May",
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          color: ColorConstants.custDarkBlue150934,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              CustomText(
                txtTitle: "40 Cherwell Drive",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstants.custDarkBlue150934,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              CustomText(
                txtTitle: "Marston Oxford OX3 OLZ",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: ColorConstants.custGrey707070,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(height: 23),
              _editedDateAndViewChangesTextRow(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

//------------------------ Edited Date And View ChangesText -------------------------/

  Widget _editedDateAndViewChangesTextRow() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              txtTitle: "Edited Date",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custGrey707070,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            CustomText(
              txtTitle: "01 Nov 2020",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custBlue1EC0EF,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              txtTitle: "View Changes",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custGrey707070,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            CustomText(
              txtTitle: "Click to View",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custBlue1EC0EF,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  //------------------------------- Profile Image card --------------------------------/

  Widget _profileImagecard() {
    return Container(
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: const CustImage(
          imgURL: ImgName.tenantPersonImage,
        ),
      ),
    );
  }
}
