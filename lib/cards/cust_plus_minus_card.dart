// ignore_for_file: unnecessary_statements

import 'package:flutter/material.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

import '../constant/img_font_color_string.dart';

class PlusMinusCard extends StatefulWidget {
  final int index;
  const PlusMinusCard({required this.index});

  @override
  State<PlusMinusCard> createState() => _PlusMinusCardState();
}

class _PlusMinusCardState extends State<PlusMinusCard> {
  int bedroomItemCount = 0;
  int bathroomItemCount = 0;
  int livingroomItemCount = 0;
  @override
  Widget build(BuildContext context) {
    int roomItemCount = 0;
    if (mounted) {
      setState(() {
        if (widget.index == 0) {
          roomItemCount = bedroomItemCount;
        } else if (widget.index == 1) {
          roomItemCount = bathroomItemCount;
        } else if (widget.index == 2) {
          roomItemCount = livingroomItemCount;
        }
      });
    }

    return //Plus Minus and Count Card
        Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => minusBtnAction(index: widget.index),
            child: const Icon(
              Icons.remove,
              size: 15,
              color: ColorConstants.custGrey707070,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: CustomText(
              txtTitle: roomItemCount.toString(),
              align: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custBlue1EC0EF,
                  ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () => plusBtnAction(index: widget.index),
            child: const Icon(
              Icons.add,
              size: 15,
              color: ColorConstants.custGrey707070,
            ),
          ),
        ],
      ),
    );
  }

// Minus button action
  void minusBtnAction({required int index}) {
    if (mounted) {
      setState(() {
        if (index == 0) {
          bedroomItemCount == 0 ? null : bedroomItemCount--;
        } else if (index == 1) {
          bathroomItemCount == 0 ? null : bathroomItemCount--;
        } else if (index == 2) {
          livingroomItemCount == 0 ? null : livingroomItemCount--;
        }
      });
    }
  }

// Plus button action
  void plusBtnAction({required int index}) {
    if (mounted) {
      setState(() {
        if (index == 0) {
          bedroomItemCount++;
        } else if (index == 1) {
          bathroomItemCount++;
        } else if (index == 2) {
          livingroomItemCount++;
        }
      });
    }
  }
}
