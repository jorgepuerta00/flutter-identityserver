import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

enum TextValidatorError {
  isEmpty,
}

class TextValidator extends FormzInput<String, TextValidatorError>
    with EquatableMixin {
  //TODO: Fix const constructor
  TextValidator.pure({
    this.isRequired = false,
  }) : super.pure('');

  TextValidator.dirty({
    this.isRequired = false,
    String value = '',
  }) : super.dirty(value);

  final bool isRequired;

  static const Map<TextValidatorError, String> errorsMessagesMap = {
    TextValidatorError.isEmpty: '',
  };

  @override
  List<Object> get props => [
        value,
        isRequired,
      ];

  TextValidator copyWithDirty({
    String? value,
    bool? isRequired,
  }) {
    return TextValidator.dirty(
      value: value ?? this.value,
      isRequired: isRequired ?? this.isRequired,
    );
  }

  @override
  TextValidatorError? validator(String? value) {
    if (isRequired && (value == null || value.length == 0)) {
      return TextValidatorError.isEmpty;
    }

    return null;
  }
}
