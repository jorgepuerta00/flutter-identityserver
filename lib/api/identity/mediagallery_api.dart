//Based on: https://medium.com/solidmvp-africa/making-your-api-calls-in-flutter-the-right-way-f0a03e35b4b1

import 'dart:async';

import 'package:revvy/api/base/api_base_helper.dart';

class MediaGalleryAPI {
  MediaGalleryAPI({
    required this.baseURL,
  }) {
    _apiBaseHelper = ApiBaseHelper(
      baseUrl: this.baseURL,
    );
  }

  ApiBaseHelper? _apiBaseHelper;
  late String baseURL;

  Future<void> postMultipartFile(
    String endpoint, {
    required String filePath,
    required String userId,
  }) async {
    _apiBaseHelper?.postMultipartFile(
      endpoint,
      filePath: filePath,
      userId: userId,
    );
  }
}
