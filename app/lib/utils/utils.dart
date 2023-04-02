import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Utils {
  static Future<void> navigate(BuildContext context, String route) async {
    if (kDebugMode) {
      print(route);
    }

    await Navigator.of(context).pushReplacementNamed(route);
  }
}
