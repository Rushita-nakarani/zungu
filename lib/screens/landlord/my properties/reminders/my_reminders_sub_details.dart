//----------------------------- My Reminders SubDetails Screen ---------------------//

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/landlord/my%20properties/reminders/book_now.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class MyRemindersSubDetailsScreen extends StatefulWidget {
  const MyRemindersSubDetailsScreen({super.key});

  @override
  State<MyRemindersSubDetailsScreen> createState() =>
      _MyRemindersSubDetailsScreenState();
}

class _MyRemindersSubDetailsScreenState
    extends State<MyRemindersSubDetailsScreen> {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              //Image, Title and SubTitle Text
              child: _buildImageTitleSubTitleCard(),
            ),
            const SizedBox(height: 10),
            //Divider
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Divider(height: 30),
            ),
            ListView.separated(
              separatorBuilder: (context, index) => const Divider(height: 70),
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //My Reminders Sub Details Card
                    _buildMyRemindersSubDetailsCard(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

//------------------------------------- Widgets -----------------------------------//

//----------------------------- My Reminders Sub Details Card ----------------------/

  Widget _buildMyRemindersSubDetailsCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15, bottom: 20, left: 5),
            // Icon Title And Box
            child: _buildIconTitleAndBox(),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 5),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildDateCard(
                        "Renewal Date",
                        "27 Jun 2021",
                      ),
                      _buildDateCard(
                        "Remind me on",
                        "28 Jun 2022",
                      ),
                      _buildBookNow()
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//------------------------------------- Book Now -----------------------------------/
  Widget _buildBookNow() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const BookNowScreen(),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: ColorConstants.custRedD92D2D,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 25,
          ),
          child: CustomText(
            align: TextAlign.center,
            txtTitle: "Book\nNow".toUpperCase(),
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ),
    );
  }
//------------------------------------- Date Card -----------------------------------/

  Widget _buildDateCard(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
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
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CustImage(
                  imgURL: ImgName.commonCalendar,
                  imgColor: ColorConstants.custDarkPurple500472,
                  width: 15,
                ),
                const SizedBox(width: 3),
                CustomText(
                  txtTitle: "Overdue",
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: ColorConstants.custRedD92D2D,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
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
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: ColorConstants.custGrey6E6E6E,
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        ),
      ),
    );
  }

//--------------------------------- Icon,Title And Box ------------------------------/

  Widget _buildIconTitleAndBox() {
    return Row(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: ColorConstants.backgroundColorFFFFFF,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: ColorConstants.custBlack000000.withOpacity(0.1),
                blurRadius: 15,
                spreadRadius: 0.2,
              ),
            ],
          ),
          child: const CustImage(
            imgURL: ImgName.gasstove,
            width: 29,
            height: 35,
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 4,
                    child: CustomText(
                      txtTitle: "Gas Safety Check",
                      style: Theme.of(context).textTheme.headline1?.copyWith(
                            color: ColorConstants.custDarkPurple160935,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.all(4.0),
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: ColorConstants.custPurple500472.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color:
                                ColorConstants.custBlack000000.withOpacity(0.1),
                            blurRadius: 15,
                            spreadRadius: 0.2,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustImage(
                            imgColor: ColorConstants.custWhiteFFFFFF,
                            imgURL: ImgName.calendar,
                            width: 15,
                            height: 15,
                          ),
                          const SizedBox(width: 10),
                          CustomText(
                            txtTitle: "4",
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      color: ColorConstants.custWhiteFFFFFF,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

//------------------------------- Image And Title, SubTitle -------------------------/

  Widget _buildImageTitleSubTitleCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          type: MaterialType.transparency,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: const CustImage(
              height: 200,
              width: double.infinity,
              imgURL:
                  "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                txtTitle: "3 Bed Detached House",
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: ColorConstants.custDarkPurple160935,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 3),
              CustomText(
                txtTitle: "25 Marylebone Road, London EC71 OBE",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: ColorConstants.custGrey8A8A8A,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
//------------------------------------- AppBar --------------------------------------/

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.custPurple500472,
      title: const CustomText(
        txtTitle: StaticString.myRemindersSubDetails,
      ),
    );
  }
}
