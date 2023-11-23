import 'package:flutter/material.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class CommonContainerWithImageValue extends StatelessWidget {
  final String imgurl;
  final Color valueContainerColor;
  final String imgValue;
  final Color? midContainerColor;
  final String? midContainertxt;
  bool secondContainer = false;
  void Function()? onTap;
  CommonContainerWithImageValue({
    super.key,
    required this.imgurl,
    required this.valueContainerColor,
    required this.imgValue,
    this.midContainerColor,
    this.midContainertxt,
    required this.secondContainer,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.bottomLeft,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 15,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CustImage(
                width: double.infinity,
                height: 200,
                imgURL: imgurl,
                boxfit: BoxFit.fitWidth,
              ),
            ),
          ),
          Container(
            height: 30,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: valueContainerColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: CustomText(
              txtTitle: imgValue,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          if (secondContainer == true)
            Positioned(
              top: MediaQuery.of(context).size.height * 0.03,
              left: MediaQuery.of(context).size.width * 0.05,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: midContainerColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomText(
                  txtTitle: midContainertxt,
                  align: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: Colors.white),
                ),
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }
}
