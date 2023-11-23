//--------------------------- Tenant New Invoices Details Screen ------------------//

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/image_upload_outlined_widget.dart';

import '../../../utils/cust_eums.dart';
import 'invoice_payment_bottomsheet.dart';

class TenantNewInvoicesDetails extends StatefulWidget {
  const TenantNewInvoicesDetails({super.key});

  @override
  State<TenantNewInvoicesDetails> createState() =>
      _TenantNewInvoicesDetailsState();
}

class _TenantNewInvoicesDetailsState extends State<TenantNewInvoicesDetails> {
  //------------------------------------ Variables ----------------------------------//

  final urlImages = [
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
  ];

//-------------------------------------- UI ---------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          txtTitle: StaticString.invoicesDetails,
        ),
        backgroundColor: ColorConstants.custDarkPurple662851,
      ),
      body: SafeArea(child: SingleChildScrollView(child: _buildBody(context))),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        // image
        SizedBox(
          height: 175,
          child: Stack(
            children: [
              Positioned(
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
                    return buildSlider(urlImage, context);
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  //Job Id Number
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        txtTitle: StaticString.tenantJobIdNumber,
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.custDarkBlue150934,
                            ),
                      ),
                      CustomText(
                        txtTitle: "#TVZ5L080721",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.custDarkBlue150934,
                            ),
                      ),
                    ],
                  ),
                  //Invoice Number
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        txtTitle: StaticString.invoiceNumber,
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.custDarkBlue150934,
                            ),
                      ),
                      CustomText(
                        txtTitle: "#1CN4627",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.custDarkBlue150934,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              //Address
              const SizedBox(height: 8),
              CustomText(
                txtTitle: "121 Cowley Road Littlemore Oxford OX4 4PH",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.custGrey707070,
                    ),
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    children: [
                      //Bath Icon
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
                        txtTitle: StaticString.tenantShowerLeak,
                        style: Theme.of(context).textTheme.headline1?.copyWith(
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
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
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
                                txtTitle: "27 Oct 2021",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
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
              //Tenant Description
              const SizedBox(height: 13),
              CustomText(
                txtTitle: StaticString.tenantDescription,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.custDarkBlue150934,
                    ),
              ),
              const SizedBox(height: 6),

              ReadMoreText(
                'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstants.custGrey707070,
                      fontWeight: FontWeight.w500,
                    ),
                colorClickableText: ColorConstants.custDarkYellow838500,
                trimMode: TrimMode.Line,
                trimCollapsedText: StaticString.readMoreInAction,
                trimExpandedText: StaticString.showLessInAction,
              ),

              const SizedBox(height: 18),
              const Divider(),
              const SizedBox(height: 18),
              Column(
                children: [
                  Row(
                    children: [
                      //Fill Heart Icon
                      const SizedBox(
                        width: 30,
                        height: 30,
                        child: CustImage(
                          imgURL: ImgName.fillheartinvoicesicon,
                        ),
                      ),
                      const SizedBox(width: 15),
                      //M Lewis Plumbing
                      CustomText(
                        txtTitle: StaticString.tenantMLewisPlumbing,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
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
                          //Contractor
                          CustomText(
                            txtTitle: StaticString.contractor,
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
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
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
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
                            txtTitle: "(3.5)",
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
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
                              txtTitle: "£296.00",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.custGrey707070,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                          //Date Completed
                          CustomText(
                            txtTitle: StaticString.dateCompleted,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
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
                                txtTitle: "15 Oct 2021",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
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
                          //Due Date
                          CustomText(
                            txtTitle: StaticString.dueDate,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
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
                          color: ColorConstants.custOrangeF28E20,
                          elevation: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const CustImage(
                                imgURL: ImgName.commonCalendar,
                                imgColor: ColorConstants.backgroundColorFFFFFF,
                                width: 12,
                              ),
                              CustomText(
                                txtTitle: "30 Oct 2021",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color:
                                          ColorConstants.backgroundColorFFFFFF,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 38),
                  _buildViewInvoice(),
                  const SizedBox(height: 50),
                  _buildLogPaymentBtn(context),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
//------------------------------ Carousel Image Slider -----------------------------/

Widget buildSlider(String urlImg, BuildContext context) {
  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CustImage(
          imgURL: urlImg,
          height: 175,
          width: double.infinity,
        ),
      ),
      Positioned(
        top: 10,
        left: 15,
        child: Container(
          height: 24,
          decoration: BoxDecoration(
            color: ColorConstants.custPureRedFF0000.withOpacity(0.55),
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: CustomText(
            txtTitle: "Urgent",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custWhiteF9F9F9,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    ],
  );
}
//------------------------------------ View Invoice --------------------------------/

Widget _buildViewInvoice() {
  return const UploadMediaOutlinedWidget(
    title: StaticString.viewInvoice,
    userRole: UserRole.TENANT,
    image: ImgName.tenantPdf,
  );
}
//----------------------------------- Log Payment Button ---------------------------/

Widget _buildLogPaymentBtn(context) {
  return CommonElevatedButton(
    bttnText: StaticString.logPayment.toUpperCase(),
    color: ColorConstants.custRedD92727,
    fontSize: 16,
    onPressed: () {
      showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return const InvoicePaymentBottomsheet();
        },
      );
    },
  );
}
