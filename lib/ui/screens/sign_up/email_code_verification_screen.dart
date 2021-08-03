import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revvy/models/shared/backend_error_info.dart';
import '../../../api/base/api_base_helper.dart';
import '../../../models/identity/verify_code_info.dart';
import '../../constants/AppFonts.dart';
import '../../services/dialog_message_service.dart';
import '../../widgets/text/header_1.dart';

import '../../../repository/identity/sign_up_repository.dart';
import '../../../sot/dialog_message/dialog_message_bloc.dart';
import '../../constants/AppColors.dart';
import '../../widgets/inputs/top_labeled_input.dart';
import 'cubit/sign_up_cubit.dart';
import 'first_last_name_screen.dart';
import '../../widgets/screen/app_top_padding_screen.dart';

class EmailCodeVerificationScreen extends StatefulWidget {
  static const String Route = '/sign_up/email_code_verification_screen';
  const EmailCodeVerificationScreen({Key? key}) : super(key: key);

  @override
  _EmailCodeVerificationScreenState createState() =>
      _EmailCodeVerificationScreenState();
}

class _EmailCodeVerificationScreenState
    extends State<EmailCodeVerificationScreen> {
  late SignUpCubit _signUpCubit;
  late SignUpRepository _signUpRepository;
  late DialogMessageService _dialogMessageService;

  final _verticalSpacing = 25.0;
  final _verificationCodeLength = 6;

  late final _focusNodes = <FocusNode>[];
  late final _inputsControllers = <TextEditingController>[];
  late List<int> _digits = List.filled(_verificationCodeLength, -1);

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _verificationCodeLength; i++) {
      final focusNode = FocusNode();
      _focusNodes.add(focusNode);
      final textEditingController = TextEditingController();
      _inputsControllers.add(textEditingController);
    }
  }

  @override
  Widget build(BuildContext context) {
    _signUpCubit = context.read<SignUpCubit>();
    _signUpRepository = context.read<SignUpRepository>();
    _dialogMessageService = context.read<DialogMessageService>();

    return AppTopPaddingScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(FirstLastNameScreen.Route);
            },
            child: Header1(
              title: '''Verify your email''',
              signs: '.',
            ),
          ),
          SizedBox(
            height: _verticalSpacing * 1.5,
          ),
          Center(
            child: Text(
              '''We sent a 6-digit code to
${_signUpCubit.state.email.value}.''',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(
            height: _verticalSpacing * 2,
          ),
          TopLabeledInput(
            label: 'Verification code',
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ..._focusNodes
                    .asMap()
                    .entries
                    .map(
                      (mapEntry) => _codeDigit(
                        focusNode: mapEntry.value,
                        index: mapEntry.key,
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
          SizedBox(
            height: _verticalSpacing / 2,
          ),
          BlocBuilder<DialogMessageBloc, DialogMessageState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (_, state) {
              return state.status == DialogMessageTypeEnum.error
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          state.message,
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 13,
                                    color: Colors.red,
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    )
                  : Opacity(
                      opacity: 0,
                    );
            },
          ),
          SizedBox(
            height: _verticalSpacing,
          ),
          Center(
            child: TextButton(
              child: Text('Resend Code'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: Theme.of(context).textTheme.bodyText1,
              ),
              onPressed: () {
                _resendEmailVerificationCode();
              },
            ),
          ),
          BlocBuilder<DialogMessageBloc, DialogMessageState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              return state.status == DialogMessageTypeEnum.loading
                  ? Center(
                      child: FloatingActionButton(
                        child: CircularProgressIndicator(
                          color: AppColors.WHITE,
                          strokeWidth: 3,
                          backgroundColor: AppColors.ORANGE,
                        ),
                        onPressed: () => 1,
                      ),
                    )
                  : Opacity(
                      opacity: 0,
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget _codeDigit({
    required FocusNode focusNode,
    required int index,
  }) {
    return BlocBuilder<DialogMessageBloc, DialogMessageState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Container(
          width: 50.0,
          child: TextField(
            controller: _inputsControllers[index],
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 1,
            decoration: InputDecoration(
              counterText: "",
              errorText: state.message.length > 0 ? state.message : null,
              errorStyle: TextStyle(
                height: 0,
              ),
            ),
            maxLengthEnforcement: MaxLengthEnforcement.none,
            autofocus: index == 0,
            focusNode: focusNode,
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.white,
            ),
            onChanged: (String value) {
              if (value.length == 1) {
                if (index < _focusNodes.length - 1) {
                  _focusNodes[index + 1].requestFocus();
                }
                _digits[index] = int.parse(value);
                _verifiCode();
              }
            },
          ),
        );
      },
    );
  }

  Future<void> _verifiCode() async {
    if (_digits.indexOf(-1) != -1) {
      return;
    }
    var verificationCode = _digits.join();

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    try {
      _dialogMessageService.showLoading();
      await _signUpRepository.verifyEmailCodeInfo(
        verifyCodeInfo: VerifyCodeInfo(
          userEmail: _signUpCubit.state.email.value,
          verificationCode: verificationCode,
        ),
      );

      _dialogMessageService.hideLoading();
      Navigator.of(context).pushNamedAndRemoveUntil(
        FirstLastNameScreen.Route,
        (route) => false,
      );
    } on ApiBadRequestException catch (ex) {
      try {
        var message =
            BackendErrorInfo.fromMap(jsonDecode(ex.response!.body.toString()))
                .title;
        _dialogMessageService.setErrorState(message);
      } catch (e) {}
    } catch (e) {
      _dialogMessageService.setErrorState('Invalid code. Please try again.');
    }
  }

  Future<void> _resendEmailVerificationCode() async {
    try {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      _dialogMessageService.showLoading();
      _focusNodes[0].requestFocus();
      for (var i = 0; i < _verificationCodeLength; i++) {
        _inputsControllers[i].text = '';
        _digits[i] = -1;
      }
      await _signUpRepository.resendEmailVerificationCode(
        verifyCodeInfo: VerifyCodeInfo(
          userEmail: _signUpCubit.state.email.value,
        ),
      );

      _dialogMessageService.displayInfo('''New code sent to
${_signUpCubit.state.email.value}''');
    } catch (e) {
      print(e);
      _dialogMessageService.setErrorState(
        'There was an error. Please try again later.',
      );
    }
  }

  @override
  void dispose() {
    for (var i = 0; i < _verificationCodeLength; i++) {
      _focusNodes[i].dispose();
      _inputsControllers[i].dispose();
    }
    super.dispose();
  }
}
