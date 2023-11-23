//-------------------------------- Get Quotes Screen ------------------------------//

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/string_constants.dart';
import 'package:zungu_mobile/screens/tenant/postajob/getquotes/choose_a_profession_screen.dart';
import 'package:zungu_mobile/screens/tenant/postajob/getquotes/get_quotes_select_screen.dart';
import 'package:zungu_mobile/screens/tenant/postajob/getquotes/select_a_service_screen.dart';
import 'package:zungu_mobile/screens/trades_person/my_jobs/confirmed_jobs/slider_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../../../../../utils/custom_extension.dart';
import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../utils/cust_eums.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/image_upload_widget.dart';
import '../../../../widgets/lenear_container.dart';

class PostAJobGetQuotesScreen extends StatefulWidget {
  const PostAJobGetQuotesScreen({super.key});

  @override
  State<PostAJobGetQuotesScreen> createState() =>
      _PostAJobGetQuotesScreenState();
}

class _PostAJobGetQuotesScreenState extends State<PostAJobGetQuotesScreen> {
//------------------------------------ Variables ----------------------------------//
  final urlImages = [
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
  ];

  final TextEditingController _tradesmansProfessionCtrl =
      TextEditingController();
  final TextEditingController _selectAServiceCtrl = TextEditingController();
  final TextEditingController _describeYourJobCtrl = TextEditingController();
  final TextEditingController _giveYourJobaCatchyHeadlineCtrl =
      TextEditingController();

  bool serviceModel = false;
  int selectedIndex = 0;
  bool isSelected = false;

  double _currentValue = 1;
  bool _showNotificationAlert = true;

  final ValueNotifier _notificationAlertNotifier = ValueNotifier(true);
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
    return _buildGetQuotes();
  }

  Widget _buildGetQuotes() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Alert Message Card
                if (_showNotificationAlert)
                  ValueListenableBuilder(
                    valueListenable: _notificationAlertNotifier,
                    builder: (context, value, child) {
                      return _alertMsgCard();
                    },
                  ),
                const SizedBox(height: 25),
                //Title Text
                _buildTitle(StaticString.selectProperty),
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
                  color: ColorConstants.custDarkYellow838500,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildSelectPropertyListView(),
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
                      //TradesmansProfession TextField
                      _buildTextFormFieldTradesmansProfession(),
                      const SizedBox(height: 25),
                      //SelectAService TextField
                      _buildTextFormFieldSelectService(),
                      const SizedBox(height: 25),
                      //GiveYourJobACatchyHeadLine TextField
                      _buildTextFormFieldGiveYourJobACatchyHeadLine(),
                      const SizedBox(height: 25),
                      //JobDescriptionYourJob TextField
                      _buildTextFormFieldJobDescYourJob(),
                      const SizedBox(height: 30),
                      //UrgentRequestAndSwitch
                      _buildUrgentRequestAndSwitch(),
                      const SizedBox(height: 25),
                      //SubTitle Text
                      _buildSubTitle(StaticString.selectDistance1),
                      LinearContainer(
                        width: MediaQuery.of(context).size.width / 8,
                        color: ColorConstants.custDarkPurple662851,
                      ),
                      const SizedBox(
                        height: 2.5,
                      ),
                      LinearContainer(
                        width: MediaQuery.of(context).size.width / 12,
                        color: ColorConstants.custDarkYellow838500,
                      ),
                      const SizedBox(height: 26),
                      //Slider
                      _buildSlider(),
                      const SizedBox(height: 30),
                      //UploadPhotosVideos
                      _uploadPhotosVideos(),
                      const SizedBox(height: 60),
                      _buildNextButton(),
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

//------------------------------------ Widgets ------------------------------------//

