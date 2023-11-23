//----------------------------- Tenant Paid Invoices Screen -----------------------//

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class TenantPaidInvoicesScreen extends StatefulWidget {
  const TenantPaidInvoicesScreen({super.key});

  @override
  State<TenantPaidInvoicesScreen> createState() =>
      _TenantPaidInvoicesScreenState();
}

class _TenantPaidInvoicesScreenState extends State<TenantPaidInvoicesScreen> {
  //-------------------------------------- UI ---------------------------------------//

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _paidInvoices(context),
    );
  }

//------------------------------------ Widgets ------------------------------------//

  Widget _paidInvoices(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: ColorConstants.backgroundColorFFFFFF,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.custBlack000000.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 0.2,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Job Id Number
                      CustomText(
                        txtTitle: StaticString.tenantJobIdNumber,
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.custDarkBlue150934,
                            ),
                      ),
                      CustomText(
                        txtTitle: "#UIR7M141221",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.custDarkBlue150934,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Invoice Number
                      CustomText(
                        txtTitle: StaticString.invoiceNumber,
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.custDarkBlue150934,
                            ),
                      ),
                      CustomText(
                        txtTitle: "#1BF7684",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.custDarkBlue150934,
                            ),
                      ),
                    ],
                  ),
                  //Address
                  const SizedBox(height: 8),
                  CustomText(
                    txtTitle: "40 Cherwell Drive Marston Oxford OX3 OLZ",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: ColorConstants.custGrey707070,
                        ),
                  ),
                  const SizedBox(height: 20),
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
                          //Replace Tiles
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
                  const SizedBox(height: 15),
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
                              //Rating Count
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

                      //Date Completed
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            txtTitle: StaticString.dateCompleted,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.custGrey707070,
                                    ),
                          ),
                          SizedBox(
                            height: 30,
                            width: 100,
                            child: Card(
                              color: ColorConstants.cust0CCE1A,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const CustImage(
                                    imgURL: ImgName.duedatecalinvoices,
                                    width: 12,
                                  ),
                                  CustomText(
                                    txtTitle: "27 Jun 2021",
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
                      //Paid Date
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            txtTitle: StaticString.paidDate,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.custGrey707070,
                                    ),
                          ),
                          SizedBox(
                            height: 30,
                            width: 100,
                            child: Card(
                              color: ColorConstants.custDarkPurple662851,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const CustImage(
                                    imgURL: ImgName.duedatecalinvoices,
                                    width: 12,
                                  ),
                                  CustomText(
                                    txtTitle: "30 Jul 2021",
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
                      const SizedBox(height: 10),
                      //Invoice
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            txtTitle: StaticString.invoice,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.custGrey707070,
                                    ),
                          ),
                          SizedBox(
                            height: 30,
                            width: 100,
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: ColorConstants.cust0CCE1A,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const CustImage(
                                      imgURL: ImgName.tenantPdf,
                                      width: 12,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25),
                                      child: CustomText(
                                        txtTitle:
                                            StaticString.view.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: ColorConstants.cust0CCE1A,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      //Status
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            txtTitle: StaticString.status,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.custGrey707070,
                                    ),
                          ),
                          SizedBox(
                            height: 30,
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustImage(
                                  imgURL: ImgName.paidnvoicesiconsuccess,
                                ),
                                const SizedBox(width: 5),
                                CustomText(
                                  txtTitle: StaticString.paid,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: ColorConstants.custgrey636363,
                                      ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //Edit Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    color: ColorConstants.custDarkYellow838500,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  child: const CustImage(
                    imgURL: ImgName.editIcon,
                    height: 22,
                    width: 22,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
