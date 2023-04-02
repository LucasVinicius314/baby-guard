import 'package:baby_guard/blocs/auth/auth_bloc.dart';
import 'package:baby_guard/blocs/auth/auth_event.dart';
import 'package:baby_guard/pages/home_page.dart';
import 'package:baby_guard/utils/constants.dart';
import 'package:baby_guard/utils/utils.dart';
import 'package:baby_guard/widgets/app_title.dart';
import 'package:baby_guard/widgets/theme_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasePageLayout extends StatelessWidget {
  const BasePageLayout({
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
                title: const Text('Início'),
                onTap: () async {
                  await Utils.navigate(context, HomePage.route);
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
