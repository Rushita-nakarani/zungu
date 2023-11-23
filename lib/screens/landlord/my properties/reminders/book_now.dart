//---------------------------------- Book Now Screen -------------------------------//

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zungu_mobile/widgets/calender_card_withshadow.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/common_outline_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/lenear_container.dart';
import 'package:zungu_mobile/widgets/rounded_lg_shape_widget.dart';

import '../../../../constant/img_font_color_string.dart';

class BookNowScreen extends StatefulWidget {
  const BookNowScreen({super.key});

  @override
  State<BookNowScreen> createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  //------------------------------------ Variables ----------------------------------//

  double _currentValue = 1;

  List<GetQuotesModel> quotationList = [
    GetQuotesModel(
      Quotestype: StaticString.mLewisPlumbing,
      showingResultSelect: true,
      heartfill: true,
      starCount: 3.5,
    ),
    GetQuotesModel(
      Quotestype: StaticString.aleesaGasHeating,
      showingResultSelect: true,
      heartfill: true,
      starCount: 3.5,
    ),
    GetQuotesModel(
      Quotestype: StaticString.aleyahBathroomFitters,
      showingResultSelect: true,
      heartfill: true,
      starCount: 3.5,
    ),
    GetQuotesModel(
      Quotestype: StaticString.rJMurphyContractors,
      showingResultSelect: true,
      heartfill: true,
      starCount: 3.5,
    ),
    GetQuotesModel(
      Quotestype: StaticString.stolyteBathrooms,
      showingResultSelect: true,
      heartfill: true,
      starCount: 3.5,
    ),
    GetQuotesModel(
      Quotestype: StaticString.patelDrains,
      showingResultSelect: true,
      heartfill: true,
      starCount: 3.5,
    ),
  ];

