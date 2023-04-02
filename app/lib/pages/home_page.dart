import 'package:baby_guard/blocs/auth/auth_bloc.dart';
import 'package:baby_guard/blocs/auth/auth_state.dart';
import 'package:baby_guard/pages/sensors_page.dart';
import 'package:baby_guard/utils/utils.dart';
import 'package:baby_guard/widgets/auth_wrapper.dart';
import 'package:baby_guard/widgets/base_page_content_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;

    final hourString =
        hour >= 18 ? 'Boa noite' : (hour >= 12 ? 'Boa tarde' : 'Bom dia');

    return AuthWrapper(
      child: BasePageContentLayout(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Início',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthDoneState) {
                        return Text('$hourString, ${state.user.username}!');
                      }

                      return Container();
                    },
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    child: const Text('VER MEUS SENSORES'),
                    onPressed: () async {
                      await Utils.replaceNavigation(context, SensorsPage.route);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
