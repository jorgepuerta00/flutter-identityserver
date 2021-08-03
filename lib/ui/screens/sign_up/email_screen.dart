import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:revvy/ui/screens/sign_in/signin_email_screen.dart';
import 'package:revvy/ui/screens/sign_up/terms_of_use_screen.dart';

import '../../constants/AppColors.dart';
import '../../constants/AppFonts.dart';
import '../../constants/AppSizes.dart';
import '../../widgets/buttons/button_accent.dart';
import '../../widgets/buttons/button_primary.dart';
import '../../widgets/inputs/email_input.dart';
import '../../widgets/inputs/top_labeled_input.dart';
import '../../widgets/text/header_1.dart';
import 'cubit/sign_up_cubit.dart';
import '../../widgets/screen/app_top_padding_screen.dart';

class EmailScreen extends StatelessWidget {
  static const String Route = '/sign_up/email_screen';

  EmailScreen({Key? key}) : super(key: key);

  final _verticalMargin = 20.0;

  late SignUpCubit _signUpCubit;
  late AppLocalizations? _messages;

  @override
  Widget build(BuildContext context) {
    _messages = AppLocalizations.of(context);
    _signUpCubit = context.read<SignUpCubit>();

    return AppTopPaddingScreen(
      child: ListView(
        children: [
          Header1(
            title: '''Sing Up
for Revvy''',
            signs: '.',
          ),
          SizedBox(
            height: _verticalMargin * 2,
          ),
          _emailInput(),
          SizedBox(
            height: _verticalMargin * 1.5,
          ),
          _signUpButton(),
          SizedBox(
            height: _verticalMargin,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Divider(
                  color: AppColors.WHITE,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'OR',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Divider(
                  color: AppColors.WHITE,
                ),
              ),
            ],
          ),
          SizedBox(
            height: _verticalMargin,
          ),
          _ButtonPrimary(),
          SizedBox(
            height: _verticalMargin * 3.0,
          ),
          Column(
            children: [
              Text(
                'By signing up, you agree to Revvy’s ',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 14,
                      color: AppColors.PRIMARY_SWATCH[200],
                      fontFamily: AppFonts.Avenir,
                    ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Terms of Use",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushNamed(TermsOfUse.Route);
                      },
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 12,
                          color: AppColors.WHITE,
                          fontFamily: AppFonts.Avenir,
                          fontWeight: FontWeight.w100,
                        ),
                    children: [
                      TextSpan(
                          text: ''' & ''',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 14,
                                    color: AppColors.PRIMARY_SWATCH[200],
                                    fontFamily: AppFonts.Avenir,
                                  ),
                          children: [
                            TextSpan(
                              text: 'Privacy Policy',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 12,
                                    color: AppColors.WHITE,
                                    fontFamily: AppFonts.Avenir,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context)
                                      .pushNamed(TermsOfUse.Route);
                                },
                            )
                          ])
                    ]),
              )
            ],
          ),
          SizedBox(
            height: _verticalMargin,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Already have an account?',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              TextButton(
                child: Text(
                  'Log in',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontFamily: AppFonts.Avenir,
                        color: AppColors.ORANGE,
                      ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    SignInEmailScreen.Route,
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  TopLabeledInput _emailInput() {
    return TopLabeledInput(
      label: 'Email',
      widget: SafeArea(
        child: BlocBuilder<SignUpCubit, SignUpState>(
          buildWhen: (previous, current) => previous.email != current.email,
          builder: (context, state) {
            return EmailInput(
              icon: Icon(Icons.remove_circle_rounded),
              emailValidator: state.email,
              onChanged: (String value) {
                _signUpCubit.emailChanged(value);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<SignUpCubit, SignUpState>(
              builder: (context, state) {
                return ButtonAccent(
                  child: Text(
                    _messages!.sign_up_get_started,
                    style: TextStyle(
                      fontFamily: AppFonts.SFProText,
                    ),
                  ),
                  onPressed: state.email.valid
                      ? () {
                          _signUpCubit.signUp(context);
                        }
                      : null,
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _ButtonPrimary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ButtonPrimary(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                fit: BoxFit.fill,
                width: 20,
                image: AssetImage('assets/apple.png'),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Sign Up with Apple',
                style: TextStyle(
                    fontFamily: AppFonts.SFProText,
                    fontSize: AppSizes.INPUT_TEXT),
              ),
            ],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(
          height: 10,
        ),
        ButtonPrimary(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                fit: BoxFit.fill,
                width: 20,
                image: AssetImage('assets/google.png'),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Sign Up with Google',
                style: TextStyle(
                    fontFamily: AppFonts.SFProText,
                    fontSize: AppSizes.INPUT_TEXT),
              ),
            ],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(
          height: 10,
        ),
        ButtonPrimary(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                fit: BoxFit.fill,
                width: 20,
                image: AssetImage('assets/twitter.png'),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Sign Up with Twitter',
                style: TextStyle(
                    fontFamily: AppFonts.SFProText,
                    fontSize: AppSizes.INPUT_TEXT),
              ),
            ],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
