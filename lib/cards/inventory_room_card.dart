import 'package:flutter/material.dart';

import '../constant/img_font_color_string.dart';
import '../widgets/cust_image.dart';
import '../widgets/custom_text.dart';

class InventoryTenantRoomCard extends StatefulWidget {
  const InventoryTenantRoomCard({
    super.key,
    required this.iconImage,
    required this.title,
    required this.color,
  });
  final String iconImage;
  final String title;
  final Color color;

  @override
  State<InventoryTenantRoomCard> createState() =>
      _InventoryTenantRoomCardState();
}

class _InventoryTenantRoomCardState extends State<InventoryTenantRoomCard> {
  int _itemCount = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorConstants.backgroundColorFFFFFF,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custBlack000000.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 0.2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustImage(
                  imgURL: widget.iconImage,
                ),
              ),
              const SizedBox(width: 10),
              CustomText(
                txtTitle: widget.title,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: ColorConstants.backgroundColorFFFFFF,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.custBlack000000.withOpacity(0.1),
                  blurRadius: 15,
                  spreadRadius: 0.2,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  constraints: const BoxConstraints(),
                  iconSize: 18,
                  onPressed: () {
                    if (mounted) {
                      setState(() {
                        _itemCount--;
                      });
                    }
                  },
                  icon: const Icon(Icons.remove),
                ),
                CustomText(
                  txtTitle: _itemCount.toString(),
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custBlue1EC0EF,
                      ),
                ),
                IconButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  constraints: const BoxConstraints(),
                  iconSize: 18,
                  onPressed: () {
                    if (mounted) {
                      setState(() {
                        _itemCount++;
                      });
                    }
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
