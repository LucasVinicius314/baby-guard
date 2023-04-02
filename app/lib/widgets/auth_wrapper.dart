import 'package:baby_guard/blocs/auth/auth_bloc.dart';
import 'package:baby_guard/blocs/auth/auth_state.dart';
import 'package:baby_guard/pages/main_page.dart';
import 'package:baby_guard/utils/utils.dart';
import 'package:baby_guard/widgets/base_scaffold.dart';
import 'package:baby_guard/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({
    super.key,
    this.isMain = false,
    required this.child,
  });

  final bool isMain;
  final Widget child;

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();

    if (!widget.isMain) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        if (BlocProvider.of<AuthBloc>(context).state is AuthInitialState) {
          await Utils.replaceNavigation(context, MainPage.route);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthInitialState) {
          await Utils.replaceNavigation(context, MainPage.route);
        }
      },
      builder: (context, state) {
        if (state is AuthErrorState) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(64),
              child: Text(state.message, textAlign: TextAlign.center),
            ),
          );
        }

        if (state is AuthDoneState) {
          return BaseScaffold(child: widget.child);
        }

        return const Scaffold(body: LoadingIndicator());
      },
    );
  }
}
