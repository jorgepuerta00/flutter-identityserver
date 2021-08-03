import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

import '../../../../models/identity/new_account_info.dart';
import '../../../../models/identity/sign_up_info.dart';
import '../../../../models/interests/industry_info.dart';
import '../../../../repository/identity/sign_up_repository.dart';
import '../../../services/dialog_message_service.dart';
import '../../../widgets/inputs/email_validator.dart';
import '../../../widgets/inputs/int_validator.dart';
import '../../../widgets/inputs/password_validator.dart';
import '../../../widgets/inputs/text_validator.dart';
import '../../dashboard/dashboard_screen.dart';
import '../email_code_verification_screen.dart';
import '../interests_screen.dart';
import '../password_screen.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required this.signUpRepository,
    required this.dialogMessageService,
  }) : super(SignUpState.initial());

  SignUpRepository signUpRepository;

  DialogMessageService dialogMessageService;

  void emailChanged(String value) {
    final email = state.email.copyWithDirty(
      value: value,
      notAvailable: false,
    );
    emit(
      state.copyWith(
        email: email,
      ),
    );
  }

  void passwordChanged(String value) {
    final password = this.state.password.copyWithDirty(value: value);
    emit(
      state.copyWith(
        password: password,
      ),
    );
  }

  void firstNameChanged(String value) {
    final firstName = this.state.firstName.copyWithDirty(value: value);
    emit(
      state.copyWith(
        firstName: firstName,
      ),
    );
  }

  void lastNameChanged(String value) {
    final lastName = this.state.lastName.copyWithDirty(value: value);
    emit(
      state.copyWith(
        lastName: lastName,
      ),
    );
  }

  void monthChanged(String value) {
    String? isDateOfBirthValidMessage = _isDateOfBirthValid(
      month: value,
      day: state.day.value,
      year: state.year.value,
    );

    FormzStatus isDateofBirthValidStatus = isDateOfBirthValidMessage == null
        ? FormzStatus.valid
        : FormzStatus.invalid;

    final month = this.state.month.copyWithDirty(value: value);
    emit(
      state.copyWith(
        month: month,
        customError:
            isDateofBirthValidStatus.isValid ? '' : isDateOfBirthValidMessage,
        isDateofBirthValidStatus: isDateofBirthValidStatus,
      ),
    );
  }

  void dayChanged(String value) {
    String? isDateOfBirthValidMessage = _isDateOfBirthValid(
      month: state.month.value,
      day: value,
      year: state.year.value,
    );
    final day = this.state.day.copyWithDirty(
          value: value,
        );

    FormzStatus isDateofBirthValidStatus = isDateOfBirthValidMessage == null
        ? FormzStatus.valid
        : FormzStatus.invalid;

    emit(
      state.copyWith(
        day: day,
        customError:
            isDateofBirthValidStatus.isValid ? '' : isDateOfBirthValidMessage,
        isDateofBirthValidStatus: isDateofBirthValidStatus,
      ),
    );
  }

  void yearChanged(String value) {
    String? isDateOfBirthValidMessage = _isDateOfBirthValid(
      month: state.month.value,
      day: state.day.value,
      year: value,
    );
    final year = this.state.year.copyWithDirty(value: value);
    FormzStatus isDateofBirthValidStatus = isDateOfBirthValidMessage == null
        ? FormzStatus.valid
        : FormzStatus.invalid;
    emit(
      state.copyWith(
        year: year,
        customError:
            isDateofBirthValidStatus.isValid ? '' : isDateOfBirthValidMessage,
        isDateofBirthValidStatus: isDateofBirthValidStatus,
      ),
    );
  }

  String? _isDateOfBirthValid({
    String? month = '',
    String? day,
    String? year,
  }) {
    if (month == null) {
      return null;
    }

    int monthIndex = state.months.indexOf(month);
    if (monthIndex == -1 || monthIndex == 0) {
      return null;
    }

    if (day == null || day.length == 0) {
      return null;
    }

    if (year == null || year.length == 0) {
      return null;
    }

    DateTime today = DateTime.now();
    DateTime adultDate = DateTime(
      int.parse(year) + 14,
      monthIndex,
      int.parse(day),
    );

    if (!adultDate.isBefore(today)) {
      return "You need to be at least 14 years old to use Revvy.";
    }

    return null;
  }

  void locationChanged(String value) {
    emit(
      state.copyWith(
        location: value,
      ),
    );
  }

  void profilePicturePicked(String value) {
    emit(
      state.copyWith(
        imagePath: value,
      ),
    );
  }

  Future<void> signUp(BuildContext context) async {
    if (!state.email.valid) {
      return;
    }

    try {
      dialogMessageService.showLoading();

      if (await _checkIfMemberEmailAlreadyExists()) {
        final email = this.state.email.copyWithDirty(
              notAvailable: true,
            );
        emit(
          state.copyWith(
            email: email,
          ),
        );
        dialogMessageService.hideLoading();
        return;
      }
      dialogMessageService.hideLoading();
      Navigator.of(context).pushNamed(PasswordScreen.Route);
    } catch (e) {
      dialogMessageService.displayError(
        'There was an unexpected error. Please try again later',
      );
    }
  }

  Future<void> createMemberAccount(BuildContext context) async {
    if (!state.email.valid || !state.password.valid) {
      return;
    }

    try {
      dialogMessageService.showLoading();

      if (await _checkIfMemberEmailAlreadyExists()) {
        return;
      }

      await signUpRepository.createNewAccount(
        newAccountInfo: NewAccountInfo(
          userEmail: state.email.value,
          password: state.password.value,
        ),
      );

      dialogMessageService.hideLoading();

      Navigator.pushNamed(context, EmailCodeVerificationScreen.Route);
    } catch (e) {
      dialogMessageService.displayError(
        'There was an unpextected error. Please try again later',
      );
    }
  }

  Future<bool> _checkIfMemberEmailAlreadyExists() async {
    var memberEmailExists = await signUpRepository.checkIfUserEmailExists(
      userEmail: state.email.value,
    );

    if (memberEmailExists) {
      dialogMessageService.setErrorState(
        'The ${state.email.value} email, already exists',
      );
      final email = this.state.email.copyWithDirty(
            notAvailable: true,
          );
      emit(
        state.copyWith(
          email: email,
        ),
      );
      dialogMessageService.hideLoading();
    }

    return memberEmailExists;
  }

  void industryAdded(String newInterestId, IndustryInfo industryInfo) {
    Map<String, IndustryInfo> newIndustriesMap =
        Map.fromEntries(state.selectedIndustriesMap.entries);

    newIndustriesMap[newInterestId] = industryInfo;

    emit(
      state.copyWith(
        selectedIndustriesMap: newIndustriesMap,
      ),
    );
  }

  void industryRemoved(String idToRemove) {
    var newIndustriesList = state.selectedIndustriesMap.values
        .where((industry) => industry.id != idToRemove);

    Map<String, IndustryInfo> newIndustriesMap = {};
    newIndustriesList.forEach((element) {
      newIndustriesMap[element.id] = element;
    });

    emit(
      state.copyWith(
        selectedIndustriesMap: newIndustriesMap,
      ),
    );
  }

  void pronounsChanged(String value) {
    emit(
      state.copyWith(
        pronouns: value,
      ),
    );
  }

  void isPronounsPublicChanged(bool value) {
    emit(
      state.copyWith(
        isPronounsPublic: value,
      ),
    );
  }

  void setPushNotifications(bool value) {
    emit(
      state.copyWith(
        pushNotifications: value,
      ),
    );
  }

  void nextDayOfBirth(BuildContext context) {
    var realDay = int.parse(state.day.value) < 10 && state.day.value.length != 2
        ? '0${state.day.value}'
        : state.day.value;

    int monthIndex = state.months.indexOf(state.month.value);
    var realMonth = monthIndex.toString();
    if (monthIndex < 10) {
      realMonth = '0$realMonth';
    }

    try {
      var dateString = '${state.year.value}-$realMonth-$realDay';
      var date = DateTime.tryParse(dateString);
      if (date!.day != int.parse(realDay)) {
        emit(state.copyWith(
          customError: 'Please enter a valid Date Of Birth',
        ));
        return;
      }

      Navigator.of(context).pushNamed(
        InterestsScreen.Route,
      );
    } catch (e) {
      dialogMessageService.displayError(
        'There was an error. Please try again later.',
      );
    }
  }

  Future<void> finishSignUp(BuildContext context) async {
    var realDay = int.parse(state.day.value) < 10 && state.day.value.length != 2
        ? '0${state.day.value}'
        : state.day.value;

    try {
      var dateString = '${state.month.value} $realDay, ${state.year.value}';
      DateFormat format = new DateFormat("MMMM dd, yyyy");
      format.parse(dateString);
    } catch (e) {
      dialogMessageService.displayError(
        'Please enter a valid date of birth',
      );
    }

    try {
      dialogMessageService.showLoading();

      int monthIndex = state.months.indexOf(state.month.value);
      var realMonth = monthIndex.toString();
      if (monthIndex < 10) {
        realMonth = '0$realMonth';
      }

      await signUpRepository.saveSignUpData(
          signUpInfo: SignUpInfo(
        userEmail: state.email.value,
        lastName: state.lastName.value,
        firstName: state.firstName.value,
        dob: '${state.year.value}-$realMonth-$realDay',
        idsIndustries: state.selectedIndustriesMap.keys.toList(),
        pronoun: state.pronouns,
        pronounVisibility: state.isPronounsPublic,
        pushNotifications: state.pushNotifications,
        locationName: state.location,
      ));

      dialogMessageService.hideLoading();

      Navigator.of(context).pushNamedAndRemoveUntil(
        DashboardScreen.Route,
        (route) => false,
        arguments: DashboardScreenArgs(
          userName: state.firstName.value,
        ),
      );
    } catch (e) {
      dialogMessageService.displayError(
        'There was an unepextected error. Please try again later',
      );
    }
  }
}
