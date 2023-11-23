import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/landlord/maintenance/trades_person_select_service.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/custom_title_with_line.dart';

import '../../../utils/cust_eums.dart';
import '../../../utils/custom_extension.dart';
import '../../../widgets/cust_image.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/date_selector.dart';
import '../../../widgets/image_upload_widget.dart';
import '../../../widgets/lenear_container.dart';
import '../../../widgets/range_time_selector.dart';
import 'trades_person_profession_screen.dart';

class MaintenancePostAJobScreen extends StatefulWidget {
  const MaintenancePostAJobScreen({super.key});

  @override
  State<MaintenancePostAJobScreen> createState() =>
      _MaintenancePostAJobScreenState();
}

class _MaintenancePostAJobScreenState extends State<MaintenancePostAJobScreen> {
  //-------------------------Widgets-----------------------//
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
  int selectedIndex = 0;
  bool isSelected = false;

  bool isIssue = false;
  bool urgentRequest = false;
  double currentSliderValue = 5;
  List<String> categoryList = ["Landlord Will Fix", "Resi Renovations"];
  String? categoroy;

  final TextEditingController tradesmanProffessionController =
      TextEditingController();
  final TextEditingController selectSrviceController = TextEditingController();
  final TextEditingController jobCatchyHeadline = TextEditingController();
  final TextEditingController jobDescription = TextEditingController();
  final TextEditingController availableDateController = TextEditingController();
  final TextEditingController availableTimeController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier _valueNotifier = ValueNotifier(true);
  DateTime? availableDate;
  //--------------------------UI--------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Alert Msg Card
            _alertMsgCard(),
            const SizedBox(height: 20),

            //Select Property text and view all button row
            _selectPropertyTextAndViewAllBtnRow(),
            const SizedBox(height: 20),

            //Selected Property ListView
            _selectPropertyListView(),
            const SizedBox(height: 50),

            //Fix Issue text and switch row
            _buildFixIssueSwitchRow(),
            const SizedBox(height: 50),

            if (isIssue) issueMySelfCard() else getQuotesCard(),

