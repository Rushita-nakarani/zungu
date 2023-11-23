import 'package:flutter/material.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../models/settings/feedback_regarding_model.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_text.dart';

class AllocatedJobFilterPopup extends StatefulWidget {
  final List<FeedbackRegardingModel> filterList;
  final void Function(FeedbackRegardingModel? feedbackRegardingModel) onSubmit;

  const AllocatedJobFilterPopup({
    super.key,
    required this.filterList,
    required this.onSubmit,
  });

  @override
  State<AllocatedJobFilterPopup> createState() =>
      _AllocatedJobFilterPopupState();
}

class _AllocatedJobFilterPopupState extends State<AllocatedJobFilterPopup> {
  FeedbackRegardingModel? feedbackRegarding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.separated(
            itemCount: widget.filterList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return Divider(
                color: ColorConstants.custGrey707070
                    .withOpacity(0.7)
                    .withOpacity(0.5),
                thickness: 0.5,
              );
            },
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      widget.filterList[index].isSelected =
                          !widget.filterList[index].isSelected;
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
                              imgColor: widget.filterList[index].isSelected
                                  ? ColorConstants.custgreen19B445
                                  : ColorConstants.custGrey707070,
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: CustomText(
                              txtTitle:
                                  widget.filterList[index].feedbackType ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.copyWith(
                                    color: widget.filterList[index].isSelected
                                        ? ColorConstants.custskyblue22CBFE
                                        : ColorConstants.custGrey707070,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 40),
          CommonElevatedButton(
            color: ColorConstants.custskyblue22CBFE,
            bttnText: StaticString.submit,
            fontSize: 14,
            onPressed: () {
              Navigator.of(context).pop();
              widget.onSubmit(feedbackRegarding);
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
