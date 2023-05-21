import 'package:baby_guard/utils/assets.dart';
import 'package:baby_guard/utils/constants.dart';
import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 32,
          width: 32,
          child: Image.asset(ImageAssets.babyGuard),
        ),
        const SizedBox(width: 8),
        const Text(Constants.appName),
      ],
    );
  }
}
