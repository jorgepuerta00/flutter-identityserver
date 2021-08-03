import 'package:flutter/material.dart';

import 'app_appbar_screen.dart';

class AppTopPaddingScreen extends StatelessWidget {
  const AppTopPaddingScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return AppAppBarScreen(
      widget: Padding(
        padding: EdgeInsets.only(top: height * 0.03),
        child: child,
      ),
    );
  }
}
