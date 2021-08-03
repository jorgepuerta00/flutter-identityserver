import 'package:flutter/material.dart';

class ApiBaseURLS {
  // static const String IDENTITY_BASE_URL = '11068ca93092.ngrok.io';
  static const String IDENTITY_BASE_URL = 'localhost:8080';
  //static const String IDENTITY_BASE_URL = '192.168.64.3';
  // static const String INTERESTS_BASE_URL = '11068ca93092.ngrok.io';
  static const String INTERESTS_BASE_URL = 'localhost:8080';
  static const String IDENTITY_CLIENT_NAME = 'flutter';

  //TODO: save sensitive data in a secrets storage
  static const String IDENTITY_CLIENT_SECRETS =
      'jKGHySpqOJJzXKn9zFr5H09CPujNpVAVgZLP5CGSRq0=';
}
