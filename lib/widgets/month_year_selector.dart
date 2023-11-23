import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:zungu_mobile/main.dart';

import '../constant/color_constants.dart';

Future<DateTime?> selectMonthAndYear({
  required TextEditingController controller,
  required Color color,
  DateTime? initialDate,
}) async {
  final DateTime? newselectedMontYear = await showMonthYearPicker(
    context: getContext,
    initialDate: initialDate ?? DateTime(2022),
    firstDate: DateTime(2022),
    lastDate: DateTime(2030),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: color,
            secondary: ColorConstants.custDarkPurple500472,
            onSecondary: Colors.white,
          ),
          dialogBackgroundColor: ColorConstants.backgroundColorFFFFFF,
        ),
        child: child!,
      );
    },
  );

  if (newselectedMontYear != null) {
    controller.text = DateFormat('MMM yyyy').format(newselectedMontYear);
  }
  return newselectedMontYear;
}
