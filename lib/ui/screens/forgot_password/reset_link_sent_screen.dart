import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/identity/user_email_info.dart';
import '../../../repository/identity/reset_password_repository.dart';
import '../../constants/AppColors.dart';
import '../../constants/AppFonts.dart';
import '../../services/dialog_message_service.dart';
import '../../widgets/screen/app_top_padding_screen.dart';
import '../../widgets/text/header_1.dart';
import '../sign_in/cubit/sign_in_cubit.dart';
import 'reset_password_screen.dart';

class ResetLinkSentScreenArgs {
  final String email;
  ResetLinkSentScreenArgs({
    required this.email,
  });
}

class ResetLinkSentScreen extends StatefulWidget {
  static const String Route = '/sign_up/reset_link_sent_screen';

  ResetLinkSentScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  final ResetLinkSentScreenArgs args;

  @override
  _ResetLinkSentScreenState createState() => _ResetLinkSentScreenState();
}

class _ResetLinkSentScreenState extends State<ResetLinkSentScreen> {
  final _verticalSpacing = 25.0;
  late SignInState state;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppTopPaddingScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Header1(
                title: '''Reset Link Sent''',
                signs: '.',
              ),
              SizedBox(
                height: _verticalSpacing,
              ),
              Column(
                children: [
                  Text(
                    '''We've got you. We send a
password reset link to''',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w200,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    widget.args.email,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: _verticalSpacing,
                  ),
                  Text(
                    '''Please check your inbox
and spam folder.''',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w200,
                        ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Don\'t see the email?',
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
                      'Resend',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontFamily: AppFonts.Avenir,
                            color: AppColors.ORANGE,
                          ),
                    ),
                    onPressed: () {
                      _resetPassword(context);
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
          userEmail: widget.args.email,
        ),
      );
      dialogMessageService.hideLoading();
    } catch (e) {
      dialogMessageService.displayError('There was an error. Please try again');
    }
  }
}
