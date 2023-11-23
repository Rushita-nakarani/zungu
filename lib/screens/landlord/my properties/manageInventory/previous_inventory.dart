//----------------------------- Previous Inventory Screen ----------------------------//

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/constant/img_constants.dart';
import 'package:zungu_mobile/constant/string_constants.dart';
import 'package:zungu_mobile/widgets/calender_card_withshadow.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class PreviousInventoryScreen extends StatefulWidget {
  const PreviousInventoryScreen({super.key});

  @override
  State<PreviousInventoryScreen> createState() =>
      _PreviousInventoryScreenState();
}

class _PreviousInventoryScreenState extends State<PreviousInventoryScreen> {
  //-------------------------------------- UI ------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildPreviousInventoryListViewCard(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
//------------------------------------ Widgets --------------------------------------//

//---------------------- Previous Inventory ListView Card ----------------------------/

  Widget _buildPreviousInventoryListViewCard() {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return _buildPreviousInventoryCard();
      },
    );
  }
//---------------------- Previous Inventory ----------------------------------------/

  Widget _buildPreviousInventoryCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 39),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
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
                  const SizedBox(height: 40),
                  CustomText(
                    txtTitle: "Paul Cooper",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: ColorConstants.custDarkBlue150934,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 14),
                  _leaseStartAndLeaseEndCard(
                    leaseStartDate: "01",
                    leaseStartMonth: "Jun 2020",
                    leaseEndDate: "31",
                    leaseMonthMonth: "May 2021",
                    bgColor: ColorConstants.backgroundColorFFFFFF,
                  ),
                  const SizedBox(height: 20),
                  _inventoryAndClickToViewTextRow(),
                  const SizedBox(height: 18),
                ],
              ),
            ),
            _profileImagecard(),
          ],
        ),
      ],
    );
  }

//---------------------- Inventory And Click To View Text Row ------------------------/

  Widget _inventoryAndClickToViewTextRow() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              txtTitle: "Inventory Summary",
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
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              txtTitle: "Inventory Summary",
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
//-------------------------- Lease Start And Lease End Row ---------------------------/

  // Lease Start And Lease End Card row
  Widget _leaseStartAndLeaseEndCard({
    required String leaseStartDate,
    required String leaseStartMonth,
    required String leaseEndDate,
    required String leaseMonthMonth,
    required Color bgColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: CommonCalenderCardWithShadow(
              bgColor: bgColor,
              calenderUrl: ImgName.commonCalendar,
              date: leaseStartDate.padRight(3),
              dateMonth: leaseStartMonth,
              title: StaticString.leasesStart,
              imgColor: ColorConstants.custDarkPurple500472,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: CommonCalenderCardWithShadow(
              bgColor: bgColor,
              calenderUrl: ImgName.commonCalendar,
              date: leaseEndDate.padRight(3),
              dateMonth: leaseMonthMonth,
              title: StaticString.leasesEnd,
              imgColor: ColorConstants.custDarkPurple500472,
            ),
          ),
        ],
      ),
    );
  }
//---------------------------- Profile Image Card ------------------------------------/

  Widget _profileImagecard() {
    return Container(
      height: 60,
      width: 60,
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
