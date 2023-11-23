import 'package:flutter/material.dart';
import 'package:zungu_mobile/widgets/common_widget.dart';

import '../../../../utils/custom_extension.dart';
import '../../constant/color_constants.dart';
import '../../constant/img_constants.dart';
import '../../constant/string_constants.dart';
import '../../widgets/common_elevated_button.dart';
import '../../widgets/cust_image.dart';
import '../../widgets/custom_text.dart';

class LandlordSettingsLatePaymentScreen extends StatelessWidget {
  const LandlordSettingsLatePaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 32),
          child: Column(
            children: [
              commonHeaderLable(
                title: StaticString.latePaymentFee,
                secondLineColor: ColorConstants.custGreen3DAE74,
                child: _buildTopCard(context),
              ),
              const SizedBox(
                height: 26,
              ),
              TextFormField(
                onChanged: (val) {},
               
                decoration: InputDecoration(
                  counterText: "",
                  labelText: StaticString.latePaymentFee,
                  prefixText: StaticString.currency.addSpaceAfter,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              CommonElevatedButton(
                bttnText: StaticString.submit,
                onPressed: () {},
                fontSize: 14,
                color: ColorConstants.custBlue1EC0EF,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // App bar ...
  AppBar _buildAppBar() {
    return AppBar(
      title: const CustomText(
        txtTitle: StaticString.generalSettings,
      ),
      backgroundColor: ColorConstants.custDarkPurple500472,
    );
  }

  Widget _buildTopCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.custLightBlueF5F9FA,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 10,
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: const CustImage(
              imgURL: ImgName.commonInformation,
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Expanded(
            child: CustomText(
              txtTitle: StaticString.setALatePayment,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.custGrey707070,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
