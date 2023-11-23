import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/constant/string_constants.dart';
import 'package:zungu_mobile/screens/landlord/tenant/create%20lease/create_new_lease_screen.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/custom_title_with_line.dart';

import '../../../../widgets/custom_text.dart';

class CreateNewLeaseAgreeAndProceed extends StatefulWidget {
  const CreateNewLeaseAgreeAndProceed({super.key});

  @override
  State<CreateNewLeaseAgreeAndProceed> createState() =>
      _CreateNewLeaseAgreeAndProceedState();
}

class _CreateNewLeaseAgreeAndProceedState
    extends State<CreateNewLeaseAgreeAndProceed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(context),
    );
  }
  
  // Appbar..
   AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: ColorConstants.custPurple500472,
      title: const Text(
        StaticString.createNewLease,
      ),
    );
  }
// Body...
  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const CustomTitleWithLine(
              primaryColor: ColorConstants.custDarkBlue160935,
              secondaryColor: ColorConstants.custGreen3DAE74,
              title: StaticString.disclaimer,
            ),
            const SizedBox(height: 30),
            CustomText(
              txtTitle: StaticString.disclaimerMsg,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custGrey7A7A7A,
                  ),
            ),
            const Spacer(),
            CommonElevatedButton(
              bttnText: StaticString.agreeAndProceed,
              color: ColorConstants.custBlue1EC0EF,
              fontSize: 14,
              onPressed: agreeAndProceedBtnAction,
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

 

  //-------------------------Button action ---------------------------//
  // move to createLeaese screen...
  void agreeAndProceedBtnAction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const CreateNewLeaseScreen(),
      ),
    );
  }
}
