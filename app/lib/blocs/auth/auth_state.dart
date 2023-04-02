import 'package:baby_guard/models/user.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthDoneState extends AuthState {
  AuthDoneState({
    required this.user,
  });

  final User user;
}

// Login

class LoginLoadingState extends AuthState {}

class LoginErrorState extends AuthState {
  LoginErrorState({
    required this.message,
  });

  final String message;
}

// Register

class RegisterLoadingState extends AuthState {}

class RegisterErrorState extends AuthState {
  RegisterErrorState({
    required this.message,
  });

  final String message;
}
