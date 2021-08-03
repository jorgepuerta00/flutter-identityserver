import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/identity/user_email_info.dart';
import '../../../repository/identity/reset_password_repository.dart';
import '../../constants/AppColors.dart';
import '../../constants/AppFonts.dart';
import '../../services/dialog_message_service.dart';
import '../../widgets/buttons/button_accent.dart';
import '../../widgets/screen/app_top_padding_screen.dart';
import '../../widgets/text/header_1.dart';
import '../sign_in/signin_email_screen.dart';
import 'reset_link_sent_screen.dart';

class ForgotPasswordScreenArgs {
  final String email;
  ForgotPasswordScreenArgs({
    required this.email,
  });
}

class ForgotPasswordScreen extends StatelessWidget {
  static const String Route = '/forgot_password/forgot_password_screen';

  ForgotPasswordScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  final ForgotPasswordScreenArgs args;
  final _verticalSpacing = 25.0;

  @override
  Widget build(BuildContext context) {
    return AppTopPaddingScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Header1(
                title: '''Forgot
Password''',
                signs: '?',
              ),
              SizedBox(
                height: _verticalSpacing,
              ),
              Column(
                children: [
                  Text(
                    '''Click on "Reset Password"
to receive password
recovery instructions to
''',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    args.email,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: _verticalSpacing * 2,
              ),
              SizedBox(
                height: _verticalSpacing * 2,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ButtonAccent(
                child: Text('Reset Password'),
                onPressed: () {
                  _resetPassword(context);
                },
              ),
              SizedBox(height: _verticalSpacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Wrong email?',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  TextButton(
                    child: Text(
                      'Change',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontFamily: AppFonts.Avenir,
                            color: AppColors.ORANGE,
                          ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(SignInEmailScreen.Route);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _resetPassword(BuildContext context) {
    DialogMessageService dialogMessageService =
        context.read<DialogMessageService>();

    ResetPasswordRepository resetPasswordRepository =
        context.read<ResetPasswordRepository>();
    try {
      dialogMessageService.showLoading();
      resetPasswordRepository.sendResetPasswordEmail(
        userEmailInfo: UserEmailInfo(
          userEmail: args.email,
        ),
      );
      Navigator.of(context).pushNamed(
        ResetLinkSentScreen.Route,
        arguments: ResetLinkSentScreenArgs(
          email: args.email,
        ),
      );
      dialogMessageService.hideLoading();
    } catch (e) {
      dialogMessageService.displayError('There was an error. Please try again');
    }
  }
}
