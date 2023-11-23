import 'package:flutter/material.dart';

import '../../../constant/img_font_color_string.dart';
import 'current_tenancy.dart';
import 'previous_tenancy.dart';
import 'tenant_my_tenancies_appbar.dart';

class TenantMyTenancies extends StatefulWidget {
  const TenantMyTenancies({super.key});

  @override
  State<TenantMyTenancies> createState() => _TenantMyTenanciesState();
}

class _TenantMyTenanciesState extends State<TenantMyTenancies> {
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
        appBar: tenantMyTenanciesBuildAppbar(title: StaticString.myTenancies),
        // appBar: tenantMyTenanciesBuildAppbar(title: StaticString.myTenancies),
        body: const SafeArea(
          child: TabBarView(
            children: [
              TenantMyTenanciesCurrentTenancy(),
              TenantMyTenanciesPreviousTenancy(),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> fetchPreviousTenancies() async {
  //   try {
  //     _loadingIndicatorNotifier.show(
  //       loadingIndicatorType: LoadingIndicatorType.spinner,
  //     );
  //     await Provider.of<TenanciesProvider>(context, listen: false)
  //         .fetchPreviousTenancy();
  //   } catch (e) {
  //     showAlert(context: context, message: e);
  //   } finally {
  //     _loadingIndicatorNotifier.hide();
  //   }
  // }
}
