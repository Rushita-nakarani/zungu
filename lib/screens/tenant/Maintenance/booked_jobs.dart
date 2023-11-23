import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/tenant/Maintenance/maintenance_common_components.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class TenantMaintenanceBookedJobs extends StatefulWidget {
  const TenantMaintenanceBookedJobs({super.key});

  @override
  State<TenantMaintenanceBookedJobs> createState() =>
      TenantMaintenanceBookedJobsState();
}

class TenantMaintenanceBookedJobsState
    extends State<TenantMaintenanceBookedJobs> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return newBookedJobCard();
      },
    );
  }

  Widget newBookedJobCard() {
    return Padding(
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
                    "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
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
                    color: ColorConstants.custGreen1ACF72.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: CustomText(
                    txtTitle: "JOB CONFIRMED",
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
          buildAddress(address: "121 Cowley Road"),
          // buildJobIdNumber(jobId: "#YQ6CA040521"),
          //buildInvoiceNumber(invoiceNumber: "#1CN4627"),
          buildAddressDescription(
            address: "Littlemore Oxford OX4 3TH",
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
          buildContractorName(contractorName: "Landlord Will Come to Fix"),
          buildJobDate(date: "29 Apr 2022"),
          const SizedBox(height: 5),
          buildJobTime(time: '13:30 - 14:30'),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
