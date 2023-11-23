import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/settings/faq_data_model.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';
import 'package:zungu_mobile/widgets/no_content_label.dart';

import '../../providers/settings/privacy_and_help_provider.dart';
import '../../widgets/custom_title_with_line.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  //------------------------------- Variables-----------------------------//
  String firstHalf = "";
  String secondHalf = "";

  // Loading Indicator
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  @override
  void initState() {
    faqDataApiCall();

    super.initState();
  }

  //------------------------------- UI-----------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(context),
    );
  }

  //------------------------------- Widgets-----------------------------//
//  Appbar...
  AppBar _buildAppbar() {
    return AppBar(
      title: const CustomText(
        txtTitle: StaticString.faq,
      ),
    );
  }

  // body...
  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: LoadingIndicator(
        loadingStatusNotifier: _loadingIndicatorNotifier,
        child: Consumer<PrivacyAndPolicyProvider>(
          builder: (context, faqProvider, child) {
            return faqProvider.faqDataList.isEmpty
                ? NoContentLabel(
                    title: StaticString.nodataFound,
                    onPress: faqDataApiCall,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTitleWithLine(
                          title: StaticString.FAQs,
                          primaryColor: ColorConstants.custDarkBlue150934,
                          secondaryColor: ColorConstants.custgreen19B445,
                        ),
                        const SizedBox(height: 20),
                        Flexible(
                          child: ListView.builder(
                            itemCount: faqProvider.faqDataList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, titleList) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    txtTitle: faqProvider
                                        .faqDataList[titleList].title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  const SizedBox(height: 25),
                                  const Divider(
                                    color: ColorConstants.custGreyEBEAEA,
                                    thickness: .8,
                                  ),
                                  const SizedBox(height: 30),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: faqProvider
                                        .faqDataList[titleList]
                                        .questionJson
                                        .length,
                                    itemBuilder: (context, queAnsList) {
                                      final QuestionJson _questionAnswer =
                                          faqProvider.faqDataList[titleList]
                                              .questionJson[queAnsList];
                                      if (_questionAnswer.answer.length > 100) {
                                        firstHalf = _questionAnswer.answer
                                            .substring(0, 100);
                                        secondHalf =
                                            _questionAnswer.answer.substring(
                                          100,
                                          _questionAnswer.answer.length,
                                        );
                                      } else {
                                        firstHalf = _questionAnswer.answer;
                                        secondHalf = "";
                                      }
                                      return Column(
                                        children: [
                                          faqDetails(
                                            _questionAnswer.question,
                                            secondHalf.isEmpty
                                                ? CustomText(
                                                    txtTitle: firstHalf,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        ?.copyWith(
                                                          color: ColorConstants
                                                              .custGrey707070,
                                                        ),
                                                  )
                                                : Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: _questionAnswer
                                                                  .isShow
                                                              ? ("$firstHalf...")
                                                              : (firstHalf +
                                                                  secondHalf),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2
                                                                  ?.copyWith(
                                                                    color: ColorConstants
                                                                        .custGrey707070,
                                                                  ),
                                                        ),
                                                        TextSpan(
                                                          text: _questionAnswer
                                                                  .isShow
                                                              ? StaticString
                                                                  .showMore
                                                              : StaticString
                                                                  .showLess,
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {
                                                                  if (mounted) {
                                                                    setState(
                                                                        () {
                                                                      _questionAnswer
                                                                              .isShow =
                                                                          !_questionAnswer
                                                                              .isShow;
                                                                    });
                                                                  }
                                                                },
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2
                                                                  ?.copyWith(
                                                                    color: ColorConstants
                                                                        .custskyblue22CBFE,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

// FAQ's Details view...
  Widget faqDetails(
    String title,
    Widget subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          txtTitle: title,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 10),
        subtitle,
        const SizedBox(height: 30),
        const Divider(
          color: ColorConstants.custGreyEBEAEA,
          thickness: .8,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  //------------------------------- Helper function-----------------------------//

  // Faq api call...
  Future<void> faqDataApiCall() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      await Provider.of<PrivacyAndPolicyProvider>(context, listen: false)
          .fetchFaqData();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
