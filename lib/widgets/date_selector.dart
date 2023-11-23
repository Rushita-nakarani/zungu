import 'package:flutter/material.dart';
import 'package:zungu_mobile/main.dart';
import 'package:zungu_mobile/utils/custom_extension.dart';

import '../constant/img_font_color_string.dart';

Future<DateTime?> selectDate({
  required TextEditingController controller,
  required Color color,
  DateTime? initialDate,
}) async {
  final DateTime? newSelectedDate = await showDatePicker(
    context: getContext,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2099),
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

  if (newSelectedDate != null) {
    controller.text = newSelectedDate.toMobileString;
  }
  return newSelectedDate;
}
