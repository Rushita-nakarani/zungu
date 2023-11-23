import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../../../../widgets/custom_text.dart';

class MyReviewScreen extends StatefulWidget {
  const MyReviewScreen({super.key});

  @override
  State<MyReviewScreen> createState() => _MyReviewScreenState();
}

class _MyReviewScreenState extends State<MyReviewScreen> {
  final double _initialRating = 2.0;
  late final _ratingController;
  late double _rating;
  final bool _isVertical = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(height: 40),
            itemBuilder: (context, index) {
              return _buildReviewCard(
                color: ColorConstants.custRedFF0000,
                //ColorConstants.custPurple500472,
                //ColorConstants.custGreen34A308
              );
            },
            itemCount: 3,
          )
        ],
      ),
    );
  }

  //------ReviewCard----------

  Widget _buildReviewCard({required Color color}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorConstants.backgroundColorFFFFFF,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const CustImage(
                    imgURL: ImgName.tenantUserIcon,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          txtTitle: "Phil Collins",
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: ColorConstants.custDarkPurple160935,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                          txtTitle: "Tnant",
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: ColorConstants.custGrey707070,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                          txtTitle: "40 Cherwell Drive, Marston Oxford OX3 0LZ",
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: ColorConstants.custGrey707070,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    _buildRatingBar(),
                    const SizedBox(height: 15),
                  ],
                ),
              ],
            ),
            _buildRatingInformation(
              txtRating: "5.0",
              txtRatingInfo: StaticString.tookCareOfProperty,
            ),
            _buildRatingInformation(
              txtRating: "1.0",
              txtRatingInfo: StaticString.paidOnTime,
            ),
            _buildRatingInformation(
              txtRating: "1.0",
              txtRatingInfo: StaticString.tookCareOfProperty,
            ),
            _buildRentArrears(
              statusAndAmount: "Yes",
              txtArrears: StaticString.previousRentArrears,
            ),
            _buildRentArrears(
              statusAndAmount: "£2560",
              txtArrears: StaticString.previousArrearsAmount,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 9,
                    ),
                    CustomText(
                      txtTitle: StaticString.reviewsStatus,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.custGrey707070,
                          ),
                    )
                  ],
                ),
                CustomText(
                  txtTitle: "Approved",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custGreen34A308,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

//-------build Rating information----
  Widget _buildRatingInformation({
    required String txtRating,
    required String txtRatingInfo,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 8,
            ),
            CustomText(
              txtTitle: txtRatingInfo,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custGrey707070,
                  ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.amber,
              child: const Icon(
                Icons.star,
                color: Colors.white,
                size: 15,
              ),
            ),
            const SizedBox(width: 5),
            CustomText(
              txtTitle: txtRating,
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        ),
      ],
    );
  }

//-------build Rating information----
  Widget _buildRentArrears({
    required String statusAndAmount,
    required String txtArrears,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 8,
            ),
            CustomText(
              txtTitle: txtArrears,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custGrey707070,
                  ),
            ),
          ],
        ),
        CustomText(
          txtTitle: statusAndAmount,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: ColorConstants.custRedFF0000,
              ),
        ),
      ],
    );
  }
//---- Buid RatingBar-----

  Widget _buildRatingBar() {
    return Row(
      children: [
        SizedBox(
          child: RatingBar.builder(
            initialRating: _initialRating,
            minRating: 1,
            direction: _isVertical ? Axis.vertical : Axis.horizontal,
            allowHalfRating: true,
            unratedColor: ColorConstants.custGreyBDBCBC,
            itemSize: 15.0,
            itemPadding: const EdgeInsets.symmetric(
              horizontal: 1.0,
            ),
            updateOnDrag: true,
            itemBuilder: (context, index) => Container(
              color: Colors.amber,
              child: const Icon(
                Icons.star,
                color: Colors.white,
              ),
            ),
            onRatingUpdate: (rating) {
              if (mounted) {
                setState(() {
                  _rating = rating;
                });
              }
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        CustomText(
          txtTitle: "(${_rating.toString()})",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorConstants.custGrey707070,
              ),
        ),
      ],
    );
  }
}
