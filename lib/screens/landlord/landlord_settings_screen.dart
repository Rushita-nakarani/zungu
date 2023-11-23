
import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/landlord/late_payment_fee_screen.dart';
import 'package:zungu_mobile/screens/landlord/property_viewing_times_screen.dart';

import '../../widgets/custom_text.dart';

class LandlordSettingsScreen extends StatelessWidget {
  const LandlordSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              txtTitle: StaticString.generalSettings,
              style: Theme.of(context).textTheme.headline2?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.custDarkBlue150934,
                  ),
            ),
            const SizedBox(
              height: 22,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  switch (index) {
                    case 0:
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const LandlordSettingsLatePaymentScreen(),
                        ),
                      );
                      break;
                    case 1:
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PropertyViewingTimesScreen(),
                        ),
                      );
                      break;
                  }
                },
                child: _buildSettingsCard(context,
                  title: index == 0
                      ? StaticString.latePaymentFee
                      : StaticString.propertyViewingTimes,
                ),
              ),
              itemCount: 2,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context,{required String title}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                txtTitle: title,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.custGrey707070,
                    ),
              ),
              const Icon(
                Icons.keyboard_arrow_right,
                color: ColorConstants.custGrey707070,
              )
            ],
          ),
        ),
        Container(
          color: ColorConstants.custGrey707070,
          height: 0.5,
          width: double.infinity,
        )
      ],
    );
  }

  // App bar ...
  AppBar _buildAppBar() {
    return AppBar(
      title: const CustomText(
        txtTitle: StaticString.setting,
      ),
      backgroundColor: ColorConstants.custDarkPurple500472,
    );
  }
}
