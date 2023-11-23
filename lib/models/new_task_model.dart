import 'package:flutter/material.dart';

class NewTaskModel {
  final String iconImage;
  final String title;
  final int itemCount;
  final Color primaryColor;
  final Color secondaryColor;
  final Function onTap;

  NewTaskModel({
    required this.iconImage,
    required this.title,
    required this.itemCount,
    required this.primaryColor,
    required this.secondaryColor,
    required this.onTap,
  });
}
