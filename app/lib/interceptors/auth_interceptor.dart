import 'package:baby_guard/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:http_interceptor/http_interceptor.dart';

class AuthInterceptor implements InterceptorContract {
  final _authRepository = AuthRepository();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      final token = await _authRepository.getAuthorization();

      if (token != null) {
        final authorization = token;

        data.headers.update(
          'Authorization',
          (value) => authorization,
          ifAbsent: () => authorization,
        );
      }

      const contentType = 'application/json; charset=UTF-8';

      data.headers.update(
        'Content-Type',
        (value) => contentType,
        ifAbsent: () => contentType,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async =>
      data;
}
