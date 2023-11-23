import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/constant/img_constants.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/main.dart';
import 'package:zungu_mobile/screens/tenant/Maintenance/maintenance_common_components.dart';
import 'package:zungu_mobile/screens/tenant/Maintenance/maintenance_home.dart';
import 'package:zungu_mobile/screens/tenant/my_tenancies/tenancy_detail.dart';
import 'package:zungu_mobile/widgets/bookmark_widget.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';


class TenantMaintenanceRejectedRequest extends StatefulWidget {
  const TenantMaintenanceRejectedRequest({super.key});

  @override
  State<TenantMaintenanceRejectedRequest> createState() => _TenantMaintenanceRejectedRequestState();
}
 bool isRequest = false;
class _TenantMaintenanceRejectedRequestState extends State<TenantMaintenanceRejectedRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO : remove app bar
      appBar: AppBar(
        title: const CustomText(
          txtTitle: StaticString.maintenance,
        ),
        backgroundColor: ColorConstants.custDarkPurple662851,
      ),
      body: _buildBody(),
    );
  }

   Widget _buildBody(){
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
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
                        color: ColorConstants.custPinkED2188.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: CustomText(
                        txtTitle: "REJECTED",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildAddress(address: "13 Parma House, 267 Banbury Road"),
                 
                  InkWell(
                  onTap: (){
                    _showDeleteMessage();
                  },
                  child: const CustImage(imgURL: ImgName.deleteRed,) ,
                 )
               
                ],
              ),
              buildAddressDescription(
                address: "Summertown OX2 7TH",
              ),
              const SizedBox(height: 10),
              buildBath(
                title: "Curtain Road",
               date: "27 Jun 2022",
              ),
               buildReportedDate(date: "27 Jun 2021"),
             const SizedBox(height: 10),
                buildRejectedDate(date: "20 Mar 2022"),
               const SizedBox(height: 20),
               buildRejectMassege(),
               const SizedBox(height: 25),
              buildTenantDescription(description: "Shower has a leak from the faucet, it seems like it is a washer which has deteriorated"),
               const SizedBox(height: 20),
              
            ],
          ),
    );

   }
   Future _showDeleteMessage() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      backgroundColor:ColorConstants.backgroundColorFFFFFF,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custBlack000000.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 0.2,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TODO: Exact center title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: ColorConstants.custLightGreyC6C6C6,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Align(
                    child: CustomText(
                      align: TextAlign.center,
                      txtTitle: StaticString.deleteRequest,
                      style:
                          Theme.of(context).textTheme.headline4?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.custDarkPurple150934,
                              ),
                    ),
                  ),
                ),
                Expanded(child: Container())
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                align: TextAlign.center,
              txtTitle:	"Are you sure you want to Delete this Entry? This action cannot be undone later.",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey8F8F8F,
                ),
              ),
            ),
            const SizedBox(height: 10),
            CommonElevatedButton(
              bttnText: StaticString.delete,
              color: ColorConstants.custRedE03816,
              onPressed: () {
               
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );         
      },
    );
  }

}