            //Give your job a catchy headline Textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: jobCatchyHeadline,
                keyboardType: TextInputType.text,
                validator: (value) => value?.validatejobHeading,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: StaticString.giveYourJobaCatchyHeadline,
                  hintText: StaticString.gasBoilerService,
                ),
              ),
            ),
            const SizedBox(height: 25),

            //Describe Your Job
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: jobDescription,
                keyboardType: TextInputType.multiline,
                validator: (value) => value?.validatejobDescription,
                maxLines: 3,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: StaticString.describeYourJob,
                ),
              ),
            ),
            const SizedBox(height: 35),

            if (isIssue)
              _buildUrgentReqSwitchRow()
            else
              _selectDistanceTextAndSliderRow(),
            const SizedBox(height: 20),

            //Upload Photos / Videos text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomText(
                txtTitle: StaticString.uploadPhotosVideos,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: ColorConstants.custDarkBlue150934),
              ),
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: UploadMediaWidget(
                images: const [],
                image: ImgName.landlordCamera,
                userRole: UserRole.LANDLORD,
                imageList: (val) {},
              ),
            ),
            const SizedBox(height: 60),

            if (isIssue)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CommonElevatedButton(
                  bttnText: StaticString.confirmJob,
                  color: ColorConstants.custBlue27C3EF,
                  onPressed: confirmJobBtnaction,
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CommonElevatedButton(
                  bttnText: StaticString.nextCapital,
                  color: ColorConstants.custBlue27C3EF,
                  onPressed: nextBtnAction,
                ),
              )
          ],
        ),
      ),
    );
  }

  //--------------------------Widget-----------------------//

  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: ColorConstants.custPurple500472,
      title: const Text(StaticString.postAJob),
      actions: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: const CustImage(
            imgURL: ImgName.capImg,
            width: 22,
          ),
        ),
      ],
    );
  }

  // Alert Message card
  Widget _alertMsgCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: ColorConstants.custGreyF8F8F8,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: ColorConstants.custGrey707070),
              color: Colors.white,
            ),
            child: const CustImage(
              imgURL: ImgName.landlordMaintenance,
              width: 36,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: CustomText(
              txtTitle: StaticString.postaJobAlertMsg,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custLightGreyB9B9B9,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          )
        ],
      ),
    );
  }

  //Select Property text and view all button row
  Widget _selectPropertyTextAndViewAllBtnRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                txtTitle: StaticString.selectProperty,
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.custDarkBlue150934,
                    ),
              ),
              InkWell(
                onTap: () => viewAllBtnaction(),
                child: CustomText(
                  // onPressed: viewAllBtnaction,
                  txtTitle: StaticString.viewAll,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custBlue1EC0EF,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          LinearContainer(
            width: MediaQuery.of(context).size.width / 7,
            color: ColorConstants.custDarkPurple500472,
          ),
          const SizedBox(
            height: 3,
          ),
          LinearContainer(
            width: MediaQuery.of(context).size.width / 11,
            color: ColorConstants.custBlue1BC4F4,
          ),
        ],
      ),
    );
  }

  //Selected Property ListView
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
                  : ColorConstants.custBlue1EC0EF,
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
              imgURL: ImgName.landlordCheckmark,
              width: 30,
            ),
          )
        else
          Container(),
      ],
    );
  }

  //Fix Issue text and switch row
  Widget _buildFixIssueSwitchRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txtTitle: StaticString.fixIssue,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          Switch.adaptive(
            activeColor: ColorConstants.custPurple500472,
            value: isIssue,
            thumbColor: MaterialStateProperty.all(
              ColorConstants.custGrey707070,
            ),
            onChanged: (value) {
              if (mounted) {
                setState(() {
                  isIssue = value;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget getQuotesCard() {
    return Column(
      children: [
        //Tradesmans Profession Textfield
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            controller: tradesmanProffessionController,
            onTap: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const TradesPersonProfession(),
                ),
              );
              if (mounted) {
                setState(() {
                  tradesmanProffessionController.text = result;
                });
              }
            },
            decoration: InputDecoration(
              labelText: StaticString.tradesmansProfession.addStarAfter,
              hintText: StaticString.plumber,
              suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
            ),
          ),
        ),
        const SizedBox(height: 25),

        //Select a Service Textfield
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            controller: selectSrviceController,
            onTap: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const LandLoardServiceScreen(),
                ),
              );
              if (mounted) {
                setState(() {
                  selectSrviceController.text = result;
                });
              }
            },
            decoration: InputDecoration(
              labelText: StaticString.selectService.addStarAfter,
              hintText: StaticString.plumbingMaintenance,
              suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
            ),
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget issueMySelfCard() {
    return Form(
      key: _formKey,
      autovalidateMode: autovalidateMode,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField(
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              items: categoryList.map((String category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (newValue) {
                if (mounted) {
                  setState(() => categoroy = newValue.toString());
                }
              },
              value: categoryList[0],
            ),
            const SizedBox(height: 25),

            //Available Date Textfield
            TextFormField(
              autovalidateMode: autovalidateMode,
              controller: availableDateController,
              validator: (value) => value?.validateDate,
              onTap: () async {
                availableDate = await selectDate(
                  initialDate: availableDate,
                  controller: availableDateController,
                  color: ColorConstants.custPurple500472,
                );
              },
              decoration: const InputDecoration(
                labelText: StaticString.availableDatestar,
                suffixIcon: CustImage(
                  width: 24,
                  imgURL: ImgName.landlordCalender,
                ),
              ),
            ),
            const SizedBox(height: 25),

            //Available timeTextfield
            TextFormField(
              autovalidateMode: autovalidateMode,
              onTap: () {
                selectRangeTime(
                  controller: availableTimeController,
                );
              },
              validator: (value) => value?.validateTimeMessage,
              controller: availableTimeController,
              decoration: const InputDecoration(
                labelText: StaticString.availableTimeStar,
                suffixIcon: CustImage(
                  width: 24,
                  imgURL: ImgName.purpleTimeIcon,
                ),
              ),
            ),
            const SizedBox(height: 25),

            //Job Price Textfield
            if (categoroy == categoryList[1])
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: TextFormField(
                  autovalidateMode: autovalidateMode,
                  controller: availableTimeController,
                  decoration: const InputDecoration(
                    labelText: StaticString.jobPricee,
                    suffixIcon: CustImage(
                      width: 24,
                      imgURL: ImgName.landlordIncome,
                    ),
                  ),
                ),
              )
            else
              const SizedBox(height: 0),
          ],
        ),
      ),
    );
  }

  Widget _selectDistanceTextAndSliderRow() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: CustomTitleWithLine(
            title: StaticString.selectDistance,
            primaryColor: ColorConstants.custPurple500472,
            secondaryColor: ColorConstants.custBlue1EC0EF,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 30),
          child: ValueListenableBuilder(
            valueListenable: _valueNotifier,
            builder: (context, val, child) {
              return Row(
                children: [
                  Expanded(
                    child: Slider(
                      thumbColor: ColorConstants.custskyblue22CBFE,
                      inactiveColor: ColorConstants.custGreyEEEAEA,
                      activeColor: ColorConstants.custskyblue22CBFE,
                      value: currentSliderValue,
                      max: 50,
                      min: 5,
                      label: currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        currentSliderValue = value;
                        _valueNotifier.notifyListeners();
                      },
                    ),
                  ),
                  CustomText(
                    txtTitle: "${currentSliderValue.toStringAsFixed(0)} Miles",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstants.custBlue1EC0EF,
                        ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  //Urgent Request text and switch row
  Widget _buildUrgentReqSwitchRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txtTitle: StaticString.urgentRequest,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          Switch.adaptive(
            activeColor: ColorConstants.custPurple500472,
            value: urgentRequest,
            thumbColor: MaterialStateProperty.all(
              ColorConstants.custGrey707070,
            ),
            onChanged: (value) {
              if (mounted) {
                setState(() {
                  urgentRequest = value;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  //--------------------------Button Action---------------------//
  void viewAllBtnaction() {}
  void nextBtnAction() {}
  void confirmJobBtnaction() {}
}
