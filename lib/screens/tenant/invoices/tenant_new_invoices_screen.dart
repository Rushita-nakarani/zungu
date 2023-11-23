//----------------------------- Tenant NewInvoices Screen -------------------------//

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/tenant/invoices/tenant_new_invoices_detail_screen.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class TenantNewInvoicesScreen extends StatefulWidget {
  const TenantNewInvoicesScreen({super.key});

  @override
  State<TenantNewInvoicesScreen> createState() =>
      _TenantNewInvoicesScreenState();
}

class _TenantNewInvoicesScreenState extends State<TenantNewInvoicesScreen> {
  //-------------------------------------- UI ---------------------------------------//

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 2,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _newInvoices();
        },
      ),
    );
  }

  //------------------------------------ Widgets ------------------------------------//

  Widget _newInvoices() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const TenantNewInvoicesDetails(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            //Image
            SizedBox(
              height: 175,
              child: Stack(
                children: [
                  Positioned(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: const CustImage(
                        imgURL:
                            "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                        height: 175,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 15,
                    child: Container(
                      height: 24,
                      decoration: BoxDecoration(
                        color:
                            ColorConstants.custPureRedFF0000.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 15,
                      ),
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  //JobIdNumber
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            txtTitle: StaticString.tenantJobIdNumber,
                            style:
                                Theme.of(context).textTheme.headline1?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.custDarkBlue150934,
                                    ),
                          ),
                          CustomText(
                            txtTitle: "#YQ6CA040521",
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.custDarkBlue150934,
                                    ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      //Invoice Number
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            txtTitle: StaticString.invoiceNumber,
                            style:
                                Theme.of(context).textTheme.headline1?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.custDarkBlue150934,
                                    ),
                          ),
                          CustomText(
                            txtTitle: "#1CN4627",
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
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
                    txtTitle: "121 Cowley  Road Littlemore OX4 4PH",
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
                          //ReplaceTiles
                          CustomText(
                            txtTitle: StaticString.tenantReplaceTiles,
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                ?.copyWith(
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
                              //Reported
                              CustomText(
                                txtTitle: StaticString.reported,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const CustImage(
                                    imgURL: ImgName.commonCalendar,
                                    imgColor:
                                        ColorConstants.custDarkPurple662851,
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
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
                                  onRatingUpdate: (value) {},
                                ),
                              ),
                              const SizedBox(width: 6),
                              //Star Count
                              CustomText(
                                txtTitle: "(3.5)",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.custGrey707070,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 3),
                          //Price
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const CustImage(
                                    imgURL: ImgName.commonCalendar,
                                    imgColor:
                                        ColorConstants.custDarkPurple662851,
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
                              //DueDate
                              CustomText(
                                txtTitle: StaticString.dueDate,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const CustImage(
                                    imgURL: ImgName.commonCalendar,
                                    imgColor:
                                        ColorConstants.backgroundColorFFFFFF,
                                    width: 12,
                                  ),
                                  CustomText(
                                    txtTitle: "30 Oct 2021",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: ColorConstants
                                              .backgroundColorFFFFFF,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
