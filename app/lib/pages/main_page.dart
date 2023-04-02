import 'package:baby_guard/blocs/auth/auth_bloc.dart';
import 'package:baby_guard/blocs/auth/auth_event.dart';
import 'package:baby_guard/blocs/auth/auth_state.dart';
import 'package:baby_guard/pages/home_page.dart';
import 'package:baby_guard/pages/login_page.dart';
import 'package:baby_guard/repositories/auth_repository.dart';
import 'package:baby_guard/utils/utils.dart';
import 'package:baby_guard/widgets/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const route = '/';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final _authRepository = RepositoryProvider.of<AuthRepository>(context);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final authBloc = BlocProvider.of<AuthBloc>(context);

      final token = await _authRepository.getAuthorization();

      if (token == null) {
        if (mounted) {
          await Utils.navigate(context, LoginPage.route);
        }
      } else {
        authBloc.add(TokenLoginEvent(token: token));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthDoneState) {
          await Utils.navigate(context, HomePage.route);
        }
      },
      child: AuthWrapper(
        isMain: true,
        child: Container(),
      ),
    );
  }
}
