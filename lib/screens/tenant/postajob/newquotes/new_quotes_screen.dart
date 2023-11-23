//------------------------------- New Quotes Screen --------------------------------//

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/main.dart';
import 'package:zungu_mobile/screens/tenant/postajob/newquotes/get_more_quotes_screen.dart';
import 'package:zungu_mobile/screens/tenant/postajob/newquotes/new_quotes_details_screen.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class NewQuotesScreen extends StatefulWidget {
  const NewQuotesScreen({super.key});

  @override
  State<NewQuotesScreen> createState() => _NewQuotesScreenState();
}

class _NewQuotesScreenState extends State<NewQuotesScreen> {
//-------------------------------------- UI ----------------------------------------//
  @override
  Widget build(BuildContext context) {
    return _buildNewQuotes();
  }

  Widget _buildNewQuotes() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                //Image for ViewNewQuotes
                _buildImageViewNewQuotes(),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      //Title for ViewNewQuotes
                      _buildTitleViewNewQuotes("40 Cherwell Drive"),
                      const SizedBox(height: 3),
                      //Sub Title for ViewNewQuotes
                      _buildSubTitleViewNewQuotes("Marston Oxford OX3 OLZ"),
                      const SizedBox(height: 20),
                      //Bath Details for ViewNewQuotes
                      _buildBathDetailsViewNewQuotes(),
                      const SizedBox(height: 12),
                      //Tenant Description Title for ViewNewQuotes
                      _buildTenantDescTitleViewNewQuotes(),
                      const SizedBox(height: 5),
                      //Tenant Description for ViewNewQuotes
                      _buildTenantDescrViewNewQuotes(),
                      const SizedBox(height: 24),
                      //ViewNewQuote Button
                      _builViewNewQuotesBtn(),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.of(getContext).push(
                  MaterialPageRoute(
                    builder: (ctx) => const GetMoreQuotesScreen(),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Image for AwaitingQuotes
                  _buildImageAwaitingQuotes(),

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        //Title for AwaitingQuotes
                        _buildTitleAwaitingQuotes("35 Croft Meadows"),
                        const SizedBox(height: 5),
                        //SubTitle for AwaitingQuotes
                        _buildSubTitleAwaitingQuotes(
                            "Sandhurst Oxford OXI 4PH",),
                        const SizedBox(height: 20),
                        //Bath Details for AwaitingQuotes
                        _buildBathDetailsAwaitingQuotes(),
                        const SizedBox(height: 12),
                        //Tenant Description Title for AwaitingQuotes
                        _buildTenantDescTitleAwaitingQuotes(),
                        const SizedBox(height: 5),
                        //Tennant Description for AwaitingQuotes
                        _buildTenantDescAwaitingQuotes(),
                        const SizedBox(height: 24),
                        //AwaitingQuotes Button
                        _builAwaitingQuotesBtn(),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//------------------------------------ Widgets -------------------------------------//

//---------------------------------- View NewQuotes  UI -----------------------------//

//--------------------------------- ViewNewQuotes button ----------------------------/

Widget _builViewNewQuotesBtn() {
  return CommonElevatedButton(
    onPressed: () {
      Navigator.of(getContext).push(
        MaterialPageRoute(
          builder: (ctx) => const NewQuotesDetailsScreen(),
        ),
      );
    },
    bttnText: StaticString.newQuotesView2Newquotes,
    color: ColorConstants.custDarkYellow838500,
    fontSize: 16,
  );
}

//-------------------------- Tenant BathDetails ViewNewQuotes  ----------------------/

Widget _buildBathDetailsViewNewQuotes() {
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
                    imgColor: ColorConstants.custDarkPurple662851,
                    width: 14,
                  ),
                  CustomText(
                    txtTitle: "27 Jun 2021",
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

//-------------------------- Tenant Description ViewNewQuotes -----------------------/

Widget _buildTenantDescrViewNewQuotes() {
  return CustomText(
    txtTitle:
        "'Bathroom tiles have become undone and is falling off the wall and needs replacing.",
    style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
          color: ColorConstants.custGrey707070,
          fontWeight: FontWeight.w500,
        ),
  );
}
//----------------------- Tenant Description Title ViewNewQuotes --------------------/

Widget _buildTenantDescTitleViewNewQuotes() {
  return CustomText(
    txtTitle: StaticString.tenantDescription,
    style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
          fontWeight: FontWeight.w500,
          color: ColorConstants.custDarkBlue150934,
        ),
  );
}

//------------------------------ Image ViewNewQuotes --------------------------------/

Widget _buildImageViewNewQuotes() {
  return Stack(
    children: [
      const CustImage(
        width: double.infinity,
        height: 175,
        cornerRadius: 12,
        imgURL:
            "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      ),
      Positioned(
        top: 15,
        left: 15,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: ColorConstants.custRedD7181F.withOpacity(0.5),
            borderRadius: BorderRadius.circular(14),
          ),
          child: CustomText(
            txtTitle: StaticString.urgent1,
            style: Theme.of(getContext).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custWhiteF9F9F9,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    ],
  );
}
//--------------------------- SubTitle Name ViewNewQuotes ---------------------------/

Widget _buildSubTitleViewNewQuotes(text) {
  return CustomText(
    txtTitle: text,
    style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
          fontWeight: FontWeight.w500,
          color: ColorConstants.custGrey707070,
        ),
  );
}

//---------------------------- Title Name ViewNewQuotes -----------------------------/

Widget _buildTitleViewNewQuotes(text) {
  return CustomText(
    txtTitle: text,
    style: Theme.of(getContext).textTheme.headline1?.copyWith(
          fontWeight: FontWeight.w700,
          color: ColorConstants.custDarkBlue150934,
        ),
  );
}

//------------------------------- Awaiting Quotes UI --------------------------------//

//------------------------------ Awaiting Quotes Button -----------------------------/

Widget _builAwaitingQuotesBtn() {
  return SizedBox(
    height: 50,
    width: double.infinity,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: ColorConstants.custDarkPurple662851,
        ),
        color: Colors.transparent,
      ),
      child: Center(
        child: CustomText(
          txtTitle: StaticString.awaitingQuotes.toUpperCase(),
          style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
                color: ColorConstants.custDarkPurple662851,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    ),
  );
}

//------------------------ Tenant Description AwaitingQuotes ------------------------/

Widget _buildTenantDescAwaitingQuotes() {
  return ReadMoreText(
    'Seeking a floor technician to instal engineered wood flooring throughout the property. The floor size is 100m2 with wastage all...',
    style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
          color: ColorConstants.custGrey707070,
          fontWeight: FontWeight.w500,
        ),
    colorClickableText: ColorConstants.custDarkYellow838500,
    trimMode: TrimMode.Line,
    trimCollapsedText: StaticString.readMoreInAction,
    trimExpandedText: StaticString.showLessInAction,
  );
}
//------------------------ Tenant Description Title AwaitingQuotes ------------------/

Widget _buildTenantDescTitleAwaitingQuotes() {
  return CustomText(
    txtTitle: StaticString.tenantDescription,
    style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
          fontWeight: FontWeight.w500,
          color: ColorConstants.custDarkBlue150934,
        ),
  );
}

