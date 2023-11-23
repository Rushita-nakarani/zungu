import 'package:flutter/material.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../../../../cards/property_card.dart';
import '../../../../constant/img_font_color_string.dart';
import '../../../../utils/custom_extension.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_title_with_line.dart';
import '../../../../widgets/date_selector.dart';
import 'check_inventory_room.dart';

class LandlordTenantEndTenancy extends StatefulWidget {
  const LandlordTenantEndTenancy({super.key});

  @override
  State<LandlordTenantEndTenancy> createState() =>
      _LandlordTenantEndTenancyState();
}

class _LandlordTenantEndTenancyState extends State<LandlordTenantEndTenancy> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final ValueNotifier _valueNotifier = ValueNotifier(true);
  final TextEditingController _endDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: _buildScaffold(),
    );
  }

  Widget _buildScaffold() {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25),
              _buildPropertyCard(),
              const SizedBox(height: 25),
              _buildBottomTitle(),
              const SizedBox(height: 20),
              _buildTenantProfile(),
              const SizedBox(height: 30),
              _buildEndTenantForm(),
              const SizedBox(height: 30),
              _buildEndTenantButton(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const CustomText(
        txtTitle: StaticString.endTenancy,
      ),
      backgroundColor: ColorConstants.custDarkPurple500472,
    );
  }

  Widget _buildPropertyCard() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: PropertyCard(
        imageUrl:
            "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        propertyTitle: "24 Oxford Street",
        propertySubtitle: "London Paddington SE1 4ER",
        color: ColorConstants.custDarkPurple500472,
        bookmarkColor: ColorConstants.custLavenderB772FF,
        bookmarkText: StaticString.hmo,
        showBookmark: true,
      ),
    );
  }

  Widget _buildBottomTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: CustomTitleWithLine(
        title: StaticString.selectTenant,
        primaryColor: ColorConstants.custDarkPurple500472,
        secondaryColor: ColorConstants.custBlue1EC0EF,
      ),
    );
  }

  Widget _buildTenantProfile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            // border: Border.all(
            //   color: ColorConstants.custBlue1EC0EF,
            // ),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      border: Border.all(
                        color: ColorConstants.custBlue1EC0EF,
                      ),
                    ),
                    child: const CustImage(
                      width: 70,
                      height: 70,
                      imgURL: ImgName.zunguFloating,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const CustomText(
                    txtTitle: "Sonata Nasha",
                  )
                ],
              ),
              const Positioned(
                right: 0,
                child: CircleAvatar(
                  maxRadius: 12,
                  minRadius: 12,
                  backgroundColor: ColorConstants.custBlue1EC0EF,
                  child: Icon(
                    Icons.check,
                    color: ColorConstants.backgroundColorFFFFFF,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEndTenantForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ValueListenableBuilder(
        valueListenable: _valueNotifier,
        builder: (context, val, child) {
          return Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: _autovalidateMode,
                  onTap: () => selectDate(
                    controller: _endDateController,
                    color: ColorConstants.custDarkPurple500472,
                  ),
                  validator: (value) => value?.validateDate,
                  controller: _endDateController,
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.next,
                  cursorColor: ColorConstants.custDarkPurple500472,
                  decoration: const InputDecoration(
                    labelText: "${StaticString.endDate}*",
                    suffixIcon: CustImage(
                      imgURL: ImgName.commonCalendar,
                      imgColor: ColorConstants.custDarkPurple500472,
                      width: 24,
                    ),
                  ),
                  readOnly: true,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEndTenantButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: CommonElevatedButton(
        bttnText: StaticString.endTenancy.toUpperCase(),
        color: ColorConstants.custBlue1EC0EF,
        fontSize: 18,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            showAlert(
              context: context,
              title: StaticString.endTenancy,
              singleBtnTitle: AlertMessageString.yesEndTenancy.toUpperCase(),
              showIcon: false,
              singleBtnColor: ColorConstants.custChartRed,
              message: AlertMessageString.endTenancyConf,
              onRightAction: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const LandlordTenantCheckInventoryRoom(),
                  ),
                );
              },
            );
          } else {
            _autovalidateMode = AutovalidateMode.always;

            _valueNotifier.notifyListeners();
          }
        },
      ),
    );
  }
}
