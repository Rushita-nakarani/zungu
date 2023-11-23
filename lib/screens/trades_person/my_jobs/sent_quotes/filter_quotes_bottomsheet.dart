import 'package:flutter/material.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../models/settings/feedback_regarding_model.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_text.dart';

class FilterQuotesBottomsheet extends StatefulWidget {
  final List<FeedbackRegardingModel> filterQuotesList;
  final void Function(FeedbackRegardingModel? feedbackRegardingModel) onSubmit;

  const FilterQuotesBottomsheet({
    super.key,
    required this.filterQuotesList,
    required this.onSubmit,
  });

  @override
  State<FilterQuotesBottomsheet> createState() =>
      _FilterQuotesBottomsheetState();
}

class _FilterQuotesBottomsheetState extends State<FilterQuotesBottomsheet> {
  int selectedIndex = 0;
  FeedbackRegardingModel? feedbackRegarding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            itemCount: widget.filterQuotesList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              widget.filterQuotesList[index].isSelected =
                  index == selectedIndex;

              return InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      selectedIndex = index;
                      feedbackRegarding = widget.filterQuotesList[index];
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustImage(
                              imgURL: ImgName.greyCheckImage,
                              imgColor:
                                  widget.filterQuotesList[index].isSelected
                                      ? ColorConstants.custgreen19B445
                                      : ColorConstants.custGrey707070,
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: CustomText(
                              txtTitle:
                                  widget.filterQuotesList[index].feedbackType ??
                                      "",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(
                                    color: widget
                                            .filterQuotesList[index].isSelected
                                        ? ColorConstants.custTeal60B0B1
                                        : ColorConstants.custDarkBlue160935,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(
                        color: ColorConstants.custGrey707070
                            .withOpacity(0.7)
                            .withOpacity(0.5),
                        thickness: 0.5,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 40),
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: CommonElevatedButton(
              color: ColorConstants.custDarkTeal017781,
              bttnText: StaticString.done.toUpperCase(),
              fontSize: 14,
              onPressed: () {
                Navigator.of(context).pop();
                widget.onSubmit(feedbackRegarding);
              },
            ),
          )
        ],
      ),
    );
  }
}
