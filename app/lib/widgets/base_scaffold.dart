import 'package:baby_guard/blocs/auth/auth_bloc.dart';
import 'package:baby_guard/blocs/auth/auth_event.dart';
import 'package:baby_guard/pages/home_page.dart';
import 'package:baby_guard/pages/sensors_page.dart';
import 'package:baby_guard/utils/constants.dart';
import 'package:baby_guard/utils/utils.dart';
import 'package:baby_guard/widgets/app_title.dart';
import 'package:baby_guard/widgets/theme_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    required this.child,
    this.floatingActionButton,
  });

  final Widget child;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    const appTitle = AppTitle();

    return Scaffold(
      appBar: AppBar(title: appTitle),
      floatingActionButton: floatingActionButton,
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
                title: const Text('Início'),
                onTap: () async {
                  await Utils.replaceNavigation(context, HomePage.route);
                },
              ),
              ListTile(
                title: const Text('Sensores'),
                onTap: () async {
                  await Utils.replaceNavigation(context, SensorsPage.route);
                },
              ),
              const Divider(height: 0),
              const ThemeExpansionTile(),
              const Divider(height: 0),
              ListTile(
                title: const Text('Sair'),
                onTap: () {
                  BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
                },
              ),
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
