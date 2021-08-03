import 'package:flutter/material.dart';

import 'password_validator.dart';
import 'text_editing_controller_with_cursor_position.dart';

class PasswordInput extends StatefulWidget {
  final PasswordValidator passwordValidator;
  final Function(String newValue) onChanged;
  final String? label;
  final String? validationErrorMsg;
  final TextInputType? textInputType;
  final Iterable<String>? autofillHints;

  PasswordInput({
    required this.passwordValidator,
    required this.onChanged,
    this.label,
    this.validationErrorMsg,
    this.textInputType,
    this.autofillHints,
  });

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  final _inputController = TextEditingControllerWithCursorPosition();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    _inputController.text = widget.passwordValidator.value;
    return TextField(
      controller: _inputController,
      obscureText: !_showPassword,
      onChanged: widget.onChanged,
      //obscuringCharacter: '*',
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: widget.label,
        suffixIcon: IconButton(
          icon: Icon(
            Icons.remove_red_eye_outlined,
            size: 30,
            color: _showPassword
                ? Theme.of(context).accentColor
                : Colors.grey[500],
          ),
          onPressed: () {
            setState(() => this._showPassword = !this._showPassword);
          },
        ),
        errorText: widget.passwordValidator.invalid
            ? PasswordValidator
                .errorsMessagesMap[widget.passwordValidator.error]
            : null,
      ),
    );
  }
}
