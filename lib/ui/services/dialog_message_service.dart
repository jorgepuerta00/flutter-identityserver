import '../../../../sot/dialog_message/dialog_message_bloc.dart';

class DialogMessageService {
  DialogMessageService({
    required this.dialogMessageBloc,
  });

  final DialogMessageBloc dialogMessageBloc;

  void showLoading([String? message]) {
    if (message == null) {
      dialogMessageBloc.add(DialogMessageShowLoadingEvent());
    } else {
      dialogMessageBloc.add(DialogMessageShowLoadingEvent(message: message));
    }
  }

  void displayError(
    String message, {
    bool displayError = true,
  }) {
    dialogMessageBloc.add(
      DialogMessageShowErrorEvent(
        message: message,
        displayDialog: displayError,
      ),
    );
  }

  void displayInfo(
    String message, {
    bool displayDialog = true,
  }) {
    dialogMessageBloc.add(
      DialogMessageShowInfoEvent(
        message: message,
        displayDialog: displayDialog,
      ),
    );
  }

  void setErrorState([String? message]) {
    dialogMessageBloc.add(
      DialogMessageShowErrorEvent(
        message: message ?? '',
        displayDialog: false,
      ),
    );
  }

  void hideLoading() {
    dialogMessageBloc.add(DialogMessageSetNoneStateEvent());
  }
}
