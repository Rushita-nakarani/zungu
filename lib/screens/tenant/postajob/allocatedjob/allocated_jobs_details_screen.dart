//----------------------------- Allocated Jobs Details Screen ----------------------//

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/main.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class AllocatedJobsDetailsScreen extends StatefulWidget {
  const AllocatedJobsDetailsScreen({super.key});

  @override
  State<AllocatedJobsDetailsScreen> createState() =>
      _AllocatedJobsDetailsScreenState();
}

class _AllocatedJobsDetailsScreenState
    extends State<AllocatedJobsDetailsScreen> {
//-------------------------------------- UI ----------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          txtTitle: StaticString.allocatedJobsDetails,
        ),
        backgroundColor: ColorConstants.custDarkPurple662851,
      ),
      body: SafeArea(child: SingleChildScrollView(child: _buildBody(context))),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          //Image
          _buildImage(),
          const SizedBox(height: 15),
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
          _buildTenantDescriptionTitle(),
          const SizedBox(height: 5),
          //Tenant Description
          _buildTenantDescription(),
          const SizedBox(height: 18),
          //Divider
          const Divider(),
          const SizedBox(height: 18),
          //Plumbing With More Details
          _buildPlumbingWithMoreDetail(),
          const SizedBox(height: 30),
          //Reason for Cancellation Box
          _buildCancellationBox(),
          const SizedBox(height: 30),
          //Reallocated Job Button
          _builReallocatedJobBtn(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

//------------------------------------ Widgets -------------------------------------//

//----------------------------- Reallocated Job Btn button --------------------------/

  Widget _builReallocatedJobBtn() {
    return CommonElevatedButton(
      onPressed: () {},
      bttnText: StaticString.reallocateJob,
      color: ColorConstants.custDarkYellow838500,
      fontSize: 16,
    );
  }

//----------------------------- Reason for Cancellation Box -------------------------/

  Widget _buildCancellationBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.custLightRedFFE6E6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            txtTitle: StaticString.reasonforCancellation,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custDarkBlue150934,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 13),
          CustomText(
            txtTitle: StaticString.imNoLongerAvailable,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custGrey707070,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 23),
        ],
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
              txtTitle: "M Lewis Plumbing",
              style: Theme.of(getContext).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custDarkYellow838500,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
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
                    onRatingUpdate: (value) {},
                  ),
                ),
                const SizedBox(width: 6),
                CustomText(
                  txtTitle: StaticString.starsCount,
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
            const SizedBox(height: 10),
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
                color: ColorConstants.custLightGreenE4FEE2,
                elevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CustImage(
                      imgURL: ImgName.timeallocatedjob,
                      width: 14,
                    ),
                    CustomText(
                      txtTitle: "16:00 - 17:30",
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
                  txtTitle: StaticString.status,
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
                color: ColorConstants.backgroundColorFFFFFF,
                elevation: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: ColorConstants.custRedFF0000,
                    ),
                    color: ColorConstants.custGreyF7F7F7,
                  ),
                  child: Center(
                    child: CustomText(
                      txtTitle: StaticString.jobDeclined,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: ColorConstants.custRedFF0000,
                          ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
//--------------------------------- Tenant Description ------------------------------/

  Widget _buildTenantDescription() {
    return CustomText(
      txtTitle:
          'Bathroom tiles have become undone and is falling off the wall and needs replacing.',
      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
            color: ColorConstants.custGrey707070,
            fontWeight: FontWeight.w500,
          ),
    );
  }
//------------------------------ Tenant Description Title ---------------------------/

  Widget _buildTenantDescriptionTitle() {
    return CustomText(
      txtTitle: StaticString.tenantDescription,
      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorConstants.custDarkBlue150934,
          ),
    );
  }

//------------------------------------ Bath Details ---------------------------------/

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
                      imgColor: ColorConstants.custDarkPurple662851,
                      width: 12,
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

//----------------------------------- SubTitle Name ---------------------------------/

  Widget _buildSubTitle(text) {
    return CustomText(
      txtTitle: text,
      style: Theme.of(getContext).textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorConstants.custGrey707070,
          ),
    );
  }

//------------------------------------- Title Name ----------------------------------/

  Widget _buildTitle(text) {
    return CustomText(
      txtTitle: text,
      style: Theme.of(getContext).textTheme.headline1?.copyWith(
            fontWeight: FontWeight.w700,
            color: ColorConstants.custDarkBlue150934,
          ),
    );
  }

//--------------------------------------- Image -------------------------------------/

  Widget _buildImage() {
    return Stack(
      children: [
        const CustImage(
          height: 175,
          width: double.infinity,
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
              txtTitle: StaticString.jobDeclined,
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
}
