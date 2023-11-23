import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/widgets/calender_card.dart';

import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../models/landlord_payment_history_model.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/custom_text.dart';
import 'edit_rental_payment_bottomsheet.dart';
import 'landlord_payment_history_filter_bottomsheet.dart';

class LandlordIncomePaymentHistoryscreen extends StatefulWidget {
  const LandlordIncomePaymentHistoryscreen({super.key});

  @override
  State<LandlordIncomePaymentHistoryscreen> createState() =>
      _LandlordIncomePaymentHistoryscreenState();
}

class _LandlordIncomePaymentHistoryscreenState
    extends State<LandlordIncomePaymentHistoryscreen> {
  //------------------------------Variables-----------------------------//
  List<PropertyHistoryModel> propertyHistoryList =
      propertyHistoryModelFromJson(json.encode(paymentHistoryDummyData));

  //------------------------------Ui-----------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  //------------------------------Widgets-----------------------------//

  // App Bar
  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: ColorConstants.custDarkPurple500472,
      title: const CustomText(
        txtTitle: StaticString.paymentHistory,
      ),
      actions: [
        IconButton(
          onPressed: filterBtnaction,
          icon: const CustImage(
            imgURL: ImgName.filter,
            imgColor: Colors.white,
            height: 25,
            width: 25,
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: propertyHistoryList.length,
        itemBuilder: (context, index) {
          return _paymentHistoryCard(
            propertyHistoryModel: propertyHistoryList[index],
          );
        },
      ),
    );
  }

  // Payment hitory card
  Widget _paymentHistoryCard({
    required PropertyHistoryModel propertyHistoryModel,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
          )
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          _custTitleAndAmountRow(
            isSymboll: true,
            title: StaticString.rent1,
            amount: propertyHistoryModel.paymentRent,
          ),

          if (propertyHistoryModel.lateFee.isEmpty)
            Container()
          else
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: _custTitleAndAmountRow(
                isSymboll: true,
                title: StaticString.lateFee,
                amount: propertyHistoryModel.lateFee,
              ),
            ),
          const SizedBox(height: 15),

          _custTitleAndAmountRow(
            title: StaticString.paymentType,
            amount: propertyHistoryModel.paymentType,
          ),

          const SizedBox(height: 20),

          // Calender card row
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              children: [
                CommonCalenderCard(
                  title: StaticString.paymentDate,
                  date: propertyHistoryModel.paymentDate
                      .substring(0, 2),
                  dateMonth: StaticString.startTenancyDate,
                  calenderUrl: ImgName.commonCalendar,
                  bgColor: ColorConstants.custWhiteF7F7F7,
                  imgColor: ColorConstants.custDarkPurple500472,
                ),
                SizedBox(width: MediaQuery.of(context).size.height * 0.035),
                CommonCalenderCard(
                  calenderUrl: ImgName.commonCalendar,
                  title: StaticString.rentPeriod,
                  date: propertyHistoryModel.rentPeriod
                      .substring(0, 2)
                      ,
                  dateMonth: propertyHistoryModel.rentPeriod
                      .substring(3, propertyHistoryModel.rentPeriod.length),
                  bgColor: ColorConstants.custWhiteF7F7F7,
                  imgColor: ColorConstants.custDarkPurple500472,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          //recuring payment
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (propertyHistoryModel.isRecuringPayment)
                Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 7,
                    top: 10,
                    bottom: 10,
                  ),
                  decoration: const BoxDecoration(
                    color: ColorConstants.custDarkPurple500472,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: CustomText(
                    txtTitle: StaticString.recuringPayment,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                )
              else
                Container(),
              Row(
                children: [
                  // Edit icon card
                  InkWell(
                    onTap: editRentalPaymntBtnAction,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: const BoxDecoration(
                        color: ColorConstants.custDarkPurple500472,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(20)),
                      ),
                      child: const CustImage(imgURL: ImgName.editIcon),
                    ),
                  ),
                  const SizedBox(width: 1.5),
                  //Delete icon card
                  InkWell(
                    onTap: deleteRentalPaymentBtnAction,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: const BoxDecoration(
                        color: ColorConstants.custBlue1EC0EF,
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(10)),
                      ),
                      child: const CustImage(imgURL: ImgName.deleteWhite),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  // custom Title and amount row
  Widget _custTitleAndAmountRow({
    required String title,
    bool isSymboll = false,
    required String amount,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txtTitle: title,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custGrey707070,
                  fontWeight: FontWeight.w400,
                ),
          ),
          // rent amount text
          CustomText(
            txtTitle: isSymboll ? "${StaticString.currency}$amount" : amount,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custBlue1EC0EF,
                  fontWeight: FontWeight.w400,
                ),
          )
        ],
      ),
    );
  }

  //---------------------------------- Button action---------------------------------//
  // Manage Property Button action
  void filterBtnaction() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const LandlordPaymentHistoryfilterBottomSheet();
      },
    );
  }

  // Edit Rental payment Button action
  void editRentalPaymntBtnAction() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const EditRentalPaymentBottomsheet();
      },
    );
  }

  // Delete Rental payment Button action
  void deleteRentalPaymentBtnAction() {
    showAlert(
      context: context,
      showIcon: false,
      icon: ImgName.activesubscriptionImage,
      title: StaticString.deleteTransection,
      message: StaticString.areYouSureYouWantToDeleteThisEntry,
      singleBtnTitle: StaticString.delete1,
      singleBtnColor: ColorConstants.custRedFF0000,
    );
  }
}
