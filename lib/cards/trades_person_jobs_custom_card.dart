import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zungu_mobile/models/trades_person/latest_job_screen_model.dart';

import '../constant/color_constants.dart';
import '../constant/img_constants.dart';
import '../constant/string_constants.dart';
import '../screens/tenant/Maintenance/maintenance_common_components.dart';
import '../widgets/cust_image.dart';
import '../widgets/custom_text.dart';

class MyJobCustCard extends StatefulWidget {
  final LatestJobModel latestJobModel;
  final bool isImg;
  final bool showJobId;
  final Color txtColor;
  final String calenderImg;
  final Color? calenderColor;
  final Widget childBtn;
  final Function()? ontap;

  const MyJobCustCard({
    super.key,
    required this.latestJobModel,
    this.isImg = false,
    this.showJobId = false,
    this.txtColor = ColorConstants.custDarkTeal017781,
    this.calenderImg = ImgName.commonCalendar,
    this.calenderColor,
    required this.childBtn,
    this.ontap,
  });

  @override
  State<MyJobCustCard> createState() => _MyJobCustCardState();
}

class _MyJobCustCardState extends State<MyJobCustCard> {
  bool isReadmore = true;
  String firstHalf = "";
  String secondHalf = "";
  @override
  Widget build(BuildContext context) {
    if (StaticString.serversLocated.length >= 20) {
      firstHalf = widget.latestJobModel.tenantDescription;
      secondHalf = "";
    } else {
      if (StaticString.serversLocated.length > 50) {
        firstHalf = widget.latestJobModel.tenantDescription.substring(0, 50);
        secondHalf = widget.latestJobModel.tenantDescription.substring(
          50,
          widget.latestJobModel.tenantDescription.length,
        );
      } else {
        firstHalf = widget.latestJobModel.tenantDescription;
        secondHalf = "";
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //-------------------- job image card and header------------------//
          if (widget.isImg)
            Container()
          else
            Stack(
              children: [
                // Job Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: const CustImage(
                    imgURL:
                        "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
                  ),
                ),

                Positioned(
                  top: MediaQuery.of(context).size.height * 0.015,
                  left: MediaQuery.of(context).size.width * 0.03,
                  child: InkWell(
                    onTap: widget.ontap,
                    child: Row(
                      children: List.generate(
                        widget.latestJobModel.jobHeaderList.length,
                        (index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 7),
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(
                                int.parse(
                                  widget.latestJobModel.jobHeaderList[index]
                                      .jobHeaderColor,
                                ),
                              ).withOpacity(0.65),
                            ),
                            child: CustomText(
                              txtTitle: widget.latestJobModel
                                  .jobHeaderList[index].jobHeader,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    color: ColorConstants.custWhiteF9F9F9,
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),

          if ((widget.latestJobModel.jobIdNo.isEmpty) ||
              (widget.showJobId == true))
            Container()
          else
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    txtTitle: StaticString.jobIDNumber,
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  CustomText(
                    txtTitle: widget.latestJobModel.jobIdNo,
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 15),

          //-------------------job title and subtitle text ------------------//
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  txtTitle: widget.latestJobModel.jobTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                CustomText(
                  txtTitle: widget.latestJobModel.jobSubtitle,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custGrey707070,
                      ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),

          //------------------Reoprted Title text and bath image----------------//
          buildBath(
            title: widget.latestJobModel.reportedTitle,
            date: widget.latestJobModel.reportedDate,
          ),

          const SizedBox(height: 5),

          // --------------------------Description header text and detail text---------------//

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
              child: CustomText(
                txtTitle: firstHalf,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstants.custGrey707070,
                      fontWeight: FontWeight.w500,
                    ),
              ),
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
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
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
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: widget.txtColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ),

          widget.childBtn,
        ],
      ),
    );
  }
}
