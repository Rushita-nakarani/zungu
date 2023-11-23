import 'package:flutter/material.dart';

class LinearContainer extends StatelessWidget {
  final double? width;
  final Color? color;

  const LinearContainer({super.key, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        alignment: Alignment.centerLeft,
        width: width,
        height: 2,
        decoration: BoxDecoration(
          color: color,
        ),
      ),
    );
  }
}
