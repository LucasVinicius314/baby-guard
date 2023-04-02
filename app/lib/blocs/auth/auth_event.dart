abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  LoginEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class LogoutEvent extends AuthEvent {}

class RegisterEvent extends AuthEvent {
  RegisterEvent({
    required this.email,
    required this.password,
    required this.username,
  });

  final String email;
  final String password;
  final String username;
}

class TokenLoginEvent extends AuthEvent {
  TokenLoginEvent({
    required this.token,
  });

  final String token;
}
