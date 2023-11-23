import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/common_container_with_value_container.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class SubScriptionDetailScreen extends StatefulWidget {
  const SubScriptionDetailScreen({super.key});

  @override
  State<SubScriptionDetailScreen> createState() =>
      _SubScriptionDetailScreenState();
}

class _SubScriptionDetailScreenState extends State<SubScriptionDetailScreen> {
  List<Subcription> subscriptionList = [
    Subcription(
      1,
      "",
      // "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
      "£ 10/month",
      "21 Park Road",
      "London EC71 OBE",
      "12 Jan 2022",
      "START DATE",
      "SUBSCRIPTION",
      "PRORATA BILLING",
      true,
      "END SUBSCRIPTION",
    ),
    Subcription(
      2,
      "",
      // "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
      "£ 10/month",
      "88 Albert Street",
      "London SW54 7NA",
      "01 Oct 2021",
      "START DATE",
      "SUBSCRIPTION",
      "ONGOING MONTHLY",
      true,
      "END SUBSCRIPTION",
    ),
    Subcription(
      3,
      "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
      "£ 10/month",
      "27 Oxford Road",
      "London EC71 OBE",
      "24 Jul 2021",
      "START DATE",
      "SUBSCRIPTION",
      "BILLING CANCELLED",
      false,
      "END SUBSCRIPTION",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.custDarkPurple500472,
        title: const CustomText(
          txtTitle: StaticString.subscriptinDetail,
        ),
      ),
      body: _buildBody(context),
    );
  }

  SafeArea _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            _buildActiveSubscriptCard(context),
            const SizedBox(height: 34),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: subscriptionList.length,
              itemBuilder: (context, index) {
                // print("fhdghdjgh:${subscriptionList.length}");
                return commonSubscriptionView(subscriptionList[index]);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActiveSubscriptCard(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: ColorConstants.custDarkPurple500472,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 18),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: ColorConstants.custskyblue22CBFE,
                  child: CustomText(
                    txtTitle: "07",
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                const SizedBox(height: 13),
                CustomText(
                  txtTitle: StaticString.propertiess,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.backgroundColorFFFFFF,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 3),
                CustomText(
                  txtTitle: StaticString.activeProperties,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.backgroundColorFFFFFF,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(
            right: 20,
            left: 20,
          ),
          decoration: BoxDecoration(
            color: ColorConstants.backgroundColorFFFFFF,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                color: ColorConstants.custGrey707070.withOpacity(0.2),
              )
            ],
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        const CustImage(
                          imgURL: ImgName.landlordCalender,
                          height: 40,
                          width: 40,
                        ),
                        const SizedBox(height: 15),
                        CustomText(
                          txtTitle: StaticString.billingCycle,
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: ColorConstants.custDarkPurple500472,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(height: 6),
                        CustomText(
                          txtTitle: StaticString.everyMonth,
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: ColorConstants.custDarkPurple500472,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: VerticalDivider(
                      color: ColorConstants.custGreyE9EDF5,
                      thickness: 2,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        const CustImage(
                          imgURL: ImgName.landlordIncome,
                          height: 40,
                          width: 40,
                        ),
                        const SizedBox(height: 15),
                        CustomText(
                          txtTitle: StaticString.monthly,
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: ColorConstants.custDarkPurple500472,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(height: 6),
                        CustomText(
                          txtTitle: "£70.00",
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: ColorConstants.custDarkPurple500472,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget commonSubscriptionView(
    Subcription subcription,
  ) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonContainerWithImageValue(
            imgurl: subcription.imgUrl,
            secondContainer: false,
            valueContainerColor: ColorConstants.custLightYellowFFFF00,
            imgValue: subcription.imgvalue,
          ),
          const SizedBox(height: 18),
          CustomText(
            txtTitle: subcription.street,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.custDarkBlue160935,
                ),
          ),
          const SizedBox(height: 4),
          CustomText(
            txtTitle: subcription.city,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.custGrey838383,
                ),
          ),
          const SizedBox(height: 26),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: subcription.id == 3
                  ? ColorConstants.custGrey4B4A4C
                  : ColorConstants.custpurple7618E2,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          CustomText(
                            txtTitle: subcription.date,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                  color: ColorConstants.backgroundColorFFFFFF,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const SizedBox(height: 7),
                          CustomText(
                            txtTitle: subcription.subscription,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                  color: ColorConstants.backgroundColorFFFFFF,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const SizedBox(height: 5),
                          CustomText(
                            txtTitle: subcription.startDate,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                  color: ColorConstants.backgroundColorFFFFFF,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: VerticalDivider(
                        color: ColorConstants.custGreyE9EDF5,
                        thickness: 2,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          CustomText(
                            txtTitle: "£0",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                  color: ColorConstants.backgroundColorFFFFFF,
                                  fontSize: 30,
                                ),
                          ),
                          const SizedBox(height: 7),
                          CustomText(
                            txtTitle: subcription.billingcancelled
                                .replaceAll(" ", "\n"),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                  color: ColorConstants.backgroundColorFFFFFF,
                                ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          if (subcription.id == 3)
            CustomText(
              txtTitle: StaticString.subDate,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custGrey838383,
                  ),
            )
          else
            Container(),
          const SizedBox(height: 15),
          if (subcription.endsb == true)
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: const BorderSide(
                  color: ColorConstants.custGrey838383,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    35.0,
                  ),
                ),
              ),
              child: CustomText(
                txtTitle: subcription.btntext,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: ColorConstants.custGrey969696,
                    ),
              ),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      endSubscriptionOnTap();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: const BorderSide(
                        color: Colors.red,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          35.0,
                        ),
                      ),
                    ),
                    child: CustomText(
                      txtTitle: StaticString.deleteSubscription,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Colors.red,
                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      activeSubscriptionOnTap();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: const BorderSide(
                        color: ColorConstants.custgreen19B445,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          35.0,
                        ),
                      ),
                    ),
                    child: CustomText(
                      txtTitle: StaticString.subscribeNow,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: ColorConstants.custgreen19B445,
                          ),
                    ),
                  ),
                )
              ],
            ),
          const SizedBox(height: 20),
          const Divider(
            color: ColorConstants.custLightGreyC6C6C6,
          ),
        ],
      ),
    );
  }

  void activeSubscriptionOnTap() {
    showAlert(
      context: context,
      icon: ImgName.activesubscriptionImage,
      title: StaticString.activeSubtitle,
      message: StaticString.activesubdetails,
      subScriptionBtn: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            side: const BorderSide(
              color: ColorConstants.custgreen19B445,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                35.0,
              ),
            ),
          ),
          child: CustomText(
            txtTitle: StaticString.activeBtnText,
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: ColorConstants.custgreen19B445,
                ),
          ),
        ),
      ),
    );
  }

  void endSubscriptionOnTap() {
    showAlert(
      context: context,
      icon: ImgName.activesubscriptionImage,
      title: StaticString.activeSubtitle,
      message: StaticString.activesubdetails,
      subScriptionBtn: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            side: const BorderSide(
              color: Colors.red,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                35.0,
              ),
            ),
          ),
          child: CustomText(
            txtTitle: StaticString.endsubbtnText,
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: Colors.red,
                ),
          ),
        ),
      ),
    );
  }
}

class Subcription {
  String imgUrl;
  int id;
  String imgvalue;
  // String imgvalusubcription;
  String street;
  String city;
  String date;
  String startDate;
  String subscription;
  String billingcancelled;
  bool endsb;
  String btntext;
  // String description;

  Subcription(
    this.id,
    this.imgUrl,
    this.imgvalue,
    this.street,
    this.city,
    this.date,
    this.startDate,
    this.subscription,
    this.billingcancelled,
    this.endsb,
    this.btntext,
  );
}
