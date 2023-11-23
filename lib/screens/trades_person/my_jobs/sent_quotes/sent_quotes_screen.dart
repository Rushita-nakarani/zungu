import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zungu_mobile/screens/trades_person/my_jobs/sent_quotes/quote_decline_screen.dart';

import '../../../../cards/trades_person_jobs_custom_card.dart';
import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../models/settings/feedback_regarding_model.dart';
import '../../../../models/trades_person/latest_job_screen_model.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/custom_text.dart';
import 'edit_quote_and_resend_screen.dart';
import 'filter_quotes_bottomsheet.dart';
import 'job_accept_and_decline_screen.dart';

class SentQuotesscreen extends StatefulWidget {
  @override
  State<SentQuotesscreen> createState() => _SentQuotesscreenState();
}

class _SentQuotesscreenState extends State<SentQuotesscreen> {
  //----------------------------Variables-----------------------------//

  List<LatestJobModel> sentQuotesDummyData =
      latestJobModelFromJson(json.encode(sentQuotesScreenDummyData));

  List<FeedbackRegardingModel> filterQuotesList = [
    FeedbackRegardingModel(
      feedbackType: StaticString.quoteDecline,
    ),
    FeedbackRegardingModel(
      feedbackType: StaticString.quoteExpired,
    ),
    FeedbackRegardingModel(
      feedbackType: StaticString.urgentQuotes,
    ),
  ];

  //----------------------------UI-----------------------------//
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          _filterTextAndIconRow(),
          _alertMsgCard(),
          const SizedBox(height: 30),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sentQuotesDummyData.length,
            itemBuilder: (context, index) {
              return MyJobCustCard(
                latestJobModel: sentQuotesDummyData[index],
                childBtn: Container(
                  height: 40,
                  margin: const EdgeInsets.only(
                    left: 10,
                    top: 20,
                    right: 10,
                    bottom: 50,
                  ),
                  // padding: const EdgeInsets.only(top: 20, bottom: 50),
                  child: ElevatedButton(
                    onPressed: () => elavtedBtnAction(
                      index: index,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: BorderSide(
                        color: Color(
                          int.parse(
                            sentQuotesDummyData[index].quotationColor,
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          35.0,
                        ),
                      ),
                    ),
                    child: CustomText(
                      txtTitle: sentQuotesDummyData[index].quotationName,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            wordSpacing: 1.5,
                            fontSize: 15,
                            color: Color(
                              int.parse(
                                sentQuotesDummyData[index].quotationColor,
                              ),
                            ),
                          ),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  //----------------------Widget-----------------------------//
  // Alert Message card
  Widget _alertMsgCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorConstants.custGreyF8F8F8,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const CustImage(
              imgURL: ImgName.commonInformation,
              width: 24,
              imgColor: ColorConstants.custDarkTeal017781,
            ),
          ),
          Expanded(
            child: CustomText(
              txtTitle: StaticString.alertMsgSentQuotes,
              maxLine: 2,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: ColorConstants.custGreyA4A3A4),
            ),
          )
        ],
      ),
    );
  }

// Filter Text and icon Row
  Widget _filterTextAndIconRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txtTitle: StaticString.filterBy.toUpperCase(),
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custDarkTeal017781,
                  height: 1,
                ),
          ),
          IconButton(
            onPressed: filterButtonAction,
            icon: const CustImage(
              imgURL: ImgName.greenFilter,
            ),
          )
        ],
      ),
    );
  }

  //-------------------------Button action -------------------------//
  void filterButtonAction() {
    showAlert(
      hideButton: true,
      context: context,
      showCustomContent: true,
      showIcon: false,
      singleBtnTitle: StaticString.submit,
      singleBtnColor: ColorConstants.custskyblue22CBFE,
      title: StaticString.whatisThisRegarding,
      content: FilterQuotesBottomsheet(
        filterQuotesList: filterQuotesList,
        onSubmit: (feedbackRegardingModel) {
          // setState(() {
          //   feedbackRegardingModel?.feedbackType ?? "";
          // });
        },
      ),
    );
  }

  void elavtedBtnAction({required int index}) {
    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => EditQuoteAndResendScreen(
              latestJobModel: sentQuotesDummyData[index],
            ),
          ),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => QuoteDeclinedScreen(
              latestJobModel: sentQuotesDummyData[index],
            ),
          ),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => QuoteDeclinedScreen(
              latestJobModel: sentQuotesDummyData[index],
            ),
          ),
        );
        break;
      case 3:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => AcceptAndDeclineJobScreen(
              latestJobModel: sentQuotesDummyData[index],
            ),
          ),
        );
        break;
      default:
    }
  }
}
