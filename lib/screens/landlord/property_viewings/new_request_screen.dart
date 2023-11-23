import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../../../widgets/custom_text.dart';
import 'customise_slider_button.dart';

class NewRequestScreen extends StatefulWidget {
  const NewRequestScreen({super.key});

  @override
  State<NewRequestScreen> createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.topLeft,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 12,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorConstants.custGreen3BD167.withOpacity(0.5),
                  ),
                  child: const Text(StaticString.onlineBook),
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              CustomText(
                txtTitle: "John Smith",
                style: Theme.of(context).textTheme.headline3?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const Spacer(),
              const CustImage(
                height: 25,
                width: 25,
                imgURL: ImgName.callImage,
              ),
              const SizedBox(width: 10),
              const CustImage(
                height: 25,
                width: 25,
                imgURL: ImgName.landlordEdit,
              ),
            ],
          ),
          const SizedBox(height: 3),
          CustomText(
            txtTitle: "121 Cowley Road Littlemore Oxford OX4 4PH",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custGrey707070,
                ),
          ),
          const SizedBox(height: 28),
          invoiceDateCompletedDetails(
            StaticString.viewingDate,
            "20 Mar 2022",
            false,
          ),
          const SizedBox(height: 12),
          invoiceDateCompletedDetails(
            StaticString.viewingTime,
            "11:00 - 12;00",
            true,
          ),
          const SizedBox(height: 15),
          CustomSliderButton(
            action: () {},
            child: const CustImage(
              imgURL: ImgName.sliderButton,
            ),
          )
        ],
      ),
    );
  }

  Widget invoiceDateCompletedDetails(
    String datetitle,
    String date,
    bool time,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txtTitle: datetitle,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorConstants.custGrey707070,
              ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: time
                ? ColorConstants.custgreen00B604
                : ColorConstants.custlightwhitee,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustImage(
                  imgURL: time ? ImgName.tenantTime : ImgName.calenderPurple,
                  height: 12,
                  width: 12,
                ),
                const SizedBox(
                  width: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3, left: 5),
                  child: CustomText(
                    txtTitle: date,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: time
                              ? Colors.white
                              : ColorConstants.custGrey707070,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
