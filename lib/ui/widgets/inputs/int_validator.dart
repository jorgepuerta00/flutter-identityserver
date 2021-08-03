import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

enum IntValidationError {
  isEmpty,
  NaN,
  minimumValue,
  maximumValue,
}

class IntValidator extends FormzInput<String, IntValidationError>
    with EquatableMixin {
  IntValidator.pure({
    this.isRequired = false,
    this.min,
    this.max,
  }) : super.pure('');

  IntValidator.dirty({
    this.isRequired = false,
    String value = '',
    this.min,
    this.max,
  }) : super.dirty(value);

  final bool isRequired;
  final int? min;
  final int? max;

  static const Map<IntValidationError, String> errorsMessagesMap = {
    IntValidationError.isEmpty: '',
    IntValidationError.NaN: '',
    IntValidationError.minimumValue: '',
    IntValidationError.maximumValue: '',
  };

  @override
  List<Object?> get props => [
        value,
        isRequired,
        min,
        max,
      ];

  IntValidator copyWithDirty({
    String? value,
    bool? isRequired,
    int? min,
    int? max,
  }) {
    return IntValidator.dirty(
      value: value ?? this.value,
      isRequired: isRequired ?? this.isRequired,
      min: min ?? this.min,
      max: max ?? this.max,
    );
  }

  @override
  IntValidationError? validator(String? value) {
    if (isRequired && (value == null || value.length == 0)) {
      return IntValidationError.isEmpty;
    }

    int intValue;
    try {
      intValue = int.parse(value!);
    } catch (e) {
      return IntValidationError.NaN;
    }

    if (min != null && intValue < min!) {
      return IntValidationError.minimumValue;
    }

    if (max != null && intValue > max!) {
      return IntValidationError.maximumValue;
    }

    return null;
  }
}
