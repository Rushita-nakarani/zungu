
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/settings/feedback_regarding_model.dart';
import 'package:zungu_mobile/screens/tenant/my_tenancies/custom_datebox.dart';
import 'package:zungu_mobile/screens/trades_person/income_expenses/income/filter_popup.dart';
import 'package:zungu_mobile/screens/trades_person/income_expenses/income/pdf_download_report.dart';
import 'package:zungu_mobile/widgets/common_outline_elevated_button.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class DownloadReportScreen extends StatefulWidget {
  const DownloadReportScreen({Key? key}) : super(key: key);

  @override
  State<DownloadReportScreen> createState() => _DownloadReportScreenState();
}

class _DownloadReportScreenState extends State<DownloadReportScreen> {
  RateMyApp rateMyApp = RateMyApp(
    minDays: 7,
    minLaunches: 10,
    remindDays: 7,
    remindLaunches: 10,
    googlePlayIdentifier: 'fr.skyost.example',
    appStoreIdentifier: '1491556149',
  );

  List<FeedbackRegardingModel> subscriptionTypeList = [
    FeedbackRegardingModel(
      feedbackType: StaticString.landlordSubscription,
    ),
    FeedbackRegardingModel(
      feedbackType: StaticString.propertyListing,
    ),
    FeedbackRegardingModel(
      feedbackType: StaticString.tradesmanSubscription,
    )
  ];

  List<ReportTypePDF> pdfReportTypeList = [
    ReportTypePDF(pdfName: "Icome Expenses Statement Profit and loss"),
    ReportTypePDF(
      pdfName: "Breakdown Statement Income and expenses by category",
    ),
    ReportTypePDF(pdfName: "Schedule E Report Helps with your tax preparation"),
    ReportTypePDF(
      pdfName: "Profit/Loss Summary One line view of income andexpenses",
    ),
    ReportTypePDF(pdfName: "Rent Ledger Shows all rent expected and collected"),
    ReportTypePDF(
      pdfName: "Rent Payment Difference View incomplete rent periods",
    )
  ];

  List<FeedbackRegardingModel> paymentCategoriesFilterList = [
    FeedbackRegardingModel(
      feedbackType: "Select All Categories",
    ),
    FeedbackRegardingModel(
      feedbackType: "Damages",
    ),
    FeedbackRegardingModel(
      feedbackType: "Deposit",
    ),
    FeedbackRegardingModel(
      feedbackType: "Late Fee",
    ),
    FeedbackRegardingModel(
      feedbackType: "Pro-Rata",
    ),
    FeedbackRegardingModel(
      feedbackType: "Rent",
    ),
  ];

  List<FeedbackRegardingModel> expensesCategoriesFilterList = [
    FeedbackRegardingModel(
      feedbackType: "Select All Categories",
    ),
    FeedbackRegardingModel(
      feedbackType: "Allowable loan interest and other financial costs",
    ),
    FeedbackRegardingModel(
      feedbackType: "Costs of services provided, including wages",
    ),
    FeedbackRegardingModel(
      feedbackType: "Legal, management and other professional fees",
    ),
    FeedbackRegardingModel(
      feedbackType: "Other allowable property expenses",
    ),
    FeedbackRegardingModel(
      feedbackType: "Property repairs and maintenance",
    ),
    FeedbackRegardingModel(
      feedbackType: "Rent, rates, insurance, ground rents",
    ),
    // FeedbackRegardingModel(
    //   feedbackType: "Include Payable by Tenant",
    // ),
    // FeedbackRegardingModel(
    //   feedbackType: "Include Capital Expenses",
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.custCyan017781,
        title: const CustomText(
          txtTitle: StaticString.reporting,
        ),
      ),
      body: _buildBody(context),
    );
  }

  SafeArea _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Select Properties...
            ..._buildListTileCard(
              StaticString.selectProperties,
              [
                DownloadModel(
                  title: StaticString.allProperties,
                  onTap: () {},
                ),
              ],
            ),

            // Select Report Type...
            ..._buildListTileCard(
              StaticString.selectReportType,
              [
                DownloadModel(
                  title: StaticString.incomeExpenseStatement,
                  onTap: () {
                    showAlert(
                      hideButton: true,
                      context: context,
                      showCustomContent: true,
                      showIcon: false,
                      title: StaticString.reportType,
                      content: PdfPopup(filterList: pdfReportTypeList),
                    );
                  },
                ),
                DownloadModel(
                  title: StaticString.allPaymentCategories,
                  onTap: () {
                    showAlert(
                      hideButton: true,
                      context: context,
                      showCustomContent: true,
                      showIcon: false,
                      title: StaticString.paymentCategories,
                      content: FilterPopup(
                        filterList: paymentCategoriesFilterList,
                        onSubmit: (paymentTypeModel) {},
                      ),
                    );
                  },
                ),
                DownloadModel(
                  title: StaticString.allExpenseCategories,
                  onTap: () {
                    showAlert(
                      hideButton: true,
                      context: context,
                      showCustomContent: true,
                      showIcon: false,
                      title: StaticString.expenseCategories,
                      content: FilterPopup(
                        filterList: expensesCategoriesFilterList,
                        onSubmit: (paymentTypeModel) {},
                      ),
                    );
                  },
                ),
              ],
            ),
            // Start Date & End Date
            ..._buildListTileCard(StaticString.selectDateRange, []),
            _startAndEndDateCardRow(),
            const Divider(),

            const SizedBox(height: 60),
            // Run Report...
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: CommonOutlineElevatedButton(
                onPressed: () {},
                borderColor: ColorConstants.custGreenAFCB1F,
                bttnText: StaticString.runReport.toUpperCase(),
                textColor: ColorConstants.custGreenAFCB1F,
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildListTileCard(String title, List<DownloadModel> values) {
    return [
      // Title...
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomText(
          txtTitle: title,
          style: Theme.of(context).textTheme.headline2!.copyWith(),
        ),
      ),
      // Values...
      ...values
          .map(
            (e) => Column(
              children: [
                // Title...
                ListTile(
                  onTap: e.onTap,
                  title: CustomText(
                    txtTitle: e.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: ColorConstants.custGrey707070),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(),
              ],
            ),
          )
          .toList()
    ];
  }

  Widget _startAndEndDateCardRow() {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: MediaQuery.of(context).size.height * 0.042),
          const CustomCalender(
            title: StaticString.startTenancy,
            date: "01",
            monthYear: "Jun 2022",
            backgroundcolor: ColorConstants.custWhiteF7F7F7,
            fontColor: ColorConstants.custCyan017781,
          ),
          SizedBox(width: MediaQuery.of(context).size.height * 0.032),
          const CustomCalender(
            title: StaticString.endTenancy,
            date: "31",
            monthYear: "Dec 2022",
            backgroundcolor: ColorConstants.custWhiteF7F7F7,
            fontColor: ColorConstants.custCyan017781,
          ),
        ],
      ),
    );
  }
}

class DownloadModel {
  final String title;
  final void Function() onTap;
  DownloadModel({required this.title, required this.onTap});
}

class ReportTypePDF {
  final String pdfName;
  ReportTypePDF({required this.pdfName});
}
