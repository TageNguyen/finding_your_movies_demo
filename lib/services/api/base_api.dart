import 'dart:convert';

import 'package:finding_your_movies_demo/enums/exception_type.dart';
import 'package:finding_your_movies_demo/resource/app_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BaseApi {
  final String _baseUrl = 'raw.githubusercontent.com';
  final Duration _kTimeOutDuration = const Duration(minutes: 2);
  final Map<String, String> _baseHeaders = {'content-type': 'application/json'};

  /// Sends an HTTP GET request with the given [headers] and [params] to the given [url].
  Future<Map<String, dynamic>> getMethod(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? params,
  }) async {
    headers ??= <String, String>{};
    params ??= <String, String>{};

    params.forEach((key, value) => params![key] = value?.toString());
    headers.addAll(_baseHeaders);

    Uri uri = Uri.https(_baseUrl, url, params);

    _logRequest(url, 'GET', params, {}, headers);

    http.Response response = await http.get(uri, headers: headers).timeout(
      _kTimeOutDuration,
      onTimeout: () {
        throw AppException(ExceptionType.timeOut);
      },
    );

    _logResponse(url, response.statusCode, jsonDecode(utf8.decode(response.bodyBytes)));
    return _handleResponse(response, url: url, body: {}, headers: headers, param: params);
  }

  /// handle response by [response.statusCode]
  /// return [response.body] if request successfully or throw an [Exception] if failed
  Future<Map<String, dynamic>> _handleResponse(
    http.Response response, {
    required String url,
    Map<String, dynamic>? param,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    int statusCode = response.statusCode;
    final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));

    if (200 >= statusCode && statusCode <= 299) {
      if (jsonBody.runtimeType != Map<String, dynamic>) {
        return {'data': jsonBody};
      }
      return jsonBody as Map<String, dynamic>;
    }
    if (statusCode == 401) {
      throw AppException(ExceptionType.unauthorized, jsonBody['message']);
    }
    if (statusCode == 403) {
      throw AppException(ExceptionType.tokenExpired, jsonBody['message']);
    }
    if (400 <= statusCode && statusCode <= 499) {
      throw AppException(ExceptionType.badRequest, jsonBody['message']);
    } else if (500 <= statusCode && statusCode <= 599) {
      throw AppException(ExceptionType.serverError, jsonBody['message']);
    }
    throw AppException(ExceptionType.unknown);
  }

  /// log for tracking easily
  void _logRequest(String url, String method, dynamic param, dynamic body,
      Map<String, String>? headers) {
    debugPrint(
        '====================================================================================');
    debugPrint('[${method.toUpperCase()}]');
    debugPrint('REQUEST TO API: $_baseUrl$url With: ');
    debugPrint('HEADER: $headers\n');
    debugPrint('PARAMS: $param\n');
    debugPrint('BODY: $body\n');
    debugPrint(
        '====================================================================================');
  }

  /// log for tracking easily
  void _logResponse(String url, int statusCode, dynamic body) {
    debugPrint(
        '====================================================================================');
    debugPrint('RESPONSE API: $_baseUrl$url With:');
    debugPrint('STATUS CODE: $statusCode');
    debugPrint('BODY: $body\n');
    debugPrint(
        '====================================================================================');
  }
}
