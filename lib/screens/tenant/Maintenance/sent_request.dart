import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/tenant/Maintenance/maintenance_common_components.dart';
import 'package:zungu_mobile/screens/tenant/Maintenance/sent_rejected_request.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class TenantMaintenanceSentRequest extends StatefulWidget {
  const TenantMaintenanceSentRequest({super.key});

  @override
  State<TenantMaintenanceSentRequest> createState() =>
      _TenantMaintenanceSentRequestState();
}

bool isRequest = false;

class _TenantMaintenanceSentRequestState
    extends State<TenantMaintenanceSentRequest> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //padding: const EdgeInsets.all(20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 2,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return currentTenancyCard();
        },
      ),
    );
  }

  Widget currentTenancyCard() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const TenantMaintenanceRejectedRequest(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Stack(
              children: [
                const CustImage(
                  cornerRadius: 12,
                  imgURL:
                      "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstants.custRedD7181F.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: CustomText(
                      txtTitle: "URGENT",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: ColorConstants.backgroundColorFFFFFF,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            buildAddress(address: "13 Parma House, 267 Banbury Road"),
            buildAddressDescription(
              address: "Summertown OX2 7TH",
            ),
            const SizedBox(height: 10),
            buildBath(
              title: "Shower Leak",
              date: "27 Jun 2021",
            ),
            const SizedBox(height: 20),
            buildTenantDescription(
              description:
                  "Shower has a leak from the faucet, it seems like it is a washer which has deteriorated",
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
