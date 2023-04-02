import 'package:baby_guard/models/user.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthDoneState extends AuthState {
  AuthDoneState({
    required this.user,
  });

  final User user;
}

enum AuthErrorStateSource {
  login,
  register,
}

class AuthErrorState extends AuthState {
  AuthErrorState({
    required this.authErrorStateSource,
    required this.message,
  });

  final AuthErrorStateSource authErrorStateSource;
  final String message;
}

// Login

class LoginLoadingState extends AuthState {}

// Register

class RegisterLoadingState extends AuthState {}
