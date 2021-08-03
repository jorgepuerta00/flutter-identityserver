import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dialog_message_event.dart';
part 'dialog_message_state.dart';

class DialogMessageBloc extends Bloc<DialogMessageEvent, DialogMessageState> {
  DialogMessageBloc() : super(DialogMessageNormalState());

  @override
  Stream<DialogMessageState> mapEventToState(
    DialogMessageEvent event,
  ) async* {
    if (event is DialogMessageSetNoneStateEvent) {
      yield DialogMessageNormalState();
    } else if (event is DialogMessageShowLoadingEvent) {
      yield DialogMessageLoadingState(
        message: event.message,
        displayErrorDialog: false,
      );
    } else if (event is DialogMessageShowInfoEvent) {
      yield DialogMessageInfoState(
        message: event.message,
        displayErrorDialog: event.displayDialog,
      );
    } else if (event is DialogMessageShowErrorEvent) {
      yield DialogMessageErrorState(
        message: event.message,
        displayErrorDialog: event.displayDialog,
      );
    } else if (event is DialogMessageShowWarningEvent) {
      yield DialogMessageWarningState(
        message: event.message,
        displayErrorDialog: event.displayDialog,
      );
    } else if (event is DialogMessageShowSuccessEvent) {
      yield DialogMessageSuccessState(
        message: event.message,
        displayErrorDialog: event.displayDialog,
      );
    }
  }
}
