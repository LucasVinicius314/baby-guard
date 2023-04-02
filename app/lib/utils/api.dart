import 'dart:async';
import 'dart:convert';

import 'package:baby_guard/exceptions/http_bad_request_exception.dart';
import 'package:baby_guard/exceptions/http_entity_not_found_exception.dart';
import 'package:baby_guard/exceptions/http_missing_authorization_exception.dart';
import 'package:baby_guard/interceptors/auth_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Response;
import 'package:http_interceptor/http/http.dart';

class Api {
  final client = InterceptedClient.build(interceptors: [AuthInterceptor()]);

  final String authority;

  Api({required this.authority});

  Uri getUri(String path) =>
      kDebugMode ? Uri.http(authority, path) : Uri.https(authority, path);

  Future<Map<String, dynamic>> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    final request = client.get(
      getUri(path),
      params: queryParameters,
    );

    final response = await request;

    await validateResponseCode(request);

    final jsonResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    return jsonResponse;
  }

  Future<Map<String, dynamic>> post({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final request = client.post(
      getUri(path),
      params: queryParameters,
      body: jsonEncode(body),
    );

    final response = await request;

    await validateResponseCode(request);

    final jsonResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    return jsonResponse;
  }

  Future<Map<String, dynamic>> patch({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final request = client.patch(
      getUri(path),
      params: queryParameters,
      body: jsonEncode(body),
    );

    final response = await request;

    await validateResponseCode(request);

    final jsonResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    return jsonResponse;
  }

  Future<Map<String, dynamic>> put({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final request = client.put(
      getUri(path),
      params: queryParameters,
      body: jsonEncode(body),
    );

    final response = await request;

    await validateResponseCode(request);

    final jsonResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    return jsonResponse;
  }

  Future<Map<String, dynamic>> delete({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final request = client.delete(
      getUri(path),
      params: queryParameters,
      body: jsonEncode(body),
    );

    final response = await request;

    await validateResponseCode(request);

    final jsonResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    return jsonResponse;
  }

  Future<void> validateResponseCode(
    FutureOr<Response> request,
  ) async {
    final awaitedReq = await request;

    if (kDebugMode) {
      print(awaitedReq.request.toString());
      print(awaitedReq.body);
    }

    String? message;

    try {
      final map = jsonDecode(utf8.decode(awaitedReq.bodyBytes));

      message = map['message'];
    } catch (e) {
      if (kDebugMode) print(e);
    }

    if ([401, 403].contains(awaitedReq.statusCode)) {
      throw HttpMissingAuthorizationException(message: message);
    } else if (awaitedReq.statusCode == 404) {
      throw HttpEntityNotFoundException(message: message);
    } else if (awaitedReq.statusCode >= 400 && awaitedReq.statusCode < 600) {
      throw HttpBadRequestException(message: message);
    }
  }
}
