import 'package:flutter/material.dart';
import 'package:portal_muni/app/text_field/text_field_ui.dart';
import 'package:portal_muni/app/theme/app_colors.dart';

class InputDate extends StatelessWidget {
  const InputDate({
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
  final ValueChanged<DateTime>? onChanged;
  final InputDecoration? decoration;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext _, StateSetter setState) {
      return Input(
        controller: controller,
        suffixIcon: icon ??
            Icon(
              Icons.calendar_today_outlined,
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
          final DateTime? newDate = await showDatePicker(
            locale: const Locale('es', 'ES'),
            context: context,
            initialDate: DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
            firstDate: DateTime(DateTime.now().year - 20, DateTime.now().month),
            lastDate: DateTime(DateTime.now().year + 20, DateTime.now().month),
            helpText: labelText ?? '',
          );

          if (newDate != null) {
            setState(
              () {
                String splitDate =
                    newDate.toString().replaceAll('-', '/').split(' ').first;
                final split = splitDate.split('/');
                controller!.text = '${split[2]}/${split[1]}/${split[0]}';

                onChanged!(newDate);
              },
            );
          }
        },
      );
    });
  }
}
