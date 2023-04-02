import 'package:baby_guard/pages/home_page.dart';
import 'package:baby_guard/utils/constants.dart';
import 'package:baby_guard/widgets/app_title.dart';
import 'package:baby_guard/widgets/theme_expansion_tile.dart';
import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  const BasePage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    const appTitle = AppTitle();

    return Scaffold(
      appBar: AppBar(title: appTitle),
      body: child,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBar(
                title: appTitle,
                automaticallyImplyLeading: false,
              ),
              ListTile(
                title: const Text('Home'),
                onTap: () async {
                  await Navigator.of(context)
                      .pushReplacementNamed(HomePage.route);
                },
              ),
              // const Divider(height: 0),
              // ...Constants.menuOptions.map((e) {
              //   return ListTile(
              //     title: Text(e.label),
              //     enabled: e.isEnabled,
              //     onTap: e.isEnabled
              //         ? () async {
              //             await Navigator.of(context)
              //                 .pushReplacementNamed(e.route);
              //           }
              //         : null,
              //   );
              // }),
              const Divider(height: 0),
              const ThemeExpansionTile(),
              const Divider(height: 0),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '2023, ${Constants.appName}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
