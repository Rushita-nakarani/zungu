//---------------- New Quotes Details Select This Trademan Screen ------------------//

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/main.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/lenear_container.dart';

class NewQuotesSelectScreenThisTrademan extends StatefulWidget {
  const NewQuotesSelectScreenThisTrademan({super.key});

  @override
  State<NewQuotesSelectScreenThisTrademan> createState() =>
      _NewQuotesSelectScreenThisTrademanState();
}

class _NewQuotesSelectScreenThisTrademanState
    extends State<NewQuotesSelectScreenThisTrademan> {
//------------------------------------ Variables -----------------------------------//

  final urlImages = [
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
  ];

  late double _rating;
  final double _initialRating = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _rating = _initialRating;
  }

//-------------------------------------- UI ----------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          txtTitle: StaticString.postAJob,
        ),
        backgroundColor: ColorConstants.custDarkPurple662851,
      ),
      body: SafeArea(child: SingleChildScrollView(child: _buildBody(context))),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 42),
        //CarouselSlider
        SizedBox(
          height: 175,
          child: CarouselSlider.builder(
            options: CarouselOptions(
              height: 400,
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 3),
            ),
            itemCount: urlImages.length,
            itemBuilder: (context, index, realIndex) {
              final urlImage = urlImages[index];
              return buildCarouselSlider(urlImage, context);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              //Title Text
              _buildTitle(),
              const SizedBox(height: 3),
              //SubTitle Text
              _buildSubTitle(),
              const SizedBox(height: 20),
              //Bath Details
              _buildBathDetails(),
              const SizedBox(height: 13),
              //Tenant Description Title
              _buildTenantDescTitle(),
              const SizedBox(height: 5),
              //Tenant Description
              _buildTenantDescDetails(),
              const SizedBox(height: 18),
              //Divider
              const Divider(),
              const SizedBox(height: 18),
              //Plumbing With More Detail
              _buildPlumbingWithMoreDetail(),
              const SizedBox(height: 25),
              //Divider
              const Divider(),
              const SizedBox(height: 25),
              //Contractor Details Text
              _buildContractorDetails(StaticString.contractorDetails),
              LinearContainer(
                width: MediaQuery.of(getContext).size.width / 8,
                color: ColorConstants.custDarkPurple662851,
              ),
              const SizedBox(
                height: 2.5,
              ),
              LinearContainer(
                width: MediaQuery.of(getContext).size.width / 12,
                color: ColorConstants.custDarkYellow838500,
              ),
              const SizedBox(height: 30),
              //Title, Block The User Icon
              _buildTitleBlockTheUserIcon(),
              const SizedBox(height: 5),
              //Loction Icon and Text
              _buildLocation(),
              const SizedBox(height: 17),
              //RatingsDetails, Miles , Description
              _buildRatingDetailsAndMilesDesc(),
              const SizedBox(height: 20),
              //Divider
              const Divider(),
              const SizedBox(height: 20),
              //Get Connected Details
              _buildGetConnectedDetails(),
              const SizedBox(height: 26),
              //Divider
              const Divider(),
              const SizedBox(height: 26),
              //Select This TradeMan Button
              _builSelectThisTradeManBtn(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }

//------------------------------------ Widgets -------------------------------------//

//-------------------------- Select This TradeMan Button ---------------------------/

  Widget _builSelectThisTradeManBtn() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: CommonElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: getContext,
            builder: (context) {
              return _bottomSheetAllocatedJob(context);
            },
          );
        },
        bttnText: StaticString.selectThisTrademan1,
        color: ColorConstants.custDarkYellow838500,
        fontSize: 16,
      ),
    );
  }

//---------------------------- BottomSheet AllocatedJob -----------------------------/

  Widget _bottomSheetAllocatedJob(context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorConstants.backgroundColorFFFFFF,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: ColorConstants.custGrey707070,
                    ),
                    color: ColorConstants.custgreyE0E0E0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: CustomText(
                      align: TextAlign.center,
                      txtTitle: StaticString.allocateJob1,
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.custDarkPurple150934,
                          ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 45, right: 45),
            child: Column(
              children: [
                CustomText(
                  align: TextAlign.center,
                  txtTitle: StaticString.youAreAllocatingThisJobTo,
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                CustomText(
                  align: TextAlign.center,
                  txtTitle: "M Lewis Gas Engineers",
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: ColorConstants.custDarkPurple662851,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          _buildAllocatedJobBtn(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

//------------------------------ Allocated Job Button -------------------------------/

  Widget _buildAllocatedJobBtn() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: CommonElevatedButton(
        onPressed: () {},
        bttnText: StaticString.allocateJob1,
        color: ColorConstants.custDarkYellow838500,
        fontSize: 16,
      ),
    );
  }
//------------------------------ Get Connected Details ------------------------------/

  Widget _buildGetConnectedDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          txtTitle: StaticString.getConnected,
          style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorConstants.custDarkPurple150934,
              ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            CircleAvatar(
              backgroundColor: ColorConstants.backgroundColorFFFFFF,
              radius: 30,
              child: CustImage(
                imgURL: ImgName.twebpostajobicon,
              ),
            ),
            CircleAvatar(
              backgroundColor: ColorConstants.backgroundColorFFFFFF,
              radius: 30,
              child: CustImage(
                imgURL: ImgName.temailpostajobicon,
              ),
            ),
            CircleAvatar(
              backgroundColor: ColorConstants.backgroundColorFFFFFF,
              radius: 30,
              child: CustImage(
                imgURL: ImgName.tcallpostajobpostajobicon,
              ),
            ),
            CircleAvatar(
              backgroundColor: ColorConstants.backgroundColorFFFFFF,
              radius: 30,
              child: CustImage(
                imgURL: ImgName.tmessagepostajobpostajobicon,
              ),
            ),
          ],
        ),
      ],
    );
  }

