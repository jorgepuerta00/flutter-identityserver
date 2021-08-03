import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/AppColors.dart';
import '../../constants/AppSizes.dart';
import '../../widgets/buttons/button_primary.dart';
import '../../widgets/inputs/text_input.dart';
import '../../widgets/inputs/top_labeled_input.dart';
import '../../widgets/text/header_1.dart';
import 'cubit/sign_up_cubit.dart';
import 'date_of_birth_screen.dart';
import '../../widgets/screen/app_top_padding_screen.dart';

class FirstLastNameScreenArgs {
  final String email;
  FirstLastNameScreenArgs({
    required this.email,
  });
}

class FirstLastNameScreen extends StatefulWidget {
  static const String Route = '/sign_up/first_last_name_screen';
  final FirstLastNameScreenArgs? args;
  FirstLastNameScreen({Key? key, this.args}) : super(key: key);

  @override
  _FirstLastNameScreenState createState() => _FirstLastNameScreenState();
}

class _FirstLastNameScreenState extends State<FirstLastNameScreen> {
  final _verticalSpacing = 25.0;

  late SignUpCubit _signUpCubit;

  @override
  Widget build(BuildContext context) {
    _signUpCubit = context.read<SignUpCubit>();

    //If email came, it means that user is finishing its onboarding
    if (widget.args?.email != null) {
      _signUpCubit.emailChanged(widget.args!.email);
    }

    return AppTopPaddingScreen(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Header1(
                  title: '''Congrats,
      Account Created''',
                  signs: '!',
                ),
                SizedBox(
                  height: _verticalSpacing,
                ),
                Text(
                  '''Let\'s get started with your
      name.''',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: _verticalSpacing * 2,
                ),
                _firstNameInput(),
                SizedBox(
                  height: _verticalSpacing,
                ),
                _lastNameInput(),
                SizedBox(
                  height: _verticalSpacing * 2,
                ),
              ],
            ),
            _nextButton(context),
          ],
        ),
      ),
    );
  }

  Widget _firstNameInput() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (_, state) {
        return Column(
          children: [
            TopLabeledInput(
              label: 'First Name(s)',
              widget: TextInput(
                textValidator: state.firstName,
                autofillHints: [AutofillHints.givenName],
                onChanged: (String value) {
                  _signUpCubit.firstNameChanged(value);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _lastNameInput() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (_, state) {
        return Column(
          children: [
            TopLabeledInput(
              label: 'Last(s) Name(s)',
              widget: TextInput(
                autofillHints: [AutofillHints.familyName],
                textValidator: state.lastName,
                onChanged: (String value) {
                  _signUpCubit.lastNameChanged(value);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _nextButton(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.firstName.valid != current.firstName.valid ||
          previous.lastName.valid != current.lastName.valid,
      builder: (_, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Step 1 of 7",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColors.PRIMARY_SWATCH[200],
                      fontSize: AppSizes.INPUT_TOP_LABEL_TEXT),
                ),
                ButtonPrimary(
                  onPressed: state.firstName.valid && state.lastName.valid
                      ? () {
                          Navigator.of(context)
                              .pushNamed(DateOfBirthScreen.Route);
                        }
                      : null,
                  child: Row(
                    children: [
                      Text(
                        'Next',
                      ),
                      Icon(Icons.chevron_right_rounded),
                    ],
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
