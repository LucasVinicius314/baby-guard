import 'package:baby_guard/models/responses/login_response.dart';
import 'package:baby_guard/models/responses/read_user_response.dart';
import 'package:baby_guard/utils/api.dart';

class UserRepository {
  const UserRepository({required this.api});

  final Api api;

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final req = api.post(
      path: '/api/v1/auth/login',
      body: {
        'email': email,
        'password': password,
      },
    );

    final data = await req;

    final res = LoginResponse.fromJson(data);

    return res;
  }

  Future<ReadUserResponse> read() async {
    final req = api.get(
      path: '/api/v1/user/',
    );

    final data = await req;

    final res = ReadUserResponse.fromJson(data);

    return res;
  }

  Future<LoginResponse> register({
    required String email,
    required String password,
    required String username,
  }) async {
    final req = api.post(
      path: '/api/v1/auth/register',
      body: {
        'email': email,
        'password': password,
        'username': username,
      },
    );

    final data = await req;

    final res = LoginResponse.fromJson(data);

    return res;
  }
}
