import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/widgets/no_content_label.dart';

import '../../cards/dashboard_card.dart';
import '../../constant/color_constants.dart';
import '../../constant/img_constants.dart';
import '../../constant/string_constants.dart';
import '../../models/dashboard/dashboard_model.dart';
import '../../providers/dashboard_provider/landlord_dashboard_provider.dart';
import '../../providers/dashboard_provider/tradesman_dashboard_provider.dart';
import '../../screens/trades_person/income_expenses/income/trades_income_home.dart';
import '../../screens/trades_person/trades_invoicing/trades_person_invoicing.dart';
import '../../widgets/cust_image.dart';
import '../../widgets/custom_alert.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/rich_text.dart';
import '../landlord/landlord_dashboard_screen.dart';
import 'my_jobs/trades_person_my_jobs_screen.dart';

class TradesPersonDashboardScreen extends StatefulWidget {
  const TradesPersonDashboardScreen({super.key});

  @override
  State<TradesPersonDashboardScreen> createState() =>
      _TradesPersonDashboardScreenState();
}

class _TradesPersonDashboardScreenState
    extends State<TradesPersonDashboardScreen> {
  //------------------------variables-------------------------------//

  List<String> myDashboardImages1 = [
    ImgName.tFinancials,
    ImgName.tIncomeexpenses,
    ImgName.tInvoicing,
    ImgName.tMyJobs,
    ImgName.tMyViewings,
    ImgName.tBusinessServices,
  ];

  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  TradesmanDashboradProvider get getTradesmanDashboardProvider =>
      Provider.of<TradesmanDashboradProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    fetchDashboardData();
  }

  List<DashboardDetailModel> _dashboardData = [];
  int taskCount = 0;

  //-----------------------------------UI--------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  //-----------------------------Widgets--------------------------//

  Widget _buildBody() {
    return SafeArea(
      top: false,
      child: LoadingIndicator(
        loadingStatusNotifier: _loadingIndicatorNotifier,
        child: GestureDetector(
          onTap: () {
            final FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search field
                      // _buildSearchField(),
                      const SizedBox(height: 20),

                      // New tasks left header text
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CustomText(
                          txtTitle: StaticString.newTaskLeft,
                          style:
                              Theme.of(context).textTheme.headline1?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // New task left list
                      Consumer<TradesmanDashboradProvider>(
                        builder: (context, dashboardTask, child) {
                          return dashboardTask.getTradesmanTaskModel == null
                              ? NoContentLabel(
                                  title: StaticString.nodataFound,
                                  onPress: () {
                                    fetchDashboardData();
                                  },
                                )
                              : SizedBox(
                                  height: 98,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      width: 35,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        dashboardTask.newTaskLeftList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return _buildNewTaskCard(
                                        newTaskLeftModel: dashboardTask
                                            .newTaskLeftList[index],
                                      );
                                    },
                                  ),
                                );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomText(
                          txtTitle: StaticString.myDashboard,
                          style:
                              Theme.of(context).textTheme.headline1?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildDashboardCard(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Search field
  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
              blurRadius: 10,
            ),
          ],
        ),
        height: 46,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                cursorColor: ColorConstants.custBlue1BC4F4,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 20, right: 10),
                  hintText: "Search",
                  hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custGreyAEAEAE,
                      ),
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
              ),
            ),
            const CustImage(
              imgURL: ImgName.landlordSearch,
              width: 24,
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  // Custom new task card
  Widget _buildNewTaskCard({required NewTaskLeftModel newTaskLeftModel}) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 80,
          width: 80,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(top: 8, bottom: 10, right: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              15,
            ),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
                blurRadius: 12,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustImage(
                height: 30,
                width: 30,
                imgURL: newTaskLeftModel.icon,
                // imgColor: index == selectedIndexForNewTaskLeftList
                //     ? Colors.white
                //     : null,
              ),
              CustomText(
                txtTitle: newTaskLeftModel.title.trim().replaceAll(" ", "\n"),
                maxLine: 2,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      // color: index == selectedIndexForNewTaskLeftList
                      //     ? Colors.white
                      //     : ColorConstants.custDarkPurple160935,
                      overflow: TextOverflow.ellipsis,
                      height: 1,
                    ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: CircleAvatar(
            maxRadius: 10,
            minRadius: 10,
            backgroundColor: ColorConstants.custDarkGreen838500,
            child: Padding(
              padding: const EdgeInsets.only(top: 1),
              child: CustomText(
                txtTitle: newTaskLeftModel.count.toString(),
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 13,
                    ),
              ),
            ),
          ),
        )
      ],
    );
  }

  // Build Dashboard Card
  Widget _buildDashboardCard() {
    return Consumer<TradesmanDashboradProvider>(
      builder: (context, dashboardData, child) {
        return dashboardData.getTradesmanDashboardModel == null
            ? NoContentLabel(
                title: StaticString.nodataFound,
                onPress: () async {
                  await getTradesmanDashboardProvider
                      .fetchTradesmanDashboardList();
                },
              )
            : GridView.builder(
                itemCount: _dashboardData.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 35),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  return DashboardCard(
                    iconImage: _dashboardData[index].iconImage,
                    title: _dashboardData[index].title,
                    subtitleValue: _dashboardData[index].subtitleValue,
                    subtitle: _dashboardData[index].subtitle,
                    customSubtitle: _dashboardData[index].customSubtitle,
                    primaryColor: ColorConstants.custDarkTeal017781,
                    bgColor: index == 0 || index == 3 || index == 4
                        ? ColorConstants.custDarkTeal017781
                        : ColorConstants.custParrotGreenAFCB1F,
                    isLeft: index % 2 == 0,
                    onTap: () {}, // _dashboardData[index].onTap,
                  );
                },
              );
      },
    );
  }

  // ------------ Financial content ------------
  Widget _financialContent() {
    return Column(
      children: [
        CustomText(
          txtTitle: "Financials",
          align: TextAlign.center,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                height: 1,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(
          height: 4,
        ),
        FittedBox(
          child: CustomText(
            txtTitle: "Income (Sep 2021)",
            align: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  height: 1,
                ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomText(
          txtTitle: "£9 854",
          align: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                height: 1,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  // ------------ Invoice content ------------
  Widget _invoiceCommonContent({
    String title = "",
    String subTitle = "",
  }) {
    return Column(
      children: [
        CustomText(
          txtTitle: title,
          align: TextAlign.center,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                height: 1,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomRichText(
          title: subTitle,
          fancyTextStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                height: 1,
                color: ColorConstants.custBlue1BC4F4,
                fontWeight: FontWeight.w700,
              ),
          normalTextStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                height: 1,
                color: ColorConstants.custDarkPurple160935,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  // ------ Helper widgets --------

  BoxDecoration commonDecoration({
    double blurRadius = 7,
    Color color = Colors.white,
  }) {
    return BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: ColorConstants.custGrey7A7A7A.withOpacity(0.3),
          blurRadius: blurRadius,
        ),
      ],
    );
  }

  //--------------------Button action--------------------//

  void dashBoardCardOntapAction({required int index}) {
    // switch (index) {
    //   case 0:
    //     Navigator.of(context).push(
    //       MaterialPageRoute(
    //         builder: (ctx) => const FinancialOverviewScreen(),
    //       ),
    //     );
    //     break;
    //   case 1:
    //     Navigator.of(context).push(
    //       MaterialPageRoute(
    //         builder: (ctx) => const TradesIncomeHome(),
    //       ),
    //     );
    //     break;
    //   case 2:
    //     Navigator.of(context).push(
    //       MaterialPageRoute(
    //         builder: (ctx) => const TradesPersonInvoicingScreen(),
    //       ),
    //     );
    //     break;
    //   case 3:
    //     Navigator.of(context).push(
    //       MaterialPageRoute(
    //         builder: (ctx) => const TradesPersonMyJobsScreen(),
    //       ),
    //     );
    //     break;
    //   case 4:
    //     break;
    //   case 5:
    //     break;
    //   default:
    // }
  }

  Future<void> fetchDashboardData() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      if (Provider.of<LandlordDashboradProvider>(context, listen: false)
              .subscribeRoleModel ==
          null) {
        return;
      }
      await Future.wait([
        getTradesmanDashboardProvider.fetchTradesmanDashboardList(),
        Provider.of<LandlordDashboradProvider>(context, listen: false)
            .fetchRoleList(),
      ]);

      _dashboardData = [
        DashboardDetailModel(
          iconImage: ImgName.tFinancials,
          title: StaticString.financials,
          customSubtitle: Column(
            children: [
              CustomText(
                txtTitle: "Income (May 2022)",
                align: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: ColorConstants.custDarkPurple150934,
                      height: 1,
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomText(
                txtTitle: "£856 052",
                align: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: ColorConstants.custDarkPurple150934,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
              ),
            ],
          ),
          onTap: () {},
        ),
        DashboardDetailModel(
          iconImage: ImgName.tIncomeexpenses,
          title: StaticString.incomeAndExpanses,
          subtitleValue: 05,
          subtitle: StaticString.newStatus,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const TradesIncomeHome(),
              ),
            );
          },
        ),
        DashboardDetailModel(
          iconImage: ImgName.tInvoicing,
          title: StaticString.invoicing,
          subtitleValue: getTradesmanDashboardProvider
                  .getTradesmanDashboardModel?.invoiceCount ??
              0,
          subtitle: StaticString.properties,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const TradesPersonInvoicingScreen(),
              ),
            );
          },
        ),
        DashboardDetailModel(
          iconImage: ImgName.tMyJobs,
          title: StaticString.myJobs,
          subtitleValue: getTradesmanDashboardProvider
                  .getTradesmanDashboardModel?.myJobCount ??
              0,
          subtitle: StaticString.newRequest,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const TradesPersonMyJobsScreen(),
              ),
            );
          },
        ),
        DashboardDetailModel(
          iconImage: ImgName.tMyViewings,
          title: StaticString.myViewings,
          subtitleValue: getTradesmanDashboardProvider
                  .getTradesmanDashboardModel?.myViewingCount ??
              0,
          subtitle: StaticString.activeStatus,
          onTap: () {},
        ),
        DashboardDetailModel(
          iconImage: ImgName.tBusinessServices,
          title: StaticString.buisnessServices.replaceAll(" ", "\n"),
          onTap: () {},
        ),
      ];
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
