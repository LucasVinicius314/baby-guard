import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Utils {
  static Future<void> popNavigation(BuildContext context) async {
    if (kDebugMode) {
      print('navigating back');
    }

    await Navigator.of(context).maybePop();
  }

  static Future<void> pushNavigation(
    BuildContext context,
    String route,
  ) async {
    if (kDebugMode) {
      print('navigating to $route');
    }

    await Navigator.of(context).pushNamed(route);
  }

  static Future<void> replaceNavigation(
    BuildContext context,
    String route,
  ) async {
    if (kDebugMode) {
      print('navigating to $route');
    }

    await Navigator.of(context)
        .pushNamedAndRemoveUntil(route, (route) => false);
  }
}
