import 'package:baby_guard/utils/constants.dart';
import 'package:baby_guard/widgets/base_page.dart';
import 'package:baby_guard/widgets/base_page_content_layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: BasePageContentLayout(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Home',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Text('Seja bem-vindo(a) ao ${Constants.appName}!'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
