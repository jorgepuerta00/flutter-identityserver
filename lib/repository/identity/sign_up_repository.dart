//Based on: https://medium.com/solidmvp-africa/making-your-api-calls-in-flutter-the-right-way-f0a03e35b4b1

import 'package:flutter/rendering.dart';
import 'package:revvy/api/api_base_urls.dart';
import 'package:revvy/api/base/api_base_helper.dart';
import 'package:revvy/api/identity/identity_api.dart';
import 'package:revvy/api/identity/interests_api.dart';
import 'package:revvy/api/identity/mediagallery_api.dart';
import 'package:revvy/models/identity/location_info.dart';
import 'package:revvy/models/identity/new_account_info.dart';
import 'package:revvy/models/identity/sign_up_info.dart';
import 'package:revvy/models/identity/verify_code_info.dart';
import 'package:revvy/models/interests/industry_info.dart';

class SignUpRepository {
  SignUpRepository();

  IdentityAPI _identityApi = IdentityAPI(
    baseURL: ApiBaseURLS.IDENTITY_BASE_URL,
  );

  InterestsAPI _interestsApi = InterestsAPI(
    baseURL: ApiBaseURLS.INTERESTS_BASE_URL,
  );

  MediaGalleryAPI _mediagalleryApi = MediaGalleryAPI(
    baseURL: ApiBaseURLS.INTERESTS_BASE_URL,
  );

  Future<bool> checkIfUserEmailExists({
    required userEmail,
  }) async {
    try {
      await _identityApi.get(
        '/ids/profile/validateemail/$userEmail',
      );

      return false;
    } on ApiBadRequestException {
      return true;
    } on Exception {
      rethrow;
    }
  }

  Future<void> createNewAccount({
    required NewAccountInfo newAccountInfo,
  }) async {
    try {
      await _identityApi.post(
        '/ids/profile/createaccount',
        body: newAccountInfo.toJson(),
      );
    } on Exception {
      rethrow;
    }
  }

  Future<void> verifyEmailCodeInfo({
    required VerifyCodeInfo verifyCodeInfo,
  }) async {
    try {
      await _identityApi.post(
        '/ids/profile/confirmationcode',
        body: verifyCodeInfo.toJson(),
      );
    } on ApiBadRequestException {
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  Future<void> resendEmailVerificationCode({
    required VerifyCodeInfo verifyCodeInfo,
  }) async {
    try {
      await _identityApi.post(
        '/ids/profile/resendverificationcode',
        body: verifyCodeInfo.toJson(),
      );
    } on Exception {
      rethrow;
    }
  }

  Future<List<LocationInfo>> getLocations({
    required String filter,
  }) async {
    List<LocationInfo> locationsList = [];
    try {
      var response = await _identityApi.get(
        '/ids/location',
        queryParameters: {
          'filter': filter,
        },
      );

      List<dynamic> screeningEventResults = response;
      screeningEventResults.forEach((element) {
        locationsList.add(LocationInfo.fromMap(element));
      });

      return locationsList;
    } catch (e) {
      return locationsList;
    }
  }

  Future<List<IndustryInfo>> getInterests(
      {required String filter,
      required String page,
      required String records}) async {
    List<IndustryInfo> interestsList = [];
    try {
      var response = await _interestsApi.get(
        '/interests/industry',
        queryParameters: {
          'filter': filter,
          'p': page,
          's': records,
        },
      );

      List<dynamic> screeningEventResults = response;
      screeningEventResults.forEach((element) {
        interestsList.add(IndustryInfo.fromMap(element));
      });

      return interestsList;
    } catch (e) {
      return interestsList;
    }
  }

  Future<void> uploadProfilePicture({
    required String filePath,
    required String userId,
  }) async {
    try {
      var response = await _mediagalleryApi.postMultipartFile(
        '/mediagallery/file/upload',
        filePath: filePath,
        userId: userId,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> saveSignUpData({
    required SignUpInfo signUpInfo,
  }) async {
    await _identityApi.post(
      '/ids/profile/saveuserdata',
      body: signUpInfo.toJson(),
    );
  }
}
