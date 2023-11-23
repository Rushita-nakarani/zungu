import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/landlord/maintenance/allocatedjob_tabview_screen.dart';
import 'package:zungu_mobile/screens/landlord/maintenance/get_quotes_screen.dart';
import 'package:zungu_mobile/screens/landlord/maintenance/reject_request_screen.dart';
import 'package:zungu_mobile/screens/landlord/maintenance/trades_person_profession_screen.dart';
import 'package:zungu_mobile/screens/landlord/maintenance/trades_person_select_service.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/common_outline_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/custom_title_with_line.dart';
import 'package:zungu_mobile/widgets/date_selector.dart';
import 'package:zungu_mobile/widgets/range_time_selector.dart';

import '../../../utils/cust_eums.dart';
import '../../../utils/custom_extension.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/image_upload_widget.dart';
import 'edit_description_popup.dart';

class MaintainanceReuestDetails extends StatefulWidget {
  const MaintainanceReuestDetails({super.key});

  @override
  State<MaintainanceReuestDetails> createState() =>
      _MaintainanceReuestDetailsState();
}

class _MaintainanceReuestDetailsState extends State<MaintainanceReuestDetails> {
  bool isReadmore = true;
  String firstHalf = "";
  bool isIssue = false;
  bool isUrgentRequest = false;
  double currentSliderValue = 5;
  List<String> uploadPhotoList = [];
  String? category;
  List<String> categoryList = ["Landlord Will Fix", "Resi Renovations"];

