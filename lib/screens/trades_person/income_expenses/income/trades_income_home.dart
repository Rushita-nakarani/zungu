import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/constant/img_constants.dart';
import 'package:zungu_mobile/constant/string_constants.dart';
import 'package:zungu_mobile/screens/landlord/invoices/invoices_filter.dart';
import 'package:zungu_mobile/screens/landlord/invoices/invoices_new_invoices.dart';
import 'package:zungu_mobile/screens/landlord/invoices/invoices_paid_invoices.dart';
import 'package:zungu_mobile/screens/trades_person/income_expenses/income/add_expanses_screen.dart';
import 'package:zungu_mobile/screens/trades_person/income_expenses/income/trades_expenses.dart';
import 'package:zungu_mobile/screens/trades_person/income_expenses/income/trades_income.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class TradesIncomeHome extends StatefulWidget {
  const TradesIncomeHome({super.key});

  @override
  State<TradesIncomeHome> createState() => _TradesIncomeHomeState();
}

class _TradesIncomeHomeState extends State<TradesIncomeHome> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: tradesIncomeBuildAppbar(title: StaticString.incomeExpenses),
        // appBar: tenantMyTenanciesBuildAppbar(title: StaticString.myTenancies),
        body: const SafeArea(
          child: TabBarView(
            children: [
              TradesPersonIncome(),
              ExpensesTabViewScreen(
                isTabbar: false,
              ),
              //TradesPersonExpenses(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar tradesIncomeBuildAppbar({
    required String title,
  }) {
    return AppBar(
      title: CustomText(
        txtTitle: title,
      ),
      backgroundColor: ColorConstants.custCyan017781,
      actions: <Widget>[
        IconButton(
          icon: const CustImage(imgURL: ImgName.addIcon),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => AddExpanseScreen(
                  isEdit: true,
                ),
              ),
            );
            // showModalBottomSheet(
            //   context: context,
            //   barrierColor: Colors.black.withOpacity(0.5),
            //   shape: const RoundedRectangleBorder(
            //     borderRadius: BorderRadius.vertical(
            //       top: Radius.circular(25.0),
            //     ),
            //   ),
            //   isScrollControlled: true,
            //   backgroundColor: ColorConstants.backgroundColorFFFFFF,
            //   builder: (context) {
            //     return const InvoicesFilter();
            //   },
            // );
          },
        )
      ],
      bottom: PreferredSize(
        preferredSize: _tabBar.preferredSize,
        child: Container(
          color: ColorConstants.backgroundColorFFFFFF,
          child: _tabBar,
        ),
      ),
    );
  }

  // Stack get _buildTabbar {
  //   return Stack(
  //     children: [
  //       const Divider(),
  //       TabBar(
  //       labelColor: ColorConstants.custGreenAFCB1F,
  //       unselectedLabelColor: ColorConstants.custGrey707070,
  //       indicator: const UnderlineTabIndicator(
  //         borderSide: BorderSide(
  //           width: 2.0,
  //           color: ColorConstants.custGreenAFCB1F,
  //         ),
  //         insets: EdgeInsets.symmetric(horizontal: 16.0),
  //       ),
  //       labelStyle: const TextStyle(
  //         fontSize: 14,
  //         fontFamily: CustomFont.ttCommons,
  //         fontWeight: FontWeight.w600,
  //       ),
  //       tabs: [
  //         Tab(
  //           text: StaticString.income.toUpperCase(),
  //         ),
  //         Tab(
  //           text: StaticString.expenses.toUpperCase(),
  //         ),
  //       ],
  //     )

  //     ],
  //   );
  // }

  TabBar get _tabBar => TabBar(
        labelColor: ColorConstants.custGreenAFCB1F,
        unselectedLabelColor: ColorConstants.custGrey707070,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 2.0,
            color: ColorConstants.custGreenAFCB1F,
          ),
          insets: EdgeInsets.symmetric(horizontal: 16.0),
        ),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontFamily: CustomFont.ttCommons,
          fontWeight: FontWeight.w600,
        ),
        tabs: [
          Tab(
            text: StaticString.income.toUpperCase(),
          ),
          Tab(
            text: StaticString.expenses.toUpperCase(),
          ),
        ],
      );
}