  //-------------------------------------- UI ----------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }
//------------------------------------- Widgets -----------------------------------//

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildTitle(),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBookNowDetailsCard(),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
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
                          color: ColorConstants.custBlue1EC0EF,
                        ),
                        const SizedBox(height: 14),
                        //Slider
                        _buildSlider(),
                        const SizedBox(height: 38),
                        //Showing Results And Select All Text
                        _buildShowingResultsAndSelectAll(),
                        const SizedBox(height: 24),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: quotationList.length,
                          itemBuilder: (context, index) {
                            return getQuotesCard(
                              quotationList[index],
                              context,
                              () {
                                if (mounted) {
                                  setState(() {
                                    quotationList[index].showingResultSelect =
                                        !quotationList[index]
                                            .showingResultSelect;
                                  });
                                }
                              },
                              () {
                                if (mounted) {
                                  setState(() {
                                    quotationList[index].heartfill =
                                        !quotationList[index].heartfill;
                                  });
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 50),
                        _buildBackAndGetQuotesButton(),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getQuotesCard(
    GetQuotesModel getQuotesModel,
    BuildContext context,
    void Function() onTap,
    void Function() heartOntap,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 21,
                  height: 21,
                  child: InkWell(
                    onTap: heartOntap,
                    child: CustImage(
                      height: 25,
                      width: 25,
                      imgURL: getQuotesModel.heartfill
                          ? ImgName.heartOutlineIcon
                          : ImgName.fillheartinvoicesicon,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CustomText(
                  txtTitle: getQuotesModel.Quotestype,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custPurple500472,
                      ),
                ),
              ],
            ),
            CustomText(
              txtTitle: "1.6 miles",
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.custGrey707070,
                  ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 23,
                  child: Container(),
                ),
                const SizedBox(width: 8),
                CustomText(
                  txtTitle: StaticString.contractor,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
                const SizedBox(width: 6),
                SizedBox(
                  child: RatingBar.builder(
                    initialRating: 5,
                    minRating: 5,
                    allowHalfRating: true,
                    unratedColor: ColorConstants.custGreyEBEAEA,
                    itemSize: 12.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                    updateOnDrag: true,
                    itemBuilder: (context, index) => Container(
                      color: Colors.amber,
                      child: const Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                    ),
                    onRatingUpdate: (value) {
                      if (mounted) {
                        setState(() {});
                      }
                    },
                  ),
                ),
                const SizedBox(width: 6),
                CustomText(
                  txtTitle: "(${getQuotesModel.starCount.toString()})",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 80,
                  child: InkWell(
                    onTap: onTap,
                    child: Container(
                      decoration: BoxDecoration(
                        color: getQuotesModel.showingResultSelect
                            ? ColorConstants.custBlue1EC0EF
                            : ColorConstants.custGreyBDBCBC,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: CustomText(
                          txtTitle: getQuotesModel.showingResultSelect
                              ? StaticString.select
                              : StaticString.selected,
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: ColorConstants.backgroundColorFFFFFF,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        const SizedBox(height: 15),
        customDivider(),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget customDivider() {
    return const Divider(
      height: 2,
      endIndent: 2,
      indent: 0,
    );
  }
//---------------------------------- Ok Button --------------------------------------/

  Widget _builOkBtn(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: CommonElevatedButton(
            color: ColorConstants.custBlue1EC0EF,
            bttnText: StaticString.ok.toUpperCase(),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
//-------------------------- BottomSheet Successfully Sent --------------------------/

  Widget _bottomSheetSuccessfullySent(context) {
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
          const SizedBox(height: 30),
          CustomText(
            txtTitle: StaticString.successfullySent,
            style: Theme.of(context).textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.custDarkPurple150934,
                ),
          ),
          const SizedBox(height: 45),
          const CustImage(
            imgURL: ImgName.postajobcheck,
          ),
          const SizedBox(height: 45),
          Padding(
            padding: const EdgeInsets.only(left: 45, right: 45),
            child: CustomText(
              align: TextAlign.center,
              txtTitle: StaticString.sentMsg,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custGrey707070,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          const SizedBox(height: 30),
          _builOkBtn(context),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

//---------------------------- Back And GetQuotes Button ----------------------------/

  Widget _buildBackAndGetQuotesButton() {
    return Row(
      children: [
        Expanded(
          child: CommonOutlineElevatedButton(
            borderColor: ColorConstants.custGrey707070,
            bttnText: StaticString.cancel,
            textColor: ColorConstants.custGrey707070,
            onPressed: () {},
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: CommonElevatedButton(
            bttnText: StaticString.getQoutes,
            color: ColorConstants.custBlue27C3EF,
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return _bottomSheetSuccessfullySent(context);
                },
              );
            },
          ),
        )
      ],
    );
  }
  //---------------------------------- Showing Results Select All --------------------------/

  Widget _buildShowingResultsAndSelectAll() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txtTitle: StaticString.showingResults,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                color: ColorConstants.custGrey707070,
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(
          height: 20,
          width: 80,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: ColorConstants.custPurple500472,
              ),
              color: Colors.transparent,
            ),
            child: Center(
              child: CustomText(
                txtTitle: StaticString.selectAll,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: ColorConstants.custPurple500472,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }

//----------------------------- SubTitle Select Distance ----------------------------/
  Widget _buildSubTitle(text) {
    return CustomText(
      txtTitle: text,
      style: Theme.of(context).textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.w600,
            color: ColorConstants.custDarkPurple150934,
          ),
    );
  }

//--------------------------------- Slider - miles ----------------------------------/
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
            activeColor: ColorConstants.custBlue1EC0EF,
            thumbColor: ColorConstants.custPurple500472,
            inactiveColor: ColorConstants.custGreyEEEAEA,
          ),
        ),
        CustomText(
          txtTitle: '${_currentValue.toInt()} Miles',
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: ColorConstants.custGrey707070,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

//------------------------------ Book Now Details Card ------------------------------/

  Widget _buildBookNowDetailsCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
            Material(
              type: MaterialType.transparency,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: const CustImage(
                  height: 200,
                  width: double.infinity,
                  imgURL:
                      "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    txtTitle: "3 Bed Detached House",
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          color: ColorConstants.custDarkPurple160935,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  CustomText(
                    txtTitle: "25 Marylebone Road, London EC71 OBE",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ColorConstants.custGrey8A8A8A,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _renewalAndRemindCalRow(
                renewalDate: "28",
                renewalDateMonth: "Jun 2022",
                remindMeOnDate: "27",
                remindMeOnDateMonth: "Jun 2022",
                bgColor: ColorConstants.custLightGreenE4FEE2,
              ),
            ],
          ),
        )
      ],
    );
  }

  // Renewal Date and Remind me row
  Widget _renewalAndRemindCalRow({
    required String renewalDate,
    required String renewalDateMonth,
    required String remindMeOnDate,
    required String remindMeOnDateMonth,
    required Color bgColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: CommonCalenderCardWithShadow(
              bgColor: ColorConstants.backgroundColorFFFFFF,
              calenderUrl: ImgName.commonCalendar,
              date: renewalDate,
              dateMonth: renewalDateMonth,
              title: StaticString.renewalDate1,
              imgColor: ColorConstants.custDarkPurple500472,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: CommonCalenderCardWithShadow(
              bgColor: ColorConstants.backgroundColorFFFFFF,
              calenderUrl: ImgName.commonCalendar,
              date: remindMeOnDate,
              dateMonth: remindMeOnDateMonth,
              title: StaticString.remindMeOn,
              imgColor: ColorConstants.custDarkPurple500472,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: const [
        SizedBox(
          width: double.infinity,
          child: RoundedLgShapeWidget(
            color: ColorConstants.custPurple500472,
            title: StaticString.yearlyGasSafetyCheck,
          ),
        ),
      ],
    );
  }
}
//------------------------------------- AppBar --------------------------------------/

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: ColorConstants.custPurple500472,
    title: const CustomText(
      txtTitle: StaticString.bookNow,
    ),
  );
}

class GetQuotesModel {
  final String Quotestype;
  bool showingResultSelect;
  bool heartfill;
  final double starCount;
  GetQuotesModel({
    required this.Quotestype,
    required this.showingResultSelect,
    required this.heartfill,
    required this.starCount,
  });
}
