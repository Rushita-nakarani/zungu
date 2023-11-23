import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../constant/string_constants.dart';
import '../../../tenant/my_tenancies/current_tenancy.dart';
import '../../../tenant/my_tenancies/previous_tenancy.dart';
import '../../../trades_person/income_expenses/income/trades_expenses.dart';
import '../../../trades_person/income_expenses/income/trades_income.dart';
import 'landlord_list_my_property_appbar.dart';

class ListMyPorpertySCreen extends StatefulWidget {
  const ListMyPorpertySCreen({super.key});

  @override
  State<ListMyPorpertySCreen> createState() => _ListMyPorpertySCreenState();
}

class _ListMyPorpertySCreenState extends State<ListMyPorpertySCreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: _buildBody(),
    );
    ;
  }

  Widget _buildBody() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: landlordListMyPropertyBuildAppbar(
          title: StaticString.listedProperties,
        ),
        body: const SafeArea(
          child: TabBarView(
            children: [
              ExpensesTabViewScreen(
                isTabbar: false,
              ),
              TradesPersonIncome(),
            ],
          ),
        ),
      ),
    );
  }
}
