import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/calender_card.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/custom_title_with_line.dart';

class LandloardSubscriptionScreen extends StatefulWidget {
  const LandloardSubscriptionScreen({super.key});

  @override
  State<LandloardSubscriptionScreen> createState() =>
      _LandloardSubscriptionScreenState();
}

class _LandloardSubscriptionScreenState
    extends State<LandloardSubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          txtTitle: StaticString.billinglandLoardSubcription,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTitleWithLine(
              title: StaticString.billingandHistory,
              primaryColor: ColorConstants.custDarkBlue150934,
              secondaryColor: ColorConstants.custgreen19B445,
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: ColorConstants.backgroundColorFFFFFF,
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        txtTitle: StaticString.landlordSubscription,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.custgreen19B445,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        txtTitle: "Invoice No: #A1B2E010322",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: ColorConstants.custGrey707070,
                            ),
                      ),
                      CustomText(
                        txtTitle: "MARCH",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: ColorConstants.custGrey707070,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: CommonCalenderCard(
                          bgColor: ColorConstants.custGreyF7F7F7,
                          calenderUrl: ImgName.landlordCalender,
                          date: "01",
                          dateMonth: "Apr 2022",
                          title: "Invoice Date",
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Expanded(
                        flex: 2,
                        child: CommonCalenderCard(
                          bgColor: ColorConstants.custGreyF7F7F7,
                          calenderUrl: ImgName.landlordIncome,
                          date: "£72",
                          dateMonth: "",
                          title: "Amount",
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: const BoxDecoration(
                            color: ColorConstants.custGreyF7F7F7,
                          ),
                          child: const CustImage(
                            imgURL: ImgName.landlordPdf,
                            width: 24,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            const CustomTitleWithLine(
              title: StaticString.billingSummery,
              primaryColor: ColorConstants.custDarkBlue150934,
              secondaryColor: ColorConstants.custgreen19B445,
            ),
            const SizedBox(height: 25),
            _buildListView(),
            const SizedBox(height: 12),
            const CustomTitleWithLine(
              title: StaticString.billingSummery,
              primaryColor: ColorConstants.custDarkBlue150934,
              secondaryColor: ColorConstants.custgreen19B445,
            ),
            const SizedBox(height: 28),
            _buildSummary()
          ],
        ),
      ),
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      itemCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                txtTitle: index == 0 ? "35 Croft Meadows" : "36 City Gardens",
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 3),
              CustomText(
                txtTitle: index == 0
                    ? "Sandhurst Oxford OX1 4PH"
                    : "3B Spinners Lane, Chorlton Manchester M1 6HJ",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.custGrey707070,
                    ),
              ),
              // CustomText(
              //   txtTitle: index == 0
              //       ? "Listing Period: 2 Weeks"
              //       : "Listing Period: 4 Weeks",
              //   style: Theme.of(context).textTheme.bodyText1?.copyWith(
              //         fontWeight: FontWeight.w400,
              //         color: ColorConstants.custGrey707070,
              //       ),
              // ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _buildDateCard(
                      StaticString.fromDate,
                      "01 Dec 2021",
                    ),
                  ),
                  Expanded(
                    child: _buildDateCard(
                      StaticString.toDate,
                      "31 Dec 2021",
                    ),
                  ),
                  Expanded(child: _buildAmountView(index))
                ],
              ),
              const SizedBox(height: 30),
              const Divider(
                color: ColorConstants.backgroundColorE5E5E5,
                thickness: 2,
              ),
            ],
          ),
        );
      },
    );
  }

  Container _buildSummary() {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.custskyblue22CBFE,
        borderRadius: BorderRadius.circular(05),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            billingSummryCard(
              StaticString.subtotal,
              "£60",
            ),
            const SizedBox(height: 10),
            billingSummryCard(
              "20% VAT",
              "£12",
            ),
            const Divider(
              color: Colors.white,
              thickness: 2,
            ),
            const SizedBox(height: 10),
            billingSummryCard(
              StaticString.total,
              "£72",
            ),
          ],
        ),
      ),
    );
  }

  Widget billingSummryCard(
    String? title,
    String? value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txtTitle: title,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: ColorConstants.backgroundColorFFFFFF,
              ),
        ),
        CustomText(
          txtTitle: value,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: ColorConstants.backgroundColorFFFFFF,
              ),
        ),
      ],
    );
  }

  Widget _buildAmountView(int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: ColorConstants.custgreen09A814,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        child: CustomText(
          align: TextAlign.center,
          txtTitle: index == 1
              ? "${StaticString.amount}\n ${"£60"}".toUpperCase()
              : "${StaticString.prorata}\n ${"£60"}".toUpperCase(),
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustImage(
              imgURL: ImgName.landlordCalender,
              imgColor: ColorConstants.custDarkPurple500472,
              width: 20,
            ),
            const SizedBox(height: 5),
            CustomText(
              txtTitle: value,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            CustomText(
              txtTitle: title,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custGrey6E6E6E,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
