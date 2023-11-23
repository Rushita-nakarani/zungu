import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/common_outline_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class SlideToAgreeScreen extends StatefulWidget {
  const SlideToAgreeScreen({super.key});

  @override
  State<SlideToAgreeScreen> createState() => _SlideToAgreeScreenState();
}

class _SlideToAgreeScreenState extends State<SlideToAgreeScreen> {
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
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            _alertMsgCard(),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  txtTitle: StaticString.showingResults,
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
                Container(
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
              ],
            ),
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
            Row(
              children: const [
                Expanded(
                  child: CommonOutlineElevatedButton(
                    borderColor: ColorConstants.custGrey707070,
                    bttnText: StaticString.back,
                    textColor: ColorConstants.custGrey707070,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: CommonElevatedButton(
                    bttnText: StaticString.getQoutes,
                    color: ColorConstants.custDarkGreen838500,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _alertMsgCard() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ColorConstants.custGreyF8F8F8,
          ),
          child: Row(
            children: [
              const Expanded(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: CustImage(
                    imgURL: ImgName.landlordMaintenance,
                    width: 36,
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
        // const Positioned(
        //   right: 0,
        //   top: 0,
        //   child: Icon(
        //     Icons.cancel_sharp,
        //     color: ColorConstants.custGrey707070,
        //     size: 20,
        //   ),
        // ),
      ],
    );
  }
}

Widget getQuotesCardcard(BuildContext context) {
  return Column(
    children: [
      Row(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 23,
                height: 23,
                child: CustImage(imgURL: ImgName.fillheartinvoicesicon),
              ),
              //M Lewis Plumbing
              const SizedBox(width: 15),
              CustomText(
                txtTitle: "M Lewis Plumbing",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.custDarkYellow838500,
                    ),
              ),
            ],
          ),
          CustomText(
            txtTitle: "1.6 miles",
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: ColorConstants.custGrey707070,
                ),
          )
        ],
      ),
      const SizedBox(height: 0),
      Container(
        padding: const EdgeInsets.only(left: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomText(
                  txtTitle: StaticString.contractor,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
                //Rating
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
                    onRatingUpdate: (value) {},
                  ),
                ),
                const SizedBox(width: 6),
                CustomText(
                  txtTitle: "(3.5)",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
              ],
            ),
            Row(
              children: [
                CustomText(
                  txtTitle: "£296.00",
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
      //Date completed
      const SizedBox(height: 24),
      Container(
        padding: const EdgeInsets.only(left: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              txtTitle: StaticString.dateCompleted,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custGrey707070,
                  ),
            ),
            SizedBox(
              height: 30,
              width: 100,
              child: Card(
                color: ColorConstants.custGreyF7F7F7,
                elevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CustImage(
                      imgURL: ImgName.landlordCalender,
                    ),
                    CustomText(
                      txtTitle: "15 Oct 2021",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.custGrey707070,
                          ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      //DueDate
      const SizedBox(height: 5),
      Container(
        padding: const EdgeInsets.only(left: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              txtTitle: StaticString.dueDate,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custGrey707070,
                  ),
            ),
            SizedBox(
              height: 30,
              width: 100,
              child: Card(
                color: ColorConstants.custOrangeF28E20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CustImage(
                      imgURL: ImgName.landlordCalender,
                    ),
                    CustomText(
                      txtTitle: "30 Oct 2021",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.custWhiteF7F7F7,
                          ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ],
  );
}

Widget getQuotesCard(
  GetQuotesModel getQuotesModel,
  BuildContext context,
  void Function() onTap,
  void Function() heartOntap,
) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 15,
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: heartOntap,
              child: CustImage(
                height: 25,
                width: 25,
                imgURL: getQuotesModel.heartfill
                    ? ImgName.heartOutlineIcon
                    : ImgName.fillheartinvoicesicon,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomText(
                          txtTitle: getQuotesModel.Quotestype,
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: ColorConstants.custDarkPurple662851,
                                  ),
                        ),
                      ),
                      Expanded(
                        child: CustomText(
                          txtTitle: "12.miles",
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: ColorConstants.custGrey707070,
                              ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        txtTitle: StaticString.contractor,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: ColorConstants.custGrey707070,
                            ),
                      ),
                      const SizedBox(
                        height: 25,
                        width: 30,
                      ),
                      CustomText(
                        txtTitle: getQuotesModel.starCount.toString(),
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: ColorConstants.custGrey707070,
                            ),
                      ),
                      InkWell(
                        onTap: onTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 1,
                          ),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        customDivider(),
      ],
    ),
  );
}

Widget customDivider() {
  return const Divider(
    height: 2,
    endIndent: 25,
    indent: 20,
    color: ColorConstants.custLightGreyEBEAEA,
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
