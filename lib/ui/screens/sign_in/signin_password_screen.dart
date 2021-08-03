import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/buttons/button_accent.dart';
import '../../widgets/inputs/password_input.dart';
import '../../widgets/inputs/top_labeled_input.dart';
import '../../widgets/screen/app_top_padding_screen.dart';
import '../../widgets/text/header_1.dart';
import 'cubit/sign_in_cubit.dart';

class SignInPasswordScreen extends StatelessWidget {
  static const String Route = '/sign_in/password_screen';

  SignInPasswordScreen({Key? key}) : super(key: key);

  final _verticalSpacing = 25.0;
  late SignInCubit _signInCubit;

  @override
  Widget build(BuildContext context) {
    _signInCubit = context.read<SignInCubit>();

    return AppTopPaddingScreen(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Header1(
                  title: '''Welcome Back''',
                  signs: '.',
                ),
                SizedBox(
                  height: _verticalSpacing,
                ),
                _emailText(context),
                SizedBox(
                  height: _verticalSpacing * 2,
                ),
                Text(
                  '''Enter your password to
      continue''',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                  textAlign: TextAlign.center,
                ),
                _passwordInput(context),
                SizedBox(
                  height: _verticalSpacing * 2,
                ),
              ],
            ),
            _signInAccountButton(context),
          ],
        ),
      ),
    );
  }

  Widget _emailText(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (_, state) {
        return Text(
          state.email.value,
          style: Theme.of(context).textTheme.bodyText1,
        );
      },
    );
  }

  Widget _passwordInput(context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (_, state) {
        return Column(
          children: [
            TopLabeledInput(
              label: 'Password',
              widget: PasswordInput(
                passwordValidator: state.password,
                onChanged: (String value) {
                  _signInCubit.passwordChanged(value);
                },
              ),
            ),
            SizedBox(
              height: _verticalSpacing + 10,
            ),
            TextButton(
              child: Text('Forgot Password?',
                  style: Theme.of(context).textTheme.bodyText1),
              onPressed: () {
                _signInCubit.goToForgotPasswordScreen(context);
              },
            )
          ],
        );
      },
    );
  }

  Widget _signInAccountButton(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) =>
          previous.password.value.isNotEmpty !=
          current.password.value.isNotEmpty,
      builder: (_, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ButtonAccent(
              child: Text('Sign In'),
              onPressed: state.password.value.isNotEmpty
                  ? () {
                      _signInCubit.signIn(context);
                    }
                  : null,
            ),
          ],
        );
      },
    );
  }
}
