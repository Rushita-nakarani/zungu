import 'package:flutter/material.dart';
import 'package:zungu_mobile/screens/trades_person/income_expenses/income/select_job_fillter.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/string_constants.dart';

class TradesSelectJob extends StatefulWidget {
  const TradesSelectJob({super.key});

  @override
  State<TradesSelectJob> createState() => _TradesSelectJobState();
}

class _TradesSelectJobState extends State<TradesSelectJob> {
  List<String> selectJob = [
    // _buildJobIDAndDetails("Abc","xyz")
    "Tradesperson",
    "Accountants",
    "Solicitors",
    "Mortgage Brokers",
    "Tenant Referencing"
  ];
  int selectedOption = -1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.custCyan017781,
          title: const CustomText(
            txtTitle: StaticString.selectJOb,
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              CommonSelectJobTile(
                btnText: StaticString.selectThisJob,
                btncolor: ColorConstants.custCyan017781,
                checkListTileList: selectJob,
                onSelect: (val) {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Column _buildJobIDAndDetails(
    BuildContext context,String jobId, String jobDetails,) {
  return Column(
    children: [
      CustomText(
        txtTitle: jobId,
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
      CustomText(
        txtTitle: jobDetails,
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontWeight: FontWeight.w400,
            ),
      )
    ],
  );
}
