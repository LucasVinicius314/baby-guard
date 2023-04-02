import 'package:baby_guard/blocs/theme/theme_bloc.dart';
import 'package:baby_guard/blocs/theme/theme_state.dart';
import 'package:baby_guard/core/bloc_providers.dart';
import 'package:baby_guard/core/repository_providers.dart';
import 'package:baby_guard/pages/home_page.dart';
import 'package:baby_guard/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProviders(
      child: BlocProviders(
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: Constants.appName,
              themeMode: state.themeMode,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Poppins',
                brightness: Brightness.light,
                primarySwatch: Colors.blue,
              ),
              darkTheme: ThemeData(
                fontFamily: 'Poppins',
                colorScheme: ColorScheme.fromSwatch(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.blue,
                ).copyWith(secondary: Colors.blueAccent),
              ),
              routes: {
                // Home page.
                HomePage.route: (context) => const HomePage(),
              },
            );
          },
        ),
      ),
    );
  }
}
