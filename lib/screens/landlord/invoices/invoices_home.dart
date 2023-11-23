import 'package:flutter/material.dart';
import 'package:zungu_mobile/screens/landlord/invoices/invoices_filter.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../../../constant/img_font_color_string.dart';
import '../../../widgets/custom_text.dart';
import 'invoices_new_invoices.dart';
import 'invoices_paid_invoices.dart';

class LandlordInvoicesHome extends StatefulWidget {
  const LandlordInvoicesHome({super.key});

  @override
  State<LandlordInvoicesHome> createState() => _LandlordInvoicesHomeState();
}

class _LandlordInvoicesHomeState extends State<LandlordInvoicesHome> {
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
        appBar: landlordInvoicesBuildAppbar(title: StaticString.invoices),
        body: const SafeArea(
          child: TabBarView(
            children: [
              LandlordInvoicesNewInvoices(),
              LandlordInvoicesPaidInvoices(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar landlordInvoicesBuildAppbar({
    required String title,
  }) {
    return AppBar(
      title: CustomText(
        txtTitle: title,
      ),
      backgroundColor: ColorConstants.custDarkPurple500472,
      actions: <Widget>[
        IconButton(
          icon: const CustImage(imgURL: ImgName.filter),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              barrierColor: Colors.black.withOpacity(0.5),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              isScrollControlled: true,
              backgroundColor: ColorConstants.backgroundColorFFFFFF,
              builder: (context) {
                return const InvoicesFilter();
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
    );
  }

  TabBar get _tabBar => TabBar(
        labelColor: ColorConstants.custBlue1EC0EF,
        unselectedLabelColor: ColorConstants.custGrey707070,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 2.0,
            color: ColorConstants.custBlue1EC0EF,
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
}
