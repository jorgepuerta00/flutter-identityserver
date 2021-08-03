import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:revvy/ui/constants/AppColors.dart';

import 'text_validator.dart';
import 'text_editing_controller_with_cursor_position.dart';

class TextInput extends StatefulWidget {
  TextInput({
    required this.textValidator,
    required this.onChanged,
    this.autofillHints,
    this.label,
    this.icon,
  });

  final TextValidator textValidator;
  final Function(String newValue) onChanged;
  final Iterable<String>? autofillHints;
  final String? label;
  final Widget? icon;

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final _inputController = TextEditingControllerWithCursorPosition();

  @override
  Widget build(BuildContext context) {
    _inputController.text = widget.textValidator.value;
    return TextField(
      textInputAction: TextInputAction.route,
      controller: _inputController,
      autofillHints: widget.autofillHints,
      onChanged: (value) {
        widget.onChanged(value);
      },
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            widget.onChanged('');
          },
          icon: Icon(
            Icons.cancel,
            color: AppColors.GREY_DARK_STRONG,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: widget.label,
        errorText: widget.textValidator.invalid
            ? TextValidator.errorsMessagesMap[widget.textValidator.error]
            : null,
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
}
