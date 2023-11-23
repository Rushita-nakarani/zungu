import 'package:flutter/material.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../../../constant/img_font_color_string.dart';
import '../../../widgets/custom_text.dart';
import 'add_current_tenancy_screen.dart';

class TenantMyTenancyAddTenancy extends StatelessWidget {
  const TenantMyTenancyAddTenancy({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(title: StaticString.myTenancies),
      backgroundColor: ColorConstants.backgroundColorFFFFFF,
      body: SingleChildScrollView(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const AddCurrentTenancyScreen(),
              ),
            );
          },
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ColorConstants.custDarkYellow838500,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ColorConstants.backgroundColorFFFFFF,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const CustImage(
                          width: 30,
                          imgURL: ImgName.tenantAddTenancy,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: const CustomText(
                          txtTitle: StaticString.addTenancy,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                            color: ColorConstants.backgroundColorFFFFFF,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomText(
                    txtTitle:
                        "You can add your Own Tenancy if the Landlord isn’t a client of ours.",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstants.backgroundColorFFFFFF,
                        ),
                  ),
                  const SizedBox(height: 20),
                  CustomText(
                    txtTitle:
                        "You can also keep a Track of all your Previous Tenancies in one place. Search, Find & Secure Rental properties using Zungu Search without ever having to leave the APP.",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstants.backgroundColorFFFFFF,
                        ),
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward,
                      color: ColorConstants.backgroundColorFFFFFF,
                      size: 30,
                    ),
                  ),
                  // const CustImage(
                  //   width: 20,
                  //   imgURL: ImgName.tenantAddTenancy,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar({required String title}) {
    return AppBar(
      title: CustomText(
        txtTitle: title,
      ),
      backgroundColor: ColorConstants.custDarkPurple662851,
    );
  }
}
