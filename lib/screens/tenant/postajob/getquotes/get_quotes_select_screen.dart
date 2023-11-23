//-------------------------------- Get Quotes Select Screen -----------------------//

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/tenant/postajob/post_a_job_screen.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/common_outline_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class GetQuoteSelectScreen extends StatefulWidget {
  const GetQuoteSelectScreen({super.key});

  @override
  State<GetQuoteSelectScreen> createState() => _GetQuoteSelectScreenState();
}

class _GetQuoteSelectScreenState extends State<GetQuoteSelectScreen> {
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
      Quotestype: StaticString.mLewisPlumbing,
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
//-------------------------------------- UI ---------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticString.postAJob),
        backgroundColor: ColorConstants.custDarkPurple662851,
      ),
      body: _buildBody(context),
    );
  }

  SafeArea _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: Column(
          children: [
            const SizedBox(height: 35),
            //Alert Message Card
            _alertMsgCard(context),
            const SizedBox(height: 35),
            //Showing Results And Select All Text
            _buildShowingResultsAndSelectAll(),
            //Get Quotes Card
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
                            !quotationList[index].showingResultSelect;
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
            const SizedBox(height: 30),
            //Back And Get Quotes Button
            _buildBackAndGetQuotesButton(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

//------------------------------------ Widgets ------------------------------------//

//----------------------------------- Ok Button ------------------------------------/

  Widget _builOkBtn(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: CommonElevatedButton(
            color: ColorConstants.custDarkYellow838500,
            bttnText: StaticString.ok.toUpperCase(),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

//---------------------------- BottomSheet Successfully Sent -----------------------/

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

//------------------------------ Back And GetQuotes Button -------------------------/

  Widget _buildBackAndGetQuotesButton() {
    return Row(
      children: [
        Expanded(
          child: CommonOutlineElevatedButton(
            borderColor: ColorConstants.custGrey707070,
            bttnText: StaticString.back,
            textColor: ColorConstants.custGrey707070,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const PostAJobScreen(),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: CommonElevatedButton(
            bttnText: StaticString.getQoutes,
            color: ColorConstants.custDarkGreen838500,
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
//---------------------------------- GetQuotes Card --------------------------------/

  Widget getQuotesCard(
    GetQuotesModel getQuotesModel,
    BuildContext context,
    void Function() onTap,
    void Function() heartOntap,
  ) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 23,
                  height: 23,
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
                const SizedBox(width: 15),
                CustomText(
                  txtTitle: getQuotesModel.Quotestype,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custDarkPurple662851,
                      ),
                ),
              ],
            ),
            CustomText(
              txtTitle: "1.6 miles",
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w500,
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
                const SizedBox(width: 15),
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
                            ? ColorConstants.custDarkGreen838500
                            : ColorConstants.custGrey707070,
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
      ],
    );
  }

  Widget customDivider() {
    return const Divider(
      height: 2,
      endIndent: 2,
      indent: 0,
      color: ColorConstants.custLightGreyEBEAEA,
    );
  }

//---------------------------- Showing Results And SelectAll -----------------------/

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
                color: ColorConstants.custDarkGreen838500,
              ),
              color: Colors.transparent,
            ),
            child: Center(
              child: CustomText(
                txtTitle: StaticString.selectAll,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: ColorConstants.custDarkGreen838500,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }

//--------------------------------- Alert Message Card -----------------------------/

  Widget _alertMsgCard(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
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
                child: CustomText(
                  txtTitle: StaticString.getQuoteMsg,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
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
