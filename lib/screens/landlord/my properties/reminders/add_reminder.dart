//------------------------------- Add Reminders Screen ----------------------------//

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/landlord/my%20properties/reminders/my_reminders_details.dart';
import 'package:zungu_mobile/screens/landlord/my%20properties/reminders/select_this_property_screen.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/date_selector.dart';
import 'package:zungu_mobile/widgets/image_upload_widget.dart';
import 'package:zungu_mobile/widgets/lenear_container.dart';

import '../../../../../utils/custom_extension.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
//------------------------------------ Variables ----------------------------------//
  final urlImages = [
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
  ];

  final TextEditingController _renewalDateCtrl = TextEditingController();
  final TextEditingController _remindMeOnCtrl = TextEditingController();

  int selectedIndex = 0;
  bool isSelected = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final ValueNotifier _valueNotifier = ValueNotifier(true);

  List<Map<String, dynamic>> selectPropertyList = [
    {
      "id": 0,
      "property_title": "35 Croft Meadows",
      "property_subtitle": "Sandhurst Oxford OX1 4PH"
    },
    {
      "id": 1,
      "property_title": "40 Cherwell Drive",
      "property_subtitle": "Marston Oxford OX3 OLZ"
    }
  ];

//-------------------------------------- UI ---------------------------------------//

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 36),
          //Select Reminder Text
          _buildSelectReminder(),
          const SizedBox(height: 44),
          //Select Reminders Details
          _buildSelectReminderDetails(),
          const SizedBox(height: 64),
          //Select Property & View All Text
          _buildSelectPropertyAndViewAll(),
          const SizedBox(height: 50),
          //Selected Property ListView
          _selectPropertyListView(),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: ValueListenableBuilder(
              valueListenable: _valueNotifier,
              builder: (context, val, child) {
                return Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Renewal Date TextField
                      _buildTextFormFieldRenewalDate(),
                      const SizedBox(height: 25),
                      //Remind me on TextField
                      _buildTextFormFieldRemindMeOn(),
                      const SizedBox(height: 30),
                      //Upload Photos / Docs
                      _uploadPhotosAndDocs(),
                      const SizedBox(height: 30),
                      //Add Reminder Button
                      _buildAddReminderBtn(),
                      const SizedBox(height: 30),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
//------------------------------------- Widgets -----------------------------------//

//--------------------------------- Add Reminder Button ----------------------------/

  Widget _buildAddReminderBtn() {
    return CommonElevatedButton(
      color: ColorConstants.custBlue2AC4EF,
      bttnText: StaticString.addReminder.toUpperCase(),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const MyRemindersDetailsScreen(),
            ),
          );
        } else {
          _autovalidateMode = AutovalidateMode.always;
          _valueNotifier.notifyListeners();
        }
      },
    );
  }

//----------------------------- Selected Property ListView -------------------------/

  Widget _selectPropertyListView() {
    return SizedBox(
      height: 275,
      width: double.infinity,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: selectPropertyList.length,
        itemBuilder: (context, index) {
          isSelected = index == selectedIndex;
          return InkWell(
            onTap: () {
              if (mounted) {
                setState(() {
                  selectedIndex = index;
                });
              }
            },
            child: propertyCard(
              imageUrl:
                  "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
              propertyTitle: selectPropertyList[index]["property_title"],
              propertySubtitle: selectPropertyList[index]["property_subtitle"],
            ),
          );
        },
      ),
    );
  }

  Widget propertyCard({
    required String imageUrl,
    required String propertyTitle,
    required String propertySubtitle,
  }) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.only(top: 10, right: 7),
          decoration: BoxDecoration(
            border: Border.all(
              color: !isSelected
                  ? Colors.transparent
                  : ColorConstants.custBlue2AC4EF,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 285,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.custBlack000000.withOpacity(0.1),
                  blurRadius: 15,
                  spreadRadius: 0.2,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustImage(
                  imgURL: imageUrl,
                  height: 170,
                  cornerRadius: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 10),
                  child: CustomText(
                    txtTitle: propertyTitle,
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 6),
                  child: CustomText(
                    txtTitle: propertySubtitle,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstants.custGrey707070,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isSelected)
          const Positioned(
            right: 0,
            top: 0,
            child: CustImage(
              imgURL: ImgName.check,
              width: 30,
            ),
          )
        else
          Container(),
      ],
    );
  }

//------------------------------- TextFormField Renewal Date -----------------------/

  Widget _buildTextFormFieldRenewalDate() {
    return TextFormField(
      onTap: () {
        selectDate(
          controller: _renewalDateCtrl,
          color: ColorConstants.custDarkPurple500472,
        );
      },
      controller: _renewalDateCtrl,
      validator: (value) => value?.validateDate,
      readOnly: true,
      keyboardType: TextInputType.datetime,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: StaticString.renewalDate,
        suffixIcon: CustImage(
          width: 18,
          height: 18,
          imgURL: ImgName.commonCalendar,
        ),
      ),
    );
  }

