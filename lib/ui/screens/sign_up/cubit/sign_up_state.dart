part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  SignUpState.initial() {
    this.months = <String>[
      'Month',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    this.month = this.month.copyWithDirty(
          value: months[0],
        );
  }

  SignUpState(
    EmailValidator email,
    PasswordValidator password,
    TextValidator firstName,
    TextValidator lastName,
    TextValidator month,
    IntValidator day,
    IntValidator year,
    List<String> months,
    String? customError,
    FormzStatus isDateofBirthValidStatus,
    String location,
    Map<String, IndustryInfo> selectedIndustriesMap,
    String imagePath,
    String pronouns,
    bool isPronounsPublic,
    bool pushNotifications,
    FormzStatus status,
  ) {
    this.email = email;
    this.password = password;
    this.firstName = firstName;
    this.lastName = lastName;
    this.month = month;
    this.year = year;
    this.day = day;
    this.months = months;
    this.customError = customError;
    this.isDateofBirthValidStatus = isDateofBirthValidStatus;
    this.location = location;
    this.selectedIndustriesMap = selectedIndustriesMap;
    this.imagePath = imagePath;
    this.pronouns = pronouns;
    this.isPronounsPublic = isPronounsPublic;
    this.pushNotifications = pushNotifications;
    this.status = status;
  }

  EmailValidator email = EmailValidator.pure(
    isRequired: true,
  );
  PasswordValidator password = PasswordValidator.pure(
    isRequired: true,
    checkPolicies: true,
  );
  TextValidator firstName = TextValidator.pure(
    isRequired: true,
  );
  TextValidator lastName = TextValidator.pure(
    isRequired: true,
  );
  TextValidator month = TextValidator.pure(
    isRequired: true,
  );
  IntValidator day = IntValidator.pure(
    isRequired: true,
    min: 1,
    max: 31,
  );
  IntValidator year = IntValidator.pure(
    isRequired: true,
    min: 1950,
    max: DateTime.now().year - 14,
  );

  String? customError;

  FormzStatus status = FormzStatus.pure;
  FormzStatus isDateofBirthValidStatus = FormzStatus.pure;

  List<String> months = [];
  String location = '';

  Map<String, IndustryInfo> selectedIndustriesMap = {};
  String imagePath = '';
  String pronouns = '';
  bool isPronounsPublic = true;
  bool pushNotifications = false;

  @override
  List<Object?> get props => [
        email,
        password,
        firstName,
        lastName,
        day,
        month,
        year,
        customError,
        isDateofBirthValidStatus,
        location,
        selectedIndustriesMap,
        imagePath,
        pronouns,
        isPronounsPublic,
        pushNotifications,
        status,
      ];

  SignUpState copyWith({
    EmailValidator? email,
    PasswordValidator? password,
    TextValidator? lastName,
    TextValidator? firstName,
    IntValidator? day,
    TextValidator? month,
    IntValidator? year,
    FormzStatus? isDateofBirthValidStatus,
    String? customError,
    String? location,
    Map<String, IndustryInfo>? selectedIndustriesMap,
    String? imagePath,
    String? pronouns,
    bool? isPronounsPublic,
    bool? pushNotifications,
    FormzStatus? status,
  }) {
    return SignUpState(
      email ?? this.email,
      password ?? this.password,
      firstName ?? this.firstName,
      lastName ?? this.lastName,
      month ?? this.month,
      day ?? this.day,
      year ?? this.year,
      this.months,
      customError ?? this.customError,
      isDateofBirthValidStatus ?? this.isDateofBirthValidStatus,
      location ?? this.location,
      selectedIndustriesMap ?? this.selectedIndustriesMap,
      imagePath ?? this.imagePath,
      pronouns ?? this.pronouns,
      isPronounsPublic ?? this.isPronounsPublic,
      pushNotifications ?? this.pushNotifications,
      status ?? this.status,
    );
  }
}
