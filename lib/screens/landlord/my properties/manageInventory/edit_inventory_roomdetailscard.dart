//----------------- EditInventory Room Details Card -----------------//

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class EditInventoryRoomDetailsCard extends StatelessWidget {
  final String selectRoomImages;
  final String selectRoomNumber;
  final String selectRoomName;

  const EditInventoryRoomDetailsCard({
    super.key,
    required this.selectRoomImages,
    required this.selectRoomNumber,
    required this.selectRoomName,
  });
//------------------------------ UI ---------------------------------//

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const SizedBox(height: 10),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 61,
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
                      _buildImageAndNumberTextRow(
                        context,
                        selectRoomImages,
                        selectRoomNumber,
                        selectRoomName,
                      ),
                      _buildEditIcon(context),
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
//---------------------------- Widgets ------------------------------//

//------------------------- Edit Icon -------------------------------/

  Widget _buildEditIcon(context) {
    return Row(
      children: const [
        Center(
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: CustImage(
              width: 25,
              height: 25,
              imgURL: ImgName.tenantEdit,
            ),
          ),
        ),
      ],
    );
  }
//------------------- Image And Number Text -------------------------/

  Row _buildImageAndNumberTextRow(
    context,
    String selectRoomImages,
    String selectRoomNumber,
    String selectRoomName,
  ) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorConstants.custRedD7181F,
              // #D7181F
              // "#4831D4",
              // "#ED2188",
              // "#2BAD2D",
              // "#A04EF6",
              // "#00C0FF",
              // "#1BE8B0",
              // "#500472"
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
                )
              ],
            ),
            child: CustImage(
              height: 42,
              width: 42,
              imgURL: selectRoomImages,
            ),
          ),
        ),
        const SizedBox(width: 10),
        CustomText(
          txtTitle: selectRoomNumber,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: ColorConstants.custBlue1EC0EF,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(width: 16),
        CustomText(
          txtTitle: selectRoomName,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: ColorConstants.custGrey656567,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
