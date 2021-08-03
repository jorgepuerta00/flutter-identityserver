import 'package:flutter/material.dart';

import '../../../widgets/screen/app_screen.dart';

class SignUpHighOrderScreen extends StatelessWidget {
  const SignUpHighOrderScreen({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      widget: widget,
    );
  }
}
