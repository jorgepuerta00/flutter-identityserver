part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  SignInState.initial() {}

  SignInState(
    EmailValidator email,
    PasswordValidator password,
    FormzStatus status,
  ) {
    this.email = email;
    this.password = password;
    this.status = status;
  }

  EmailValidator email = EmailValidator.pure(
    isRequired: true,
  );
  PasswordValidator password = PasswordValidator.pure(
    isRequired: true,
    checkPolicies: false,
  );

  FormzStatus status = FormzStatus.pure;

  @override
  List<Object?> get props => [
        email,
        password,
        status,
      ];

  SignInState copyWith({
    EmailValidator? email,
    PasswordValidator? password,
    FormzStatus? status,
  }) {
    return SignInState(
      email ?? this.email,
      password ?? this.password,
      status ?? this.status,
    );
  }
}
