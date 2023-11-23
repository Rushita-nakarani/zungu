//----------------------------- New Quotes Details Screen --------------------------//

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/main.dart';
import 'package:zungu_mobile/screens/tenant/postajob/newquotes/new_quotes_details_select_this_trademan_screen.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class NewQuotesDetailsScreen extends StatefulWidget {
  const NewQuotesDetailsScreen({super.key});

  @override
  State<NewQuotesDetailsScreen> createState() => _NewQuotesDetailsScreenState();
}

class _NewQuotesDetailsScreenState extends State<NewQuotesDetailsScreen> {
//------------------------------------ Variables ----------------------------------//

  final urlImages = [
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
  ];

  bool _showNotificationAlert = true;
  final ValueNotifier _notificationAlertNotifier = ValueNotifier(true);

//-------------------------------------- UI ---------------------------------------//

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
        const SizedBox(
          height: 28,
        ),
        //Alert Message Card
        if (_showNotificationAlert)
          ValueListenableBuilder(
            valueListenable: _notificationAlertNotifier,
            builder: (context, value, child) {
              return _alertMsgCard(context);
            },
          ),
        const SizedBox(height: 45),
        //CarouselSlider
        SizedBox(
          height: 175,
          child: CarouselSlider.builder(
            options: CarouselOptions(
              height: 400,
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 3),
              //  viewportFraction: 0.7,
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
              _buildTitle("40 Cherwell Drive"),
              const SizedBox(height: 3),
              //SubTitle Text
              _buildSubTitle("Marston Oxford OX3 OLZ"),
              const SizedBox(height: 20),
              //Bath Details
              _buildBathDetails(),
              const SizedBox(height: 13),
              //Tenant Description Title
              _buildTenantDescTitle(),
              const SizedBox(height: 5),
              //Tenent Description
              _buildTenantDesc(),
              const SizedBox(height: 18),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Divider
                      const Divider(),
                      const SizedBox(height: 18),
                      //Plumbin with More Details
                      _buildPlumbingWithMoreDetail(),
                      const SizedBox(height: 25),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

//------------------------------------ Widgets ------------------------------------//

//------------------------------- PlumbingWithMoreDetail ---------------------------/

  Widget _buildPlumbingWithMoreDetail() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const NewQuotesSelectScreenThisTrademan(),
          ),
        );
      },
      child: Column(
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
                    txtTitle: StaticString.tenantContractor,
                    style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
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
                      txtTitle: "£157.54",
                      style: Theme.of(getContext).textTheme.headline2?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.custGrey707070,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 17),
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
      ),
    );
  }
//--------------------------------- Tenant Description -----------------------------/

  Widget _buildTenantDesc() {
    return CustomText(
      txtTitle:
          "Bathroom tiles have become undone and is falling off the wall and needs replacing.",
      style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
            color: ColorConstants.custGrey707070,
            fontWeight: FontWeight.w500,
          ),
    );
  }
//------------------------------- Tenant Description Title -------------------------/

  Widget _buildTenantDescTitle() {
    return CustomText(
      txtTitle: StaticString.tenantDescription,
      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorConstants.custDarkBlue150934,
          ),
    );
  }

//----------------------------------- Bath Details ---------------------------------/

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

//---------------------------------- SubTitle Name ---------------------------------/

  Widget _buildSubTitle(text) {
    return CustomText(
      txtTitle: text,
      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorConstants.custGrey707070,
          ),
    );
  }

//------------------------------------ Title Name ----------------------------------/

  Widget _buildTitle(text) {
    return CustomText(
      txtTitle: text,
      style: Theme.of(getContext).textTheme.headline1?.copyWith(
            fontWeight: FontWeight.w700,
            color: ColorConstants.custDarkBlue150934,
          ),
    );
  }

//------------------------------- Carsoule Image Slider ----------------------------/

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

//--------------------------------- Alert Message Card -----------------------------/

  Widget _alertMsgCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ColorConstants.custGreyF7F7F7,
            ),
            child: Row(
              children: [
                Flexible(
                  child: CircleAvatar(
                    backgroundColor:
                        ColorConstants.custGrey707070.withOpacity(0.1),
                    radius: 25,
                    child: const CustImage(
                      width: 40,
                      height: 40,
                      imgURL: ImgName.informativepostajob,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 4,
                  child: CustomText(
                    txtTitle: StaticString.newQuotesAlertMsg,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ColorConstants.custGrey707070,
                          fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
