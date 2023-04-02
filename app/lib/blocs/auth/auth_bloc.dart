import 'package:baby_guard/blocs/auth/auth_event.dart';
import 'package:baby_guard/blocs/auth/auth_state.dart';
import 'package:baby_guard/exceptions/http_bad_request_exception.dart';
import 'package:baby_guard/repositories/auth_repository.dart';
import 'package:baby_guard/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.authRepository,
    required this.userRepository,
  }) : super(AuthInitialState()) {
    on<LoginEvent>((event, emit) async {
      try {
        emit(LoginLoadingState());

        final token = (await userRepository.login(
          email: event.email,
          password: event.password,
        ))
            .token;

        if (token == null) {
          emit(LoginErrorState(message: 'Empty token.'));
        } else {
          await authRepository.setAuthorization(token);

          final user = (await userRepository.read()).user;

          if (user == null) {
            emit(LoginErrorState(message: 'Empty user.'));
          } else {
            emit(AuthDoneState(user: user));
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }

        emit(LoginErrorState(message: e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      await authRepository.setAuthorization(null);

      emit(AuthInitialState());
    });

    on<RegisterEvent>((event, emit) async {
      try {
        emit(RegisterLoadingState());

        final token = (await userRepository.register(
          email: event.email,
          password: event.password,
          username: event.username,
        ))
            .token;

        if (token == null) {
          emit(LoginErrorState(message: 'Empty token.'));
        } else {
          await authRepository.setAuthorization(token);

          final user = (await userRepository.read()).user;

          if (user == null) {
            emit(LoginErrorState(message: 'Empty user.'));
          } else {
            emit(AuthDoneState(user: user));
          }
        }
      } on HttpBadRequestException catch (e) {
        if (kDebugMode) {
          print(e);
        }

        emit(RegisterErrorState(message: e.message ?? 'Algo deu errado.'));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }

        emit(RegisterErrorState(message: e.toString()));
      }
    });

    on<TokenLoginEvent>((event, emit) async {
      try {
        emit(LoginLoadingState());

        final token = event.token;

        await authRepository.setAuthorization(token);

        final user = (await userRepository.read()).user;

        if (user == null) {
          emit(LoginErrorState(message: 'Empty user.'));
        } else {
          emit(AuthDoneState(user: user));
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }

        emit(LoginErrorState(message: e.toString()));
      }
    });
  }

  final AuthRepository authRepository;
  final UserRepository userRepository;
}
