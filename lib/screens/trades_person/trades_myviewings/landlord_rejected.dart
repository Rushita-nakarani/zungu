//---------------------------- Trades LandLord Rejecte Screen ---------------------//

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class TradesLandLordRejecteScreen extends StatefulWidget {
  const TradesLandLordRejecteScreen({super.key});

  @override
  State<TradesLandLordRejecteScreen> createState() =>
      _TradesLandLordRejecteScreenState();
}

class _TradesLandLordRejecteScreenState
    extends State<TradesLandLordRejecteScreen> {
//-------------------------------------- UI ----------------------------------------//
  @override
  Widget build(BuildContext context) {
    return _buildLandlordRejected();
  }

  Widget _buildLandlordRejected() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5),
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
                      txtTitle: "John Smith",
                      txtSubTitle: "121 Cowley Road Littlemore Oxford OX4 4PH",
                      txtDate: "Viewing Date",
                      txtTime: "Viewing Time",
                      date: "20 Mar 2022",
                      time: "13:45 - 14:30",
                      propertyStatus: "Property already Taken",
                    ),
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

//--------------------------------- property Details --------------------------------/

  Widget _propertyDetails({
    required txtTitle,
    required txtSubTitle,
    required txtDate,
    required txtTime,
    required date,
    required time,
    required propertyStatus,
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
                        imgURL: ImgName.commonCalendar,
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
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            height: 50,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorConstants.custLightRedFEE5E5,
            ),
            child: CustomText(
              txtTitle: propertyStatus,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custBrown876D6D,
                    fontWeight: FontWeight.w600,
                  ),
            ),
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
                  color: ColorConstants.custRedFF0000.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: CustomText(
                  txtTitle: "Rejected".toUpperCase(),
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
