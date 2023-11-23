import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zungu_mobile/main.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'custom_text.dart';

class CommonBadgeWithIcon extends StatelessWidget {
  final Widget icon;
  final String badgeCount;
  final Color color;
  final bool disable;
  final Function()? onPressed;

  const CommonBadgeWithIcon({
    super.key,
    required this.icon,
    required this.badgeCount,
    required this.color,
    this.disable = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return _commonBadgeIcon();
  }

  Widget _commonBadgeIcon() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        IconButton(
          onPressed: disable ? () {} : onPressed,
          icon: icon,
        ),
        Positioned(
          right: 7,
          top: 7,
          child: CircleAvatar(
            maxRadius: 8,
            minRadius: 8,
            backgroundColor: color,
            child: CustomText(
              txtTitle: badgeCount,
              style: Theme.of(getContext)
                  .textTheme
                  .caption
                  ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),

          // Container(
          //   padding: const EdgeInsets.all(2),
          //   decoration: BoxDecoration(
          //     color: color,
          //     borderRadius: BorderRadius.circular(6),
          //   ),
          //   constraints: const BoxConstraints(
          //     minWidth: 14,
          //     minHeight: 14,
          //   ),
          //   child: Text(
          //     badgeCount,
          //     style: const TextStyle(
          //       color: Colors.white,
          //       fontSize: 8,
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
        )
      ],
    );
  }
}
