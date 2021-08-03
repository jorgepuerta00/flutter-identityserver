import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/AppSizes.dart';
import '../platform/platform_appbar.dart';
import '../platform/platform_scaffold.dart';

class AppAppBarScreen extends StatelessWidget {
  const AppAppBarScreen({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      platformAppBar: PlatformAppBar(),
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