//----------------------- Rating Details, Miles And Description ---------------------/

  Widget _buildRatingDetailsAndMilesDesc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          txtTitle: StaticString.ratings1,
          style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorConstants.custDarkPurple150934,
              ),
        ),
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  child: RatingBar.builder(
                    initialRating: _initialRating,
                    minRating: 1,
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
                        setState(() {
                          _rating = value;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 6),
                CustomText(
                  txtTitle: "(${_rating.toString()})",
                  style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: CustomText(
                txtTitle: "2.6 miles",
                style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.custDarkGreen838500,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        ReadMoreText(
          'M Lewis Gas Engineers is Oxfords most afforadable and reliable company for all your gas and heating work.',
          style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
                color: ColorConstants.custGrey707070,
                fontWeight: FontWeight.w500,
              ),
          colorClickableText: ColorConstants.custDarkYellow838500,
          trimMode: TrimMode.Line,
          trimCollapsedText: StaticString.readMoreInAction,
          trimExpandedText: StaticString.showLessInAction,
        ),
      ],
    );
  }

//------------------------------- Location Icon And Text ----------------------------/

  Widget _buildLocation() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustImage(
          imgURL: ImgName.mapIcon,
          imgColor: ColorConstants.custGrey707070,
        ),
        const SizedBox(width: 5),
        CustomText(
          txtTitle: StaticString.contractorDetail,
          style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
                color: ColorConstants.custGrey707070,
                fontWeight: FontWeight.w400,
              ),
        )
      ],
    );
  }
