import 'package:baby_guard/blocs/auth/auth_bloc.dart';
import 'package:baby_guard/blocs/auth/auth_event.dart';
import 'package:baby_guard/blocs/auth/auth_state.dart';
import 'package:baby_guard/pages/home_page.dart';
import 'package:baby_guard/pages/register_page.dart';
import 'package:baby_guard/utils/env.dart';
import 'package:baby_guard/utils/utils.dart';
import 'package:baby_guard/widgets/app_title.dart';
import 'package:baby_guard/widgets/base_page_content_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const route = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Widget _getContent() {
    return Scaffold(
      appBar: AppBar(title: const AppTitle()),
      body: BasePageContentLayout(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Entrar',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Form(
            key: _formKey,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        value ??= '';

                        // TODO: fix, validator

                        if (value.length < 3) {
                          return 'Email muito curto.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                      ),
                      validator: (value) {
                        value ??= '';

                        if (value.length < 3) {
                          return 'Senha muito curta.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _submit,
                      child: const Text('ENTRAR'),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      child: const Text('CRIAR CONTA'),
                      onPressed: () async {
                        await Utils.pushNavigation(context, RegisterPage.route);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(Env.apiAuthority, textAlign: TextAlign.center),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    BlocProvider.of<AuthBloc>(context).add(
      LoginEvent(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      _emailController.text = 'test@test.com';
      _passwordController.text = '1234';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthDoneState) {
          await Utils.replaceNavigation(context, HomePage.route);
        } else if (state is AuthErrorState) {
          if (state.authErrorStateSource == AuthErrorStateSource.login) {
            await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Atenção'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(state.message),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () async {
                        await Utils.popNavigation(context);
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
      },
      child: _getContent(),
    );
  }
}
