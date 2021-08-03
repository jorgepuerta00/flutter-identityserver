import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

enum PasswordValidationError {
  isEmpty,
  mustIncludeUpperCase,
  mustIncludeLowerCase,
  mustIncludeADigit,
  insuficientLength,
  specialCharacter,
  wrongPassword,
}

class PasswordValidator extends FormzInput<String, PasswordValidationError>
    with EquatableMixin {
  final bool isRequired;
  final bool? wrongPassword;
  final bool? checkPolicies;

  PasswordValidator.pure({
    this.isRequired = false,
    this.wrongPassword = false,
    this.checkPolicies = true,
  }) : super.pure('');

  PasswordValidator.dirty({
    this.isRequired = false,
    String value = '',
    this.wrongPassword,
    this.checkPolicies,
  }) : super.dirty(value);

  static const Map<PasswordValidationError, String> errorsMessagesMap = {
    PasswordValidationError.isEmpty: 'Enter a password',
    PasswordValidationError.mustIncludeUpperCase: 'Uppercase letter',
    PasswordValidationError.mustIncludeLowerCase: 'Lowercase letter',
    PasswordValidationError.mustIncludeADigit: 'Number',
    PasswordValidationError.insuficientLength: '6+ characters',
    PasswordValidationError.specialCharacter: 'Symbol (!@#\$%^*-_+=)',
    PasswordValidationError.wrongPassword: 'Wrong password. Please try again!',
  };

  static final RegExp mustIncludeLowerCase = RegExp(
    r'(?=.*[a-z])',
  );

  static final RegExp mustIncludeUpperCase = RegExp(
    r'(?=.*[A-Z])',
  );

  static final RegExp mustIncludeADigit = RegExp(
    r'(?=.*\d)',
  );

  static final RegExp mustIncludeSpecialCharacter = RegExp(
    r'([!@#\$%^*\-\_+=])',
  );

  @override
  List<Object?> get props => [
        value,
        isRequired,
        wrongPassword,
        checkPolicies,
      ];

  bool isLengthValid(value) {
    return value.length >= 6;
  }

  bool isLowerCaseValid(value) {
    return mustIncludeLowerCase.hasMatch(value);
  }

  bool isUpperCaseValid(value) {
    return mustIncludeUpperCase.hasMatch(value);
  }

  bool isMustIncludeADigitValid(value) {
    return mustIncludeADigit.hasMatch(value);
  }

  bool isMustIncludeACharacterValid(value) {
    return mustIncludeSpecialCharacter.hasMatch(value);
  }

  PasswordValidator copyWithDirty({
    String? value,
    bool? isRequired,
    bool? wrongPassword,
    bool? checkPolicies,
  }) {
    return PasswordValidator.dirty(
      value: value ?? this.value,
      isRequired: isRequired ?? this.isRequired,
      wrongPassword: wrongPassword ?? this.wrongPassword,
      checkPolicies: checkPolicies ?? this.checkPolicies,
    );
  }

  @override
  PasswordValidationError? validator(String? value) {
    if (isRequired && (value == null || value.length == 0)) {
      return PasswordValidationError.isEmpty;
    }

    if (wrongPassword != null && wrongPassword!) {
      return PasswordValidationError.wrongPassword;
    }

    if (checkPolicies == null || !checkPolicies!) {
      return null;
    }

    if (!isLengthValid(value)) {
      return PasswordValidationError.insuficientLength;
    }

    if (!isLowerCaseValid(value)) {
      return PasswordValidationError.mustIncludeLowerCase;
    }

    if (!isUpperCaseValid(value)) {
      return PasswordValidationError.mustIncludeUpperCase;
    }

    if (!isMustIncludeADigitValid(value)) {
      return PasswordValidationError.mustIncludeADigit;
    }

    if (!isMustIncludeACharacterValid(value)) {
      return PasswordValidationError.specialCharacter;
    }

    return null;
  }
}