//------------------------------ Slide To Agree Button -----------------------------/

  Widget _builSlideToAgreeBtn() {
    return Stack(
      children: [
        Container(
          height: 50,
          margin: const EdgeInsets.only(
            top: 30,
            left: 25,
            right: 25,
            bottom: 50,
          ),
          child: SliderButton(
            buttonColor: ColorConstants.custDarkPurple662851,
            vibrationFlag: true,
            buttonSize: 50,
            width: MediaQuery.of(context).size.width,
            highlightedColor: ColorConstants.custDarkYellow838500,
            baseColor: Colors.white,
            alignLabel: const Alignment(0.1, 0.1),
            backgroundColor: ColorConstants.custDarkYellow838500,
            action: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  //GetQuoteSelectScreen
                  builder: (ctx) => const GetQuoteSelectScreen(),
                ),
              );
            },
            label: Text(
              StaticString.slidetoAgree.toUpperCase(),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 1,
                    wordSpacing: 2,
                  ),
            ),
            icon: const Icon(
              Icons.navigate_next,
              color: ColorConstants.custGreen3CAC71,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }

//------------------------- BottomSheet TheSmallPrint Action -----------------------/

  Widget _bottomSheetTheSmallPrintAction(context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorConstants.backgroundColorFFFFFF,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: ColorConstants.custgreyE0E0E0,
                  ),
                  color: ColorConstants.custgreyE0E0E0,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: CustomText(
                  txtTitle: StaticString.smallPrint,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.custDarkPurple150934,
                      ),
                ),
              ),
              Container(),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: CustomText(
              align: TextAlign.center,
              txtTitle: StaticString.theSmallPrintDetails,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custGrey707070,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          const SizedBox(height: 25),
          //SlideToAgreeBtn
          _builSlideToAgreeBtn(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

//----------------------------------- Next button ----------------------------------/

  Widget _buildNextButton() {
    return CommonElevatedButton(
      color: ColorConstants.custDarkYellow838500,
      bttnText: StaticString.next1.toUpperCase(),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return _bottomSheetTheSmallPrintAction(context);
            },
          );
        } else {
          _autovalidateMode = AutovalidateMode.always;
          _valueNotifier.notifyListeners();
        }
      },
    );
  }

//------------------------------- Upload Photos / videos ---------------------------/

  Widget _uploadPhotosVideos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          txtTitle: StaticString.uploadPhotosVideos,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: ColorConstants.custDarkBlue150934,
                fontWeight: FontWeight.w400,
              ),
        ),
        const SizedBox(height: 20),
        UploadMediaWidget(
          images: const [],
          color: ColorConstants.custDarkPurple662851,
          image: ImgName.tenantCamera,
          userRole: UserRole.TENANT,
          imageList: (images) {
            debugPrint(images.toString());
          },
        ),
      ],
    );
  }
//----------------------------------- Slider - miles -------------------------------/

  Widget _buildSlider() {
    return Row(
      children: [
        Expanded(
          child: Slider(
            value: _currentValue,
            min: 1,
            max: 100,
            onChanged: (selectedValue) {
              if (mounted) {
                setState(() {
                  _currentValue = selectedValue;
                });
              }
            },
            activeColor: ColorConstants.custDarkYellow838500,
            thumbColor: ColorConstants.custDarkYellow838500,
            inactiveColor: ColorConstants.custGreyEEEAEA,
          ),
        ),
        const SizedBox(height: 25),
        CustomText(
          txtTitle: '${_currentValue.toInt()} miles',
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: ColorConstants.custDarkYellow838500,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

//------------------------------- Urgent Request And Switch ------------------------/

  Widget _buildUrgentRequestAndSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txtTitle: StaticString.urgentRequest,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w400,
                color: ColorConstants.custDarkBlue150934,
              ),
        ),
        Switch.adaptive(
          activeColor: ColorConstants.custDarkPurple662851,
          activeTrackColor: ColorConstants.custDarkPurple662851,
          value: serviceModel,
          // _switchValue,
          onChanged: (value) {
            if (mounted) {
              setState(() {
                serviceModel = value;
              });
            }
          },
        ),
      ],
    );
  }
