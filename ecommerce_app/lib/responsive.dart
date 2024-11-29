import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
    });

    static bool isMobile(BuildContext context) =>
    MediaQuery.sizeOf(context).width <= 600;

    static bool isTablet(BuildContext context) =>
    MediaQuery.sizeOf(context).width < 1024 &&
    MediaQuery.sizeOf(context).width >= 600;

    static bool isDesktop(BuildContext context) =>
    MediaQuery.sizeOf(context).width >= 1024;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    if (size.width >=1024) {
      return desktop;
    }
    if (size.width >=600 && size.width <1024) {
      return tablet;
    }
    else {
      return mobile;
    }
  }
}
