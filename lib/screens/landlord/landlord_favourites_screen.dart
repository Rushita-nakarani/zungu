import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/constant/string_constants.dart';
import 'package:zungu_mobile/screens/landlord/landlord_favourites_filter.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

import '../../constant/img_constants.dart';

class LandlordMyFavouritesScreen extends StatefulWidget {
  const LandlordMyFavouritesScreen({super.key});

  @override
  State<LandlordMyFavouritesScreen> createState() => _LandlordMyFavouritesScreenState();
}

class _LandlordMyFavouritesScreenState extends State<LandlordMyFavouritesScreen> {
  late final _ratingController;
  late double _rating;

  final double _userRating = 3.0;
  final int _ratingBarMode = 1;
  final double _initialRating = 2.0;
  final bool _isRTLMode = false;
  final bool _isVertical = false;

  IconData? _selectedIcon;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30, left: 18, right: 18),
        child: ListView.separated(
          padding: const EdgeInsets.only(bottom: 30),
          separatorBuilder: (context, index) => const SizedBox(height: 25),
          shrinkWrap: true,
          itemCount: 10,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _buildCard();
          },
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
            blurRadius: 12,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              txtTitle: "Tredesman",
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custGrey707070,
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  txtTitle: "M Lewis",
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.custDarkPurple150934,
                      ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.custGrey7A7A7A.withOpacity(0.3),
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: const CustImage(
                    imgURL: ImgName.fillheartinvoicesicon,
                    height: 18,
                    width: 18,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const CustImage(
                  imgURL: ImgName.mapIcon,
                  imgColor: ColorConstants.custGrey707070,
                ),
                const SizedBox(
                  width: 5,
                ),
                CustomText(
                  txtTitle: "314 Park Avenue, London",
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            ),
            Row(
              children: [
                CustomText(
                  txtTitle: "Rating",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRating(),
                CustomText(
                  txtTitle: "2.6 miles",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custBlue1EC0EF,
                      ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const CustomText(
        txtTitle: StaticString.myFavourites,
      ),
      backgroundColor: ColorConstants.custDarkBlue150934,
      actions: <Widget>[
        IconButton(
          icon: const CustImage(imgURL: ImgName.filter),
          onPressed: () {
            _selectModel();
            // _showDeleteMessage();
          },
        )
      ],
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        SizedBox(
          child: RatingBar.builder(
            initialRating: _initialRating,
            minRating: 1,
            direction: _isVertical ? Axis.vertical : Axis.horizontal,
            allowHalfRating: true,
            unratedColor: ColorConstants.custGreyEBEAEA,
            itemSize: 12.0,
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
              setState(() {
                _rating = rating;
              });
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

  Future _selectModel() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: ColorConstants.backgroundColorFFFFFF,
      builder: (context) {
        return const FilterSelector();
        // Selector(
        //   controller: controller,
        // );
      },
    );
  }

  Future _showDeleteMessage() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: ColorConstants.backgroundColorFFFFFF,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.custBlack000000.withOpacity(0.1),
                blurRadius: 15,
                spreadRadius: 0.2,
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // TODO: Exact center title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: ColorConstants.custLightGreyC6C6C6,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Align(
                        child: CustomText(
                          align: TextAlign.center,
                          txtTitle: StaticString.deleteRequest,
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.custDarkPurple150934,
                                  ),
                        ),
                      ),
                    ),
                    Expanded(child: Container())
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    align: TextAlign.center,
                    txtTitle:
                        "Are you sure you want to Delete this Entry? This action cannot be undone later.",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstants.custGrey8F8F8F,
                        ),
                  ),
                ),
                const SizedBox(height: 10),
                CommonElevatedButton(
                  bttnText: StaticString.delete,
                  color: ColorConstants.custRedE03816,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
