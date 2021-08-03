//Based on: https://medium.com/solidmvp-africa/making-your-api-calls-in-flutter-the-right-way-f0a03e35b4b1

import 'dart:async';

import 'package:revvy/api/base/api_base_helper.dart';

class IdentityAPI {
  IdentityAPI({
    required this.baseURL,
  }) {
    _apiBaseHelper = ApiBaseHelper(
      baseUrl: this.baseURL,
    );
  }

  ApiBaseHelper? _apiBaseHelper;
  late String baseURL;

  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _apiBaseHelper?.get(endpoint,
        headers: _getBaseHeaders(null), queryParameters: queryParameters);
  }

  Future<dynamic> post(
    String endpoint, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    return _apiBaseHelper?.post(
      endpoint,
      headers: _getBaseHeaders(null),
      body: body,
    );
  }

  Future<dynamic> put(
    String endpoint, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    return _apiBaseHelper?.put(
      endpoint,
      headers: _getBaseHeaders(null),
      body: body,
    );
  }

  Map<String, String> _getBaseHeaders(
    Map<String, String>? headers,
  ) {
    Map<String, String> finalHeadersMap = {
      'content-type': 'application/json',
    };
    if (headers != null) {
      finalHeadersMap.addAll(headers);
    }

    return finalHeadersMap;
  }
}
