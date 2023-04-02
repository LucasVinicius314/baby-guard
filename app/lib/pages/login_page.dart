import 'package:baby_guard/blocs/auth/auth_bloc.dart';
import 'package:baby_guard/blocs/auth/auth_event.dart';
import 'package:baby_guard/blocs/auth/auth_state.dart';
import 'package:baby_guard/pages/home_page.dart';
import 'package:baby_guard/widgets/app_title.dart';
import 'package:baby_guard/widgets/base_page_content_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  static const route = '/login';

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Widget _getContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppTitle()),
      body: BasePageContentLayout(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Login',
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
                      child: const Text('ENTRAR'),
                      onPressed: () {
                        _submit(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
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
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthDoneState) {
          await Navigator.of(context).pushReplacementNamed(HomePage.route);
        } else if (state is LoginErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: _getContent(context),
    );
  }
}