//-------------------------------- Job Description Your Job ------------------------/

  Widget _buildTextFormFieldJobDescYourJob() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      controller: _describeYourJobCtrl,
      validator: (value) => value?.emptyTenantDescription,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      maxLines: 5,
      decoration: const InputDecoration(
        labelText: "${StaticString.describeYourJob1}*",
      ),
    );
  }
//----------------------------- Give Your Job A Catchy Headline --------------------/

  Widget _buildTextFormFieldGiveYourJobACatchyHeadLine() {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      controller: _giveYourJobaCatchyHeadlineCtrl,
      validator: (value) => value?.emptyHeadline,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: "${StaticString.giveYourJobACatchyHeadline}*",
      ),
    );
  }

//----------------------------------- Select Service -------------------------------/

  Widget _buildTextFormFieldSelectService() {
    return TextFormField(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => SelectAServiceScreen(
              controller: _selectAServiceCtrl,
            ),
          ),
        );
      },
      controller: _selectAServiceCtrl,
      validator: (value) => value?.emptySelectAService,
      readOnly: true,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: "${StaticString.selectAService}*",
        suffixIcon: CustImage(
          width: 14,
          imgURL: ImgName.downArrow,
        ),
      ),
    );
  }

//------------------------------- Tradesmans Profession ----------------------------/

  Widget _buildTextFormFieldTradesmansProfession() {
    return TextFormField(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            //ChooseAProfessionScreen
            builder: (ctx) => ChooseAProfessionScreen(
              controller: _tradesmansProfessionCtrl,
            ),
          ),
        );
      },
      controller: _tradesmansProfessionCtrl,
      validator: (value) => value?.emptyTradesmansProfession,
      readOnly: true,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: "${StaticString.tradesmansProfession1}*",
        suffixIcon: CustImage(
          width: 14,
          imgURL: ImgName.downArrow,
        ),
      ),
    );
  }

//----------------------------- Selected Property ListView -------------------------/

  Widget _buildSelectPropertyListView() {
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
                  : ColorConstants.custDarkYellow838500,
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
              imgURL: ImgName.tenantCheckmarkCircleFilled,
              width: 30,
            ),
          )
        else
          Container(),
      ],
    );
  }

//------------------------------ SubTitle Name UrgentRequest -----------------------/

  Widget _buildSubTitle(text) {
    return CustomText(
      txtTitle: text,
      style: Theme.of(context).textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.w600,
            color: ColorConstants.custDarkPurple150934,
          ),
    );
  }
//------------------------------------ Title Name ----------------------------------/

  Widget _buildTitle(text) {
    return CustomText(
      txtTitle: text,
      style: Theme.of(context).textTheme.headline1?.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorConstants.custDarkPurple150934,
          ),
    );
  }

//-------------------------------- Alert Message Card ------------------------------/

  Widget _alertMsgCard() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorConstants.custGreyF7F7F7,
          ),
          child: Row(
            children: [
              const Expanded(
                child: CircleAvatar(
                  backgroundColor: ColorConstants.custDarkYellow838500,
                  radius: 25,
                  child: CircleAvatar(
                    backgroundColor: ColorConstants.backgroundColorFFFFFF,
                    radius: 24,
                    child: CustImage(
                      imgURL: ImgName.postajobmaintenance,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 4,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: ColorConstants.custLightGreyB9B9B9,
                            fontWeight: FontWeight.w500,
                          ),
                      children: const <TextSpan>[
                        TextSpan(
                          text:
                              'Please seek your Landlords Permission before carrying out any Private work on your Rental property, if unsure send your Landlord a',
                        ),
                        TextSpan(
                          text: ' Maintenance Request ',
                          style:
                              TextStyle(color: ColorConstants.custBlue2BCDFB),
                        ),
                        TextSpan(
                          text: ' instead ',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: -8,
          top: -8,
          child: InkWell(
            onTap: () {
              if (mounted) {
                setState(() {
                  _showNotificationAlert = false;

                  _notificationAlertNotifier.notifyListeners();
                });
              }
            },
            child: const Icon(
              Icons.cancel_sharp,
              color: ColorConstants.custGreyBDBCBC,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
