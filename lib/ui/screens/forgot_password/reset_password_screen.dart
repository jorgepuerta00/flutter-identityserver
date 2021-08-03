import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/identity/reset_password_info.dart';
import '../../../repository/identity/reset_password_repository.dart';
import '../../widgets/buttons/button_accent.dart';
import '../../widgets/inputs/password_input.dart';
import '../../widgets/inputs/password_policies_indicator.dart';
import '../../widgets/inputs/password_validator.dart';
import '../../widgets/inputs/top_labeled_input.dart';
import '../../widgets/screen/app_top_padding_screen.dart';
import '../../widgets/text/header_1.dart';
import '../sign_in/signin_email_screen.dart';

class ResetPasswordScreenArgs {
  final String email;
  ResetPasswordScreenArgs({
    required this.email,
  });
}

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  static const String Route = '/forgot_password/reset_password_screen';
  final ResetPasswordScreenArgs args;

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _verticalSpacing = 25.0;

  late ResetPasswordRepository _resetPasswordRepository;
  PasswordValidator _passwordValidator = PasswordValidator.pure(
    isRequired: true,
    checkPolicies: true,
  );

  @override
  Widget build(BuildContext context) {
    _resetPasswordRepository = context.read<ResetPasswordRepository>();
    return AppTopPaddingScreen(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Header1(
                  title: '''Reset
      Password''',
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
                _passwordInput(context),
                SizedBox(
                  height: _verticalSpacing * 2,
                ),
              ],
            ),
            _resetPasswordButton(context),
          ],
        ),
      ),
    );
  }

  Widget _passwordInput(context) {
    return Column(
      children: [
        TopLabeledInput(
          label: 'New Password',
          widget: PasswordInput(
            passwordValidator: _passwordValidator,
            onChanged: (String value) {
              setState(() {
                _passwordValidator =
                    _passwordValidator.copyWithDirty(value: value);
              });
            },
          ),
        ),
        SizedBox(
          height: _verticalSpacing / 2,
        ),
        PasswordInputPoliciesIndicator(
          passwordValidator: _passwordValidator,
        )
      ],
    );
  }

  Widget _resetPasswordButton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ButtonAccent(
          child: Text('Set New Password'),
          onPressed: _passwordValidator.valid
              ? () {
                  _resetPasswordRepository.resetPassword(
                    resetPasswordInfo: ResetPasswordInfo(
                      userEmail: widget.args.email,
                      password: _passwordValidator.value,
                    ),
                  );
                  Navigator.of(context).pushNamed(SignInEmailScreen.Route);
                }
              : null,
        ),
      ],
    );
  }
}
