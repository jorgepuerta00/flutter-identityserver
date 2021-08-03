import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:revvy/ui/constants/AppColors.dart';

import 'password_validator.dart';

class PasswordInputPoliciesIndicator extends StatelessWidget {
  final PasswordValidator passwordValidator;
  final fontSize = 14.0;
  final horizontalMargin = 8.0;
  final verticalMargin = 15.0;

  PasswordInputPoliciesIndicator({
    required this.passwordValidator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: verticalMargin - 10,
        ),
        _inputValidationPolicy(
          context,
          isValid: passwordValidator.isLengthValid(passwordValidator.value),
          validMessage: '6+ characters',
          validationError: PasswordValidationError.insuficientLength,
        ),
        SizedBox(
          height: verticalMargin,
        ),
        _inputValidationPolicy(
          context,
          isValid: passwordValidator.isUpperCaseValid(passwordValidator.value),
          validMessage: 'Uppercase letter',
          validationError: PasswordValidationError.mustIncludeUpperCase,
        ),
        SizedBox(
          height: verticalMargin,
        ),
        _inputValidationPolicy(
          context,
          isValid: passwordValidator.isLowerCaseValid(passwordValidator.value),
          validMessage: 'Lowercase letter',
          validationError: PasswordValidationError.mustIncludeLowerCase,
        ),
        SizedBox(
          height: verticalMargin,
        ),
        _inputValidationPolicy(
          context,
          isValid: passwordValidator
              .isMustIncludeADigitValid(passwordValidator.value),
          validMessage: 'Number',
          validationError: PasswordValidationError.mustIncludeADigit,
        ),
        SizedBox(
          height: verticalMargin,
        ),
        _inputValidationPolicy(
          context,
          isValid: passwordValidator
              .isMustIncludeACharacterValid(passwordValidator.value),
          validMessage: 'Symbol (!@#\$%^*-_+=)',
          validationError: PasswordValidationError.specialCharacter,
        ),
      ],
    );
  }

  Widget _inputValidationPolicy(
    BuildContext context, {
    required bool isValid,
    required String validMessage,
    required PasswordValidationError validationError,
  }) {
    return Row(
      children: <Widget>[
        isValid
            ? SvgPicture.asset(
                'assets/icons/password_policy_ok.svg',
              )
            : SvgPicture.asset(
                'assets/icons/password_policy.svg',
              ),
        SizedBox(
          width: isValid ? horizontalMargin : horizontalMargin * 2 + 2,
        ),
        Text(
          PasswordValidator.errorsMessagesMap[validationError] ?? '',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: fontSize,
                letterSpacing: .1,
                fontWeight: FontWeight.normal,
                color: isValid
                    ? Theme.of(context).textTheme.bodyText1?.color
                    : AppColors.GREY_DARK_STRONG,
              ),
        )
      ],
    );
  }
}
