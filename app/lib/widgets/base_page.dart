import 'package:baby_guard/blocs/auth/auth_bloc.dart';
import 'package:baby_guard/blocs/auth/auth_state.dart';
import 'package:baby_guard/pages/main_page.dart';
import 'package:baby_guard/widgets/base_page_layout.dart';
import 'package:baby_guard/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasePage extends StatelessWidget {
  const BasePage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthInitialState) {
          await Navigator.of(context).pushReplacementNamed(MainPage.route);
        }
      },
      builder: (context, state) {
        if (state is AuthDoneState) {
          return BasePageLayout(child: child);
        }

        return const Scaffold(body: LoadingIndicator());
      },
    );
  }
}
