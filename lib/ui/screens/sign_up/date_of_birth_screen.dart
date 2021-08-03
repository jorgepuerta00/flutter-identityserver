import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:revvy/ui/constants/AppFonts.dart';
import 'package:revvy/ui/screens/sign_up/interests_screen.dart';
import 'package:revvy/ui/widgets/inputs/int_input.dart';

import '../../constants/AppColors.dart';
import '../../constants/AppSizes.dart';
import '../../widgets/buttons/button_primary.dart';
import '../../widgets/inputs/top_labeled_input.dart';
import '../../widgets/text/header_1.dart';
import 'cubit/sign_up_cubit.dart';
import '../../widgets/screen/app_top_padding_screen.dart';

class DateOfBirthScreen extends StatefulWidget {
  static const String Route = '/sign_up/day_of_birth_screen';

  DateOfBirthScreen({Key? key}) : super(key: key);

  @override
  _DateOfBirthScreenState createState() => _DateOfBirthScreenState();
}

class _DateOfBirthScreenState extends State<DateOfBirthScreen> {
  String dropdownMonthValue = 'Month';
  String dropdownDayValue = 'DD';
  String dropdownYearValue = 'YYYY';

  final _verticalSpacing = 25.0;

  late SignUpCubit _signUpCubit;

  @override
  Widget build(BuildContext context) {
    _signUpCubit = context.read<SignUpCubit>();

    return AppTopPaddingScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header1(
                title: '''When\'s Your 
Birthday''',
                signs: '?',
              ),
              SizedBox(
                height: _verticalSpacing,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _monthInput(),
                  _dayInput(),
                  _yearInput(),
                ],
              ),
              SizedBox(
                height: _verticalSpacing,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'This won’t be part of your public profile.',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 13,
                          letterSpacing: 1,
                          color: AppColors.PRIMARY_SWATCH[200],
                          fontFamily: AppFonts.Avenir,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              BlocBuilder<SignUpCubit, SignUpState>(
                buildWhen: (previous, current) =>
                    previous.customError != current.customError,
                builder: (context, state) {
                  return Text(
                    state.customError == null || state.customError?.length == 0
                        ? ''
                        : state.customError!,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 13,
                          color: AppColors.RED,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.normal,
                        ),
                  );
                },
              )
            ],
          ),
          _nextButton(context),
        ],
      ),
    );
  }

  Widget _monthInput() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.month != current.month,
      builder: (context, state) {
        return TopLabeledInput(
          label: 'Month',
          widget: Container(
            width: 140,
            height: 44,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.GREY_DARK),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: AppColors.PRIMARY_SWATCH,
                  value: state.month.value,
                  isDense: true,
                  isExpanded: true,
                  style: const TextStyle(color: AppColors.WHITE),
                  onChanged: (String? value) {
                    if (value != null) {
                      _signUpCubit.monthChanged(value);
                    }
                  },
                  items: _signUpCubit.state.months
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _dayInput() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.day != current.day,
      builder: (_, state) {
        return TopLabeledInput(
          label: 'Day',
          widget: Container(
            width: 87,
            height: 44,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.GREY_DARK),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: IntInput(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              hintText: 'DD',
              intValidator: state.day,
              onChanged: (String value) {
                _signUpCubit.dayChanged(value);
              },
              autofillHints: [AutofillHints.birthdayDay],
            ),
          ),
        );
      },
    );
  }

  Widget _yearInput() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.year != current.year,
      builder: (_, state) {
        return TopLabeledInput(
            label: 'Year',
            widget: Container(
              width: 86,
              height: 44,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.GREY_DARK),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: Center(
                  child: IntInput(
                intValidator: state.year,
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  _signUpCubit.yearChanged(value);
                },
                hintText: 'YYYY',
                autofillHints: [AutofillHints.birthdayYear],
              )),
            ));
      },
    );
  }

  Widget _nextButton(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.month.valid != current.month.valid ||
          previous.day.valid != current.day.valid ||
          previous.year.valid != current.year.valid ||
          previous.isDateofBirthValidStatus != current.isDateofBirthValidStatus,
      builder: (_, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Step 2 of 7",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColors.PRIMARY_SWATCH[200],
                      fontSize: AppSizes.INPUT_TOP_LABEL_TEXT),
                ),
                ButtonPrimary(
                  onPressed: state.month.valid &&
                          state.day.valid &&
                          state.year.valid &&
                          state.isDateofBirthValidStatus == FormzStatus.valid
                      ? () {
                          _signUpCubit.nextDayOfBirth(context);
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
