import 'package:flutter/material.dart';
import 'package:revvy/ui/widgets/platform/platform_scaffold.dart';

class AppScreenNoBorder extends StatelessWidget {
  const AppScreenNoBorder({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Scaffold(
        body: SafeArea(
          child: widget,
        ),
      ),
    );
  }
}
