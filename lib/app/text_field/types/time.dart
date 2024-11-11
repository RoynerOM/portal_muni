import 'package:flutter/material.dart';
import 'package:portal_muni/app/text_field/text_field_ui.dart';
import 'package:portal_muni/app/theme/app_colors.dart';

class InputTime extends StatelessWidget {
  const InputTime({
    super.key,
    required this.controller,
    this.iconColor,
    this.labelText,
    this.hitText,
    this.validator,
    this.decoration,
    required this.onChanged,
    this.icon,
  });

  final TextEditingController? controller;
  final Color? iconColor;
  final String? labelText;
  final String? hitText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<TimeOfDay>? onChanged;
  final InputDecoration? decoration;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext _, StateSetter setState) {
        return Input(
          controller: controller,
          suffixIcon: icon ??
              Icon(
                Icons.timelapse,
                color: iconColor ?? AppColor.icon2,
              ),
          labelText: labelText,
          hintText: hitText,
          decoration: decoration,
          validator: validator,
          enabled: true,
          isCollapsed: false,
          readOnly: true,
          onTap: () async {
            TimeOfDay selectedTime = TimeOfDay.now();

            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: selectedTime,
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData(
                    useMaterial3: true,
                    dialogTheme: DialogTheme(
                      surfaceTintColor: AppColor.background,
                      backgroundColor: AppColor.background,
                    ),
                  ),
                  child: child!,
                );
              },
            );

            if (picked != null && picked != selectedTime) {
              setState(
                () {
                  controller!.text = formatTime(picked);
                  onChanged!(picked);
                },
              );
            }
          },
        );
      },
    );
  }
}

String formatTime(TimeOfDay time) {
  int hour = time.hourOfPeriod;
  int minute = time.minute;
  String period = time.period == DayPeriod.am ? 'AM' : 'PM';

  return '$hour:$minute $period';
}
