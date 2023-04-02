import 'package:dyn_mouse_scroll/dyn_mouse_scroll.dart';
import 'package:flutter/material.dart';

class BasePageContentLayout extends StatelessWidget {
  const BasePageContentLayout({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DynMouseScroll(
      builder: (context, controller, physics) {
        return SingleChildScrollView(
          physics: physics,
          controller: controller,
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ),
        );
      },
    );
  }
}