//------------------------------- TextFormField Remind Me On -----------------------/

  Widget _buildTextFormFieldRemindMeOn() {
    return TextFormField(
      onTap: () {
        selectDate(
          controller: _remindMeOnCtrl,
          color: ColorConstants.custDarkPurple500472,
        );
      },
      controller: _renewalDateCtrl,
      validator: (value) => value?.validateDate,
      readOnly: true,
      keyboardType: TextInputType.datetime,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: StaticString.remindMeOn,
        suffixIcon: CustImage(
          width: 18,
          height: 18,
          imgURL: ImgName.commonCalendar,
        ),
      ),
    );
  }

//---------------------------------- Upload Photos / Docs --------------------------/

  Widget _uploadPhotosAndDocs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          txtTitle: StaticString.photoAndDoc,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                color: ColorConstants.custDarkBlue150934,
                fontWeight: FontWeight.w500,
              ),
        ),
        LinearContainer(
          width: MediaQuery.of(context).size.width / 8,
          color: ColorConstants.custDarkPurple662851,
        ),
        const SizedBox(
          height: 2.5,
        ),
        LinearContainer(
          width: MediaQuery.of(context).size.width / 12,
          color: ColorConstants.custBlue1EC0EF,
        ),
        const SizedBox(height: 28),
        UploadMediaWidget(
          images: const [],
          image: ImgName.landlordCamera1,
          userRole: UserRole.LANDLORD,
          imageList: (images) {
            debugPrint(images.toString());
          },
        ),
      ],
    );
  }

//------------------------------- Select Property & View All -----------------------/

  Widget _buildSelectPropertyAndViewAll() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                txtTitle: StaticString.selectProperty1,
                style: Theme.of(context).textTheme.headline2?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.custDarkPurple160935,
                    ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const SelectThisPropertyScreen(),
                    ),
                  );
                },
                child: CustomText(
                  txtTitle: StaticString.viewAll1,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custBlue2AC4EF,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearContainer(
            width: MediaQuery.of(context).size.width / 8,
            color: ColorConstants.custDarkPurple662851,
          ),
          const SizedBox(
            height: 2.5,
          ),
          LinearContainer(
            width: MediaQuery.of(context).size.width / 12,
            color: ColorConstants.custBlue2AC4EF,
          ),
        ],
      ),
    );
  }
//--------------------------------- Select Reminder Details ------------------------/

  Widget _buildSelectReminderDetails() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _customCardSelectReminde(
              "Yearly Gas\nSafety Check",
              ColorConstants.backgroundColorFFFFFF,
              ImgName.gasstove,
            ),
            _customCardSelectReminde(
              "Yearly\nPAT Testing",
              ColorConstants.backgroundColorFFFFFF,
              ImgName.wire,
            ),
            _customCardSelectReminde(
              "Energy\nPerformance",
              ColorConstants.custPinkD72DAD,
              ImgName.performance,
            ),
          ],
        ),
        const SizedBox(height: 44),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _customCardSelectReminde(
              "Electrical\nCertification",
              ColorConstants.backgroundColorFFFFFF,
              ImgName.improve,
            ),
            _customCardSelectReminde(
              "HMO\nLicensing",
              ColorConstants.backgroundColorFFFFFF,
              ImgName.guarantee,
            ),
            _customCardSelectReminde(
              "Home\nInsurance",
              ColorConstants.backgroundColorFFFFFF,
              ImgName.guarantee,
            ),
          ],
        ),
        const SizedBox(height: 44),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _customCardSelectReminde(
              "Contents\nInsurance",
              ColorConstants.backgroundColorFFFFFF,
              ImgName.shield,
            ),
            _customCardSelectReminde(
              "Public\nLiability",
              ColorConstants.backgroundColorFFFFFF,
              ImgName.liability,
            ),
            _customCardSelectReminde(
              "Employers\nLiability",
              ColorConstants.backgroundColorFFFFFF,
              ImgName.professional,
            ),
          ],
        ),
      ],
    );
  }

  Widget _customCardSelectReminde(
    String txtTitle,
    Color color,
    String img,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 90,
          child: Column(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.custBlack000000.withOpacity(0.1),
                      blurRadius: 15,
                      spreadRadius: 0.2,
                    ),
                  ],
                ),
                child: Center(
                  child: CustImage(
                    imgURL: img,
                    width: 24,
                    height: 28,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomText(
                align: TextAlign.center,
                txtTitle: txtTitle,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstants.custDarkBlue160935,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

//---------------------------------- Select Reminder -------------------------------/

  Widget _buildSelectReminder() {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            txtTitle: StaticString.selectReminder,
            style: Theme.of(context).textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.custDarkPurple160935,
                ),
          ),
          LinearContainer(
            width: MediaQuery.of(context).size.width / 8,
            color: ColorConstants.custDarkPurple662851,
          ),
          const SizedBox(
            height: 2.5,
          ),
          LinearContainer(
            width: MediaQuery.of(context).size.width / 12,
            color: ColorConstants.custBlue2AC4EF,
          ),
        ],
      ),
    );
  }
}
