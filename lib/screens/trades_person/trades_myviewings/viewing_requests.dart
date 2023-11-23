//----------------------------- Trades Viewing Requests Screen ---------------------//

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class TradesViewingRequestsScreen extends StatefulWidget {
  const TradesViewingRequestsScreen({super.key});

  @override
  State<TradesViewingRequestsScreen> createState() =>
      _TradesViewingRequestsScreenState();
}

class _TradesViewingRequestsScreenState
    extends State<TradesViewingRequestsScreen> {
//-------------------------------------- UI ----------------------------------------//
  @override
  Widget build(BuildContext context) {
    return _buildViewingRequests();
  }

  Widget _buildViewingRequests() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    //Image
                    _buildImage(),
                    const SizedBox(height: 16),
                    //Property Details
                    _propertyDetails(
                      txtTitle: "Eve Properties",
                      txtSubTitle: "6 Pixey Place, Wolvercote Oxford OX2 8HN",
                      txtDate: "Requested Date",
                      txtTime: "Requested Time",
                      date: "20 Mar 2022",
                      time: "13:45 - 14:30",
                    ),
                    const SizedBox(height: 32),
                    //Button
                    _builBtn(),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

//------------------------------------ Widgets -------------------------------------//

//---------------------------------- BottomSheet ------------------------------------/

  Future _showDeleteViewing() {
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
                        color: ColorConstants.custGrey707070,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Align(
                        child: CustomText(
                          align: TextAlign.center,
                          txtTitle: StaticString.deleteViewing,
                          style:
                              Theme.of(context).textTheme.headline2?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.custDarkPurple150934,
                                  ),
                        ),
                      ),
                    ),
                    Expanded(child: Container())
                  ],
                ),
                const SizedBox(height: 45),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    align: TextAlign.center,
                    txtTitle: StaticString.confirmationDeleteViewing,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstants.custGrey707070,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                const SizedBox(height: 45),
                CommonElevatedButton(
                  bttnText: StaticString.deleteViewing.toUpperCase(),
                  color: ColorConstants.custRedE03816,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
//------------------------------------- Button --------------------------------------/

  Widget _builBtn() {
    return InkWell(
      onTap: () {
        _showDeleteViewing();
      },
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: ColorConstants.custRedFB0000,
              width: 2,
            ),
            color: Colors.transparent,
          ),
          child: Center(
            child: CustomText(
              txtTitle: StaticString.deleteRequest.toUpperCase(),
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custRedFB0000,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
      ),
    );
  }

//--------------------------------- property Details --------------------------------/

  Widget _propertyDetails({
    required txtTitle,
    required txtSubTitle,
    required txtDate,
    required txtTime,
    required date,
    required time,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                txtTitle: txtTitle,
                style: Theme.of(context).textTheme.headline3?.copyWith(
                      fontWeight: FontWeight.w600,
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
                        color: ColorConstants.custGrey7A7A7A.withOpacity(0.3),
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: const Card(
                    child: CustImage(
                      imgURL: ImgName.callcopytrades,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          CustomText(
            txtTitle: txtSubTitle,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.custGrey707070,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                txtTitle: txtDate,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.custGrey707070,
                    ),
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
                        imgURL: ImgName.greenCalender,
                        imgColor: ColorConstants.custCyan017781,
                        width: 14,
                      ),
                      CustomText(
                        txtTitle: date,
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.custGrey707070,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                txtTitle: txtTime,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.custGrey707070,
                    ),
              ),
              SizedBox(
                height: 30,
                width: 100,
                child: Card(
                  color: ColorConstants.custGreen1ACF72,
                  elevation: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CustImage(
                        imgURL: ImgName.watch,
                        imgColor: ColorConstants.custWhiteFFFFFF,
                        width: 14,
                      ),
                      CustomText(
                        txtTitle: time,
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.custWhiteFFFFFF,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
//-------------------------------------- Image --------------------------------------/

  Widget _buildImage() {
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
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: ColorConstants.custGreen3BD167.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: CustomText(
                  txtTitle: "Awaiting Acceptance".toUpperCase(),
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: ColorConstants.custWhiteFFFFFF,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
