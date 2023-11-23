import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/trades_person/latest_job_screen_model.dart';
import 'package:zungu_mobile/screens/trades_person/income_expenses/income/add_expanses_screen.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

import '../../../../widgets/cust_image.dart';

class ExpensesTabViewScreen extends StatefulWidget {
  final bool isTabbar;
  const ExpensesTabViewScreen({required this.isTabbar});

  @override
  State<ExpensesTabViewScreen> createState() => _ExpensesTabViewScreenState();
}

class _ExpensesTabViewScreenState extends State<ExpensesTabViewScreen> {
  //--------------------------------- variable-------------------------------//;
  bool isOnTap = true;
  bool logPayment = false;

  List<LatestJobModel> allocatedJobDummyData =
      latestJobModelFromJson(json.encode(maintenanceAllocatedJobdummyData));

  List<LatestJobModel> completedJobDummyData =
      latestJobModelFromJson(json.encode(maintenanceCompletedJobdummyData));

  //--------------------------------- UI-------------------------------//;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isOnTap ? _purchasesView() : _billPaymentsView(),
      ),
    );
  }

  //--------------------------------- Widgets-------------------------------//;

  // Allocated job view
  Widget _purchasesView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          _purchasesAndBillPaymentBtnRow(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color:
                                ColorConstants.custGrey7A7A7A.withOpacity(0.2),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  txtTitle: "job ID: AH6US270322",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: ColorConstants.custCyan017781,
                                      ),
                                ),
                                CustomText(
                                  txtTitle: "745 The Green London SW29 0GS",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        color: ColorConstants.custGrey707070,
                                      ),
                                ),
                                const SizedBox(height: 20),
                                _buildDetailsRow(
                                  textTitle: "Purchase Type",
                                  textSubTitle: "Parts & Materials",
                                  color: ColorConstants.custCyan017781,
                                ),
                                const SizedBox(height: 10),
                                _buildDetailsRow(
                                  textTitle: "Materials",
                                  textSubTitle: "£120.00",
                                  color: ColorConstants.custCyan017781,
                                ),
                                const SizedBox(height: 10),
                                _buildPurchasedDate(
                                  titleName: "Rejected",
                                  date: "10 Mar 2022",
                                  color: ColorConstants.custGreen0CCE1A,
                                ),
                                const SizedBox(height: 10),
                                _buildDetailsRow(
                                  textTitle: "Invoice/Receipt",
                                  child: const CustImage(
                                    imgURL: ImgName.landlordPdfCircle,
                                    height: 20,
                                    width: 20,
                                  ),
                                  textSubTitle: "£120.00",
                                  color: ColorConstants.custCyan017781,
                                ),
                                const SizedBox(height: 10),
                                _buildDetailsRow(
                                  textTitle: "Status",
                                  child: const CustImage(
                                    imgURL: ImgName.iconSuccess,
                                    height: 20,
                                    width: 20,
                                  ),
                                  textSubTitle: "Paid",
                                  color: ColorConstants.custCyan017781,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => AddExpanseScreen(
                                        isEdit: false,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: ColorConstants.custCyan017781,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                    ),
                                  ),
                                  child: const CustImage(
                                    imgURL: ImgName.editIcon,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 1.5),
                              InkWell(
                                onTap: () {
                                  showAlert(
                                    context: context,
                                    title: StaticString.deleteExpense,
                                    singleBtnTitle: StaticString.delete,
                                    showIcon: false,
                                    singleBtnColor: ColorConstants.custChartRed,
                                    message: AlertMessageString
                                        .incomeExpensesDeleteAlert,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: ColorConstants
                                        .custParrotGreenAFCB1F, //secondaryColor,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                  child: const CustImage(
                                    imgURL: ImgName.deleteWhite,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  //-------Bill PaymentView---------

  Widget _billPaymentsView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          _purchasesAndBillPaymentBtnRow(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color:
                                ColorConstants.custGrey7A7A7A.withOpacity(0.2),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      txtTitle: StaticString.paid,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: ColorConstants
                                                .custDarkPurple150934,
                                          ),
                                    ),
                                    CustomText(
                                      txtTitle: "£1440.00",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                ColorConstants.custCyan017781,
                                          ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                _buildDetailsRow(
                                  textTitle: "Due Date",
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.custOrangeFFAE00,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(width: 4),
                                        CustomText(
                                          txtTitle: "1st Of Month",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: ColorConstants
                                                    .custWhiteFFFFFF,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                if (logPayment == false)
                                  _buildPurchasedDate(
                                    titleName: "Paid",
                                    date: "10 Mar 2022",
                                    color: ColorConstants.custCyan017781,
                                  )
                                else
                                  Container(),
                                const SizedBox(height: 10),
                                _buildDetailsRow(
                                  textTitle: "Repeat Interval",
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorConstants.custGreen0CCE1A,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(width: 4),
                                        CustomText(
                                          txtTitle: "Monthly",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: ColorConstants
                                                    .custGreen0CCE1A,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                if (logPayment == false)
                                  _buildDetailsRow(
                                    textTitle: "Status",
                                    child: const CustImage(
                                      imgURL: ImgName.iconSuccess,
                                      height: 20,
                                      width: 20,
                                    ),
                                    textSubTitle: "Paid",
                                    color: ColorConstants.custgrey636363,
                                  )
                                else
                                  _buildDetailsRow(
                                    textTitle: "Status",
                                    child: const CustImage(
                                      imgURL: ImgName.commonRedCross,
                                      height: 20,
                                      width: 20,
                                    ),
                                    textSubTitle: "Unpaid",
                                    color: ColorConstants.custgrey636363,
                                  )
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          _recurringEditAndDeteleBtn()
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  //---Purchases and Bill Payment tab card-------

  Widget _purchasesAndBillPaymentBtnRow() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: ColorConstants.custParrotGreenAFCB1F,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          Expanded(
            child: custElavetadeBtn(
              btnColor:
                  isOnTap ? Colors.white : ColorConstants.custParrotGreenAFCB1F,
              textColor: isOnTap ? ColorConstants.custGrey707070 : Colors.white,
              btnTitle: "Purchases",
              btnOntap: () {
                if (mounted) {
                  setState(() {
                    isOnTap = !isOnTap;
                  });
                }
              },
            ),
          ),
          Expanded(
            child: custElavetadeBtn(
              btnColor: !isOnTap
                  ? Colors.white
                  : ColorConstants.custParrotGreenAFCB1F,
              textColor:
                  !isOnTap ? ColorConstants.custGrey707070 : Colors.white,
              btnTitle: "Bill Payments",
              btnOntap: () {
                if (mounted) {
                  setState(() {
                    isOnTap = !isOnTap;
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }

  // Custom Elaveted button
  Widget custElavetadeBtn({
    required Color btnColor,
    required Color textColor,
    required String btnTitle,
    required Function() btnOntap,
  }) {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        onPressed: btnOntap,
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        child: CustomText(
          txtTitle: btnTitle,
          style: Theme.of(context).textTheme.caption?.copyWith(
                wordSpacing: 1.5,
                fontSize: 15,
                color: textColor,
              ),
        ),
      ),
    );
  }

  // Widget _buildPaidDate({required String date}) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       CustomText(
  //         txtTitle: "Paid Date",
  //         style: Theme.of(context).textTheme.bodyText2?.copyWith(
  //               color: ColorConstants.custGrey707070,
  //             ),
  //       ),
  //       Container(
  //         padding: const EdgeInsets.all(6),
  //         decoration: BoxDecoration(
  //           color: ColorConstants.custDarkPurple500472,
  //           borderRadius: BorderRadius.circular(6),
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             const CustImage(
  //               imgURL: ImgName.landlordCalender,
  //               imgColor: ColorConstants.backgroundColorFFFFFF,
  //             ),
  //             const SizedBox(width: 4),
  //             CustomText(
  //               txtTitle: date,
  //               style: Theme.of(context).textTheme.caption?.copyWith(
  //                     fontWeight: FontWeight.w600,
  //                     color: ColorConstants.backgroundColorFFFFFF,
  //                   ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

//------------ PurchasedDate Row---------
  Widget _buildPurchasedDate({
    required String? titleName,
    required String? date,
    required Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Row(
            children: [
              CustomText(
                txtTitle: titleName,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstants.custGrey707070,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustImage(
                imgURL: ImgName.calenderPurple,
                imgColor: ColorConstants.custWhiteFFFFFF,
              ),
              const SizedBox(width: 4),
              CustomText(
                txtTitle: date,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.custWhiteFFFFFF,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

//-----------------build Details-----------------

  Widget _buildDetailsRow({
    required String? textTitle,
    final String? textSubTitle,
    Widget? child,
    final Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Row(
            children: [
              CustomText(
                txtTitle: textTitle,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstants.custGrey707070,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: child,
              ),
              const SizedBox(width: 4),
              CustomText(
                txtTitle: textSubTitle,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //-------------- Recurring Delete and Edit Btn---------------
  //
  Widget _recurringEditAndDeteleBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (logPayment == true)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 11,
            ),
            decoration: const BoxDecoration(
              color: ColorConstants.custCyan017781, // primaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: CustomText(
              txtTitle: StaticString.recurringPayment,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custWhiteFFFFFF,
                  ),
            ),
          )
        else
          _logPaymentButton(),
        SizedBox(
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => AddExpanseScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: const BoxDecoration(
                    color: ColorConstants.custCyan017781,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                    ),
                  ),
                  child: const CustImage(
                    imgURL: ImgName.editIcon,
                  ),
                ),
              ),
              const SizedBox(width: 1.5),
              InkWell(
                onTap: () {
                  showAlert(
                    context: context,
                    title: StaticString.deleteExpense,
                    singleBtnTitle: StaticString.delete,
                    showIcon: false,
                    singleBtnColor: ColorConstants.custChartRed,
                    message: AlertMessageString.incomeExpensesDeleteAlert,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: const BoxDecoration(
                    color: ColorConstants.custParrotGreenAFCB1F,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: const CustImage(
                    imgURL: ImgName.deleteWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

//------------------LogPaymentBtn------------------

  Widget _logPaymentButton() {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width / 3,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(0.0),
          backgroundColor: MaterialStateProperty.all<Color>(
            ColorConstants.custChartRed,
          ),
        ),
        onPressed: () {
          showAlert(
            context: context,
            title: StaticString.deleteExpense,
            singleBtnTitle: StaticString.delete,
            showIcon: false,
            singleBtnColor: ColorConstants.custChartRed,
            message: AlertMessageString.incomeExpensesDeleteAlert,
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 4,
          ),
          child: CustomText(
            txtTitle: StaticString.logPayment.toUpperCase(),
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.custWhiteFFFFFF,
                ),
          ),
        ),
      ),
    );
  }
}
