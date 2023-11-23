import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/trades_person/trades_invoicing/paid_invoicing_screen.dart';
import 'package:zungu_mobile/screens/trades_person/trades_invoicing/sent_invoicing_screen.dart';
import 'package:zungu_mobile/screens/trades_person/trades_invoicing/to_be_invoicing_screen.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class TradesPersonInvoicingScreen extends StatefulWidget {
  const TradesPersonInvoicingScreen({super.key});

  @override
  State<TradesPersonInvoicingScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TradesPersonInvoicingScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.custDarkTeal017781,
        title: const CustomText(
          txtTitle: StaticString.tradesPersonInvoicingScreen,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const CustImage(
              imgURL: ImgName.settingImage,
            ),
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TabBar(
              labelColor: ColorConstants.custParrotGreenAFCB1F,
              unselectedLabelColor: ColorConstants.custGrey707070,
              indicatorColor: ColorConstants.custParrotGreenAFCB1F,
              controller: _tabController,
              tabs: [
                Tab(
                  text: StaticString.toBeInvoiced.toUpperCase(),
                ),
                Tab(
                  text: StaticString.sentInvoices.toUpperCase(),
                ),
                Tab(text: StaticString.paidInvoices.toUpperCase()),
              ],
              labelStyle: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ToBeInvoicingscreen(),
                SentInvoicingscreen(),
                PaidInvoicingscren()
              ],
            ),
          )
        ],
      ),
    );
  }
}
