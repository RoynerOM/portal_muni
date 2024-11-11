import 'package:flutter/material.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:toast_message_bar/toast_message_bar.dart';

class Alert {
  static void success(
    BuildContext context, {
    String? title,
    String? message,
    Widget? icon,
    bool pop = false,
  }) {
    ToastMessageBar(
      icon: icon ??
          Icon(
            Icons.check_circle,
            color: HexColor('#07a098'),
          ),
      title: title,
      titleSize: 18,
      backgroundColor: HexColor('#effefb'),
      borderRadius: BorderRadius.circular(20),
      borderColor: HexColor('#25dccc'),
      titleColor: HexColor('#023031'),
      margin: const EdgeInsets.fromLTRB(25, 60, 25, 25),
      message: message,
      messageSize: 16,
      messageColor: HexColor('#023031'),
      duration: const Duration(seconds: 3),
      toastMessageBarPosition: ToastMessageBarPosition.top,
      onTap: (x) {
        x.dismiss();
      },
      mainButton: Icon(
        Icons.close_rounded,
        color: HexColor('#07a098'),
      ),
    ).show(context).then((value) {
      if (!context.mounted) return;
    });
  }

  static void error(
    BuildContext context, {
    String? title,
    String? message,
    Widget? icon,
  }) {
    ToastMessageBar(
      icon: icon ??
          Icon(
            Icons.info,
            color: HexColor('#e61c2b'),
          ),
      title: title,
      titleSize: 18,
      message: message,
      messageSize: 16,
      onTap: (x) {
        x.dismiss();
      },
      mainButton: Icon(
        Icons.close_rounded,
        color: HexColor('#e61c2b'),
      ),
      backgroundColor: HexColor('#fff1f2'),
      borderRadius: BorderRadius.circular(20),
      borderColor: HexColor('#ff6974'),
      titleColor: HexColor('#48070c'),
      messageColor: HexColor('#48070c'),
      isDismissible: true,
      margin: const EdgeInsets.fromLTRB(25, 60, 25, 25),
      duration: const Duration(seconds: 3),
      toastMessageBarPosition: ToastMessageBarPosition.top,
    ).show(context);
  }
}
