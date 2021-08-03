part of 'dialog_message_bloc.dart';

abstract class DialogMessageEvent extends Equatable {
  final String message;
  final bool displayDialog;

  const DialogMessageEvent(
    this.message,
    this.displayDialog,
  );

  @override
  List<Object> get props => [message];
}

class DialogMessageSetNoneStateEvent extends DialogMessageEvent {
  const DialogMessageSetNoneStateEvent() : super('', false);
}

class DialogMessageShowLoadingEvent extends DialogMessageEvent {
  const DialogMessageShowLoadingEvent({
    String message = 'Loading...',
  }) : super(message, false);
}

class DialogMessageShowInfoEvent extends DialogMessageEvent {
  const DialogMessageShowInfoEvent({
    String message = '',
    bool displayDialog = true,
  }) : super(message, displayDialog);
}

class DialogMessageShowErrorEvent extends DialogMessageEvent {
  const DialogMessageShowErrorEvent({
    String message = '',
    bool displayDialog = true,
  }) : super(message, displayDialog);
}

class DialogMessageShowWarningEvent extends DialogMessageEvent {
  const DialogMessageShowWarningEvent({
    String message = '',
    bool displayDialog = true,
  }) : super(message, displayDialog);
}

class DialogMessageShowSuccessEvent extends DialogMessageEvent {
  const DialogMessageShowSuccessEvent({
    String message = '',
    bool displayDialog = true,
  }) : super(message, displayDialog);
}
