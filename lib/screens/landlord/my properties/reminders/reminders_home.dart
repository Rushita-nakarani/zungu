//--------------------------------- Reminders Home Screen --------------------------/

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/landlord/my%20properties/reminders/add_reminder.dart';
import 'package:zungu_mobile/screens/landlord/my%20properties/reminders/my_reminders.dart';
import 'package:zungu_mobile/screens/landlord/my%20properties/reminders/overdue_reminders.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class RemindersHomeScreen extends StatefulWidget {
  const RemindersHomeScreen({super.key});

  @override
  State<RemindersHomeScreen> createState() => _RemindersHomeScreenState();
}

class _RemindersHomeScreenState extends State<RemindersHomeScreen> {
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
            txtTitle: StaticString.reminders,
          ),
          backgroundColor: ColorConstants.custPurple500472,
          actions: <Widget>[
            IconButton(
              icon: const CustImage(imgURL: ImgName.filter),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const OverdueRemindersScreen(),
                  ),
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
              AddReminderScreen(),
              MyRemindersScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
//----------------------------------- TabBar Reminders------------------------------/

TabBar get _tabBar => TabBar(
      labelColor: ColorConstants.custBlue2AC4EF,
      unselectedLabelColor: ColorConstants.custGrey707070,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2.0,
          color: ColorConstants.custBlue2AC4EF,
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
          text: StaticString.addReminder.toUpperCase(),
        ),
        Tab(
          text: StaticString.myReminders.toUpperCase(),
        ),
      ],
    );
