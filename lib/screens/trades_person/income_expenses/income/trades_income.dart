import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:zungu_mobile/cards/income_exp_details_card.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/constant/img_constants.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/landlord/invoices/invoices_common_components.dart';
import 'package:zungu_mobile/screens/trades_person/income_expenses/income/download_report_screen.dart';
import 'package:zungu_mobile/widgets/common_outline_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class TradesPersonIncome extends StatefulWidget {
  const TradesPersonIncome({super.key});

  @override
  State<TradesPersonIncome> createState() => TradesPersonIncomeState();
}

class TradesPersonIncomeState extends State<TradesPersonIncome> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: _buildBody());
  }

  Widget _buildBody() {
    return Column(
      children: [
        const SizedBox(height: 40),
        _buildRevenue(),
        const SizedBox(height: 40),
        _downloadReportButton(),
        _buildCard()
      ],
    );
  }

  Widget _buildRevenue() {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        const CustImage(
          imgURL: ImgName.tradesPersonRevenue,
        ),
        Container(
          alignment: Alignment.center,
          height: 160,
          width: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorConstants.custCyanB4DFDC,
              width: 16,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 152,
          width: 152,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorConstants.custYellowF5ECD2,
              width: 8,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                txtTitle: "19",
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: ColorConstants.custCyan017781,
                    ),
              ),
              CustomText(
                txtTitle: StaticString.total.toUpperCase(),
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: ColorConstants.custCyan017781,
                    ),
              ),
              CustomText(
                txtTitle: StaticString.jobs.toUpperCase(),
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: ColorConstants.custCyan017781,
                    ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -20,
          child: Column(
            children: [
              CustomText(
                txtTitle: StaticString.totalRevenue.toUpperCase(),
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstants.custCyan017781,
                    ),
              ),
              CustomText(
                txtTitle: "£14 500",
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: ColorConstants.custCyan017781,
                    ),
              )
            ],
          ),
        ),
      ],
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
    // const CommonOutlineElevatedButton(
    //   bttnText: "Download Report",
    //   borderColor: ,

    // );
  }

  Widget _buildCard() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 1.5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: buildDecoration(),
                        child: _buildBoxOneDetails(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: buildDecoration(),
                        child: IncomeExpensesDetailsCard(
                          number: "10",
                          imageURL: ImgName.yield,
                          jobTitle: StaticString.paid,
                          jobSubTitle: StaticString.invoices.toUpperCase(),
                          value: "£5450",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: buildDecoration(),
                        child: IncomeExpensesDetailsCard(
                          number: "05",
                          imageURL: ImgName.onSite,
                          jobTitle: StaticString.pendingIncomeExpenses,
                          jobSubTitle: StaticString.jobs.toUpperCase(),
                          value: "£5050",
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: buildDecoration(),
                        child: IncomeExpensesDetailsCard(
                          number: "02",
                          imageURL: ImgName.invoicing,
                          jobTitle: StaticString.outstanding,
                          jobSubTitle: StaticString.invoices.toUpperCase(),
                          value: "£4000",
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: buildDecoration(),
                        child: IncomeExpensesDetailsCard(
                          number: "01",
                          imageURL: ImgName.overDue,
                          jobTitle: StaticString.overDue,
                          jobSubTitle: StaticString.invoices.toUpperCase(),
                          value: "£1200",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration buildDecoration() {
    return BoxDecoration(
      color: ColorConstants.custCyan017781,
      borderRadius: BorderRadius.circular(10),
    );
  }

  Widget _buildBoxOneDetails() {
    return IncomeExpensesDetailsCard(
      number: "14",
      imageURL: ImgName.onSite,
      jobTitle: StaticString.completed,
      jobSubTitle: StaticString.jobs,
      value: "£9450",
      child: CircularPercentIndicator(
        radius: 50.0,
        lineWidth: 8.0,
        percent: 0.8,
        //header: const Text("Icon header"),
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              txtTitle: "13",
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: ColorConstants.custWhiteFFFFFF,
                  ),
            ),
            CustomText(
              txtTitle: StaticString.invoiced,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custWhiteFFFFFF,
                  ),
            )
          ],
        ),

        backgroundColor: ColorConstants.custWhiteFFFFFF,
        progressColor: ColorConstants.custParrotGreenAFCB1F,
      ),
    );
  }
}
