import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_widget.dart';

class PlatformAppBar extends PlatformWidget {
  PlatformAppBar();

  @override
  CupertinoNavigationBar buildCupertinoWidget(BuildContext context) {
    var appTheme = Theme.of(context);
    final canPop = Navigator.of(context).canPop();
    return CupertinoNavigationBar(
      leading: canPop
          ? CupertinoNavigationBarBackButton(
              previousPageTitle: 'Back',
              color: appTheme.appBarTheme.textTheme?.headline6?.color,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      backgroundColor: appTheme.appBarTheme.backgroundColor,
    );
  }

  @override
  AppBar buildMaterialWidget(BuildContext context) {
    return AppBar();
  }
}
