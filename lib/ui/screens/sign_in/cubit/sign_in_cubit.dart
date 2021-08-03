import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;

import '../../../../api/api_base_urls.dart';
import '../../../services/dialog_message_service.dart';
import '../../../widgets/inputs/email_validator.dart';
import '../../../widgets/inputs/password_validator.dart';
import '../../dashboard/dashboard_screen.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../sign_up/first_last_name_screen.dart';
import '../signin_password_screen.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required this.dialogMessageService,
  }) : super(SignInState.initial());

  DialogMessageService dialogMessageService;

  void emailChanged(String value) {
    final email = state.email.copyWithDirty(
      value: value,
      notAvailable: false,
    );
    emit(
      state.copyWith(
        email: email,
      ),
    );
  }

  void passwordChanged(String value) {
    final password = this.state.password.copyWithDirty(value: value);
    emit(
      state.copyWith(
        password: password,
      ),
    );
  }

  Future<void> goToPasswordScreen(BuildContext context) async {
    // if (!state.email.valid) {
    //   return;
    // }

    try {
      Navigator.pushNamed(context, SignInPasswordScreen.Route);
    } catch (e) {}
  }

  Future<void> goToForgotPasswordScreen(BuildContext context) async {
    if (!state.email.valid) {
      return;
    }

    try {
      Navigator.pushNamed(
        context,
        ForgotPasswordScreen.Route,
        arguments: ForgotPasswordScreenArgs(
          email: state.email.value,
        ),
      );
    } catch (e) {}
  }

  Future<void> validateUserCredentials(BuildContext context) async {
    if (!state.email.valid || !state.password.valid) {
      return;
    }

    try {
      Navigator.pushNamed(context, SignInPasswordScreen.Route);
    } catch (e) {}
  }

  Future<void> signIn(BuildContext context) async {
    if (!state.email.valid) {
      return;
    }

    try {
      dialogMessageService.showLoading();

      final authorizationEndpoint = Uri.parse(
        'http://${ApiBaseURLS.IDENTITY_BASE_URL}/ids/connect/token',
      );

      final identifier = ApiBaseURLS.IDENTITY_CLIENT_NAME;
      final secret = ApiBaseURLS.IDENTITY_CLIENT_SECRETS;

      // Make a request to the authorization endpoint that will produce the fully
      // authenticated Client.
      var client = await oauth2.resourceOwnerPasswordGrant(
        authorizationEndpoint,
        state.email.value,
        state.password.value,
        identifier: identifier,
        secret: secret,
      );

      if (client.credentials.accessToken.isNotEmpty) {
        Map<String, dynamic> userClaims =
            await _getUserClaims(client.credentials.accessToken);

        dialogMessageService.hideLoading();
        if (userClaims['given_name'] != null) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            DashboardScreen.Route,
            (route) => false,
            arguments: DashboardScreenArgs(
              userName: userClaims['given_name'],
            ),
          );
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
            FirstLastNameScreen.Route,
            (route) => false,
            arguments: state.email.value,
          );
        }
      }
    } catch (e) {
      //print('Error: ' + e.toString());
      if (e.toString().contains("invalid_grant")) {
        emit(
          state.copyWith(
            password: state.password.copyWithDirty(
              wrongPassword: true,
            ),
          ),
        );
      } else {
        dialogMessageService.displayError(
          'There was an unexpected error. Please try again later',
        );
      }

      dialogMessageService.hideLoading();
    }
  }

  Future<Map<String, dynamic>> _getUserClaims(String token) async {
    final userInfoEndpoint = Uri.parse(
        'http://${ApiBaseURLS.IDENTITY_BASE_URL}/ids/connect/userinfo');

    //Get the user claims from identity server 4
    var client = await http.get(
      userInfoEndpoint,
      headers: {HttpHeaders.authorizationHeader: "Bearer " + token},
    );

    //print(client.body);
    return jsonDecode(client.body);
  }
}
