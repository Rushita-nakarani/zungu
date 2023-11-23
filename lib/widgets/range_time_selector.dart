import 'package:flutter/material.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';

import '../main.dart';

Future<void> selectRangeTime({
  required TextEditingController controller,
}) async {
  TimeRangePicker.show(
    unSelectedEmpty: false,
    context: getContext,
    onSubmitted: (TimeRangeValue value) {
      if (value.startTime != null && value.endTime != null) {
        controller.text =
            "${value.startTime?.hour}:${value.startTime?.minute} - ${value.endTime?.hour}:${value.endTime?.minute}";
      }
    },
  );
}
