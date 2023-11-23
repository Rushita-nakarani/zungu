import 'package:flutter/material.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../constant/img_constants.dart';

typedef RatingChangeCallback = void Function(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final double size;
  final Color? starColor;
  final RatingChangeCallback? onRatingChanged;
  final String fullStar;
  final String halfStar;
  final String star;

  final MainAxisAlignment mainAxisAlignment;

  const StarRating({
    this.starCount = 5,
    this.rating = .0,
    this.size = 36,
    this.starColor,
    this.onRatingChanged,
    this.fullStar = ImgName.ratingsFill,
    this.halfStar = ImgName.ratingsHalf,
    this.star = ImgName.ratingsNone,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: List.generate(starCount, (index) => buildStar(context, index)),
    );
  }

  Widget buildStar(BuildContext context, int index) {
    Widget icon;
    if (index >= rating) {
      icon = CustImage(
        imgURL: star,
        height: size,
        imgColor: starColor,
        width: size,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = CustImage(
        imgURL: halfStar,
        height: size,
        imgColor: starColor,
        width: size,
      );
    } else {
      icon = CustImage(
        imgURL: fullStar,
        height: size,
        imgColor: starColor,
        width: size,
      );
    }
    return GestureDetector(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged!(index + 1.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 3),
        child: icon,
      ),
    );
  }
}
