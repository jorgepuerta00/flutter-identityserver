import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/buttons/button_accent.dart';
import '../../widgets/inputs/password_input.dart';
import '../../widgets/inputs/password_policies_indicator.dart';
import '../../widgets/inputs/top_labeled_input.dart';
import '../../widgets/text/header_1.dart';
import 'cubit/sign_up_cubit.dart';
import '../../widgets/screen/app_top_padding_screen.dart';

class PasswordScreen extends StatelessWidget {
  static const String Route = '/sign_up/password_screen';

  PasswordScreen({Key? key}) : super(key: key);

  final _verticalSpacing = 25.0;
  late SignUpCubit _signUpCubit;

  @override
  Widget build(BuildContext context) {
    _signUpCubit = context.read<SignUpCubit>();

    return AppTopPaddingScreen(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Header1(
                  title: '''Welcome to
      Revvy''',
                  signs: '.',
                ),
                SizedBox(
                  height: _verticalSpacing,
                ),
                Text(
                  'Create a password.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: _verticalSpacing * 2,
                ),
                _passwordInput(),
                SizedBox(
                  height: _verticalSpacing * 2,
                ),
              ],
            ),
            _createAccountButton(context),
          ],
        ),
      ),
    );
  }

  Widget _passwordInput() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (_, state) {
        return Column(
          children: [
            TopLabeledInput(
              label: 'Password',
              widget: PasswordInput(
                passwordValidator: state.password,
                onChanged: (String value) {
                  _signUpCubit.passwordChanged(value);
                },
              ),
            ),
            SizedBox(
              height: _verticalSpacing / 2,
            ),
            PasswordInputPoliciesIndicator(
              passwordValidator: state.password,
            )
          ],
        );
      },
    );
  }

  Widget _createAccountButton(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password.valid != current.password.valid,
      builder: (_, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ButtonAccent(
              child: Text('Create Account'),
              onPressed: state.password.valid
                  ? () {
                      _signUpCubit.createMemberAccount(context);
                    }
                  : null,
            ),
          ],
        );
      },
    );
  }
}
