import 'package:baby_guard/blocs/auth/auth_bloc.dart';
import 'package:baby_guard/blocs/sensor/sensor_bloc.dart';
import 'package:baby_guard/blocs/theme/theme_bloc.dart';
import 'package:baby_guard/blocs/theme/theme_event.dart';
import 'package:baby_guard/repositories/auth_repository.dart';
import 'package:baby_guard/repositories/sensor_repository.dart';
import 'package:baby_guard/repositories/theme_repository.dart';
import 'package:baby_guard/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders extends StatelessWidget {
  const BlocProviders({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authRepository: RepositoryProvider.of<AuthRepository>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
        ),
        BlocProvider<SensorBloc>(
          create: (context) => SensorBloc(
            sensorRepository: RepositoryProvider.of<SensorRepository>(context),
          ),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(
            themeRepository: RepositoryProvider.of<ThemeRepository>(context),
          )..add(LoadThemeEvent()),
        ),
      ],
      child: child,
    );
  }
}
