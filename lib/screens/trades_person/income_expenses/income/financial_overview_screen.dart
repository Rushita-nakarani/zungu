import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/constant/img_constants.dart';
import 'package:zungu_mobile/constant/string_constants.dart';
import 'package:zungu_mobile/screens/trades_person/income_expenses/income/download_report_screen.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class FinancialOverviewScreen extends StatefulWidget {
  const FinancialOverviewScreen({super.key});

  @override
  State<FinancialOverviewScreen> createState() =>
      _FinancialOverviewScreenState();
}

class _FinancialOverviewScreenState extends State<FinancialOverviewScreen>
    with TickerProviderStateMixin {
  //--------------------------------- variable-------------------------------//;
  bool isOnTap = true;
  bool logPayment = false;
  List<int> selectedTab = [0, 1, 2];
  double _currentValue = 0;

  // ignore: always_declare_return_types
  setEndPressed(double value) {
    if (mounted) {
      setState(() {
        _currentValue = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.custCyan017781,
        appBar: AppBar(
          backgroundColor: ColorConstants.custCyan017781,
          title: const CustomText(
            txtTitle: StaticString.financials,
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    TabController tabController = TabController(length: 3, vsync: this);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  txtTitle: "Financial Overview",
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.custWhiteFFFFFF,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorConstants.custCyan017781,
                    ),
                    indicatorPadding: const EdgeInsets.all(5),
                    controller: tabController,
                    //labelStyle: const TextStyle(color: Colors.black),
                    labelColor: ColorConstants.backgroundColorFFFFFF,
                    unselectedLabelColor: ColorConstants.custCyan017781,
                    tabs: const [
                      Tab(
                        child: Text(
                          "Income",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Expenses",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Cash Flow",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1.28,
              child: TabBarView(
                controller: tabController,
                children: [
                  _buildIncome(),
                  _buildIncome(),
                  _buildIncome(),
                ],
              ),
            ),
            //_incomeExpensesCashflowBtnRow(),
            // const SizedBox(height: 0),
            // if (isOnTap) _buildExpenses() else _buildIncome(),
            // const SizedBox(height: 30),
            // _buildMonthName(),
            // const SizedBox(height: 30),
            // _buildIndicator(),
            // Row(
            //   children: [
            //     _buildIndicatorDetails(
            //       bgcolor: ColorConstants.custGreyD5DAF8,
            //       textTitle: StaticString.invoiced,
            //       textColor: ColorConstants.custWhiteFFFFFF,
            //     ),
            //     _buildIndicatorDetails(
            //       bgcolor: ColorConstants.custParrotGreenAFCB1F,
            //       textTitle: StaticString.paidToDate,
            //       textColor: ColorConstants.custWhiteFFFFFF,
            //     ),
            //     _buildIndicatorDetails(
            //       color: ColorConstants.custWhiteF1F0F0,
            //       bgcolor: ColorConstants.custCyan017781,
            //       textTitle: StaticString.overdue,
            //       textColor: ColorConstants.custCyan017781,
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 40),
            // _downloadReportButton(),
            // const SizedBox(height: 50),
            // _buildIncomeDetails()
          ],
        ),
      ),
    );
  }

  Widget _buildIncome() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                txtTitle: StaticString.income,
                style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: ColorConstants.backgroundColorFFFFFF,
                    ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CustomText(
                        txtTitle: "Nov 2021",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const CustImage(
                        imgURL: ImgName.downArrow,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        _buildMonthName(),
        const SizedBox(height: 30),
        _buildIndicator(),
        Row(
          children: [
            _buildIndicatorDetails(
              bgcolor: ColorConstants.custGreyD5DAF8,
              textTitle: StaticString.invoiced,
              textColor: ColorConstants.custWhiteFFFFFF,
            ),
            _buildIndicatorDetails(
              bgcolor: ColorConstants.custParrotGreenAFCB1F,
              textTitle: StaticString.paidToDate,
              textColor: ColorConstants.custWhiteFFFFFF,
            ),
            _buildIndicatorDetails(
              color: ColorConstants.custWhiteF1F0F0,
              bgcolor: ColorConstants.custCyan017781,
              textTitle: StaticString.overdue,
              textColor: ColorConstants.custCyan017781,
            ),
          ],
        ),
        const SizedBox(height: 40),
        _downloadReportButton(),
        const SizedBox(height: 50),
        _buildIncomeDetails()
      ],
    );
  }

  // Widget _incomeExpensesCashflowBtnRow() {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 30),
  //     padding: const EdgeInsets.all(5),
  //     decoration: BoxDecoration(
  //       color: ColorConstants.custWhiteFFFFFF,
  //       borderRadius: BorderRadius.circular(9),
  //     ),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: custElavetadeBtn(
  //             btnColor: isOnTap ? Colors.white : ColorConstants.custCyan017781,
  //             textColor: isOnTap ? ColorConstants.custCyan017781 : Colors.white,
  //             btnTitle: "Income",
  //             btnOntap: () {
  //               setState(() {
  //                 // selectedTab.[0] = !selectedTab.[0];
  //                 isOnTap = !isOnTap;
  //               });
  //             },
  //           ),
  //         ),
  //         Expanded(
  //           child: custElavetadeBtn(
  //             btnColor: !isOnTap ? Colors.white : ColorConstants.custCyan017781,
  //             textColor:
  //                 !isOnTap ? ColorConstants.custCyan017781 : Colors.white,
  //             btnTitle: "Expenses",
  //             btnOntap: () {
  //               setState(() {
  //                 isOnTap = !isOnTap;
  //               });
  //             },
  //           ),
  //         ),
  //         Expanded(
  //           child: custElavetadeBtn(
  //             btnColor: !isOnTap ? Colors.white : ColorConstants.custCyan017781,
  //             textColor:
  //                 !isOnTap ? ColorConstants.custCyan017781 : Colors.white,
  //             btnTitle: "Cash Flow",
  //             btnOntap: () {
  //               setState(() {
  //                 //isOnTap = !isOnTap;
  //               });
  //             },
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  //----------- Custom Elaveted button--------

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

//---------- _build Month Name------------

  Widget _buildMonthName() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CustomText(
              txtTitle: "Jan",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custWhiteFFFFFF,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              width: 40,
            ),
            //const Spacer(),
            CustomText(
              txtTitle: "Feb",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custWhiteFFFFFF,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              width: 40,
            ),
            //const Spacer(),
            CustomText(
              txtTitle: "Mar",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custWhiteFFFFFF,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              width: 40,
            ),
            //const Spacer(),
            CustomText(
              txtTitle: "Apr",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custWhiteFFFFFF,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              width: 40,
            ),
            //const Spacer(),
            CustomText(
              txtTitle: "May",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custWhiteFFFFFF,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              width: 40,
            ),
            //const Spacer(),
            CustomText(
              txtTitle: "Jun",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custWhiteFFFFFF,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              width: 40,
            ),
            //const Spacer(),
            CustomText(
              txtTitle: "Jun",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custWhiteFFFFFF,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            // const Spacer(),
            // CustomText(
            //   txtTitle: "Jun",
            //   style: Theme.of(context).textTheme.bodyText1?.copyWith(
            //         color: ColorConstants.custWhiteFFFFFF,
            //         fontWeight: FontWeight.w500,
            //       ),
            // )
          ],
        ),
      ),
    );
  }

