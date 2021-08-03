part of 'dialog_message_bloc.dart';

enum DialogMessageTypeEnum {
  none,
  loading,
  error,
  warning,
  success,
  info,
}

abstract class DialogMessageState {
  final String message;
  final DialogMessageTypeEnum status;
  final bool displayDialog;
  const DialogMessageState({
    required this.message,
    required this.status,
    required this.displayDialog,
  });
}

class DialogMessageNormalState extends DialogMessageState {
  const DialogMessageNormalState()
      : super(
          message: '',
          status: DialogMessageTypeEnum.none,
          displayDialog: false,
        );
}

class DialogMessageLoadingState extends DialogMessageState {
  const DialogMessageLoadingState({
    required String message,
    required bool displayErrorDialog,
  }) : super(
          message: message,
          status: DialogMessageTypeEnum.loading,
          displayDialog: displayErrorDialog,
        );
}

class DialogMessageInfoState extends DialogMessageState {
  const DialogMessageInfoState({
    String message = '',
    required bool displayErrorDialog,
  }) : super(
          message: message,
          status: DialogMessageTypeEnum.info,
          displayDialog: displayErrorDialog,
        );
}

class DialogMessageErrorState extends DialogMessageState {
  const DialogMessageErrorState({
    String message = '',
    required bool displayErrorDialog,
  }) : super(
          message: message,
          status: DialogMessageTypeEnum.error,
          displayDialog: displayErrorDialog,
        );
}

class DialogMessageWarningState extends DialogMessageState {
  const DialogMessageWarningState({
    String message = '',
    required bool displayErrorDialog,
  }) : super(
          message: message,
          status: DialogMessageTypeEnum.warning,
          displayDialog: displayErrorDialog,
        );
}

class DialogMessageSuccessState extends DialogMessageState {
  const DialogMessageSuccessState({
    String message = '',
    required bool displayErrorDialog,
  }) : super(
          message: message,
          status: DialogMessageTypeEnum.success,
          displayDialog: displayErrorDialog,
        );
}
