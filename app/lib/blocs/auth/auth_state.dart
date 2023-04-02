import 'package:baby_guard/models/user.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthDoneState extends AuthState {
  AuthDoneState({
    required this.user,
  });

  final User user;
}

class AuthErrorState extends AuthState {
  AuthErrorState({
    required this.message,
  });

  final String message;
}

// Login

class LoginLoadingState extends AuthState {}

// Register

class RegisterLoadingState extends AuthState {}
