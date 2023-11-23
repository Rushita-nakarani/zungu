import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

import '../../../widgets/cust_image.dart';
import '../../../widgets/rate_star.dart';

class AwaitingQuotesJobDetailScreen extends StatefulWidget {
  const AwaitingQuotesJobDetailScreen({super.key});

  @override
  State<AwaitingQuotesJobDetailScreen> createState() =>
      _AwaitingQuotesJobDetailScreenState();
}

class _AwaitingQuotesJobDetailScreenState
    extends State<AwaitingQuotesJobDetailScreen> {
  List<GetQuotesModel> quotationList = [
    GetQuotesModel(
      Quotestype: StaticString.mLewisPlumbing,
      showingResultSelect: false,
      heartfill: true,
      starCount: 3.5,
    ),
    GetQuotesModel(
      Quotestype: StaticString.rJMurphyContractors,
      showingResultSelect: false,
      heartfill: false,
      starCount: 3.5,
    ),
    GetQuotesModel(
      Quotestype: StaticString.stolyteBathrooms,
      showingResultSelect: false,
      heartfill: false,
      starCount: 3.5,
    ),
    GetQuotesModel(
      Quotestype: StaticString.patelDrains,
      showingResultSelect: false,
      heartfill: false,
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
      heartfill: false,
      starCount: 3.5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticString.postAJob),
        backgroundColor: ColorConstants.custPurple500472,
      ),
      body: _buildBody(),
    );
  }

  SafeArea _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            _alertMsgCard(),
            const SizedBox(height: 35),
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
            const SizedBox(height: 45),
            const CommonElevatedButton(
              color: ColorConstants.custGreyBDBCBC,
              bttnText: StaticString.getMoreQuotes,
              height: 40,
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
                  txtTitle: StaticString.postAjobMsg,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ),
        const Positioned(
          right: 0,
          top: 0,
          child: Icon(
            Icons.cancel_sharp,
            color: ColorConstants.custGreyBDBCBC,
            size: 20,
          ),
        ),
      ],
    );
  }
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomText(
                          txtTitle: getQuotesModel.Quotestype,
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: ColorConstants.custPurple500472,
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
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Row(
                          children: [
                            CustomText(
                              txtTitle: StaticString.contractor,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    color: ColorConstants.custGrey707070,
                                  ),
                            ),
                            StarRating(
                              rating: getQuotesModel.starCount,
                              size: 14,
                            ),
                            const SizedBox(width: 5),
                            CustomText(
                              txtTitle:
                                  "(${getQuotesModel.starCount.toString()})",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    color: ColorConstants.custGrey707070,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: getQuotesModel.showingResultSelect
                            ? Row(
                                children: [
                                  InkWell(
                                    onTap: onTap,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 1,
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorConstants.custGreyBDBCBC,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: CustomText(
                                          txtTitle: StaticString.select,
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
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
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
