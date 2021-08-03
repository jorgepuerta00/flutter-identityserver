import 'package:flutter/material.dart';
import 'package:revvy/ui/constants/AppSizes.dart';
import 'package:revvy/ui/widgets/platform/platform_scaffold.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: AppSizes.SCREEN_PADDING_HORIZONTAL,
              right: AppSizes.SCREEN_PADDING_HORIZONTAL,
              top: AppSizes.SCREEN_PADDING_TOP,
              bottom: AppSizes.SCREEN_PADDING_BOTTOM,
            ),
            child: widget,
          ),
        ),
      ),
    );
  }
}
