import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

enum EmailValidationError {
  invalid,
  noAvailable,
}

class EmailValidator extends FormzInput<String, EmailValidationError>
    with EquatableMixin {
  //TODO: Fix const constructor
  EmailValidator.pure({
    this.isRequired = false,
    this.notAvailable = false,
  }) : super.pure('');

  EmailValidator.dirty({
    this.isRequired = false,
    this.notAvailable = false,
    String value = '',
  }) : super.dirty(value);

  final bool isRequired;
  final bool notAvailable;

  @override
  List<Object> get props => [
        value,
        isRequired,
        notAvailable,
      ];

  static final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static const Map<EmailValidationError, String> errorsMessagesMap = {
    EmailValidationError.invalid: 'Incorrect email format. e.g xyz@gmail.com',
    EmailValidationError.noAvailable: 'Email address already in use',
  };

  EmailValidator copyWithDirty({
    String? value,
    bool? isRequired,
    bool? notAvailable,
  }) {
    return EmailValidator.dirty(
      value: value ?? this.value,
      isRequired: isRequired ?? this.isRequired,
      notAvailable: notAvailable ?? this.notAvailable,
    );
  }

  @override
  EmailValidationError? validator(String value) {
    if (!emailRegExp.hasMatch(value)) {
      return EmailValidationError.invalid;
    }
    if (notAvailable) {
      return EmailValidationError.noAvailable;
    }

    return null;
  }
}
