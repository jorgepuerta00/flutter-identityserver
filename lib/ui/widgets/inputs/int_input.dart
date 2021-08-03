import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/AppColors.dart';
import 'int_validator.dart';
import 'text_editing_controller_with_cursor_position.dart';

class IntInput extends StatefulWidget {
  IntInput({
    required this.intValidator,
    required this.onChanged,
    this.autofillHints,
    this.hintText,
    this.icon,
    this.decoration,
    this.keyboardType,
    this.inputFormatters,
  });

  final IntValidator intValidator;
  final Function(String newValue) onChanged;
  final Iterable<String>? autofillHints;
  final String? hintText;
  final Widget? icon;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;

  @override
  _IntInputState createState() => _IntInputState();
}

class _IntInputState extends State<IntInput> {
  final _inputController = TextEditingControllerWithCursorPosition();

  @override
  Widget build(BuildContext context) {
    _inputController.number = widget.intValidator.value;
    return TextField(
      inputFormatters: widget.inputFormatters,
      textInputAction: TextInputAction.route,
      controller: _inputController,
      autofillHints: widget.autofillHints,
      onChanged: (value) {
        widget.onChanged(value);
      },
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: AppColors.GREY_DARK,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          errorText: widget.intValidator.invalid
              ? IntValidator.errorsMessagesMap[widget.intValidator.error]
              : null,
          errorStyle: TextStyle(fontSize: 1, height: 0)),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
}
