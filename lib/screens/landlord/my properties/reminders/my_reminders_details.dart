//------------------------------ My Reminders Details Screen ------------------------/

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/landlord/my%20properties/reminders/book_now.dart';
import 'package:zungu_mobile/screens/landlord/my%20properties/reminders/my_reminders_sub_details.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/rounded_lg_shape_widget.dart';

class MyRemindersDetailsScreen extends StatefulWidget {
  const MyRemindersDetailsScreen({super.key});

  @override
  State<MyRemindersDetailsScreen> createState() =>
      _MyRemindersDetailsScreenState();
}

class _MyRemindersDetailsScreenState extends State<MyRemindersDetailsScreen> {
//-------------------------------------- UI ----------------------------------------//

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
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  ListView.separated(
                    separatorBuilder: (context, index) =>
                        const Divider(height: 70),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //My Reminders Details Card
                          _buildMyRemindersDetailsCard(),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//------------------------------------ Widgets -------------------------------------//

//--------------------------- My Reminders Details Card -----------------------------/

  Widget _buildMyRemindersDetailsCard() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const MyRemindersSubDetailsScreen(),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
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
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      //color: ColorConstants.custRedD92727.withOpacity(0.5),
                      color: ColorConstants.custgreen00B604.withOpacity(0.5),
                    ),
                    child: CustomText(
                      txtTitle: "4 Reminders".toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  txtTitle: "3 Bed Detached House",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(
                                        color:
                                            ColorConstants.custDarkPurple160935,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                const SizedBox(height: 3),
                                CustomText(
                                  txtTitle: "25 Maryleondon EC71 OBE",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        color: ColorConstants.custGrey8A8A8A,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: ColorConstants.custPurple500472
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorConstants.custBlack000000
                                      .withOpacity(0.1),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
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
          ),
        ),
        const SizedBox(height: 25),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const BookNowScreen(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  _buildDateCard(
                    "Renewal Date",
                    "28 Jun 2021",
                  ),
                  _buildDateCard(
                    "Remind me on",
                    "27 Jun 2022",
                  ),
                  _buildBookNow()
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
//---------------------------------- Book Now ---------------------------------------/

  Widget _buildBookNow() {
    return Card(
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
    );
  }
//---------------------------------- Date Card --------------------------------------/

  Widget _buildDateCard(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
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
                const SizedBox(width: 5),
                CustomText(
                  txtTitle: "",
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

//------------------------------------- Title ---------------------------------------/

  Widget _buildTitle() {
    return Column(
      children: const [
        SizedBox(
          width: double.infinity,
          child: RoundedLgShapeWidget(
            color: ColorConstants.custDarkPurple500472,
            title: StaticString.yearlyGasSafetyCheck,
          ),
        ),
      ],
    );
  }
//------------------------------------- AppBar --------------------------------------/

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.custDarkPurple500472,
      title: const CustomText(
        txtTitle: StaticString.myRemindersDetails,
      ),
    );
  }
}
