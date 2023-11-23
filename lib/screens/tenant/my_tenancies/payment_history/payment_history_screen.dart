import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/color_constants.dart';

import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../models/landlord_payment_history_model.dart';
import '../../../../utils/cust_eums.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/custom_text.dart';
import '../custom_datebox.dart';
import 'payment_history_edit_bottomsheet.dart';
import 'payment_history_filter_bottomsheet.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key, required this.screenType});
  final UserRole screenType;

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  // TODO: put condition for api fetching when API is available

  List<PropertyHistoryModel> propertyHistoryList =
      propertyHistoryModelFromJson(json.encode(paymentHistoryDummyData));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: widget.screenType == UserRole.LANDLORD
          ? ColorConstants.custDarkPurple500472
          : ColorConstants.custDarkPurple662851,
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.screenType == UserRole.TENANT) _buildAddressCard(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: propertyHistoryList.length,
              itemBuilder: (context, index) {
                return _paymentHistoryCard(
                  propertyHistoryModel: propertyHistoryList[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: const EdgeInsets.all(10),
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
      child: Row(
        children: [
          const CustImage(
            imgURL: ImgName.tenantMapPointer,
            width: 24,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  txtTitle: "Property Address",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                CustomText(
                  txtTitle:
                      "Flat 5 City Gardens, 3B Crown Way Manchester M15 5LP",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custDarkPurple150934,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ],
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
            title: StaticString.rent,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomCalender(
                    title: StaticString.paymentDate,
                    date: "15",
                    monthYear: "Sep 2021",
                    backgroundcolor: ColorConstants.custWhiteF7F7F7,
                    fontColor: widget.screenType == UserRole.LANDLORD
                        ? ColorConstants.custDarkPurple500472
                        : ColorConstants.custDarkPurple662851,
          
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: CustomCalender(
                    title: StaticString.rentPeriod,
                    date: "",
                    monthYear: "Jul 2021",
                    backgroundcolor: ColorConstants.custWhiteF7F7F7,
                    fontColor: widget.screenType == UserRole.LANDLORD
                        ? ColorConstants.custDarkPurple500472
                        : ColorConstants.custDarkPurple662851,
                  ),
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
                _buildRecuringPayment()
              else
                Container(),
              _buildEditAndDelete(),
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
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  color: widget.screenType == UserRole.LANDLORD
                      ? ColorConstants.custBlue1EC0EF
                      : ColorConstants.custDarkYellow838500,
                  fontWeight: FontWeight.w600,
                ),
          )
        ],
      ),
    );
  }

  Widget _buildRecuringPayment() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: widget.screenType == UserRole.LANDLORD
            ? ColorConstants.custDarkPurple500472
            : ColorConstants.custDarkPurple662851,
        borderRadius: const BorderRadius.only(
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
    );
  }

  Widget _buildEditAndDelete() {
    return Row(
      children: [
        // Edit icon card
        InkWell(
          onTap: editRentalPaymntBtnAction,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: widget.screenType == UserRole.LANDLORD
                  ? ColorConstants.custDarkPurple500472
                  : ColorConstants.custDarkPurple662851,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
              ),
            ),
            child: const CustImage(imgURL: ImgName.editIcon),
          ),
        ),
        const SizedBox(width: 1.5),

        //Delete icon card
        InkWell(
          onTap: deleteRentalPaymntBtnAction,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: widget.screenType == UserRole.LANDLORD
                  ? ColorConstants.custBlue1EC0EF
                  : ColorConstants.custDarkYellow838500,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(15),
              ),
            ),
            child: const CustImage(imgURL: ImgName.deleteWhite),
          ),
        )
      ],
    );
  }

  //---------------------------------- Button action---------------------------------//
  // Manage Property Button action
  void filterBtnaction() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return PaymentHistoryFilterBottomSheet(screenType: widget.screenType);
        // return Container();
      },
    );
  }

  // Edit Rental payment Button action
  void editRentalPaymntBtnAction() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return EditRentPaymentBottomsheet(screenType: widget.screenType);
        // return Container();
      },
    );
  }

  // Delete Rental payment Button action
  void deleteRentalPaymntBtnAction() {
    showAlert(
      context: context,
      title: StaticString.deleteTransection,
      singleBtnTitle: StaticString.delete,
      showIcon: false,
      singleBtnColor: ColorConstants.custChartRed,
      message: AlertMessageString.deleteTranctionConf,
    );
  }
}