//----------------------------- Title, Block The User Icon --------------------------/

  Widget _buildTitleBlockTheUserIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txtTitle: "M Lewis Gas Engineers",
          style: Theme.of(getContext).textTheme.headline1?.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorConstants.custDarkBlue150934,
              ),
        ),
        SizedBox(
          height: 35,
          width: 35,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.custGrey7A7A7A
                      .withOpacity(0.3), //color of shadow

                  blurRadius: 7, // blur radius
                ),
              ],
            ),
            child: Card(
              elevation: 2,
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: getContext,
                    builder: (context) {
                      return _bottomSheetBlockThisUser(context);
                    },
                  );
                },
                icon: const CustImage(
                  imgURL: ImgName.landlordBlockUser,
                  width: 36,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

//----------------------------- BottomSheet Block This User -------------------------/

  Widget _bottomSheetBlockThisUser(context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorConstants.backgroundColorFFFFFF,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: ColorConstants.custGrey707070,
                    ),
                    color: ColorConstants.custgreyE0E0E0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: CustomText(
                      align: TextAlign.center,
                      txtTitle: StaticString.blockThisUser1,
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.custDarkPurple150934,
                          ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 45, right: 45),
            child: Column(
              children: [
                CustomText(
                  align: TextAlign.center,
                  txtTitle: StaticString.msgConfirmation,
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                CustomText(
                  align: TextAlign.center,
                  txtTitle: "M Lewis Gas Engineers",
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: ColorConstants.custDarkPurple662851,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 25),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ColorConstants.custGrey707070,
                          fontWeight: FontWeight.w500,
                        ),
                    children: const <TextSpan>[
                      TextSpan(
                        text:
                            'By proceeding, you will no longer be able to get Quotes from this Tradesman. You can ',
                      ),
                      TextSpan(
                        text: 'unblock ',
                        style: TextStyle(
                          color: ColorConstants.custDarkGreen838500,
                        ),
                      ),
                      TextSpan(
                        text: ' him at any time from the settings menu ',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          _buildTradesmanBtn(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

//------------------------------ Block Tradesman Button -----------------------------/

  Widget _buildTradesmanBtn() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: CommonElevatedButton(
        onPressed: () {},
        bttnText: StaticString.blockTradesman1,
        color: ColorConstants.custDarkYellow838500,
        fontSize: 16,
      ),
    );
  }

//------------------------------------ Title Name -----------------------------------/

  Widget _buildContractorDetails(text) {
    return CustomText(
      txtTitle: text,
      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.w600,
            color: ColorConstants.custDarkPurple150934,
          ),
    );
  }

//------------------------------ Plumbing With More Detail --------------------------/

  Widget _buildPlumbingWithMoreDetail() {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 30,
              height: 30,
              child: CustImage(
                imgURL: ImgName.fillheartinvoicesicon,
              ),
            ),
            const SizedBox(width: 15),
            CustomText(
              txtTitle: "M Lewis Gas Engineers",
              style: Theme.of(getContext).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custDarkYellow838500,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 5),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Container(),
                ),
                const SizedBox(width: 15),
                CustomText(
                  txtTitle: StaticString.contractor,
                  style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
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
                    onRatingUpdate: (value) {
                      if (mounted) {
                        setState(() {});
                      }
                    },
                  ),
                ),
                const SizedBox(width: 6),
                CustomText(
                  txtTitle: "(4.0)",
                  style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
              ],
            ),
            const SizedBox(width: 3),
            Flexible(
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: CustomText(
                    txtTitle: "£243.98",
                    style: Theme.of(getContext).textTheme.headline2?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.custGrey7C7B7B,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 17),

        //
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Container(),
                ),
                const SizedBox(width: 15),
                CustomText(
                  txtTitle: StaticString.availableDate,
                  style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
              ],
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
                      imgURL: ImgName.commonCalendar,
                      imgColor: ColorConstants.custDarkBlue150934,
                      width: 12,
                    ),
                    CustomText(
                      txtTitle: "20 Mar 2022",
                      style: Theme.of(getContext).textTheme.caption?.copyWith(
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
        const SizedBox(height: 5),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Container(),
                ),
                const SizedBox(width: 15),
                CustomText(
                  txtTitle: StaticString.availableTime,
                  style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
              width: 100,
              child: Card(
                color: ColorConstants.custGreen0CCE1A,
                elevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CustImage(
                      imgURL: ImgName.tenantTime,
                      imgColor: ColorConstants.backgroundColorFFFFFF,
                      width: 14,
                    ),
                    CustomText(
                      txtTitle: "16:00 - 18:30",
                      style: Theme.of(getContext).textTheme.caption?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.backgroundColorFFFFFF,
                          ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 5),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Container(),
                ),
                const SizedBox(width: 15),
                CustomText(
                  txtTitle: StaticString.quoteExpiryDate,
                  style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
              width: 100,
              child: Card(
                color: ColorConstants.custlightRedFED6D6,
                elevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CustImage(
                      imgURL: ImgName.commonCalendar,
                      imgColor: ColorConstants.custDarkBlue150934,
                      width: 12,
                    ),
                    CustomText(
                      txtTitle: "26 Mar 2022",
                      style: Theme.of(getContext).textTheme.caption?.copyWith(
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
      ],
    );
  }

//---------------------------------- Tenant Description -----------------------------/

  Widget _buildTenantDescDetails() {
    return CustomText(
      txtTitle:
          'Bathroom tiles have become undone and is falling off the wall and needs replacing.',
      style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
            color: ColorConstants.custGrey707070,
            fontWeight: FontWeight.w500,
          ),
    );
  }
//------------------------------- Tenant Description Title --------------------------/

  Widget _buildTenantDescTitle() {
    return CustomText(
      txtTitle: StaticString.tenantDescription,
      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorConstants.custDarkBlue150934,
          ),
    );
  }

//------------------------------------- Bath Details --------------------------------/

  Widget _buildBathDetails() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConstants.custWhiteF7F7F7,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const CustImage(
                  imgURL: ImgName.bathTub1,
                ),
              ),
            ),
            const SizedBox(width: 15),
            CustomText(
              txtTitle: StaticString.replacetiles,
              style: Theme.of(getContext).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custDarkYellow838500,
                  ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Container(),
                ),
                const SizedBox(width: 15),
                CustomText(
                  txtTitle: StaticString.reported,
                  style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custGrey707070,
                      ),
                ),
              ],
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
                      imgURL: ImgName.commonCalendar,
                      imgColor: ColorConstants.custDarkBlue150934,
                      width: 12,
                    ),
                    CustomText(
                      txtTitle: "20 Jul 2021",
                      style: Theme.of(getContext).textTheme.caption?.copyWith(
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
      ],
    );
  }

//----------------------------------- Sub Title Name --------------------------------/

  Widget _buildSubTitle() {
    return CustomText(
      txtTitle: "Marston Oxford OX3 OLZ",
      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorConstants.custGrey707070,
          ),
    );
  }

//------------------------------------- Title Name ----------------------------------/

  Widget _buildTitle() {
    return CustomText(
      txtTitle: "40 Cherwell Drive",
      style: Theme.of(getContext).textTheme.headline1?.copyWith(
            fontWeight: FontWeight.w700,
            color: ColorConstants.custDarkBlue150934,
          ),
    );
  }

//------------------------------------- Carousel Slider -----------------------------/

  Widget buildCarouselSlider(String urlImage, BuildContext context) {
    return Stack(
      children: [
        CustImage(
          width: double.infinity,
          height: 160,
          cornerRadius: 12,
          imgURL: urlImage,
        ),
      ],
    );
  }
}
