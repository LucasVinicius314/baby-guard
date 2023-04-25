import 'package:baby_guard/blocs/theme/theme_bloc.dart';
import 'package:baby_guard/blocs/theme/theme_state.dart';
import 'package:baby_guard/core/bloc_providers.dart';
import 'package:baby_guard/core/repository_providers.dart';
import 'package:baby_guard/pages/home_page.dart';
import 'package:baby_guard/pages/login_page.dart';
import 'package:baby_guard/pages/main_page.dart';
import 'package:baby_guard/pages/register_page.dart';
import 'package:baby_guard/pages/sensors_page.dart';
import 'package:baby_guard/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const buttonStyle =
        ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.all(18)));

    const elevatedButtonTheme = ElevatedButtonThemeData(style: buttonStyle);
    const outlinedButtonTheme = OutlinedButtonThemeData(style: buttonStyle);
    const textButtonTheme = TextButtonThemeData(style: buttonStyle);

    return RepositoryProviders(
      child: BlocProviders(
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: Constants.appName,
              themeMode: state.themeMode,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('pt', 'BR')],
              theme: ThemeData(
                fontFamily: 'Poppins',
                brightness: Brightness.light,
                primarySwatch: Colors.blue,
                textButtonTheme: textButtonTheme,
                elevatedButtonTheme: elevatedButtonTheme,
                outlinedButtonTheme: outlinedButtonTheme,
              ),
              darkTheme: ThemeData(
                fontFamily: 'Poppins',
                colorScheme: ColorScheme.fromSwatch(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.blue,
                ).copyWith(secondary: Colors.blueAccent),
                textButtonTheme: textButtonTheme,
                elevatedButtonTheme: elevatedButtonTheme,
                outlinedButtonTheme: outlinedButtonTheme,
              ),
              routes: {
                MainPage.route: (context) => const MainPage(),
                HomePage.route: (context) => const HomePage(),
                LoginPage.route: (context) => const LoginPage(),
                RegisterPage.route: (context) => const RegisterPage(),
                SensorsPage.route: (context) => const SensorsPage(),
              },
            );
          },
        ),
      ),
    );
  }
}
