import 'package:flutter/material.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class RoundedLgShapeWidget extends StatelessWidget {
  final Color color;
  final String title;
  const RoundedLgShapeWidget({
    Key? key,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(color: color),
            ),
            const SizedBox(
              height: 55,
              width: double.infinity,
            ),
          ],
        ),
        Container(
          height: 55,
          margin: const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(33),
              ),
              color: color,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(33),
              ),
              color: color,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomText(
                txtTitle: title,
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 5),
              Container(
                color: color,
                height: 3,
                width: MediaQuery.of(context).size.width / 6,
              )
            ],
          ),
        ),
      ],
    );
  }
}
