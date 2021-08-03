import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/AppColors.dart';
import '../../constants/AppFonts.dart';
import '../../constants/AppSizes.dart';
import '../../widgets/buttons/button_accent.dart';
import '../../widgets/buttons/button_primary.dart';
import '../../widgets/inputs/email_input.dart';
import '../../widgets/inputs/top_labeled_input.dart';
import '../../widgets/screen/app_top_padding_screen.dart';
import '../../widgets/text/header_1.dart';
import '../sign_up/email_screen.dart';
import 'cubit/sign_in_cubit.dart';

class SignInEmailScreen extends StatelessWidget {
  static const String Route = '/sign_in/signin_email_screen';

  SignInEmailScreen({Key? key}) : super(key: key);

  late SignInCubit _signInCubit;

  @override
  Widget build(BuildContext context) {
    final _verticalSpacing = 20.0;
    _signInCubit = context.read<SignInCubit>();

    return AppTopPaddingScreen(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Header1(
              title: '''Log in to
      Your Account''',
              signs: '.',
            ),
            SizedBox(
              height: _verticalSpacing * 2,
            ),
            _emailInput(),
            SizedBox(
              height: _verticalSpacing * 1.5,
            ),
            _signInButton(context),
            SizedBox(
              height: _verticalSpacing,
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
              height: _verticalSpacing,
            ),
            _ButtonPrimary(),
            SizedBox(
              height: _verticalSpacing * 3.5,
            ),
            SizedBox(
              height: _verticalSpacing + 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Don\'t have an account yet?',
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
                    'Sign up',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontFamily: AppFonts.Avenir,
                          color: AppColors.ORANGE,
                        ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      EmailScreen.Route,
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TopLabeledInput _emailInput() {
    return TopLabeledInput(
      label: 'Email',
      widget: SafeArea(
        child: BlocBuilder<SignInCubit, SignInState>(
          buildWhen: (previous, current) => previous.email != current.email,
          builder: (context, state) {
            return EmailInput(
              icon: Icon(Icons.remove_circle_rounded),
              emailValidator: state.email,
              onChanged: (String value) {
                _signInCubit.emailChanged(value);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _signInButton(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) =>
          previous.email.valid != current.email.valid,
      builder: (_, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ButtonAccent(
              child: Text('Sign In'),
              onPressed: state.email.valid
                  ? () {
                      _signInCubit.goToPasswordScreen(context);
                    }
                  : null,
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
                'Continue with Apple',
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
                'Continue with Google',
                style: TextStyle(
                  fontFamily: AppFonts.SFProText,
                  fontSize: AppSizes.INPUT_TEXT,
                ),
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
                'Continue with Twitter',
                style: TextStyle(
                  fontFamily: AppFonts.SFProText,
                  fontSize: AppSizes.INPUT_TEXT,
                ),
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
