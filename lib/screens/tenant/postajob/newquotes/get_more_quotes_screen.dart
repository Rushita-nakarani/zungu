//------------------------------- Get More Quotes Screen --------------------------//

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class GetMoreQuotesScreen extends StatefulWidget {
  const GetMoreQuotesScreen({super.key});

  @override
  State<GetMoreQuotesScreen> createState() => _GetMoreQuotesScreenState();
}

class _GetMoreQuotesScreenState extends State<GetMoreQuotesScreen> {
  //------------------------------------ Variables ----------------------------------//

  bool _showNotificationAlert = true;
  final ValueNotifier _notificationAlertNotifier = ValueNotifier(true);

  List<GetMoreQuotesModel> quotationList = [
    GetMoreQuotesModel(
      Quotestype: StaticString.mLewisPlumbing,
      showingResultSelect: true,
      heartfill: true,
      starCount: 3.5,
    ),
    GetMoreQuotesModel(
      Quotestype: StaticString.rJMurphyContractors,
      showingResultSelect: true,
      heartfill: true,
      starCount: 3.5,
    ),
    GetMoreQuotesModel(
      Quotestype: StaticString.stolyteBathrooms,
      showingResultSelect: true,
      heartfill: true,
      starCount: 3.5,
    ),
    GetMoreQuotesModel(
      Quotestype: StaticString.patelDrains,
      showingResultSelect: true,
      heartfill: true,
      starCount: 3.5,
    ),
    GetMoreQuotesModel(
      Quotestype: StaticString.aleesaGasHeating,
      showingResultSelect: true,
      heartfill: true,
      starCount: 3.5,
    ),
    GetMoreQuotesModel(
      Quotestype: StaticString.aleyahBathroomFitters,
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
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 35),
            //Alert Message Card
            if (_showNotificationAlert)
              ValueListenableBuilder(
                valueListenable: _notificationAlertNotifier,
                builder: (context, value, child) {
                  return _alertMsgCard(context);
                },
              ),
            const SizedBox(height: 40),
            //Get More Quotes Card
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
            //Get More Quotes Button
            _builGetMoreQuotesBtn(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

//------------------------------------ Widgets ------------------------------------//
//------------------------------- GetMoreQuotes Button -----------------------------/

  Widget _builGetMoreQuotesBtn() {
    return CommonElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      bttnText: StaticString.getMoreQuotes1,
      color: ColorConstants.custDarkPurple662851,
      fontSize: 16,
    );
  }

//-------------------------------- GetMoreQuotes Card ------------------------------/

  Widget getQuotesCard(
    GetMoreQuotesModel getQuotesModel,
    BuildContext context,
    void Function() onTap,
    void Function() heartOntap,
  ) {
    return Column(
      children: [
        const SizedBox(height: 10),
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
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.custGrey707070,
                  ),
            )
          ],
        ),
        const SizedBox(height: 10),
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
        const SizedBox(height: 5),
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

//--------------------------------- Alert Message Card -----------------------------/

  Widget _alertMsgCard(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
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
                child: CustomText(
                  txtTitle: StaticString.gMoreQuotesAlertMsg,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w600,
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

class GetMoreQuotesModel {
  final String Quotestype;
  bool showingResultSelect;
  bool heartfill;
  final double starCount;
  GetMoreQuotesModel({
    required this.Quotestype,
    required this.showingResultSelect,
    required this.heartfill,
    required this.starCount,
  });
}