//-----------Graph Indicator------------

  Widget _buildIndicator() {
    return SizedBox(
      height: 233,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: 179,
              child: FAProgressBar(
                size: 8,
                progressColor: ColorConstants.custParrotGreenAFCB1F,
                backgroundColor: Colors.white,
                currentValue: 70,
                animatedDuration: const Duration(milliseconds: 800),
                direction: Axis.vertical,
                verticalDirection: VerticalDirection.up,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 139,
              child: FAProgressBar(
                size: 8,
                progressColor: ColorConstants.custParrotGreenAFCB1F,
                backgroundColor: Colors.white,
                currentValue: 70,
                animatedDuration: const Duration(milliseconds: 800),
                direction: Axis.vertical,
                verticalDirection: VerticalDirection.up,
              ),
            ),
            const Spacer(),
            FAProgressBar(
              size: 8,
              progressColor: ColorConstants.custParrotGreenAFCB1F,
              backgroundColor: Colors.white,
              currentValue: 50,
              animatedDuration: const Duration(milliseconds: 800),
              direction: Axis.vertical,
              verticalDirection: VerticalDirection.up,
            ),
            const Spacer(),
            SizedBox(
              height: 179,
              child: FAProgressBar(
                size: 8,
                progressColor: ColorConstants.custParrotGreenAFCB1F,
                backgroundColor: Colors.white,
                currentValue: 30,
                animatedDuration: const Duration(milliseconds: 800),
                direction: Axis.vertical,
                verticalDirection: VerticalDirection.up,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 99,
              child: FAProgressBar(
                size: 8,
                progressColor: ColorConstants.custParrotGreenAFCB1F,
                backgroundColor: Colors.white,
                currentValue: 60,
                animatedDuration: const Duration(milliseconds: 800),
                direction: Axis.vertical,
                verticalDirection: VerticalDirection.up,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 199,
              child: FAProgressBar(
                size: 8,
                progressColor: ColorConstants.custParrotGreenAFCB1F,
                backgroundColor: Colors.white,
                currentValue: 40,
                animatedDuration: const Duration(milliseconds: 800),
                direction: Axis.vertical,
                verticalDirection: VerticalDirection.up,
              ),
            )
            //],
          ],
        ),
      ),
    );
  }

  Widget _buildIndicatorDetails({
    Color? color,
    Color? bgcolor,
    String? textTitle,
    Color? textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 6,
                backgroundColor: bgcolor,
              ),
              const SizedBox(
                width: 10,
              ),
              CustomText(
                txtTitle: textTitle,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _downloadReportButton() {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
              side: const BorderSide(
                color: ColorConstants.custParrotGreenAFCB1F,
                width: 4,
              ),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(0.0),
          backgroundColor: MaterialStateProperty.all<Color>(
            ColorConstants.custCyan017781,
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const DownloadReportScreen(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CustImage(
                imgURL: ImgName.download,
              ),
              CustomText(
                txtTitle: StaticString.downloadReport,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstants.custWhiteFFFFFF,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //--------Income Details--------------//

  Widget _buildIncomeDetails() {
    return Container(
      alignment: Alignment.topCenter,
      height: MediaQuery.of(context).size.height / 1.8,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  txtTitle: "Income",
                  style: Theme.of(context).textTheme.headline2,
                ),
                Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: ColorConstants.custGreyF7F7F7,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CustomText(
                          txtTitle: "Nov 2021",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const CustImage(
                          imgURL: ImgName.downArrow,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3.1,
              decoration: BoxDecoration(
                color: ColorConstants.backgroundColorFFFFFF,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
                    blurRadius: 12,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            children: const [
                              CustImage(
                                imgURL: ImgName.invoice,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomText(
                                txtTitle: "innvoiced",
                              )
                            ],
                          ),
                        ),
                        CustomText(
                          txtTitle: "£5125",
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            children: const [
                              CustImage(
                                imgURL: ImgName.invoice,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomText(
                                txtTitle: "Paid to Date",
                              )
                            ],
                          ),
                        ),
                        CustomText(
                          txtTitle: "£2050",
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            children: const [
                              CustImage(
                                imgURL: ImgName.invoice,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomText(
                                txtTitle: "Overdue",
                              )
                            ],
                          ),
                        ),
                        CustomText(
                          txtTitle: "£5125",
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            children: const [
                              CustImage(
                                imgURL: ImgName.invoice,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomText(
                                txtTitle: "Outstanding",
                              )
                            ],
                          ),
                        ),
                        CustomText(
                          txtTitle: "£1825",
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //-------------Expenses Details-------------//

  Widget _buildExpenses() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                txtTitle: StaticString.expenses,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    ?.copyWith(color: ColorConstants.backgroundColorFFFFFF),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CustomText(
                        txtTitle: "Nov 2021",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const CustImage(
                        imgURL: ImgName.downArrow,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        _buildMonthName(),
        const SizedBox(height: 30),
        _buildIndicator(),
        Row(
          children: [
            _buildIndicatorDetails(
              bgcolor: ColorConstants.custGreyD5DAF8,
              textTitle: StaticString.invoiced,
              textColor: ColorConstants.custWhiteFFFFFF,
            ),
            _buildIndicatorDetails(
              bgcolor: ColorConstants.custParrotGreenAFCB1F,
              textTitle: StaticString.paidToDate,
              textColor: ColorConstants.custWhiteFFFFFF,
            ),
            _buildIndicatorDetails(
              color: ColorConstants.custWhiteF1F0F0,
              bgcolor: ColorConstants.custCyan017781,
              textTitle: StaticString.overdue,
              textColor: ColorConstants.custCyan017781,
            ),
          ],
        ),
        const SizedBox(height: 40),
        _downloadReportButton(),
        const SizedBox(height: 50),
        _buildIncomeDetails()
      ],
    );
  }
}
