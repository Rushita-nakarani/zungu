import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';

import '../../../../utils/custom_extension.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/common_widget.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/date_selector.dart';

class LandlordTenantsEndTenancyScreen extends StatefulWidget {
  const LandlordTenantsEndTenancyScreen({super.key});

  @override
  State<LandlordTenantsEndTenancyScreen> createState() =>
      _LandlordTenantsEndTenancyScreenState();
}

class _LandlordTenantsEndTenancyScreenState
    extends State<LandlordTenantsEndTenancyScreen> {
  //-------------------------------variable----------------------------//

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _endDateController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  DateTime? endDate;
  //-------------------------------Ui----------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  //-----------------------------Widgets------------------------//

  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: ColorConstants.custDarkPurple500472,
      title: const Text(StaticString.endTenancy),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 30),
        child: GestureDetector(
          onTap: () {
            final FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                //Home  view Details card
                _homeViewDetailsCard(),
                const SizedBox(height: 10),

                // Select Tenant theader text and details
                _selectTenant(),

                // End date textfield
                _endDateTextfield(),
                const SizedBox(height: 20),

                //log payment elavated button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CommonElevatedButton(
                    bttnText: StaticString.endTenancyCapital,
                    color: ColorConstants.custBlue1EC0EF,
                    fontSize: 14,
                    onPressed: endTenancyBtnAction,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Home  view Details card
  Widget _homeViewDetailsCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
            blurRadius: 12,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: const CustImage(
              height: 170,
              width: double.infinity,
              imgURL:
                  "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
            ),
          ),
          const SizedBox(height: 15),
          CustomText(
            txtTitle: "40 Chewewell Drive",
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  color: ColorConstants.custDarkBlue150934,
                  fontWeight: FontWeight.w700,
                ),
          ),
          CustomText(
            txtTitle: "Marston Oxford OX3 OLZ",
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: ColorConstants.custGrey707070,
                  fontWeight: FontWeight.w500,
                ),
          )
        ],
      ),
    );
  }

  Padding _selectTenant() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: commonHeaderLable(
        title: StaticString.selectTenant,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image Card
            _profileImageCard(context),
            const SizedBox(height: 10),

            // Person Name Text
            CustomText(
              txtTitle: StaticString.sonataNasha,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    color: ColorConstants.custGrey707070,
                    fontWeight: FontWeight.w400,
                  ),
            )
          ],
        ),
      ),
    );
  }

  // Profile Image Card
  Widget _profileImageCard(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 80,
          width: 80,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorConstants.custBlue1EC0EF,
            ),
          ),
          child: const ClipOval(
            child: CustImage(
              boxfit: BoxFit.contain,
              imgURL: ImgName.tenantPersonImage,
              height: 70,
              width: 70,
            ),
          ),
        ),
        // Positioned(
        //   top: MediaQuery.of(context).size.height * 0.01,
        //   left: MediaQuery.of(context).size.height * 0.008,
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.circular(100),
        //     child: const CustImage(
        //       imgURL: ImgName.tenantPersonImage,
        //       height: 70,
        //       width:70,
        //     ),
        //   ),
        // ),
        Positioned(
          right: MediaQuery.of(context).size.height * 0.006,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConstants.custBlue1EC0EF,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 13,
            ),
          ),
        )
      ],
    );
  }

  // End date textfield
  Widget _endDateTextfield() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: TextFormField(
        readOnly: true,
        autovalidateMode: _autovalidateMode,
        validator: (value) => value?.validateEmpty,
        controller: _endDateController,
        keyboardType: TextInputType.datetime,
        decoration: const InputDecoration(
          labelText: StaticString.endDate,
          suffixIcon: CustImage(
            width: 20,
            imgURL: ImgName.calendar,
            imgColor: ColorConstants.custDarkPurple500472,
          ),
        ),
        onTap: () async {
          endDate = await selectDate(
            initialDate: endDate,
            controller: _endDateController,
            color: ColorConstants.custDarkPurple500472,
          );
        },
      ),
    );
  }

  //----------------------------button action-------------------------//
  void endTenancyBtnAction() {
    if (mounted) {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
    if (_formKey.currentState!.validate()) {
      final FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }
  }
}