//----------------------------- Bath Details AwaitingQuotes -------------------------/

Widget _buildBathDetailsAwaitingQuotes() {
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
            txtTitle: "Solid Wood Floor Fitting",
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
                    imgColor: ColorConstants.custDarkPurple662851,
                    width: 14,
                  ),
                  CustomText(
                    txtTitle: "27 Jun 2021",
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
//------------------------------- Image Awaiting Quotes -----------------------------/

Widget _buildImageAwaitingQuotes() {
  return Stack(
    children: const [
      CustImage(
        width: double.infinity,
        height: 175,
        cornerRadius: 12,
        imgURL:
            "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      ),
    ],
  );
}

//---------------------------- SubTitle Name AwaitingQuotes -------------------------/

Widget _buildSubTitleAwaitingQuotes(text) {
  return CustomText(
    txtTitle: text,
    style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
          fontWeight: FontWeight.w500,
          color: ColorConstants.custGrey707070,
        ),
  );
}

//----------------------------- Title Name AwaitingQuotes ----------------------------/

Widget _buildTitleAwaitingQuotes(text) {
  return CustomText(
    txtTitle: text,
    style: Theme.of(getContext).textTheme.headline1?.copyWith(
          fontWeight: FontWeight.w700,
          color: ColorConstants.custDarkBlue150934,
        ),
  );
}
