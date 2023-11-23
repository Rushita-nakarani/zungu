//---------------------------- TabBar Invoices Home Screen ------------------------//

import 'package:flutter/material.dart';
import 'package:zungu_mobile/screens/tenant/invoices/tenant_new_invoices_screen.dart';
import 'package:zungu_mobile/screens/tenant/invoices/tenant_paid_invoices_screen.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

import '../../../constant/img_font_color_string.dart';
import 'invoices_filter_by_bottomsheet.dart';

class TenantInvoicesScreen extends StatefulWidget {
  const TenantInvoicesScreen({super.key});

  @override
  State<TenantInvoicesScreen> createState() => _TenantInvoicesScreenState();
}

class _TenantInvoicesScreenState extends State<TenantInvoicesScreen> {
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
        appBar: AppBar(
          title: const CustomText(
            txtTitle: StaticString.invoicesName,
          ),
          backgroundColor: ColorConstants.custDarkPurple662851,
          actions: <Widget>[
            IconButton(
              icon: const CustImage(imgURL: ImgName.filter),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return const InvoicesFilterByBottomsheet();
                  },
                );
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
        ),
        body: const SafeArea(
          child: TabBarView(
            children: [
              TenantNewInvoicesScreen(),
              TenantPaidInvoicesScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

//--------------------------------- TabBar Invoices -------------------------------//
TabBar get _tabBar => TabBar(
      labelColor: ColorConstants.custDarkYellow838500,
      unselectedLabelColor: ColorConstants.custGrey707070,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2.0,
          color: ColorConstants.custDarkYellow838500,
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
          text: StaticString.newInvoices.toUpperCase(),
        ),
        Tab(
          text: StaticString.paidInvoices.toUpperCase(),
        ),
      ],
    );