  final TextEditingController selectanOptionController =
      TextEditingController();
  final TextEditingController availableDateController = TextEditingController();
  final TextEditingController availableTimeController = TextEditingController();
  final TextEditingController tradesmanProffessionController =
      TextEditingController();
  final TextEditingController selectSrviceController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier _deleteNotifier = ValueNotifier(true);
  DateTime? paymentDate;
  String secondHalf = "";
  @override
  void initState() {
    if (StaticString.serversLocated.length > 50) {
      firstHalf = StaticString.tenantdescription.substring(0, 50);
      secondHalf = StaticString.tenantdescription.substring(
        50,
        StaticString.tenantdescription.length,
      );
    } else {
      firstHalf = StaticString.tenantdescription;
      secondHalf = "";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticString.maintainanceRequestDetails),
        backgroundColor: ColorConstants.custPurple500472,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              _sliderView(),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      txtTitle: "121 Cowley Road",
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    CustomText(
                      txtTitle: "Littlemore Oxford OX4 4PH",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.custGrey707070,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(7),
                          decoration: const BoxDecoration(
                            color: ColorConstants.custLightBlueF5F9FA,
                          ),
                          child: const CustImage(
                            imgURL: ImgName.bathTub1,
                          ),
                        ),
                        const SizedBox(width: 10),
                        CustomText(
                          txtTitle: StaticString.showerLeak,
                          style:
                              Theme.of(context).textTheme.headline1?.copyWith(
                                    color: ColorConstants.custskyblue22CBFE,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: CustomText(
                            txtTitle: StaticString.reported,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      color: ColorConstants.custGrey707070,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: ColorConstants.custLightBlueF5F9FA,
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: CustImage(
                                  imgURL: ImgName.greenCalender,
                                ),
                              ),
                              const SizedBox(width: 5),
                              CustomText(
                                txtTitle: "15/2/2021",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                      color: ColorConstants.custGrey707070,
                                      height: 1,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomText(
                        txtTitle: "Tenant Description",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    if (secondHalf.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(firstHalf),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: isReadmore
                                    ? ("$firstHalf...")
                                    : (firstHalf + secondHalf),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.custGrey707070,
                                    ),
                              ),
                              TextSpan(
                                text: isReadmore ? "Show more" : "Show less",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (mounted) {
                                      setState(() {
                                        isReadmore = !isReadmore;
                                      });
                                    }
                                  },
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                      color: ColorConstants.custskyblue22CBFE,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 30),
                    _tenantDetailsCard(
                      personName: "Sonata Nasha",
                      title: "TENANT",
                      onTap: () {
                        showAlert(
                          context: context,
                          title: StaticString.editDescription,
                          showIcon: false,
                          showCustomContent: true,
                          hideButton: true,
                          content: const EditDescriptionPopup(),
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          txtTitle: StaticString.fixIssue,
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
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
                    if (isIssue) issueMySelfCard() else getQuotesCard(),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: CommonOutlineElevatedButton(
                            borderColor: ColorConstants.custPurple500472,
                            bttnText: StaticString.rejectRequest,
                            fontSize: 18,
                            onPressed: () {
                              showAlert(
                                context: context,
                                title: StaticString.reasonOfReject,
                                showIcon: false,
                                showCustomContent: true,
                                content: const ReasonOFRejectPopup(),
                                hideButton: true,
                              );
                            },
                            textColor: ColorConstants.custPurple500472,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        if (isIssue)
                          Expanded(
                            child: CommonElevatedButton(
                              bttnText: StaticString.confirmJob,
                              color: ColorConstants.custskyblue22CBFE,
                              fontSize: 18,
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) =>
                                        const AllocatedJobTabViewScreen(
                                      isTabbar: false,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        else
                          Expanded(
                            child: CommonElevatedButton(
                              bttnText: StaticString.getQutes,
                              color: ColorConstants.custskyblue22CBFE,
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => const GetQuotesScreen(),
                                  ),
                                );
                              },
                              fontSize: 18,
                            ),
                          )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getQuotesCard() {
    return Column(
      children: [
        const SizedBox(height: 30),
        const CustomTitleWithLine(
          title: StaticString.getaQuote,
          primaryColor: ColorConstants.custPurple500472,
          secondaryColor: ColorConstants.custskyblue22CBFE,
        ),
        const SizedBox(height: 30),
        TextFormField(
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
          decoration: const InputDecoration(
            labelText: StaticString.tradesmansProfession,
            hintText: StaticString.plumber,
            suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
          ),
        ),
        const SizedBox(height: 30),
        TextFormField(
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
          decoration: const InputDecoration(
            labelText: StaticString.selectService,
            hintText: StaticString.plumbingMaintenance,
            suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
          ),
        ),
        const SizedBox(height: 30),
        Row(
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
              value: isUrgentRequest,
              thumbColor: MaterialStateProperty.all(
                ColorConstants.custGrey707070,
              ),
              onChanged: (value) {
                if (mounted) {
                  setState(() {
                    isUrgentRequest = value;
                  });
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        const CustomTitleWithLine(
          title: StaticString.selectDistance,
          primaryColor: ColorConstants.custPurple500472,
          secondaryColor: ColorConstants.custskyblue22CBFE,
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: Slider(
                thumbColor: ColorConstants.custDarkBlue150934,
                inactiveColor: ColorConstants.custGrey707070,
                activeColor: ColorConstants.custskyblue22CBFE,
                value: currentSliderValue,
                max: 50,
                min: 5,
                label: currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    currentSliderValue = value;
                  });
                },
              ),
            ),
            Text(
              "${currentSliderValue.toStringAsFixed(0)} Miles",
            ),
          ],
        ),
      ],
    );
  }

  Widget _sliderView() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider.builder(
              options: CarouselOptions(
                height: 160,
                enlargeCenterPage: true,
                autoPlay: true,
              ),
              itemCount: 5,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 15,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color:
                                  ColorConstants.custBlue2A00FF.withOpacity(.5),
                            ),
                            child: CustomText(
                              txtTitle: StaticString.tenant,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    color: ColorConstants.custWhiteF9F9F9,
                                  ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: ColorConstants.custPureRedFF0000
                                  .withOpacity(.5),
                            ),
                            child: CustomText(
                              txtTitle: StaticString.urgent,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    color: ColorConstants.custWhiteF9F9F9,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget issueMySelfCard() {
    return Form(
      key: _formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // TextFormField(
          //   autovalidateMode: autovalidateMode,
          //   controller: selectanOptionController,
          //   decoration: const InputDecoration(
          //     labelText: StaticString.selectanOption,
          //     suffixIcon: Icon(
          //       Icons.keyboard_arrow_down_rounded,
          //       size: 30,
          //       color: ColorConstants.custGrey707070,
          //     ),
          //   ),
          // ),
          DropdownButtonFormField(
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            items: categoryList.map((String category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() => category = newValue.toString());
            },
            value: categoryList[0],
            // decoration: const InputDecoration(

            //     // contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            //     // filled: true,
            //     // fillColor: Colors.grey[200],
            //     //  hintText: Localization.of(context).category,
            //     //  errorText: errorSnapshot.data == 0 ? Localization.of(context).categoryEmpty : null,),
            //     ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            autovalidateMode: autovalidateMode,
            controller: availableDateController,
            validator: (value) => value?.validateDate,
            onTap: () async {
              paymentDate = await selectDate(
                initialDate: paymentDate,
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
          const SizedBox(height: 30),
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
          const SizedBox(height: 30),
          if (category == categoryList[1])
            TextFormField(
              autovalidateMode: autovalidateMode,
              controller: availableTimeController,
              decoration: const InputDecoration(
                labelText: StaticString.jobPricee,
                suffixIcon: CustImage(
                  width: 24,
                  imgURL: ImgName.landlordIncome,
                ),
              ),
            )
          else
            const SizedBox(height: 0),
          const SizedBox(height: 30),
          CustomText(
            txtTitle: StaticString.uploadPhotosVideo,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(height: 14),
          UploadMediaWidget(
            images: const [],
            image: ImgName.landlordCamera,
            userRole: UserRole.LANDLORD,
            imageList: (images) {
              debugPrint(images.toString());
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _tenantDetailsCard({
    String? title,
    String? personName,
    void Function()? onTap,
  }) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
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
      child: Row(
        children: [
          // Tenant Person Image
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: const CustImage(
                    imgURL: ImgName.tenantPersonImage,
                    height: 60,
                    width: 60,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.custGrey707070.withOpacity(0.60),
                  // color: propertyListModel.offerType == "TO LET" && isDeleted
                  //     ? ColorConstants.custGrey707070.withOpacity(0.60)
                  //     : null,
                ),
              ),
            ],
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TENANT Text
                CustomText(
                  txtTitle: title,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                // tenant person name text
                CustomText(
                  txtTitle: personName, // propertyList.tenantName,
                  textOverflow: TextOverflow.ellipsis,
                  maxLine: 1,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w400,
                      ),
                )
              ],
            ),
          ),

          // Tenant rent card
          InkWell(
            onTap: onTap,
            child: Container(
              width: 115,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(65),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: ColorConstants.custPurple500472,
                //propertyList.offerColor
              ),
              child: const CustImage(
                imgURL: ImgName.editIcon,
                imgColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
