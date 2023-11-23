import 'package:flutter/material.dart';

import '../../../constant/color_constants.dart';
import '../../../constant/string_constants.dart';
import '../../../widgets/common_outline_elevated_button.dart';
import '../../../widgets/custom_text.dart';

class SelectPropertyPopup extends StatefulWidget {
  final Function() onDiscard;
  final Function() onContintue;
  const SelectPropertyPopup({
    super.key,
    required this.onDiscard,
    required this.onContintue,
  });

  @override
  State<SelectPropertyPopup> createState() => _SelectPropertyPopupState();
}

class _SelectPropertyPopupState extends State<SelectPropertyPopup> {
  @override
  Widget build(BuildContext context) {
    return _buildDeleteContent();
  }

  Widget _buildDeleteContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomText(
              txtTitle: StaticString.addPropertyMsg,
              align: TextAlign.center,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              children: [
                Expanded(
                  child: CommonOutlineElevatedButton(
                    bttnText: StaticString.discard,
                    borderColor: ColorConstants.custRedE96254,
                    textColor: ColorConstants.custRedE96254,
                    onPressed: widget.onDiscard,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CommonOutlineElevatedButton(
                    bttnText: StaticString.continu.toUpperCase(),
                    borderColor: ColorConstants.custGreen3DAE74,
                    textColor: ColorConstants.custGreen3DAE74,
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onContintue();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
