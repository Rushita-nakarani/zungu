import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/landlord/property_viewings/confirm_viewing.dart';
import 'package:zungu_mobile/screens/landlord/property_viewings/new_request_screen.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class MyViewingScreen extends StatefulWidget {
  const MyViewingScreen({super.key});

  @override
  State<MyViewingScreen> createState() => _MyViewingScreenState();
}

class _MyViewingScreenState extends State<MyViewingScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.custPurple500472,
        title: const CustomText(
          txtTitle: StaticString.myViewings,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [_tabbar(), _tabbarView()],
        ),
      ),
    );
  }

  Widget _tabbar() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TabBar(
        labelPadding: EdgeInsets.zero,
        labelColor: ColorConstants.custBlue1EC0EF,
        unselectedLabelColor: ColorConstants.custGrey707070,
        indicatorColor: ColorConstants.custBlue1EC0EF,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
        controller: _tabController,
        tabs: const [
          Tab(
            text: StaticString.newRequest,
          ),
          Tab(text: StaticString.confirmViewing),
        ],
        labelStyle: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _tabbarView() {
    return Expanded(
      child: TabBarView(
        // physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const [NewRequestScreen(), ConfirmViewingScreen()],
      ),
    );
  }
}
