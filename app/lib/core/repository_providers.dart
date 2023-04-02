import 'package:baby_guard/repositories/auth_repository.dart';
import 'package:baby_guard/repositories/sensor_repository.dart';
import 'package:baby_guard/repositories/theme_repository.dart';
import 'package:baby_guard/repositories/user_repository.dart';
import 'package:baby_guard/utils/api.dart';
import 'package:baby_guard/utils/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepositoryProviders extends StatelessWidget {
  RepositoryProviders({
    super.key,
    required this.child,
  });

  final Widget child;

  final _api = Api(authority: Env.apiAuthority);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<SensorRepository>(
          create: (context) => SensorRepository(api: _api),
        ),
        RepositoryProvider<ThemeRepository>(
          create: (context) => ThemeRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(api: _api),
        ),
      ],
      child: child,
    );
  }
}
