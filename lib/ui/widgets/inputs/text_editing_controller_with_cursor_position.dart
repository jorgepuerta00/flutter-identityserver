import 'package:flutter/material.dart';

//How to keep cursor position
// source : https://github.com/flutter/flutter/issues/11416#issuecomment-719707246
class TextEditingControllerWithCursorPosition extends TextEditingController {
  TextEditingControllerWithCursorPosition({
    String? text,
    int? number,
  }) : super(
          text: text,
        );

  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: value.selection,
      composing: TextRange.empty,
    );
  }

  set number(String newInt) {
    value = value.copyWith(
      text: newInt,
      selection: value.selection,
      composing: TextRange.empty,
    );
  }
}
