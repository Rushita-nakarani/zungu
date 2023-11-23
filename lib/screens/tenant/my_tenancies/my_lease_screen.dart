import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/calender_card.dart';
import 'package:zungu_mobile/widgets/common_container_with_value_container.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

import '../../../widgets/bookmark_widget.dart';

class MyLeaseScreen extends StatefulWidget {
  const MyLeaseScreen({super.key});

  @override
  State<MyLeaseScreen> createState() => _MyLeaseScreenState();
}

class _MyLeaseScreenState extends State<MyLeaseScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.custPurple500472,
          title: const Text(
            StaticString.myLeases,
          ),
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: Container(
              color: ColorConstants.backgroundColorFFFFFF,
              child: _tabBar,
            ),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _tenancyList(),
              _tenancyList(),
            ],
          ),
        ),
      ),
    );
  }

  // Tabbar getter
  TabBar get _tabBar => TabBar(
        indicatorColor: ColorConstants.custskyblue22CBFE,
        labelColor: ColorConstants.custskyblue22CBFE,
        unselectedLabelColor: ColorConstants.custGrey707070,
        labelStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontWeight: FontWeight.w600,
            ),
        tabs: const [
          Tab(
            text: StaticString.currentLease,
          ),
          Tab(
            text: StaticString.previousLease,
          ),
        ],
      );

  Widget _tenancyList() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonContainerWithImageValue(
              imgurl:
                  "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
              secondContainer: false,
              valueContainerColor:
                  ColorConstants.custDarkBlue150934.withOpacity(0.6),
              imgValue: "£ 1250/month",
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomText(
                txtTitle: StaticString.windmillRoad,
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: ColorConstants.custDarkBlue150934,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomText(
                txtTitle: "Headington Oxford OX3 7BL",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: ColorConstants.custGrey707070),
              ),
            ),
            const SizedBox(height: 25),

            // Leases Person Card
            _leasesPersonCard(
              roomNo: "1",
              personName: "John smith",
              rentamount: "325",
              bookMarkCardColor: ColorConstants.custDarkYellowFFBF00,
              isCamera: false,
            ),
            const SizedBox(height: 30),

            // Leases Person Card
            _leasesPersonCard(
              roomNo: "2",
              personName: "Betty Rodgers",
              rentamount: "655",
              bookMarkCardColor: ColorConstants.custgreen09A814,
              isCamera: true,
            ),
          ],
        ),
      ),
    );
  }

  // Leases Person Card
  Widget _leasesPersonCard({
    required String personName,
    required String rentamount,
    required String roomNo,
    required Color bookMarkCardColor,
    required bool isCamera,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
            blurRadius: 7,
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          // Leases person details and room book mark card row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: const [
                  SizedBox(height: 12),
                  CustImage(
                    height: 50,
                    width: 50,
                    imgURL: ImgName.defaultProfile1,
                  ),
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      txtTitle: personName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    CustomText(
                      txtTitle:
                          "${StaticString.rentGem} ${StaticString.currency}$rentamount",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.custGrey707070,
                          ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              buildBookmark(
                text: "Room\n$roomNo",
                color: bookMarkCardColor, // (widget.id * 25).getExpiresColor,
                size: const Size(40, 50),
              ),
            ],
          ),

          // Leases start and end calender and pdf card row
          _leasesStartEndCalenderAndPdfCameraCardRow(
            endDate: "31",
            endDateMonth: "Mar 2020",
            startDate: "01",
            startDateMonth: "Apr 2019",
            imgUrl: ImgName.landlordPdf,
            bgColor: ColorConstants.custLightGreenE4FEE2,
          ),

          if (isCamera)
            _leasesStartEndCalenderAndPdfCameraCardRow(
              endDate: "15",
              endDateMonth: "Mar 2018 ",
              startDate: "14",
              startDateMonth: "Mar 2019",
              imgUrl: ImgName.landlordCamera,
              bgColor: ColorConstants.custLightRedFFE6E6,
            )
          else
            Container(),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // Lease start and end date ,pdf icon row
  Widget _leasesStartEndCalenderAndPdfCameraCardRow({
    required String startDate,
    required String startDateMonth,
    required String endDate,
    required String endDateMonth,
    required String imgUrl,
    required Color bgColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CommonCalenderCard(
              bgColor: bgColor,
              calenderUrl: ImgName.commonCalendar,
              date: startDate,
              dateMonth: startDateMonth,
              title: StaticString.leasesStart,
              imgColor: ColorConstants.custDarkPurple500472,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 2,
            child: CommonCalenderCard(
              bgColor: bgColor,
              calenderUrl: ImgName.commonCalendar,
              date: endDate,
              dateMonth: endDateMonth,
              title: StaticString.leasesEnd,
              imgColor: ColorConstants.custDarkPurple500472,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: ColorConstants.custGreyF7F7F7,
              ),
              child: CustImage(
                imgURL: imgUrl,
                height: 30,
                boxfit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
