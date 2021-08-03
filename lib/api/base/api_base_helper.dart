//Based on: https://medium.com/solidmvp-africa/making-your-api-calls-in-flutter-the-right-way-f0a03e35b4b1

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../api_base_urls.dart';

Uri getUri(
  String uri,
  String endpoint,
  Map<String, dynamic>? queryParameters,
) {
  return Uri.http(uri, endpoint, queryParameters);
}

class APIException implements Exception {
  APIException({
    this.response,
    this.message,
    this.prefix = 'Error During Communication:',
  });

  final Response? response;
  final message;
  final prefix;

  String toString() {
    return '$prefix$message';
  }
}

class ApiBadRequestException extends APIException {
  ApiBadRequestException({response, message})
      : super(
          response: response,
          message: message,
        );
}

class ApiUnauthorisedException extends APIException {
  ApiUnauthorisedException({response, message})
      : super(
          response: response,
          message: message,
        );
}

class ApiInvalidInputException extends APIException {
  ApiInvalidInputException({response, message})
      : super(
          response: response,
          message: message,
        );
}

class ApiConflictException extends APIException {
  ApiConflictException({response, message})
      : super(
          response: response,
          message: message,
        );
}

class ApiNotFoundException extends APIException {
  ApiNotFoundException({response, message})
      : super(
          response: response,
          message: message,
        );
}

class ApiBaseHelper {
  final String baseUrl;

  ApiBaseHelper({required this.baseUrl});

  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    var responseJson;
    try {
      var uri = getUri(baseUrl, endpoint, queryParameters);
      final response = await http.get(
        uri,
        headers: headers,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw APIException(message: 'No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(
    String endpoint, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    var responseJson;
    try {
      final response = await http.post(
        getUri(baseUrl, endpoint, null),
        body: body,
        headers: headers,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw APIException(message: 'No Internet connection');
    }
    return responseJson;
  }

  Future<void> postMultipartFile(
    String endpoint, {
    required String filePath,
    required String userId,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://${ApiBaseURLS.IDENTITY_BASE_URL}/mediagallery/file/upload'),
      );
      request.fields.addAll({'UserId': userId});
      request.files.add(
        await http.MultipartFile.fromPath('File', filePath),
      );

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      throw APIException(message: 'No Internet connection');
    }
  }

  Future<dynamic> put(
    String endpoint, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    var responseJson;
    try {
      final response = await http.put(
        getUri(baseUrl, endpoint, null),
        body: body,
        headers: headers,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw APIException(message: 'No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        if (response.body.length == 0) {
          return {};
        }
        var responseJson = json.decode(
          response.body.toString(),
        );
        return responseJson;
      case 400:
        throw ApiBadRequestException(
          response: response,
          message: response.body.toString(),
        );
      case 401:
      case 403:
        throw ApiUnauthorisedException(
          response: response,
          message: response.body.toString(),
        );

      case 404:
        throw ApiNotFoundException(
          response: response,
          message: response.body.toString(),
        );

      case 409:
        throw ApiConflictException(
          response: response,
          message: response.body.toString(),
        );

      case 500:
      default:
        throw APIException(
          response: response,
          message:
              'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
        );
    }
  }
}
