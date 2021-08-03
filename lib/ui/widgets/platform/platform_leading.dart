import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_widget.dart';

class PlatformLeading extends PlatformWidget {
  PlatformLeading();

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    if (canPop)
      return CupertinoNavigationBarBackButton(
        previousPageTitle: 'Back',
      );
    else
      return Text('back');
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return Text('Back');
  }
}
