import 'package:flutter/material.dart';

import '../constant/img_font_color_string.dart';
import '../main.dart';

Future<void> selectTime({
  required TextEditingController controller,
  required Color color,
}) async {
  final TimeOfDay? newSelectedTime = await showTimePicker(
    context: getContext,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: color,
          ),
          dialogBackgroundColor: ColorConstants.backgroundColorFFFFFF,
        ),
        child: child!,
      );
    },
  );
  if (newSelectedTime != null) {
    controller.text = "${newSelectedTime.hour}${":"}${newSelectedTime.minute}";
  }
}
