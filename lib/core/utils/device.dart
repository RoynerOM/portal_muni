import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class Device {
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenDensity(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  static bool isSmallScreen(BuildContext context) {
    return width(context) < 600;
  }

  static bool isMediumScreen(BuildContext context) {
    return width(context) >= 600 && width(context) < 1024;
  }

  static bool isLargeScreen(BuildContext context) {
    return width(context) >= 1024;
  }

  static Orientation orientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  static double media(BuildContext context) {
    double w = Device.width(context);
    if (w < 576) return w;
    if (w >= 576 && w < 768) return 540;
    if (w >= 768 && w < 992) return 720;
    if (w >= 992 && w < 1200) return 960;
    if (w >= 1200 && w < 1400) return 1140;
    if (w >= 1400) return 1320;
    return w;
  }

  static double? span(
    BuildContext context, {
    int xs = 12,
    int sm = 12,
    int md = 12,
    int lg = 12,
    int xl = 12,
    int xxl = 12,
    double? gutter = 24,
  }) {
    double w = media(context);
    if (kDebugMode) {
      print(w);
    }
    double percent = (w / 12);
    if (w == 540) return percent * sm - gutter!; //sm
    if (w == 720) return percent * md - gutter!; //md
    if (w == 960) return percent * lg - gutter!; //lg
    if (w == 1140) return percent * xl - gutter!; //xl
    if (w == 1320) return (percent * xxl) - gutter!; //xxl
    return percent * xs - gutter!; //col
  }
}
