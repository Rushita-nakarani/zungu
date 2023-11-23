import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/settings/billing_model.dart';
import 'package:zungu_mobile/models/settings/feedback_regarding_model.dart';
import 'package:zungu_mobile/screens/settings/billings/landloard_subscription_billing_screen.dart';
import 'package:zungu_mobile/screens/settings/billings/property_listing_billing_screen.dart';
import 'package:zungu_mobile/screens/settings/billings/trades_person_billings_screen.dart';
import 'package:zungu_mobile/widgets/calender_card.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/custom_title_with_line.dart';
import 'package:zungu_mobile/widgets/date_selector.dart';

import '../../../../utils/custom_extension.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  // Variables...

  List<BillingModel> billingList = [
    BillingModel(
      title: StaticString.tradesmanSubscription,
      invoiceNo: "Invoice No: #A1B2G011221",
      month: "DECEMBER",
    ),
    BillingModel(
      title: StaticString.propertyListing,
      invoiceNo: "Invoice No: #A1B2G011221",
      month: "JANUARY",
    ),
    BillingModel(
      title: StaticString.landlordSubscription,
      invoiceNo: "Invoice No: #A1B2G011221",
      month: "MARCH",
    ),
  ];

  List<FeedbackRegardingModel> subscriptionTypeList = [
    FeedbackRegardingModel(
      id: 0,
      feedbackType: StaticString.landlordSubscription,
    ),
    FeedbackRegardingModel(
      id: 1,
      feedbackType: StaticString.propertyListing,
    ),
    FeedbackRegardingModel(
      id: 2,
      feedbackType: StaticString.tradesmanSubscription,
    )
  ];

  List<Widget> billingScreens = [
    const TradesmansubscriptionBillingScreen(),
    const PropertyListingScreen(),
    const LandloardSubscriptionScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  // Appbar...
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(StaticString.billing),
      actions: [
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return FilterSubScriptionSheet(
                  subScriptionList: subscriptionTypeList,
                );
              },
            );
          },
          icon: const CustImage(
            imgURL: ImgName.filter,
          ),
        )
      ],
    );
  }

  // body...
  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 41),
              child: CustomTitleWithLine(
                title: StaticString.billingandHistory,
                primaryColor: ColorConstants.custDarkBlue150934,
                secondaryColor: ColorConstants.custgreen19B445,
              ),
            ),
            const SizedBox(height: 15),
            ListView.builder(
              itemCount: billingList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return billingCard(billingList[index], index);
              },
            )
          ],
        ),
      ),
    );
  }

  // billing card view...
  Widget billingCard(BillingModel billingModel, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
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
                  txtTitle: billingModel.title,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => billingScreens[index],
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.custGreyF7F7F7,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.navigate_next_rounded,
                      color: ColorConstants.custskyblue22CBFE,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  txtTitle: billingModel.invoiceNo,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
                CustomText(
                  txtTitle: billingModel.month,
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
    );
  }
}

class FilterSubScriptionSheet extends StatefulWidget {
  final List<FeedbackRegardingModel> subScriptionList;
  const FilterSubScriptionSheet({super.key, required this.subScriptionList});

  @override
  State<FilterSubScriptionSheet> createState() =>
      _FilterSubScriptionSheetState();
}

class _FilterSubScriptionSheetState extends State<FilterSubScriptionSheet> {
  // ----------------Variable--------//
  // formkey...
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // controller...
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  DateTime? fromDate;
  DateTime? toDate;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: CustomText(
                  txtTitle: StaticString.filter,
                  align: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 24,
                      ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  child: CustomText(
                    txtTitle: StaticString.reset,
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          color: ColorConstants.custskyblue22CBFE,
                        ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      widget.subScriptionList[index].isSelected =
                          !widget.subScriptionList[index].isSelected;
                    });
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustImage(
                              imgURL: ImgName.greyCheckImage,
                              imgColor:
                                  widget.subScriptionList[index].isSelected
                                      ? ColorConstants.custgreen19B445
                                      : ColorConstants.custGrey707070,
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: CustomText(
                              txtTitle:
                                  widget.subScriptionList[index].feedbackType ??
                                      "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    color: widget
                                            .subScriptionList[index].isSelected
                                        ? ColorConstants.custskyblue22CBFE
                                        : ColorConstants.custGrey707070,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        thickness: 0.5,
                        color: ColorConstants.custGrey707070,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Row(
              children: [
                // From date textfield
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    scrollPadding: EdgeInsets.zero,
                    autovalidateMode: autovalidateMode,
                    validator: (value) => value?.validateEmpty,
                    controller: _fromDateController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      labelText: StaticString.fromDate,
                      suffixIcon: CustImage(
                        width: 20,
                        imgURL: ImgName.calendar,
                        imgColor: ColorConstants.custDarkBlue150934,
                      ),
                    ),
                    onTap: fromDateonTapAction,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),

                // End date textfield
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    scrollPadding: EdgeInsets.zero,
                    autovalidateMode: autovalidateMode,
                    validator: (value) => value?.validateEmpty,
                    controller: _endDateController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      labelText: StaticString.endDate,
                      suffixIcon: CustImage(
                        width: 20,
                        imgURL: ImgName.calendar,
                        imgColor: ColorConstants.custDarkBlue150934,
                      ),
                    ),
                    onTap: toDateonTapAction,
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: CommonElevatedButton(
              bttnText: StaticString.applyFilter,
              fontSize: 14,
              color: ColorConstants.custskyblue22CBFE,
            ),
          )
        ],
      ),
    );
  }

//  fromDate
  Future<void> fromDateonTapAction() async {
    fromDate = await selectDate(
      initialDate: fromDate,
      controller: _fromDateController,
      color: ColorConstants.custGrey707070,
    );
  }

  Future<void> toDateonTapAction() async {
    toDate = await selectDate(
      initialDate: toDate,
      controller: _endDateController,
      color: ColorConstants.custGrey707070,
    );
  }
}
