import 'package:flutter/material.dart';

class AppRoutes {
  static const home = "/";
  static const settings = "/settings";

  static void navigateTo(BuildContext context, String routeName) {
    switch (routeName) {
      case AppRoutes.home:
        Navigator.popUntil(
            context, (route) => route.settings.name == AppRoutes.home);
        break;
      default:
        Navigator.pushReplacementNamed(context, routeName);
    }
  }

  static void push(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }
}
